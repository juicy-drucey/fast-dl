/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

zmlab2 = zmlab2 or {}
zmlab2.Storage = zmlab2.Storage or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 6934fa9aa9cae346d9d98f13a34cb65a9923e0c6860723630bc61c5cbd5ae93a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575

function zmlab2.Storage.BuyCheck(ply,id)
    local data = zmlab2.config.Storage.Shop[id]
    if data == nil then return false end
    if data.rank and istable(data.rank) and table.Count(data.rank) > 0 and zclib.Player.RankCheck(ply,data.rank) == false then return false end
    if data.job and istable(data.job) and table.Count(data.job) > 0 and data.job[zclib.Player.GetJob(ply)] == nil then return false end
    if data.customcheck and data.customcheck(ply) == false then return false end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723
