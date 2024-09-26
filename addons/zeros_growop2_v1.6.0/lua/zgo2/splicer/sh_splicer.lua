/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Splicer = zgo2.Splicer or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	Splicers are used to create new weedseeds from existing one

*/

// How many items can fit in to the splicer, this should not be touched which is why i dont add it to the main config
zgo2.Splicer.ItemLimit = 5


/*
	Can we create new plants
*/
function zgo2.Splicer.CanUse(Splicer)
	return table.Count(zgo2.config.Plants) < 390
end

/*
	Can we use the weedbranch at the specified slot for splicing?
*/
function zgo2.Splicer.CanSplice(Splicer,ply,Slot)
	local Data = Splicer.DataSets[Slot]
	if not Data then return true end
	Data = zgo2.Plant.GetData(Data)
	if not Data then return true end
	return zgo2.Player.CanUse(ply,Data)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

/*
	Returns how much it would cost to splice the current weedplants together
*/
function zgo2.Splicer.GetCost(Splicer)
	local cost = 0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	for k, v in pairs(Splicer.DataSets) do
		local val = (zgo2.Plant.GetTotalMoney(v) / 100) * zgo2.config.Splicer.SplicingCostPerPlant
		cost = cost + val
	end

	return cost
end

/*
	Tells us if the splicer has enough splice data sets to create a new spliced weed config
*/
function zgo2.Splicer.HasEnoughSpliceData(Splicer,ply)
	if not Splicer.DataSets then return false end
	if table.Count(Splicer.DataSets) <= 1 then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	local ValidSets = 0
	for slot,WeedID in pairs(Splicer.DataSets) do
		local dat = zgo2.Plant.GetData(WeedID)
		if not dat then continue end

		if zgo2.Player.CanUse(ply,dat) then
			ValidSets = ValidSets + 1
		end
	end
	return ValidSets >= 2
end
