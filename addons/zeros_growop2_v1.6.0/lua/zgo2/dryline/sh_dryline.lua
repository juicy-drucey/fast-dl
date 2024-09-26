/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Dryline = zgo2.Dryline or {}

/*

	Drylines are used to dry weed, they are 2 anker points connected by a rope / line
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

*/

/*
	How many branches can fit on that rope
*/
function zgo2.Dryline.GetBranchLimit(Dryline)
	if Dryline.BranchLimit == nil then
		Dryline.BranchLimit = math.Clamp(math.Round(Dryline:GetPos():Distance(Dryline:GetEndPoint()) / 15),2,zgo2.config.Dryline.BranchLimit)
	end
	return Dryline.BranchLimit
end

/*
	How much does this rope cost
*/
function zgo2.Dryline.GetCost(startPos,endPos)
	return math.Round((startPos:Distance(endPos) / 10) * zgo2.config.Dryline.CostPerUnit)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

/*
	Returns how long it takes for this weedbranch spot to dry
*/
function zgo2.Dryline.GetTime(Dryline,spot)
	if not Dryline.WeedBranches[spot] then return 0 end

	local drytime = zgo2.config.Dryline.DryTime
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	// TODO Modify drytime later when a fan is pointed at this spot

	return drytime
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

/*
	Returns if the weedbranch is done drying
*/
function zgo2.Dryline.IsDried(Dryline,spot)
	if not Dryline.WeedBranches[spot] then return false end
	return CurTime() > (Dryline.WeedBranches[spot].time + zgo2.Dryline.GetTime(Dryline,spot))
end
