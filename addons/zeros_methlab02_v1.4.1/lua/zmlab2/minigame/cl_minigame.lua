/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
zmlab2 = zmlab2 or {}
zmlab2.MiniGame = zmlab2.MiniGame or {}

/*
	Called from the SERVER to tell the Client about the minigame id
*/
net.Receive("zmlab2.MiniGame.GameID", function(len)
    zclib.Debug_Net("zmlab2.MiniGame.GameID",len)

	local MiniGame_Ent = net.ReadEntity()
	local GameID = net.ReadString()
	if MiniGame_Ent and IsValid(MiniGame_Ent) and MiniGame_Ent:IsValid() and GameID then
		MiniGame_Ent.GameID = GameID
	end
end)

/*
	Called from the SERVER to start a minigame
*/
net.Receive("zmlab2_MiniGame", function(len)
    zclib.Debug_Net("zmlab2_MiniGame",len)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	local GameID = net.ReadString()
    local MiniGame_Ent = net.ReadEntity()

	zmlab2.MiniGame.List[GameID]:OnStart(MiniGame_Ent,ply)

	zmlab2.MiniGame.List[GameID]:Interface(MiniGame_Ent,ply)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358

/*
	Called from the MiniGame to send the game result to the SERVER
*/
function zmlab2.MiniGame.Finish(GameID,Machine,Result)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	zmlab2.MiniGame.List[ GameID ]:OnFinish(Machine, LocalPlayer(), Result)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

	net.Start("zmlab2_MiniGame")
	net.WriteString(GameID)
	net.WriteEntity(Machine)
	net.WriteBool(Result)
	net.SendToServer()
end
