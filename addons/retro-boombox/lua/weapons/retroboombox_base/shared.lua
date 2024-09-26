--SWEP.ViewModelFlip 			= false
SWEP.Author					= "Venatuss & Slawer"
SWEP.Instructions			= "Click to use"

SWEP.ViewModel				= Model( "models/sterling/retro_c_boombox.mdl" )
SWEP.WorldModel 			= Model( "models/sterling/retro_w_boombox.mdl" )

SWEP.UseHands				= true

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.Primary.Damage         = 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Delay 			= 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Category 				= "RetroBoombox"
SWEP.PrintName				= "Boombox base"
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= false

SWEP.MainColor = "white"
SWEP.SecondaryColor = "silver"
SWEP.TubeLightsColor = "white"
SWEP.MainLightsColor = "white"
SWEP.SoundLightsColor = "red"
SWEP.ScreenBackgroundColor = Color( 32, 32, 32, 255 )
SWEP.ScreenContentColor = Color( 0, 255, 219, 255 )

local color_background
local materials
local color_lightblue

if CLIENT then
	materials = {
		[ "volume-up"] = Material( "materials/retro_boombox/volume-up.png" ),
		[ "volume-down"] = Material( "materials/retro_boombox/volume-down.png" ),
		[ "right"] = Material( "materials/retro_boombox/right.png" ),
		[ "grab"] = Material( "materials/retro_boombox/grab.png" ),
		[ "light"] = Material( "materials/retro_boombox/light.png" ),
		[ "pause"] = Material( "materials/retro_boombox/pause.png" ),
		[ "sound-bar"] = Material( "materials/retro_boombox/sound-bar.png" ),
		[ "power"] = Material( "materials/retro_boombox/power.png" ),
		[ "left"] = Material( "materials/retro_boombox/left.png" ),
		[ "play"] = Material( "materials/retro_boombox/play.png" ),
		[ "separation-bar"] = Material( "materials/retro_boombox/separation-bar.png" ),
	}

	color_background = Color( 32, 32, 32, 255 )
	color_lightblue = Color( 0, 255, 219, 255 )
end

net.Receive( "RetroBoombox:SendBoomboxInfos", function()
	local tColors = net.ReadTable()

	timer.Simple( 0.5, function()
		if IsValid( LocalPlayer():GetWeapon( "retroboombox_base" ) ) then
			LocalPlayer():GetWeapon( "retroboombox_base" ):GiveProperties( tColors or {} )
		end
	end )
end )

function SWEP:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Power" )
	self:NetworkVar( "Bool", 1, "Playing" )
	self:NetworkVar( "Float", 0, "Frequence" )
	self:NetworkVar( "Float", 1, "SoundLevel" )
	self:NetworkVar( "Float", 2, "LightMode" )
end


function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:Reload()
end

--[[
	///
]]

function SWEP:PlayAnimation( iLevel )
	iLevel = math.Round( iLevel or 1 )
	if ( self.NextAnimation or 0 ) > CurTime() then return end
	self.NextAnimation = CurTime() + 0.3

	self:ResetSequence( iLevel )

	if SERVER then return end
	if not IsValid( self.Owner ) or not IsValid( self.Owner:GetViewModel() ) then return end

	self.Owner:GetViewModel():ResetSequence( iLevel )
end

function SWEP:PlayFailSound()
	if SERVER then return end

	if IsValid( self.FailSound ) then 
		if self.FailSound:GetState() ~= GMOD_CHANNEL_PLAYING then
			self.FailSound:Play() 
		end
		return
	end

	sound.PlayFile( "sound/retro_boombox/no-radio.mp3", "3d", function( station, errCode, errStr )
		if ( IsValid( station ) ) then
			station:Play()
			station:SetVolume( 10 )
			self.FailSound = station
		end
	end )
end

local frequencies = RetroBoombox.Config.Frequencies
function SWEP:PlayStation( frequence )
	if SERVER then return end

	if self.FrequenceAsked then return end

	local tInfos = frequencies[ frequence ]
	if not tInfos then return end

	self.FrequenceAsked = true

	sound.PlayURL( tInfos.url, "3d", function( station, errorid, errorname )
		if not IsValid( self ) then return end

		self.FrequenceAsked = false

		if IsValid( self.Station ) then self.Station:Stop() end
		if IsValid( self.FailSound ) then self.FailSound:Pause() end

		if not IsValid( self.Owner ) or not IsValid( self.Owner:GetActiveWeapon() ) or self.Owner:GetActiveWeapon() ~= self then return end

		if ( IsValid( station ) ) then

			station:SetPos( self:GetPos() )
			station:Play()

			self.Station = station

		else

			self:PlayFailSound()

		end
	end )
