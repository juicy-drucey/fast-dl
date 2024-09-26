/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Plant = zgo2.Plant or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

/*

	Updates the players about activity change
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

*/

if SERVER then
	util.AddNetworkString("zgo2.Plant.UpdateActivity")

	function zgo2.Plant.SendActivityList(ply)
		net.Start("zgo2.Plant.UpdateActivity")
		net.WriteUInt(table.Count(zgo2.config.Plants), 32)

		for k, v in pairs(zgo2.config.Plants) do
			net.WriteUInt(k, 10)
			net.WriteUInt(v.Activity or 0, 32)
		end

		net.Send(ply)
	end

	net.Receive("zgo2.Plant.UpdateActivity", function(len,ply)
		zclib.Debug_Net("zgo2.Plant.UpdateActivity", len)
	    if zclib.Player.Timeout(nil,ply) == true then return end
		if not zclib.Player.IsAdmin(ply) then return end
		zgo2.Plant.SendActivityList(ply)
	end)
else
	function zgo2.Plant.RequestActivityList()
		net.Start("zgo2.Plant.UpdateActivity")
		net.SendToServer()
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

	net.Receive("zgo2.Plant.UpdateActivity", function(len, ply)
		zclib.Debug_Net("zgo2.Plant.UpdateActivity", len)

		for i = 1, net.ReadUInt(32) do
			zgo2.config.Plants[ net.ReadUInt(10) ].Activity = net.ReadUInt(32) or 0
		end
	end)
end
