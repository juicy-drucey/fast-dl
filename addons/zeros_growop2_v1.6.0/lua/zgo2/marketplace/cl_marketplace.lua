/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Marketplace = zgo2.Marketplace or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	The Marketplace manages which players has what weed in which Marketplace in the world
	Players can sell large amounts of weed from here

*/

/*
	Updates buy_rate of the marketplaces
*/
zgo2.Marketplace.LastUpdateRate = CurTime()
net.Receive("zgo2.Marketplace.UpdateRate", function(len,ply)
    zclib.Debug_Net("zgo2.Marketplace.UpdateRate", len)
	local MarketID = net.ReadUInt(10)
	local BuyRate = net.ReadUInt(10)

	zgo2.Marketplace.List[MarketID].buy_rate = BuyRate
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

	zgo2.Marketplace.LastUpdateRate = net.ReadUInt(32)
end)

/*
	Updates what cargo the player has in the specified marketplace
*/
net.Receive("zgo2.Marketplace.UpdateCargo", function(len,ply)
    zclib.Debug_Net("zgo2.Marketplace.UpdateCargo", len)

	local id = net.ReadUInt(10)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

	local dataLength = net.ReadUInt(16)
    local dataDecompressed = util.Decompress(net.ReadData(dataLength))
    local list = util.JSONToTable(dataDecompressed)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	zgo2.Marketplace.List[id].Cargo = list or {}

	hook.Run("zgo2.Marketplace.OnCargoUpdate",id)
end)

/*
	Adds a newly created transfer to the transfer list
*/
zgo2.Marketplace.Transfers = {
	/*
		[TransferID] = {StartID = NUMBER,DestinationID = NUMBER, WeedList = TABLE}
	*/
}
net.Receive("zgo2.Marketplace.SendCargo", function(len,ply)
    zclib.Debug_Net("zgo2.Marketplace.SendCargo", len)

	local Ply64 = net.ReadString()
	local TransferID = net.ReadString()
	local StartID = net.ReadUInt(10)
	local DestinationID = net.ReadUInt(10)

	local TravelDuration = net.ReadUInt(32)
	local MuleID = net.ReadUInt(32)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	zgo2.Marketplace.Transfers[TransferID] = {
		PlayerName = PlyName,
		Player64 = Ply64,
		MuleID = MuleID,
		StartID = StartID,
		DestinationID = DestinationID,
		TravelDuration = TravelDuration,
		TravelStart = CurTime(),
		// This will be used to auto remove the transfer item later
		ArivalTime = CurTime() + TravelDuration
	}

	zclib.Avatar.GetMaterial(Ply64, function(mat)
		zgo2.Marketplace.Transfers[ TransferID ].PlayerAvatar = mat
	end)

	steamworks.RequestPlayerInfo(Ply64, function(steamName)
		zgo2.Marketplace.Transfers[ TransferID ].PlayerName = steamName
	end)

	hook.Run("zgo2.Marketplace.OnTransferCreated",TransferID)
end)
