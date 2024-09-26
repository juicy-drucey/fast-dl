/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not CLIENT then return end
zmlab2 = zmlab2 or {}
zmlab2.Table = zmlab2.Table or {}

function zmlab2.Table.Initialize(Table)
    Table.IsAutobreaking = false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

local function DrawButton(x, y,w,h, txt, hover)
    draw.SimpleText(txt, zclib.GetFont("zmlab2_font02"), x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    zclib.util.DrawOutlinedBox(x - w / 2, y - h / 2, w, h, 4, color_white)
    if hover then
        draw.RoundedBox(0, x - w / 2, y - h / 2, w, h, zmlab2.colors["white02"])
    end
end

function zmlab2.Table.Draw(Table)
    if zclib.util.InDistance(LocalPlayer():GetPos(), Table:GetPos(), 1000) and Table.IsAutobreaking == false and zclib.Convar.Get("zmlab2_cl_drawui") == 1 then
        cam.Start3D2D(Table:LocalToWorld(Vector(0, 0, 36.3)), Table:LocalToWorldAngles(Angle(0, 180, 0)), 0.05)

            if IsValid(Table:GetCrate()) then
                DrawButton(-255, 210, 300, 80, zmlab2.language["Drop"], Table:OnDrop_Crate(LocalPlayer()))
            else
                local txtSize = zclib.util.GetTextSize(zmlab2.language["MissingCrate"], zclib.GetFont("zmlab2_font02"))
                local barSize = math.Clamp(txtSize * 1.1, 400, 700)
                zclib.util.DrawOutlinedBox((-barSize / 2) - 260, -140, barSize, 280, 8, zmlab2.colors["white02"])
                draw.SimpleText(zmlab2.language["MissingCrate"], zclib.GetFont("zmlab2_font02"), -260, 0, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            if IsValid(Table:GetTray()) then
                DrawButton(245, 210, 300, 80, zmlab2.language["Drop"], Table:OnDrop_Tray(LocalPlayer()))
            end
        cam.End3D2D()
    end
end

function zmlab2.Table.Think(Table)

    zclib.util.LoopedSound(Table, "zmlab2_machine_icebreaker_loop", Table.IsAutobreaking == true)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    if zclib.util.InDistance(LocalPlayer():GetPos(),Table:GetPos(), 1000) then
        if Table:GetIsAutobreaking() ~= Table.IsAutobreaking then
            Table.IsAutobreaking = Table:GetIsAutobreaking()

            if Table.IsAutobreaking then
                zclib.Animation.Play(Table,"run", 1)
            else
                zclib.Animation.Play(Table,"idle", 1)
            end
        end
    else
        Table.IsAutobreaking = nil
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function zmlab2.Table.OnRemove(Table)
    Table:StopSound("zmlab2_machine_icebreaker_loop")
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358
