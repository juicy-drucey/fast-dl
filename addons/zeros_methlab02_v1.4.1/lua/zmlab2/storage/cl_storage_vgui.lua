/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
net.Receive("zmlab2_Storage_OpenInterface", function(len)
    zclib.Debug_Net("zmlab2_Storage_OpenInterface",len)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    LocalPlayer().zmlab2_Storage = net.ReadEntity()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    zmlab2.Interface.Create(600,365,zmlab2.language["Storage"],function(pnl)

        zmlab2.Interface.AddModelList(pnl,zmlab2.config.Storage.Shop,function(id)
            // IsLocked
            return zmlab2.Storage.BuyCheck(LocalPlayer(),id) == false
        end,
        function(id)
            // IsSelected
            return false
        end,
        function(id)
            // OnClick
            if LocalPlayer().zmlab2_Storage:GetNextPurchase() > CurTime() then return end

            net.Start("zmlab2_Storage_Buy")
            net.WriteEntity(LocalPlayer().zmlab2_Storage)
            net.WriteUInt(id,16)
            net.SendToServer()
        end,
        function(raw_data)
            return {model = raw_data.model,render = {FOV = 35},color = raw_data.color,bodygroup = {[0] = 5}} , raw_data.name , zclib.Money.Display(raw_data.price)
        end)
    end)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
