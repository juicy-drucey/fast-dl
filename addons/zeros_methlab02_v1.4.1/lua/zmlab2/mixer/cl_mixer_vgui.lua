/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

net.Receive("zmlab2_Mixer_OpenInterface", function(len)
    zclib.Debug_Net("zmlab2_Mixer_OpenInterface", len)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

    LocalPlayer().zmlab2_Mixer = net.ReadEntity()

    zmlab2.Interface.Create(600,365,zmlab2.language["SelectMethType"],function(pnl)

        zmlab2.Interface.AddModelList(pnl,zmlab2.config.MethTypes,function(id)
            // IsLocked
            return zmlab2.Mixer.MethTypeCheck(LocalPlayer(),id) == false
        end,
        function(id)
            // IsSelected
            return IsValid(LocalPlayer().zmlab2_Mixer) and LocalPlayer().zmlab2_Mixer:GetMethType() == id
        end,
        function(id)
            // OnClick
            net.Start("zmlab2_Mixer_SetMethType")
            net.WriteEntity(LocalPlayer().zmlab2_Mixer)
            net.WriteUInt(id, 16)
            net.SendToServer()
        end,
        function(raw_data)
            return {model = raw_data.crystal_mdl,render = {FOV = 35},color = raw_data.color} , raw_data.name , zclib.Money.Display(raw_data.price * ( zmlab2.config.NPC.SellRanks[zclib.Player.GetRank(LocalPlayer())] or zmlab2.config.NPC.SellRanks["default"]))
        end)
    end)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a
