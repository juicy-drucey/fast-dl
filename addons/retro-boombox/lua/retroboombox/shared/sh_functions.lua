local sMaterialPrefix = "sterling/retro_boombox_"
local subMaterials = {
	[ sMaterialPrefix .. "main" ] = {
		index = 0,
		folder = "main"
	},
	[ sMaterialPrefix .. "metalic" ] = {
		index = 1,
		folder = "main"
	},
	[ sMaterialPrefix .. "lights_main" ] = {
		index = 5,
		folder = "light"
	},
	[ sMaterialPrefix .. "light_tube" ] = {
		index = 3,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_09" ] = {
		index = 16,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_08" ] = {
		index = 15,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_07" ] = {
		index = 14,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_06" ] = {
		index = 13,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_05" ] = {
		index = 12,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_04" ] = {
		index = 11,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_03" ] = {
		index = 10,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_02" ] = {
		index = 9,
		folder = "light"
	},
	[ sMaterialPrefix .. "vol_light_01" ] = {
		index = 8,
		folder = "light"
	},
}

local tLightsModes = {
	[ 1 ] = {
		onStart = function( eBoombox )
			RetroBoombox:SetMainLights( eBoombox, false )
			RetroBoombox:SetTubeLights( eBoombox, false )
			RetroBoombox:SetSoundLights( eBoombox, 0 )
		end,
	},
	[ 2 ] = {
		onStart = function( eBoombox )
			RetroBoombox:SetMainLights( eBoombox, true )
			RetroBoombox:SetTubeLights( eBoombox, true )
			RetroBoombox:SetSoundLights( eBoombox, 9 )
		end,
	},
	[ 3 ] = {
		onStart = function( eBoombox )
			local index = eBoombox:EntIndex()
			local current = false

			-- If the player is too far from the timer, we check his distance only each 5 seconds.
			local isAdjusted = false
			local function timerFunc()
				if not IsValid( eBoombox ) then timer.Remove( "lightBoombox:" .. index ) return end

				if CLIENT then
					if eBoombox:GetPos():DistToSqr( LocalPlayer():GetPos() ) > 695000 then
						isAdjusted = true
						timer.Adjust( "lightBoombox:" .. index, 5, 0, timerFunc )
						return
					elseif isAdjusted then
						isAdjusted = false
						timer.Adjust( "lightBoombox:" .. index, 0.3, 0, timerFunc )
					end
				end

				RetroBoombox:SetMainLights( eBoombox, not current )
				RetroBoombox:SetTubeLights( eBoombox, not current )
				RetroBoombox:SetSoundLights( eBoombox, current and 0 or 9 )
				current = not current
			end

			timer.Create( "lightBoombox:" .. index, 0.3, 0, timerFunc )
		end,
		onFinish = function( eBoombox )
			timer.Remove( "lightBoombox:" .. eBoombox:EntIndex() )
		end
	},
	[ 4 ] = {
		onStart = function( eBoombox )
			local index = eBoombox:EntIndex()
			RetroBoombox:SetMainLights( eBoombox, true )
			RetroBoombox:SetTubeLights( eBoombox, true )

			-- If the player is too far from the timer, we check his distance only each 5 seconds.
			local isAdjusted = false
			local function timerFunc()
				if not IsValid( eBoombox ) then timer.Remove( "lightBoombox:" .. index ) return end

				if CLIENT then
					if eBoombox:GetPos():DistToSqr( LocalPlayer():GetPos() ) > 695000 then
						isAdjusted = true
						timer.Adjust( "lightBoombox:" .. index, 5, 0, timerFunc )
						return
					elseif isAdjusted then
						isAdjusted = false
						timer.Adjust( "lightBoombox:" .. index, 0.01, 0, timerFunc )
					end
				end
				RetroBoombox:SetSoundLights( eBoombox, eBoombox.LightLevel or 9 )
				current = not current
			end

			timer.Create( "lightBoombox:" .. index, 0.01, 0, timerFunc )
		end,
		onFinish = function( eBoombox )
			timer.Remove( "lightBoombox:" .. eBoombox:EntIndex() )
		end
	},
}

function RetroBoombox:ChangeColor( eBoombox, sType, sColor )
	local sColor = sColor or "white"
	local materialName = sMaterialPrefix .. sType
	eBoombox:SetSubMaterial( subMaterials[ materialName ].index, "sterling/colors/" .. subMaterials[ materialName ].folder .. "/retro_boombox_" .. subMaterials[ materialName ].folder .. "_" .. sColor )
end

function RetroBoombox:GetSoundLights()
	return eBoombox.SoundLights
end

function RetroBoombox:SetMainLights( eBoombox, bPower )
	eBoombox.MainLights = bPower
	RetroBoombox:ChangeColor( eBoombox, "lights_main", bPower and eBoombox.MainLightsColor or "zero" )
end

function RetroBoombox:SetTubeLights( eBoombox, bPower )
	eBoombox.MainLights = bPower
	RetroBoombox:ChangeColor( eBoombox, "light_tube", bPower and eBoombox.TubeLightsColor or "zero" )
end

function RetroBoombox:SetSoundLights( eBoombox, iPower )
	eBoombox.SoundLights = iPower
	for i=1, 9 do
		if i <= iPower then
			RetroBoombox:ChangeColor( eBoombox, "vol_light_0" .. i, eBoombox.SoundLightsColor )
		else
			RetroBoombox:ChangeColor( eBoombox, "vol_light_0" .. i, "zero" )
		end
	end
end

function RetroBoombox:ChangeLightMode( eBoombox, iMode )
	iMode = tLightsModes[ iMode or -1 ] and iMode or 1

	if eBoombox.LightMode and tLightsModes[ eBoombox.LightMode ].onFinish then
		tLightsModes[ eBoombox.LightMode ].onFinish( eBoombox )
	end

	eBoombox.LightMode = iMode

	if SERVER then
		eBoombox:SetLightMode( iMode )
	end

	if tLightsModes[ eBoombox.LightMode ] and tLightsModes[ eBoombox.LightMode ].onStart then
		tLightsModes[ eBoombox.LightMode ].onStart( eBoombox )
	end
end
