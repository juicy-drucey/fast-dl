/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.OilSpot = zrush.OilSpot or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

function zrush.OilSpot.GetData(id)
    return zrush.Holes[id]
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

function zrush.OilSpot.GetRandom()
    // Get DrillHole Information
    local OilHolePool = {}
    for k, v in pairs(zrush.Holes) do
        for i = 1, v.chance do
            table.insert(OilHolePool, k)
        end
    end

    return table.Random(OilHolePool)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22