end

function SWEP:PlayMusic()
	if SERVER then return end

	if IsValid( self.Owner ) and IsValid( self.Owner:GetViewModel() ) and self:GetLightMode() ~= self.Owner:GetViewModel().LightMode then
		RetroBoombox:ChangeLightMode( self.Owner:GetViewModel(), self:GetLightMode() )
	end

	if self:GetLightMode() ~= self.LightMode then
		RetroBoombox:ChangeLightMode( self, self:GetLightMode() )
	end

	if self:GetPower() then
		if IsValid( self.FailSound ) and self.FailSound:GetState() == ( GMOD_CHANNEL_PLAYING ) then
			if IsValid( self.Station ) then
				self.FailSound:Pause()
				return
			elseif self:GetPos():DistToSqr( LocalPlayer():GetPos() ) > RetroBoombox.Config.MaxSoundDistance then
				self.FailSound:SetVolume( 0 )
				return
			end
			self.FailSound:SetPos( self:GetPos() )
			self.FailSound:SetVolume( self:GetSoundLevel() / RetroBoombox.Config.MaxSoundVolume )
		end
		if IsValid( self.Station ) then
			if self.Station:GetState() == ( GMOD_CHANNEL_PLAYING or GMOD_CHANNEL_PAUSED ) and self:GetPos():DistToSqr( LocalPlayer():GetPos() ) > RetroBoombox.Config.MaxSoundDistance then
				self.Station:Stop()
				return
			end

			if self:GetPlaying() then
				if self.Station:GetState() ~= GMOD_CHANNEL_PLAYING then
					self.Station:Play()
					return
				end
			elseif self.Station:GetState() ~= GMOD_CHANNEL_PAUSED then
				self.Station:Pause()
				return
			end

			if self.Station:GetFileName() ~= frequencies[ self:GetFrequence() ].url then
				self.Station:Stop()
				self:PlayStation( self:GetFrequence() )
				return
			end

			if self.Station:GetVolume() ~= self:GetSoundLevel() / RetroBoombox.Config.MaxSoundVolume then
				self.Station:SetVolume( self:GetSoundLevel() / RetroBoombox.Config.MaxSoundVolume )
			end

			self.Station:SetPos( self:GetPos() )
			self:PlayAnimation( ( self.LightLevel or 3 ) / 3 )
		elseif self:GetPos():DistToSqr( LocalPlayer():GetPos() ) < RetroBoombox.Config.MaxSoundDistance then
			self:PlayStation( self:GetFrequence() )
		end
	elseif IsValid( self.Station ) then
		self.Station:Stop()
	end
end

local left = Vector( 3.3, -7.4, 6.6 )
local right = Vector( 3.3, 7.4, 6.6 )
function SWEP:Think()
	if not IsValid( self.Owner ) or not IsValid( self.Owner:GetActiveWeapon() ) or self.Owner:GetActiveWeapon() ~= self then return end
	self:PlayMusic()
end

--[[
	///
]]

function SWEP:SetWorldModelColors()
	RetroBoombox:ChangeColor( self, "main", self.MainColor )
	RetroBoombox:ChangeColor( self, "metalic", self.SecondaryColor )
	RetroBoombox:ChangeLightMode( self, self:GetLightMode() or 0 )
end

function SWEP:SetViewModelColors()
	if SERVER then return end

	if not IsValid( self.Owner ) or not IsValid( self.Owner:GetViewModel() ) then return end

	RetroBoombox:ChangeColor( self.Owner:GetViewModel(), "main", self.MainColor )
	RetroBoombox:ChangeColor( self.Owner:GetViewModel(), "metalic", self.SecondaryColor )
	RetroBoombox:ChangeLightMode( self.Owner:GetViewModel(),  self:GetLightMode() or 0 )
end

function SWEP:PrimaryAttack()
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	if IsValid( self.Owner ) and self.Owner.keyCurrentlyPressed and self.Owner.keyCurrentlyPressed[ RetroBoombox.Config.KeyBase ] then
		if RetroBoombox.Config.Frequencies[ self:GetFrequence() + 1 ] then
			self:SetFrequence( self:GetFrequence() + 1 )
		else
			self:SetFrequence( 1 )
		end
	end
end

