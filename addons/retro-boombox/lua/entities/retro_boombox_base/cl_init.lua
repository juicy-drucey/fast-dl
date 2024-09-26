include( "shared.lua" )

local materials = {
	[ "volume-up"] = Material( "materials/retro_boombox/volume-up.png" ),
	[ "volume-down"] = Material( "materials/retro_boombox/volume-down.png" ),
	[ "right"] = Material( "materials/retro_boombox/right.png" ),
	[ "grab"] = Material( "materials/retro_boombox/grab.png" ),
	[ "light"] = Material( "materials/retro_boombox/light.png" ),
	[ "pause"] = Material( "materials/retro_boombox/pause.png" ),
	[ "power"] = Material( "materials/retro_boombox/power.png" ),
	[ "left"] = Material( "materials/retro_boombox/left.png" ),
	[ "play"] = Material( "materials/retro_boombox/play.png" ),
}

local color_background = Color( 32, 32, 32, 255 )
local color_main = Color( 255, 255, 255, 255 )

function ENT:Draw()
	self:DrawModel()

	if self:GetPos():DistToSqr( LocalPlayer():GetPos() ) > 250000 then 
		if IsValid( self.Indicator ) then 
			self.Indicator:Remove()
		end
		if IsValid( self.RightScreen ) then
			self.RightScreen:Remove()
		end
		if IsValid( self.LeftScreen ) then
			self.LeftScreen:Remove()
		end
		for iID, oMenu in pairs( self.OffScreen or {} ) do
			if not IsValid( oMenu ) then continue end
			oMenu:Remove()
		end
		return
	end

	local aAngle = self:LocalToWorldAngles( Angle( 0, 90, 90 ) )
	local vPosition = self:LocalToWorld( Vector( 3.59, -7.85, 1.35 ) )
	cam.Start3D2D( vPosition, aAngle, 0.01 )
		if self:GetPower() then
			self:DrawRightScreen():PaintManual3D( vPosition, aAngle, 0.01 )
		else
			self:DrawOffScreen( 1 ):PaintManual3D( vPosition, aAngle, 0.01 )
		end
	cam.End3D2D()

	local aAngle2 = self:LocalToWorldAngles( Angle( 0, 90, 90 ) )
	local vPosition2 = self:LocalToWorld( Vector( 3.6, 1.65, 1.35 ) )
	cam.Start3D2D( vPosition2, aAngle2, 0.01 )
		if self:GetPower() then
			self:DrawLeftScreen():PaintManual()
		else
			self:DrawOffScreen( 2 ):PaintManual3D( vPosition2, aAngle2, 0.01 )
		end
	cam.End3D2D()
end

function ENT:SetParticleEffect( bShouldPlay )
	if not RetroBoombox.Config.ShouldUseParticles then return end

	if bShouldPlay then
		if not IsValid( self.ParticleOne ) then
			self.ParticleOne = CreateParticleSystem( self, "music_stars", PATTACH_ABSORIGIN_FOLLOW )
		end
		if not IsValid( self.ParticleTwo ) then
			self.ParticleTwo = CreateParticleSystem( self, "music_notes_02", PATTACH_ABSORIGIN_FOLLOW )
		end
		if not IsValid( self.ParticleThree ) then
			self.ParticleThree = CreateParticleSystem( self, "music_notes_core", PATTACH_ABSORIGIN_FOLLOW )
		end
	else
		if IsValid( self.ParticleOne ) then
			self.ParticleOne:StopEmission()
		end
		if IsValid( self.ParticleTwo ) then
			self.ParticleTwo:StopEmission()
		end
		if IsValid( self.ParticleThree ) then
			self.ParticleThree:StopEmission()
		end
	end
end

function ENT:PlayAnimation( iLevel )
	if ( self.NextAnimation or 0 ) > CurTime() then return end
	self:ResetSequence( iLevel )
	self.NextAnimation = CurTime() + 0.3
end

function ENT:GetFrequenceIndicator()
	if IsValid( self.Indicator ) then return self.Indicator end

	self.Indicator = ClientsideModel( "models/sterling/retro_boombox_slider.mdl", RENDERGROUP_TRANSLUCENT )
