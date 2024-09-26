/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
zmlab2 = zmlab2 or {}
zmlab2.Storage = zmlab2.Storage or {}

function zmlab2.Storage.DrawUI(Storage)
    if zclib.util.InDistance(LocalPlayer():GetPos(),Storage:GetPos(), 1000) and zclib.Convar.Get("zmlab2_cl_drawui") == 1 then
        cam.Start3D2D(Storage:LocalToWorld(Vector(0, 13.5, 40)), Storage:LocalToWorldAngles(Angle(0, 180, 90)), 0.1)
            local txtSize = zclib.util.GetTextSize(zmlab2.language["Storage"], zclib.GetFont("zmlab2_font02"))
            local barSize = txtSize * 1.1
            draw.RoundedBox(0, -barSize / 2, -48, barSize, 48, zclib.colors["black_a200"])
            local nextTime = math.Clamp(Storage:GetNextPurchase() - CurTime(), 0, zmlab2.config.Storage.BuyInterval)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a

            if nextTime > 0 then
                draw.RoundedBox(0, -barSize / 2, -48, (barSize / zmlab2.config.Storage.BuyInterval) * nextTime, 48, zmlab2.colors["orange01"])
            end

            zclib.util.DrawOutlinedBox(-barSize / 2, -48, barSize, 48, 2, color_white)
            draw.SimpleText(zmlab2.language["Storage"], zclib.GetFont("zmlab2_font02"), 0, -23, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function zmlab2.Storage.Initialize(Storage) end
function zmlab2.Storage.OnRemove(Storage) end