function SWEP:SecondaryAttack()
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	if SERVER and IsValid( self.Owner ) and self.Owner.keyCurrentlyPressed and self.Owner.keyCurrentlyPressed[ RetroBoombox.Config.KeyBase ] then
		local eBoombox = ents.Create( self.BoomboxClass or "retroboombox_base" )
		eBoombox:Spawn()
		eBoombox:SetPower( self:GetPower() )
		eBoombox:SetPlaying( self:GetPlaying() )
		eBoombox:SetFrequence( self:GetFrequence() )
		eBoombox:SetSoundLevel( self:GetSoundLevel() )
		eBoombox:SetLightMode( self:GetLightMode() )
		eBoombox:SetPos( self:GetPos() + self.Owner:GetForward() * 20 + self.Owner:GetUp() * 70 )
		eBoombox:SetAngles( self:GetAngles() )

		if IsValid( self.BoomboxOwner ) and eBoombox.SetBoomboxOwner then
			eBoombox:SetBoomboxOwner( self.BoomboxOwner )
		end

		hook.Run( "onBoomboxDropped", self.Owner, self, eBoombox )

		self:Remove()
	end
end

function SWEP:GiveProperties( tColors )
	self.MainColor = tColors.MainColor or "white"
	self.SecondaryColor = tColors.SecondaryColor or "silver"
	self.TubeLightsColor = tColors.TubeLightsColor or "white"
	self.MainLightsColor = tColors.MainLightsColor or "white"
	self.SoundLightsColor =  tColors.SoundLightsColor or "red"
	self.ScreenBackgroundColor = tColors.ScreenBackgroundColor or Color( 32, 32, 32, 255 )
	self.ScreenContentColor = tColors.ScreenContentColor or Color( 0, 255, 219, 255 )

	if CLIENT and IsValid( self.Owner ) and IsValid( self.Owner:GetViewModel() ) then
		self.Owner:GetViewModel().MainColor = tColors.MainColor or "white"
		self.Owner:GetViewModel().SecondaryColor = tColors.SecondaryColor or "silver"
		self.Owner:GetViewModel().TubeLightsColor = tColors.TubeLightsColor or "white"
		self.Owner:GetViewModel().MainLightsColor = tColors.MainLightsColor or "white"
		self.Owner:GetViewModel().SoundLightsColor = tColors.SoundLightsColor or "red"
		self.Owner:GetViewModel().ScreenBackgroundColor = tColors.ScreenBackgroundColor or Color( 32, 32, 32, 255 )
		self.Owner:GetViewModel().ScreenContentColor = tColors.ScreenContentColor or Color( 0, 255, 219, 255 )
	end

	self:SetViewModelColors()
	self:SetWorldModelColors()

end

function SWEP:Deploy()
	self.LightMode = nil
	self:SetViewModelColors()
	self:SetWorldModelColors()
end

function SWEP:Initialize()
	self:SetHoldType( "grenade" )

	self:SetViewModelColors()
	self:SetWorldModelColors()

	if CLIENT then
		color_background = self.ScreenBackgroundColor or Color( 32, 32, 32, 255 )
		color_lightblue = self.ScreenContentColor or Color( 0, 255, 219, 255 )
	end

	self.IsBoombox = true
end

function SWEP:ResetViewModelMaterials()
	if SERVER then return end

	if not IsValid( self.Owner ) or not IsValid( self.Owner:GetViewModel() ) then return end

	for iID, sMat in pairs( self.Owner:GetViewModel():GetMaterials() ) do
		self.Owner:GetViewModel():SetSubMaterial( iID - 1 )
	end
end

function SWEP:ClearSounds()
	if IsValid( self.Station ) then 
		self.Station:Stop()
	end
	if IsValid( self.FailSound ) then 
		self.FailSound:Stop()
	end
end

function SWEP:OnRemove()
	self:ResetViewModelMaterials()
	self:ClearSounds()

	for iID, oMenu in pairs( self.SwepScreen or {} ) do
		if not IsValid( oMenu ) then continue end
		oMenu:Remove()
	end
end

function SWEP:Holster()
	self:ResetViewModelMaterials()
	self:ClearSounds()

	for iID, oMenu in pairs( self.SwepScreen or {} ) do
		if not IsValid( oMenu ) then continue end
		oMenu:Remove()
	end
    return true
end