end

function ENT:Initialize()
	self:GetFrequenceIndicator()
	color_background = self.ScreenBackgroundColor or Color( 32, 32, 32, 255 )
	color_lightblue = self.ScreenContentColor or Color( 0, 255, 219, 255 )
end

function ENT:PlayFailSound()
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
function ENT:PlayStation( frequence )
	if self.FrequenceAsked then return end

	local tInfos = frequencies[ frequence ]
	if not tInfos then return end

	self.FrequenceAsked = true

	sound.PlayURL( tInfos.url, "3d", function( station, errorid, errorname )
		if not IsValid( self ) then return end

		self.FrequenceAsked = false

		if IsValid( self.Station ) then self.Station:Stop() end
		if IsValid( self.FailSound ) then self.FailSound:Pause() end

		if ( IsValid( station ) ) then

			station:SetPos( self:GetPos() )
			station:Play()

			self.Station = station

		else

			self:PlayFailSound()

		end
	end )
end

function ENT:OnRemove()
	if IsValid( self.Station ) then 
		self.Station:Stop()
	end
	if IsValid( self.FailSound ) then 
		self.FailSound:Stop()
	end
	if IsValid( self.Indicator ) then 
		self.Indicator:Remove()
	end
	if IsValid( self.RightScreen ) then
		self.RightScreen:Remove()
	end
	if IsValid( self.LeftScreen ) then
		self.LeftScreen:Remove()
	end
	for iID, oMenu in pairs( self.OffScreen or {} ) do
		if not IsValid( oMenu ) then continue end
		oMenu:Remove()
	end
end

local left = Vector( 3.3, -7.4, 6.6 )
local right = Vector( 3.3, 7.4, 6.6 )
function ENT:Think()
	if self:GetLightMode() ~= self.LightMode then
		RetroBoombox:ChangeLightMode( self, self:GetLightMode() )
	end
	if IsValid( self.Indicator ) then
		local percentage = self:GetFrequence() / #RetroBoombox.Config.Frequencies - (1/#RetroBoombox.Config.Frequencies/2)
		self.Percentage = self.Percentage or 0
		
		if self.Percentage ~= percentage and math.abs( self.Percentage - percentage ) < 0.01 then
			self.Percentage = percentage
		elseif self.Percentage < percentage then
			self.Percentage = self.Percentage + 0.01
		elseif self.Percentage > percentage then
			self.Percentage = self.Percentage - 0.01
		end
		local vPosition = self:LocalToWorld( LerpVector( self.Percentage, left, right ) )
		local aAngle = self:LocalToWorldAngles( Angle( 0, 0, 0 ) )
		self.Indicator:SetPos( vPosition )
		self.Indicator:SetAngles( aAngle )
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
				self:SetParticleEffect( false )
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
			self:SetParticleEffect( true )
		end
	elseif IsValid( self.Station ) then
		self:SetParticleEffect( false )
		self.Station:Stop()
	end
end

function ENT:DrawOffScreen( iID )
	if self.OffScreen and self.OffScreen[ iID ] and IsValid( self.OffScreen[ iID ] ) then return self.OffScreen[ iID ] end

	local this = self

	local size_x, size_y = 620, 400

	self.OffScreen = self.OffScreen or {}
	self.OffScreen[ iID ] = vgui.Create( "Boombox.3DFrame" )
	local dFrame = self.OffScreen[ iID ]
	dFrame:SetSize( size_x , size_y )
	dFrame:SetDrawCursor( false )
	dFrame:SetCursorColor( Color( 0, 255, 0 ) )
	dFrame:SetCursorRadius( 10 )
	dFrame:ShowCloseButton( false )
	dFrame:SetTitle( "" )
	dFrame:SetPaintedManually( true )
	dFrame:ParentToHUD()
	function dFrame:Paint( w, h ) 
		draw.RoundedBox( 0, 0, 0, w, h, color_background )
		
		surface.SetDrawColor( color_main )
		surface.SetMaterial( materials[ "power" ] )
		surface.DrawTexturedRect( size_x / 2 - 150, 50, 300, 300 )
	end

	local dTurnPower = vgui.Create( "DButton", dFrame )
	dTurnPower:Dock( FILL )
	dTurnPower:SetText( "" )
	function dTurnPower:DoClick()
		net.Start( "RetroBoombox:TurnPower" )
			net.WriteEntity( this )
			net.WriteBool( true )
		net.SendToServer()
	end
	function dTurnPower:Paint( w, h )
	end

	dFrame:UpdateChildren()
	return dFrame
