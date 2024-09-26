/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.PowerLines = zgo2.PowerLines or {}
zgo2.PowerLines.List = zgo2.PowerLines.List or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	Powerlines  just visually show cables between connected ents (Generator / Lamp)

*/
local gravity = Vector(0, 0, -0.2)
local damping = 0.5
local Length = 12
function zgo2.PowerLines.PreDraw()
	for ent,_ in pairs(zgo2.Generator.List) do
        if not IsValid(ent) then
			continue
		end

		if not ent.m_Initialized then continue end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

		if zclib.util.InDistance(ent:GetPos(), LocalPlayer():GetPos(), 1000) == false then continue end

		if ent.ConnectedEntities then
			for k,v in pairs(ent.ConnectedEntities) do
				zgo2.PowerLines.Draw(ent,k)
			end
		end
    end
end

local rope_beam = Material("zerochain/zgo2/cable/cable_power")
local BatteryPos = {
	["models/zerochain/props_growop2/zgo2_led_lamp01.mdl"] = Vector(18,0,2),
	["models/zerochain/props_growop2/zgo2_led_lamp02.mdl"] = Vector(18,0,2),
	["models/zerochain/props_growop2/zgo2_led_lamp03.mdl"] = Vector(18,0,2),
	["models/zerochain/props_growop2/zgo2_sodium_lamp01.mdl"] = Vector(18,0,2),
	["models/zerochain/props_growop2/zgo2_sodium_lamp02.mdl"] = Vector(18,0,2),
	["models/zerochain/props_growop2/zgo2_sodium_lamp03.mdl"] = Vector(18,0,2),
	["models/zerochain/props_growop2/zgo2_tent_led_lamp.mdl"] = Vector(-30,25,-65),
	["models/zerochain/props_growop2/zgo2_tent_sodium_lamp.mdl"] = Vector(-30,25,-65),

	["models/zerochain/props_growop2/zgo2_weedcruncher.mdl"] = Vector(5,-25,0),
	["models/zerochain/props_growop2/zgo2_pump.mdl"] = Vector(0,0,0),
}
local vec01 = Vector(18,0,2)
function zgo2.PowerLines.GetBatteryPos(ent)
	return BatteryPos[ent:GetModel()] or vec01
end

local vec02 = Vector(0,0,5)
function zgo2.PowerLines.Draw(gen,ent)
	if IsValid(gen) and IsValid(ent) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

		local from = gen:LocalToWorld(vec02)
		local to = ent:LocalToWorld(zgo2.PowerLines.GetBatteryPos(ent))
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

		// Render the rope
		if to then
			local r_start = from
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

			// Create rope points
			if ent.LinePoints == nil then
				ent.LinePoints = zclib.Rope.Setup(Length, r_start)
			end

			// Updates the Rope points to move physicly
			if ent.LinePoints and table.Count(ent.LinePoints) > 0 then
				zclib.Rope.Update(ent.LinePoints, r_start, to, Length, gravity, damping)
			end

			// Draw the rope
			zclib.Rope.Draw(ent.LinePoints, r_start, to, Length, rope_beam, nil, color_white,2)
		else
			ent.LinePoints = nil
		end
	else
		ent.LinePoints = nil
	end
end
