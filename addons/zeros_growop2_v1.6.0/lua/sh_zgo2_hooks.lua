/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

/*

	A bunch of hooks to modify certain aspects
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

/*
	Called once a player sells weed on a marketplace
*/
hook.Add("zgo2.Shop.CanBuy","zgo2.Shop.CanBuy.test",function(ply,item_data)
	// If the player is superadmin and the item costs more then 1000$ then he is not allowed to buy it
	// if IsValid(ply) and ply:IsSuperAdmin() and item_data and item_data.price > 1000 then return false end
end)

/*
	Called once a player sells weed on a marketplace
*/
hook.Add("zgo2.Shop.OverwriteSpawnLimit","zgo2.Shop.OverwriteSpawnLimit.test",function(ply,item_data,spawnlimit)
	// If the player is superadmin then he can spawn / buy times as many entities
	//if IsValid(ply) and ply:IsSuperAdmin() and then return spawnlimit * 3 end
end)

if SERVER then
	/*
		Called once a player sells weed on a marketplace
	*/
	hook.Add("zgo2.Marketplace.OnCargoSold","zgo2.Marketplace.OnCargoSold.test",function(ply,MarketplaceID,cargo_name,cargo_amount,cargo_value,cargo_data)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

	end)

	/*
		Called once a player sells weed to the npc
	*/
	hook.Add("zgo2.NPC.OnQuickSell","zgo2.NPC.OnQuickSell.test",function(ply,weed_id,weed_amount,weed_value)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	end)

	/*
		Called once a player buys something from the multitool
	*/
	hook.Add("zgo2.Shop.OnPurchase","zgo2.Shop.OnPurchase.test",function(ply,data)

	end)

	/*
		Called once a player sells something using the multitool
	*/
	hook.Add("zgo2.Shop.OnSell","zgo2.Shop.OnSell.test",function(ply,data,price)

	end)

	/*
		Called from the Spliced Plant Activity system and can be used to prevent a spliced weed config from being deleted
	*/
	hook.Add("zgo2.SplicedPlant.PreventDeletion","zgo2.SplicedPlant.PreventDeletion.test",function(id)
		/*
		local PlantData = zgo2.Plant.GetData(id)
		if PlantData then
			// NOTE Besides the default Plant config we also save certain info about the player who spliced it
			PlantData.creator_id
			PlantData.creator_name
			PlantData.creator_rank

			// Can be used to prevent spliced weed from getting deleted if its made by a superadmin
			if PlantData.creator_rank == "superadmin" then return true end
		end
		*/
	end)

	/*
		Called when a player trys to pickup a entity with his backpack
		Return true or false
		NOTE Return nothing to let the normal checks handle this
	*/
	hook.Add("zgo2.Backpack.AllowPickup","zgo2.Backpack.AllowPickup.test",function(ply,ent)

		/*
		if IsValid(ply) and ply:IsSuperAdmin() and IsValid(ent) and ent:GetClass() == "grenade_helicopter" then
			return true
		end
		*/
	end)
end

if CLIENT then
	/*
		Called once a marketplace receives the players cargo
	*/
	hook.Add("zgo2.Marketplace.OnCargoUpdate","zgo2.Marketplace.OnCargoUpdate.Test",function(MarketplaceID)

	end)

	/*
		Called once a transfer got succesfully created
	*/
	hook.Add("zgo2.Marketplace.OnTransferCreated","zgo2.Marketplace.OnTransferCreated.Test",function(TransferID)

	end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
