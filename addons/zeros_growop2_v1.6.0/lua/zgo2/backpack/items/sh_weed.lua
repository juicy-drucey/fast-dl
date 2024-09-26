/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/


/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

	Here we register a custom Backpack item class to overwrite
		What custom data we wanna send to the client
		How the item looks in the slot
		When it can be pickedup or dropped from the inventory
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

local function SnapshotPanel(itm,SlotData)
	local imgpnl = vgui.Create("DImage", itm)
	imgpnl:Dock(FILL)

	local img = zclib.Snapshoter.Get({
		class = SlotData.Class,
		model = SlotData.Model,
		PlantID = SlotData.weed_id,
	}, imgpnl)

	imgpnl:SetImage(img and img or "materials/zerochain/zerolib/ui/icon_loading.png")
	return imgpnl
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812


zgo2.Backpack.RegisterItem("zgo2_jar",{
	CanPickUp = function(ent) return ent:GetWeedID() > 0 end,

	CanDrop = function(ply, data)
		if zgo2.Jar.ReachedSpawnLimit(ply) then
			zclib.Notify(ply, zgo2.language[ "Spawnlimit" ], 1)

			return
		end
		return true
	end,

	GetData = function(slot_data) return { weed_id = slot_data.DT.WeedID, weed_amount = slot_data.DT.WeedAmount or 1 } end,

	DisplayOverwrite = function(itm,SlotData) return SnapshotPanel(itm,SlotData) end
})

zgo2.Backpack.RegisterItem("zgo2_weedblock",{
	CanPickUp = function(ent) return ent:GetWeedID() > 0 end,

	CanDrop = function(ply, data)
		if zgo2.Weedblock.ReachedSpawnLimit(ply) then
			zclib.Notify(ply, zgo2.language[ "Spawnlimit" ], 1)

			return
		end
		return true
	end,

	GetData = function(slot_data) return { weed_id = slot_data.DT.WeedID, weed_amount = slot_data.DT.WeedAmount or 1 } end,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	DisplayOverwrite = function(itm,SlotData) return SnapshotPanel(itm,SlotData) end
})
