/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Player = zgo2.Player or {}

/*
	Checks if the player is a weed grower
*/
function zgo2.Player.IsWeedGrower(ply)
	local job = zclib.Player.GetJob(ply)
	local CorrectJob = true

	if (zgo2.config.Jobs.Pro and table.Count(zgo2.config.Jobs.Pro) > 0 and zgo2.config.Jobs.Pro[ job ] ~= true) and (zgo2.config.Jobs.Basic and table.Count(zgo2.config.Jobs.Basic) > 0 and zgo2.config.Jobs.Basic[ job ] ~= true) and (zgo2.config.Jobs.Amateur and table.Count(zgo2.config.Jobs.Amateur) > 0 and zgo2.config.Jobs.Amateur[ job ] ~= true) then
		CorrectJob = false
	end

	return CorrectJob
end

/*
	Performs a rank and job check for the provided player and data
*/
function zgo2.Player.CanUse(ply,data)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	// Does the player have the correct job to buy this item?
	if data.jobs and table.Count(data.jobs) > 0 and not data.jobs[zclib.Player.GetJob(ply)] then return false , true , false end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

	// Does the player have the correct rank to buy this item?
	if data.ranks and table.Count(data.ranks) > 0 and not zclib.Player.RankCheck(ply, data.ranks) then return false , false ,true end
	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3