end

function ENT:DrawRightScreen()
	if self.RightScreen and IsValid( self.RightScreen ) then  return self.RightScreen end
	local this = self

	local size_x, size_y = 620, 400
	local hover_extend = 20
	local hover_move = hover_extend / 2

	self.RightScreen = vgui.Create( "Boombox.3DFrame" )
	local dFrame = self.RightScreen
	dFrame:SetSize( size_x , size_y )
	dFrame:SetDrawCursor( false )
	dFrame:SetCursorColor( Color( 0, 255, 0 ) )
	dFrame:SetCursorRadius( 10 )
	dFrame:ShowCloseButton( false )
	dFrame:SetTitle( "" )
	dFrame:SetPaintedManually( true )
	dFrame:ParentToHUD()
	dFrame.ClicEffects = {}
	function dFrame:Paint( w, h )
		draw.RoundedBox( 3, 0, 0, w, h, color_background )
		for iID, tData in pairs( self.ClicEffects or {} ) do
			if not IsValid( tData.panel ) then self.ClicEffects[ iID ] = nil continue end

			local animationTime = 0.1

			local minSizeX, minSizeY = tData.panel:GetSize()
			local maxSizeX, maxSizeY = minSizeX * 1.5, minSizeY * 1.5
			local basePosX, basePosY = tData.panel:GetPos()

			local currentPercentage = (CurTime() - tData.startTime) / animationTime
			local lerpX, lerpY = Lerp( currentPercentage, minSizeX, maxSizeX ),  Lerp( currentPercentage, minSizeY, maxSizeY )

			surface.SetDrawColor( ColorAlpha( color_main, math.max( 50 - 50 * currentPercentage, 0 ) ) )
			surface.SetMaterial( materials[ tData.mat ] )
			surface.DrawTexturedRect( basePosX - ( lerpX - minSizeX ) / 2, basePosY - ( lerpY - minSizeY ) / 2, lerpX, lerpY )

			if CurTime() - tData.startTime > animationTime then
				self.ClicEffects[ iID ] = nil
			end
		end
	end
	function dFrame:DrawClicEffect( dPanel, sTexture )
		table.insert( self.ClicEffects, {
			panel = dPanel,
			mat = sTexture,
			startTime = CurTime()
		} )
	end

	--[[ 
		Sound part
	]]
	local dSoundUp = vgui.Create( "DButton", dFrame )
	dSoundUp:SetPos( 418, 31 - hover_move )
	dSoundUp:SetSize( 62 + hover_extend, 62 + hover_extend )
	dSoundUp:SetText( "")
	function dSoundUp:DoClick()
		net.Start( "RetroBoombox:ChangeSound" )
			net.WriteEntity( this )
			net.WriteInt( 1, 3 )
		net.SendToServer()

		dFrame:DrawClicEffect( self, "volume-up" )
	end
	function dSoundUp:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end

		surface.SetMaterial( materials[ "volume-up" ] )
		surface.DrawTexturedRect( 0, ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	local dSoundDown = vgui.Create( "DButton", dFrame )
	dSoundDown:SetPos( 141 - hover_move * 2, 31 - hover_move )
	dSoundDown:SetSize( 62 + hover_extend, 62 + hover_extend )
	dSoundDown:SetText( "")
	function dSoundDown:DoClick()
		net.Start( "RetroBoombox:ChangeSound" )
			net.WriteEntity( this )
			net.WriteInt( -1, 3 )
		net.SendToServer()

		dFrame:DrawClicEffect( self, "volume-down" )
	end
	dSoundDown.CurrentSize = 0
	function dSoundDown:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end
		surface.SetMaterial( materials[ "volume-down" ] )
		surface.DrawTexturedRect( ( w - self.CurrentSize ), ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	local dSoundShow = vgui.Create( "DPanel", dFrame )
	dSoundShow:SetPos( 211, 58 )
	dSoundShow:SetSize( 197, 7 )
	dSoundShow.CurrentSize = 0
	function dSoundShow:Paint( w, h )
		local soundPercentage = ( math.Clamp( IsValid( this ) and this.GetSoundLevel and this:GetSoundLevel() or 0, 0, RetroBoombox.Config.MaxSoundVolume ) ) / RetroBoombox.Config.MaxSoundVolume

		local currentSound = w * soundPercentage or 0
		self.CurrentSize = (self.CurrentSize or 0) + (currentSound > self.CurrentSize and 1 or -1 )

		draw.RoundedBox( h / 2, 0, 0, w, h, ColorAlpha( color_main, 30 ) )
		draw.RoundedBox( h / 2, 0, 0, self.CurrentSize, h, color_main )
	end

	--[[ 
		Main part
	]]


	local dPowerButton = vgui.Create( "DButton", dFrame )
	dPowerButton:SetPos( 231 - hover_move, 107 - hover_move )
	dPowerButton:SetSize( 157 + hover_extend, 157 + hover_extend )
	dPowerButton:SetText( "")
	function dPowerButton:DoClick()
		net.Start( "RetroBoombox:TurnPower" )
			net.WriteEntity( this )
			net.WriteBool( false )
		net.SendToServer()

		dFrame:DrawClicEffect( self, "power" )
	end
	function dPowerButton:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end
		surface.SetMaterial( materials[ "power" ] )
		surface.DrawTexturedRect( ( w - self.CurrentSize ) / 2, ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	local dLightButton = vgui.Create( "DButton", dFrame )
	dLightButton:SetPos( 64 - hover_move, 161 - hover_move )
	dLightButton:SetSize( 77 + hover_extend, 77 + hover_extend )
	dLightButton:SetText( "")
	function dLightButton:DoClick()
		net.Start( "RetroBoombox:ChangeLightMode" )
			net.WriteEntity( this )
		net.SendToServer()
		dFrame:DrawClicEffect( self, "light" )
	end
	function dLightButton:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end
		surface.SetMaterial( materials[ "light" ] )
		surface.DrawTexturedRect( ( w - self.CurrentSize ) / 2, ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	local dGrabButton = vgui.Create( "DButton", dFrame )
	dGrabButton:SetPos( 468 - hover_move , 161 - hover_move )
	dGrabButton:SetSize( 77 + hover_extend, 77 + hover_extend )
	dGrabButton:SetText( "")
	function dGrabButton:DoClick()
		net.Start( "RetroBoombox:GrabBoombox" )
			net.WriteEntity( this )
		net.SendToServer()
	end
	function dGrabButton:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end
		surface.SetMaterial( materials[ "grab" ] )
		surface.DrawTexturedRect( ( w - self.CurrentSize ) / 2, ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	--[[ 
		Frequence part
	]]

	local dPreviousFrequence = vgui.Create( "DButton", dFrame )
	dPreviousFrequence:SetPos( 137 - hover_move, 299 - hover_move )
	dPreviousFrequence:SetSize( 69 + hover_extend, 69 + hover_extend )
	dPreviousFrequence:SetText( "")
	function dPreviousFrequence:DoClick()
		net.Start( "RetroBoombox:ChangeFrequence" )
			net.WriteEntity( this )
			net.WriteInt( -1, 3 )
		net.SendToServer()

		dFrame:DrawClicEffect( self, "left" )
	end
	function dPreviousFrequence:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end
		surface.SetMaterial( materials[ "left" ] )
		surface.DrawTexturedRect( ( w - self.CurrentSize ) / 2, ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	local dPause = vgui.Create( "DButton", dFrame )
	dPause:SetPos( 283 - hover_move, 306 - hover_move )
	dPause:SetSize( 55 + hover_extend, 55 + hover_extend )
	dPause:SetText( "")
	function dPause:DoClick()
		net.Start( "RetroBoombox:TurnPlaying" )
			net.WriteEntity( this )
		net.SendToServer()

		dFrame:DrawClicEffect( self, this:GetPlaying() and "pause" or "play" )
	end
	function dPause:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end
		surface.SetMaterial( this:GetPlaying() and materials[ "pause" ] or materials[ "play" ] )
		surface.DrawTexturedRect( ( w - self.CurrentSize ) / 2, ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	local dNextFrequence = vgui.Create( "DButton", dFrame )
	dNextFrequence:SetPos( 413 - hover_move, 299 - hover_move )
	dNextFrequence:SetSize( 72 + hover_extend, 72 + hover_extend )
	dNextFrequence:SetText( "")
	function dNextFrequence:DoClick()
		net.Start( "RetroBoombox:ChangeFrequence" )
			net.WriteEntity( this )
			net.WriteInt( 1, 3 )
		net.SendToServer()

		dFrame:DrawClicEffect( self, "right" )
	end
	function dNextFrequence:Paint( w, h )
		if self:IsHovered() then
			surface.SetDrawColor( color_main )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) + 4, w - hover_extend, w )
		else
			surface.SetDrawColor( ColorAlpha( color_main, 50 ) )
			self.CurrentSize = math.Clamp( (self.CurrentSize or 0) - 4, w - hover_extend, w )
		end
		surface.SetMaterial( materials[ "right" ] )
		surface.DrawTexturedRect( ( w - self.CurrentSize ) / 2, ( h - self.CurrentSize ) / 2, self.CurrentSize, self.CurrentSize )
	end

	dFrame:UpdateChildren()
	return dFrame
end

local smoothdata = {}
function ENT:DrawLeftScreen()
	if self.LeftScreen and IsValid( self.LeftScreen ) then return self.LeftScreen end
	local this = self

	local size_x, size_y = 620, 400

	self.LeftScreen = vgui.Create( "Boombox.3DFrame" )
	local dFrame = self.LeftScreen
	dFrame:SetSize( size_x , size_y )
	dFrame:SetDrawCursor( false )
	dFrame:SetCursorColor( Color( 0, 255, 0 ) )
	dFrame:SetCursorRadius( 10 )
	dFrame:ShowCloseButton( false )
	dFrame:SetTitle( "" )
	dFrame:SetPaintedManually( true )
	dFrame:ParentToHUD()
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

				draw.RoundedBox( 0, i * boxSize, size_y - height, boxSize, height, color_main )
				draw.RoundedBox( 0, size_x - i * boxSize, size_y - height, boxSize, height, color_main )
			end

			this.LightLevel = math.Round( 9 * maxHeight / size_y ) or 9
		end
	end


	local dCurrentFrequence = vgui.Create( "DPanel", dFrame )
	dCurrentFrequence:SetPos( 0, 0 )
	dCurrentFrequence:SetSize( size_x, size_y )
	function dCurrentFrequence:Paint( w, h )
		-- if not IsValid( this ) then return end

		-- local text = frequencies[ this:GetFrequence() or 1 ].name
		-- draw.SimpleText( text, "Boombox:20", w / 2, h, Color( 247, 255, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
	end
	function dCurrentFrequence:UpdateRadio()
		local imageSize = size_y
		local dLogo = vgui.Create( "DHTML", dCurrentFrequence )
		dLogo:Dock( TOP )
		dLogo:DockMargin( (size_x-imageSize)/2 + 10, 0, (size_x-imageSize)/2 + 0, 0  )
		dLogo:SetTall( imageSize  )
		function dLogo:Think()
			if not IsValid( this ) then return end
			if not this.GetFrequence then return end
			
			if self.Frequence ~= this:GetFrequence() then
				self:SetHTML( string.format( "<img src='%s' width ='%s' height='%s' >", frequencies[ this:GetFrequence() or 1 ].logo , imageSize - 20, imageSize - 20 ) )
				self.Frequence = this:GetFrequence()
			end
		end
	end

	dCurrentFrequence:UpdateRadio()

	dFrame:UpdateChildren()
	return dFrame
end