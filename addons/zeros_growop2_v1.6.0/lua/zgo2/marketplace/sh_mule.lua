/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Mule = zgo2.Mule or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

function zgo2.Mule.GetData(MuleID)
	return zgo2.config.Mules[MuleID]
end

function zgo2.Mule.GetCost(MuleID)
	return zgo2.config.Mules[MuleID].cost
end

function zgo2.Mule.CanUse(MuleID,ply)
	local MuleData = zgo2.Mule.GetData(MuleID)
	if not MuleData then return false end

	// Does the player have the correct job to use this mule?
	if MuleData.jobs and table.Count(MuleData.jobs) > 0 and not MuleData.jobs[zclib.Player.GetJob(ply)] then
		zclib.PanelNotify.Create(ply,zgo2.language[ "WrongJob" ], 1)
		zclib.Notify(ply, zclib.table.JobToString(MuleData.jobs), 1)
		return false
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

	// Does the player have the correct rank to use this mule?
	if MuleData.ranks and table.Count(MuleData.ranks) > 0 and not zclib.Player.RankCheck(ply, MuleData.ranks) then
		zclib.PanelNotify.Create(ply,zgo2.language[ "WrongRank" ], 1)
		zclib.Notify(ply, zclib.table.ToString(MuleData.ranks), 1)
		return false
	end

	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
