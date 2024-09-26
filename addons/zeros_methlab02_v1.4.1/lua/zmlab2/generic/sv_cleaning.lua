/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not SERVER then return end
zmlab2 = zmlab2 or {}
zmlab2.Cleaning = zmlab2.Cleaning or {}

function zmlab2.Cleaning.Setup(ent)
	ent.Cleaning_Goal = math.random(3,10)
end

function zmlab2.Cleaning.Inflict(ent,ply,OnFinished)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358

	if ent.Cleaning_Goal == nil then zmlab2.Cleaning.Setup(ent) end
	ent.Cleaning_Goal = math.Clamp(ent.Cleaning_Goal - 1,0,10)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

	if ent.Cleaning_Goal <= 0 then
		ent.Cleaning_Goal = nil
		ent:RemoveAllDecals()
		pcall(OnFinished)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

	local tr = ply:GetEyeTrace()
	if tr and tr.Hit and tr.HitPos then
		zclib.NetEvent.Create("clean",{[1] = tr.HitPos})
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
