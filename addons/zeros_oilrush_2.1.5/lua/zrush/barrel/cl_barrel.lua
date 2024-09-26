/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if SERVER then return end
zrush = zrush or {}
zrush.Barrel = zrush.Barrel or {}

function zrush.Barrel.Initialize(Barrel)
    zclib.EntityTracker.Add(Barrel)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function zrush.Barrel.OnRemove(Barrel)
    zclib.EntityTracker.Remove(Barrel)
end

function zrush.Barrel.Draw(Barrel)
    if zclib.Convar.Get("zclib_cl_drawui") == 1 and zclib.util.InDistance(Barrel:GetPos(), LocalPlayer():GetPos(), 500) then
        local oil = Barrel:GetOil()
        local Fuel = Barrel:GetFuel()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

        if oil > 0 then
            Barrel.SmoothOil = Lerp(FrameTime() * 2, Barrel.SmoothOil or 0,oil)
            zrush.Barrel.DrawInfo(Barrel, 1, Barrel.SmoothOil)
        elseif Fuel > 0 then
            Barrel.SmoothFuel = Lerp(FrameTime() * 2, Barrel.SmoothFuel or 0,Fuel)
            zrush.Barrel.DrawInfo(Barrel, 2, Fuel)
        else
            zrush.Barrel.DrawInfo(Barrel, 0, 0)
        end
    end
end

local l_pos01 = Vector(3.2, -17.15, 6.5)
local l_ang01 = Angle(-180, 0, 90)
local l_pos02 = Vector(-3.2, 17.15, 6.5)
local l_ang02 = Angle(0, 0, -90)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

function zrush.Barrel.DrawInfo(Barrel, ltype, lamount)
    local aBar = math.Clamp((435 / zrush.config.Barrel.Storage) * lamount, 0, 435)
    cam.Start3D2D(Barrel:LocalToWorld(l_pos01), Barrel:LocalToWorldAngles(l_ang01), 0.1)
        draw.RoundedBox(0, 0, -30, 60, 435, zrush.default_colors["grey01"])
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

        if ltype == 1 then
            draw.RoundedBox(0, 0, -30, 60, aBar, color_black)
        elseif ltype == 2 then
            draw.RoundedBox(0, 0, -30, 60, aBar, zrush.Fuel.GetDarkenColor(Barrel:GetFuelTypeID()))
        else
            draw.RoundedBox(0, 0, -30, 60, aBar, color_white)
        end

        surface.SetDrawColor(zrush.default_colors["white02"])
        surface.SetMaterial(zrush.default_materials["barrel_scalar"])
        surface.DrawTexturedRect(0, -30, 64, 435)
    cam.End3D2D()

    cam.Start3D2D(Barrel:LocalToWorld(l_pos02), Barrel:LocalToWorldAngles(l_ang02), 0.1)
        draw.RoundedBox(0, 0, -30, 60, 435, zrush.default_colors["grey01"])

        if ltype == 1 then
            draw.RoundedBox(0, 0, -30, 60, aBar, color_black)
        elseif ltype == 2 then
            draw.RoundedBox(0, 0, -30, 60, aBar, zrush.Fuel.GetDarkenColor(Barrel:GetFuelTypeID()))
        else
            draw.RoundedBox(0, 0, -30, 60, aBar, color_white)
        end

        surface.SetDrawColor(zrush.default_colors["white02"])
        surface.SetMaterial(zrush.default_materials["barrel_scalar"])
        surface.DrawTexturedRect(0, -30, 64, 435)
    cam.End3D2D()
end
