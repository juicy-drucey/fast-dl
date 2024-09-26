/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.NPC = zgo2.NPC or {}
zgo2.NPC.List = zgo2.NPC.List or {}

/*
	Check if the player is allowed to buy this bong
*/
function zgo2.NPC.CanBuyBong(ply,id)
	local BongData = zgo2.Bong.GetData(id)
	if not BongData then return end

	local CanBuy = true

	// Does the player have the correct job to buy this item?
	if BongData.jobs and table.Count(BongData.jobs) > 0 and not BongData.jobs[zclib.Player.GetJob(ply)] then
		CanBuy = false
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	// Does the player have the correct rank to buy this item?
	if BongData.ranks and table.Count(BongData.ranks) > 0 and not zclib.Player.RankCheck(ply, BongData.ranks) then
		CanBuy = false
	end

	return CanBuy
end

/*
	Checks if the players is customer
*/
function zgo2.NPC.IsCustomer(ply)
	local job = zclib.Player.GetJob(ply)
	local CorrectJob = true

	if zgo2.config.NPC.jobs and table.Count(zgo2.config.NPC.jobs) > 0 and zgo2.config.NPC.jobs[ job ] ~= true then
		CorrectJob = false
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

	return CorrectJob
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
