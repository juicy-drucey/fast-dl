/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
zmlab2 = zmlab2 or {}
zmlab2.FrezzerTray = zmlab2.FrezzerTray or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723

/*
    ProcessState
    0 = Empty
    1 = Liquid
    2 = Frozen
*/
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575


function zmlab2.FrezzerTray.Initialize(FrezzerTray)
    // Fixes the tray follwing the frezzer attachments correctly
	//FrezzerTray:SetPredictable(true) BUG Causes the entity while being moved to look like its lagging
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358

function zmlab2.FrezzerTray.Draw(FrezzerTray)
    if zmlab2.config.Frezzer.Tray_DisplayState and zclib.util.InDistance(LocalPlayer():GetPos(),FrezzerTray:GetPos(), 1000) and zclib.Convar.Get("zmlab2_cl_drawui") == 1 then

        cam.Start3D2D(FrezzerTray:LocalToWorld(Vector(0, 0, 0.5)), FrezzerTray:LocalToWorldAngles(Angle(0, 180, 0)), 0.5)
            local state = FrezzerTray:GetProcessState()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

            if state == 1 then
                surface.SetDrawColor(color_white)
                surface.SetMaterial(zclib.Materials.Get("icon_box01"))
                surface.DrawTexturedRectRotated(0, 0, 20, 20, 0)

                surface.SetDrawColor(color_white)
                surface.SetMaterial(zclib.Materials.Get("icon_cold"))
                surface.DrawTexturedRectRotated(0, 0, 15, 15, 0)
            elseif state == 2 then
                surface.SetDrawColor(color_white)
                surface.SetMaterial(zclib.Materials.Get("icon_box01"))
                surface.DrawTexturedRectRotated(0, 0, 20, 20, 0)

                surface.SetDrawColor(color_white)
                surface.SetMaterial(zclib.Materials.Get("icon_breaking"))
                surface.DrawTexturedRectRotated(0, 0, 15, 15, 0)
            end
        cam.End3D2D()
    end
end