local smoothdata = {}
--[[
	Here no need to use a 3D2D usable frame. Just paint it is enough.
]]
function SWEP:DrawSwepScreen( iType )
	self.SwepScreen = self.SwepScreen or {}
	if self.SwepScreen[ iType ] and IsValid( self.SwepScreen[ iType ] ) then return self.SwepScreen[ iType ] end
	local this = self

	local size_x, size_y = 620 * 0.6, 400 * 0.6
	if iType == 2 then
		size_x, size_y = 620 * 0.65, 400 * 0.65
	end
	local right_wide = size_x * 0.2

	self.SwepScreen[ iType ] = vgui.Create( "DFrame" )
	local dFrame = self.SwepScreen[ iType ]
	dFrame:SetSize( size_x , size_y )
	-- dFrame:SetDrawCursor( false )
	-- dFrame:SetCursorColor( Color( 0, 255, 0 ) )
	-- dFrame:SetCursorRadius( 10 )
	dFrame:SetPaintedManually( true )
	dFrame:ShowCloseButton( false )
	dFrame:SetTitle( "" )
	function dFrame:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 32, 32, 32 ) )
		if IsValid( this.Station ) then
			local boxSize = 4
			local boxNumber = 170
			local AMP = 1500
			local data = {}
			this.LightLevel = 0
			this.Station:FFT( data, FFT_1024 )

			local maxHeight = 0
			for i=1, boxNumber / 2 do
				smoothdata[i] = Lerp( 10 * FrameTime(), smoothdata[i] or 0, data[i] or 0 )
				local height = math.Clamp( smoothdata[i] * AMP, 0, size_y )

				maxHeight = math.max( maxHeight, height )

				draw.RoundedBox( 0, i * boxSize, size_y - height, boxSize, height, color_lightblue )
				draw.RoundedBox( 0, size_x - i * boxSize, size_y - height, boxSize, height, color_lightblue )
			end

			this.LightLevel = math.Round( 9 * maxHeight / size_y ) or 9
		end
	end


	local dCurrentFrequence = vgui.Create( "DPanel", dFrame )
	dCurrentFrequence:SetPos( 0, 0 )
	dCurrentFrequence:SetSize( size_x, size_y )
	function dCurrentFrequence:Paint( w, h )
	end
	function dCurrentFrequence:UpdateRadio()
		local imageSize = size_y
		local dLogo = vgui.Create( "DHTML", dCurrentFrequence )
		dLogo:Dock( TOP )
		dLogo:DockMargin( (size_x-imageSize)/2 + 10, 0, (size_x-imageSize)/2 + 0, 0  )
		dLogo:SetTall( imageSize  )
		function dLogo:Think()
			if not IsValid( this ) then return end

			if self.Frequence ~= this:GetFrequence() then
				self:SetHTML( string.format( "<img src='%s' width ='%s' height='%s' >", frequencies[ this:GetFrequence() ~= 0 and this:GetFrequence() or 1 ].logo , imageSize - 20, imageSize - 20 ) )
				self.Frequence = this:GetFrequence()
			end
		end
	end

	dCurrentFrequence:UpdateRadio()

	return dFrame
end

if SERVER then return end

