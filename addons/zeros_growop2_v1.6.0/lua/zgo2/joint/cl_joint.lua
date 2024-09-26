/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Joint = zgo2.Joint or {}
zgo2.Joint.List = zgo2.Joint.List or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	Bongs are used to smoke da weed
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

*/

function zgo2.Joint.Initialize(Joint)
	Joint:SetHoldType(Joint.HoldType)
	Joint.LastWeed = -1
	Joint.LastWeedAmount = -1
	Joint.WeedLevel = -1
end

function zgo2.Joint.DrawHUD(Joint)
	local weed = Joint:GetWeedID()

	if Joint.LastWeed ~= weed then
		Joint.LastWeed = weed

		if Joint.LastWeed ~= -1 then
			Joint.WeedLevel = Joint:GetWeedAmount()
		end
	end

	local weed_amount = Joint:GetWeedAmount()

	if Joint.LastWeedAmount ~= weed_amount then
		Joint.LastWeedAmount = weed_amount
	end

	if Joint.LastWeed ~= -1 then
		Joint.WeedLevel = Joint.WeedLevel - 2 * FrameTime()
		Joint.WeedLevel = math.Clamp(Joint.WeedLevel, Joint.LastWeedAmount, zgo2.config.DoobyTable.WeedPerJoint)
		local width = (315 / zgo2.config.DoobyTable.WeedPerJoint) * Joint.WeedLevel
		draw.RoundedBox(5, 800 * zclib.wM, 1027 * zclib.hM, 320 * zclib.wM, 45 * zclib.hM, zclib.colors[ "black_a100" ])
		draw.RoundedBox(5, 803 * zclib.wM, 1029 * zclib.hM, width * zclib.wM, 41 * zclib.hM, zgo2.Plant.GetColor(weed))
		draw.SimpleText(zgo2.Plant.GetName(weed), zclib.GetFont("zclib_font_medium"), 960 * zclib.wM, 1065 * zclib.hM, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function zgo2.Joint.Think(Joint)
	zclib.util.LoopedSound(LocalPlayer(), "zgo2_joint_loop", Joint:GetIsSmoking())
end

function zgo2.Joint.Holster(Joint)
	if IsValid(LocalPlayer()) then
		LocalPlayer():StopSound("zgo2_joint_loop")
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function zgo2.Joint.OnRemove(Joint)
	if IsValid(LocalPlayer()) then
		LocalPlayer():StopSound("zgo2_joint_loop")
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
