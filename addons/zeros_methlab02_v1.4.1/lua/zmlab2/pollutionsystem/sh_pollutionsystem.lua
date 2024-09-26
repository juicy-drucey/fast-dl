/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

zmlab2 = zmlab2 or {}
zmlab2.PollutionSystem = zmlab2.PollutionSystem or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

zmlab2.PollutionSystem.PolutedAreas = zmlab2.PollutionSystem.PolutedAreas or {}

function zmlab2.PollutionSystem.GetSize()
    return 100
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

// Returns the Pump Duration
function zmlab2.PollutionSystem.GetPosition(raw_pos)
    local size = zmlab2.PollutionSystem.GetSize()
    return Vector(math.Round(zclib.util.SnapValue(size,raw_pos.x)),math.Round(zclib.util.SnapValue(size,raw_pos.y)),math.Round(zclib.util.SnapValue(size,raw_pos.z)))
end

function zmlab2.PollutionSystem.FindNearest(pos,dist)
    local id
    if zmlab2.PollutionSystem.PolutedAreas and #zmlab2.PollutionSystem.PolutedAreas > 0 then
        for k,v in pairs(zmlab2.PollutionSystem.PolutedAreas) do
            if v == nil then continue end
            if v.pos == nil then continue end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a

            //debugoverlay.Sphere(v.pos,10,1,Color( 255, 255, 255 ,50),true)

            if zclib.util.InDistance(v.pos, pos, dist) then
                //debugoverlay.Sphere(v.pos,25,1,Color( 0, 255, 0 ,50),true)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 26dae7d76e41fa1a07cc1df9ca15aaa8a69611b8a8ac7b7fe6f2c87d405dd477

                id = k
                break
            end
        end
    end
    return id
end
