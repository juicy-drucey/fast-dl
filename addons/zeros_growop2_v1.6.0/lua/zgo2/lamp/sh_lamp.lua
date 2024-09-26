/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Lamp = zgo2.Lamp or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	Lamps are used to provide the Lamps with light, depending on the lamp it can have diffrent colors, muliply bulbs and a wider light cone

*/

/*
	Get the UniqueID
*/
function zgo2.Lamp.GetID(ListID)
    return zgo2.Lamp.GetData(ListID).uniqueid
end

/*
	Get the list id
*/
function zgo2.Lamp.GetListID(UniqueID)
    return zgo2.config.Lamps_ListID[UniqueID] or 0
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

/*
	Get the Lamp config data
*/
function zgo2.Lamp.GetData(UniqueID)
    if UniqueID == nil then return end

    // If its a list id then lets return its data
    if zgo2.config.Lamps[UniqueID] then return zgo2.config.Lamps[UniqueID] end

    // If its a uniqueid then lets get its list id and return the data
    local id = zgo2.Lamp.GetListID(UniqueID)
    if UniqueID and id and zgo2.config.Lamps[id] then
        return zgo2.config.Lamps[id]
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

/*
	Tell us if the lamp currently capable of emitting light
*/
function zgo2.Lamp.EmittingLight(Lamp)
	return Lamp:GetLightSwitch() and Lamp:GetPower() > 0
end

/*
	Returns the current color of the lamp
*/
function zgo2.Lamp.GetLightColor(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	if not dat then return Color(255,220,150) end
	return dat.color.default or Color(255,220,150)
end

/*
	Returns the name
*/
function zgo2.Lamp.GetName(UniqueID)
	local dat = zgo2.Lamp.GetData(UniqueID)
	if not dat then return "Unkown" end
	return dat.name
end

/*
	Called when the light color changes
*/
function zgo2.Lamp.UpdateLightColorVar(Lamp,newColor)
	Lamp.LightColor = Color(newColor.x,newColor.y,newColor.z,225)

	if CLIENT then
		zgo2.Lamp.OnColorChange(Lamp)
	end

	Lamp.ColorHue, Lamp.ColorSat, Lamp.ColorVal = ColorToHSV(Lamp.LightColor)
end

/*
	Returns if this lamp can change its color
*/
function zgo2.Lamp.CanChangeColor(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	if not dat then return false end
	return dat.color.change == true
end

/*
	Returns if this lamp causes heat
*/
function zgo2.Lamp.CausesHeat(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	return dat.heat == true
end

/*
	Returns if this lamp can only be placed in a tent
*/
function zgo2.Lamp.TentOnly(LampID)
	local dat = zgo2.Lamp.GetData(LampID)
	return dat.tent == true
end

/*
	Returns if this lamp uses bulbs
*/
function zgo2.Lamp.UsesBulbs(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	return dat.bulbs
end

/*
	Check if the provided position is in the lit area
*/
function zgo2.Lamp.InsideLightArea(Lamp,ent)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	local tPos = Lamp:WorldToLocal(ent:GetPos())

	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	local result
	for k,data in pairs(dat.visuals) do

		if Lamp.Bulbs and not Lamp.Bulbs[k] then continue end

		local lpos , lang, h, d = data.lpos , data.lang , data.cone.h , data.cone.d

		h = h * 65
		d = d * 150 // 320

		local bpos,bang = Lamp:LocalToWorld(lpos) , Lamp:LocalToWorldAngles(lang)
		bang:RotateAroundAxis(bang:Right(),-90)
		local tr = util.TraceLine( {
			start = bpos,
			endpos = bpos + bang:Forward() * d,
			mask = MASK_PLAYERSOLID_BRUSHONLY,
		} )

		// How much of the fraction was used?
		if tr and tr.Fraction then d = d * tr.Fraction end

		// Check if the position of the plant is in distance of the light cone, if its inside the view cone and if its height is in the allowed range
		// NOTE Its a lot of checks but way better then calling ents.FindInCone per second per plant and i also dont have to Calculate a rotated box check.
		if zclib.util.InDistance(bpos, ent:GetPos(), d) and zclib.util.IsInsideViewCone(ent:GetPos(),bpos,bang,d,400) and tPos.z > -60 and tPos.z < h then
			//debugoverlay.Sphere(ent:GetPos(),5,1,Color( 0,255, 0 ),true)
			result = true
			break
		end
	end

	return result
end

/*
	Returns the ui data
*/
// Where is the on switch
local switch_vec = Vector(4.3, 0, 42)
local switch_ang = Angle(0, 90, 90)

// Where is the color change button
local color_vec = Vector(4.3, 0, 35)
local color_ang = Angle(0, 90, 90)

// Where should the power be displayed
local power_vec = Vector(18.5, 0, 7)
local power_ang = Angle(0, 90, 90)

function zgo2.Lamp.GetUI_Power(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	if dat.ui then
		return dat.ui.power_vec or power_vec , dat.ui.power_ang or power_ang
	else
		return power_vec , power_ang
	end
end

function zgo2.Lamp.GetUI_Switch(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	if dat.ui then
		return dat.ui.switch_vec or switch_vec , dat.ui.switch_ang or switch_ang
	else
		return switch_vec , switch_ang
	end
end

function zgo2.Lamp.GetUI_Color(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	if dat.ui then
		return dat.ui.color_vec or color_vec , dat.ui.color_ang or color_ang
	else
		return color_vec , color_ang
	end
end

/*
	Returns if this lamp causes heat
*/
function zgo2.Lamp.GetPowerUsage(Lamp)
	local dat = zgo2.Lamp.GetData(Lamp:GetLampID())
	return dat.power or 1
end

/*
	Returns how many bulbs the lamp has
*/
function zgo2.Lamp.GetActiveBulbs(Lamp)
	if Lamp.Bulbs then
		local count = 0
		for k, v in pairs(Lamp.Bulbs) do if v then count = count + 1 end end
		return count
	else
		return 99
	end
end

/*
	Is the lamp currently emitting light?
*/
function zgo2.Lamp.IsEmittingLight(Lamp)
	return Lamp:GetLightSwitch() and Lamp:GetPower() > 0 and zgo2.Lamp.GetActiveBulbs(Lamp) > 0
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
