/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

zmlab2 = zmlab2 or {}
zmlab2.MiniGame = zmlab2.MiniGame or {}
zmlab2.MiniGame.List = zmlab2.MiniGame.List or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

/*
	Registers a new minigame
*/
function zmlab2.MiniGame.Register(id,data)
	data.GameID = id
	zmlab2.MiniGame.List[id] = data
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function zmlab2.MiniGame.GetPenalty(Machine)
    return math.Round(zmlab2.config.MiniGame.Quality_Penalty)
end

function zmlab2.MiniGame.GetReward(Machine)
    return math.Round(zmlab2.config.MiniGame.Quality_Reward)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477