mGradient_l = Material( "vgui/gradient-u" )
local listText = {
	( "[%s+E] %s" ):format( input.GetKeyName(RetroBoombox.Config.KeyBase), RetroBoombox:L("TurnPower") ),
	( "[%s+%s] %s" ):format( input.GetKeyName(RetroBoombox.Config.KeyBase), RetroBoombox:L("LMB"), RetroBoombox:L("Frequency") ),
	( "[%s+%s] %s" ):format( input.GetKeyName(RetroBoombox.Config.KeyBase), RetroBoombox:L("RMB"), RetroBoombox:L("Drop") ),
	( "[%s+UP/DOWN] %s" ):format( input.GetKeyName(RetroBoombox.Config.KeyBase), RetroBoombox:L("Volume") ),
}
function SWEP:PostDrawViewModel( eViewModel )
	local vPosition = eViewModel:GetPos()
    vPosition = vPosition + eViewModel:GetForward() * 16.9 + eViewModel:GetRight() * 8.7 + eViewModel:GetUp() * 0
    local aAngle = eViewModel:GetAngles()

    aAngle:RotateAroundAxis( aAngle:Up(), -10 )
    aAngle:RotateAroundAxis( aAngle:Right(), -185 )
    aAngle:RotateAroundAxis( aAngle:Forward(), -86.5 )

	cam.Start3D2D( vPosition, aAngle, 0.01 )
		self:DrawSwepScreen(1):PaintManual()
	cam.End3D2D()

	local vPosition2 = eViewModel:GetPos()
    vPosition2 = vPosition2 + eViewModel:GetForward() * 22.5 + eViewModel:GetRight() * 8.5 + eViewModel:GetUp() * 3
    local aAngle2 = eViewModel:GetAngles()

    aAngle2:RotateAroundAxis( aAngle2:Up(), 45 )
    aAngle2:RotateAroundAxis( aAngle2:Right(), -185 )
    aAngle2:RotateAroundAxis( aAngle2:Forward(), -95 )

	cam.Start3D2D( vPosition2, aAngle2, 0.01 )
		for iID, sText in pairs( listText ) do
			surface.SetFont( "Boombox:18" )
			local text_x, text_y = surface.GetTextSize( sText )
			local margin_left, margin_top = 20, 5

			draw.RoundedBox( 0, -text_x-margin_left, ( iID - 1 ) * ( text_y + margin_top * 2 + 15 ), text_x + margin_left * 2, text_y + margin_top * 2, Color( 0, 0, 0, 200 ) )
			-- surface.SetDrawColor( Color( 52, 152, 219, 30 ) )
			-- surface.SetMaterial( mGradient_l )
			-- surface.DrawTexturedRect( -text_x - margin_left, ( iID - 1 ) * ( text_y + margin_top * 2 + 15 ), text_x + margin_left * 2, (text_y + margin_top * 2) / 1.3 )

			-- draw.RoundedBox( 0, -text_x - margin_left - 15, ( iID - 1 ) * ( text_y + margin_top * 2 + 15 ), 15, text_y + margin_top * 2, Color( 52, 152, 219, 255 ) )
			draw.SimpleText( sText, "Boombox:18", 4, ( ( iID - 1 ) * ( text_y + margin_top * 2 + 15 ) ) + 4 + margin_top, Color( 0, 0, 0 ), TEXT_ALIGN_RIGHT )
			draw.SimpleText( sText, "Boombox:18", 0, ( iID - 1 ) * ( text_y + margin_top * 2 + 15 ) + margin_top, color_white, TEXT_ALIGN_RIGHT )
		end
	cam.End3D2D()

	local vPosition = eViewModel:GetPos()
    vPosition = vPosition + eViewModel:GetForward() * 12.5 + eViewModel:GetRight() * 8.2 + eViewModel:GetUp() * 0.4
    local aAngle = eViewModel:GetAngles()

    aAngle:RotateAroundAxis( aAngle:Up(), -10 )
    aAngle:RotateAroundAxis( aAngle:Right(), -185 )
    aAngle:RotateAroundAxis( aAngle:Forward(), -86.5 )

	cam.Start3D2D( vPosition, aAngle, 0.01 )
		self:DrawSwepScreen(1):PaintManual()
	cam.End3D2D()
end

--  function SWEP:DrawWorldModel()
-- 	self:DrawModel()

-- 	if not IsValid( self.Owner ) then return end

--     self:SetPos( self.Owner:GetPos() )
-- end

-- function SWEP:DrawWorldModel()
-- 	self:DrawModel()

-- 	-- print( self:GetWeaponWorldModel() )

-- 	local vPosition = self:GetPos()
--     vPosition = vPosition + self:GetForward() * 11 + self:GetRight() * 11.9 + self:GetUp() * 1.1
--     local aAngle = self:GetAngles()

--     aAngle:RotateAroundAxis( aAngle:Up(), -20 )
--     aAngle:RotateAroundAxis( aAngle:Right(), -185 )
--     aAngle:RotateAroundAxis( aAngle:Forward(), -86 )

-- 	cam.Start3D2D( vPosition, aAngle, 0.01 )
-- 		self:DrawSwepScreen():PaintManual()
-- 	cam.End3D2D()
-- end


function SWEP:DrawWorldModel()
	self:DrawModel()

	if not IsValid( self.Owner ) then return end
	local boneID = self.Owner:LookupBone( "ValveBiped.Bip01_R_Clavicle" ) or 0

	local bonePos, boneAngle = self.Owner:GetBonePosition( boneID )

	local vPosition = bonePos
    vPosition = vPosition + boneAngle:Forward() * 8.3 + boneAngle:Right() * -9.1 + boneAngle:Up() * -2.4
    local aAngle = boneAngle

    aAngle:RotateAroundAxis( aAngle:Up(), 7 )
    aAngle:RotateAroundAxis( aAngle:Right(), 157 )
    aAngle:RotateAroundAxis( aAngle:Forward(), -4 )

	cam.Start3D2D( vPosition, aAngle, 0.01 )
		self:DrawSwepScreen( 2 ):PaintManual()
	cam.End3D2D()

    local vPosition2 = vPosition + boneAngle:Forward() * -6.3 + boneAngle:Right() * 0 + boneAngle:Up() * 0.1

	cam.Start3D2D( vPosition2, aAngle, 0.01 )
		self:DrawSwepScreen( 2 ):PaintManual()
	cam.End3D2D()
end
