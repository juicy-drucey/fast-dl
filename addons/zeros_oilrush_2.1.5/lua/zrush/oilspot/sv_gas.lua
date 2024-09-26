/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if not SERVER then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

local function ButanGas_DamagePlayers()

    for k, v in pairs(zrush.DrillHole.List) do
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

        local dmgInfo = DamageInfo()
        dmgInfo:SetDamage( zrush.config.Machine["DrillHole"].ButanGas_Damage )
        dmgInfo:SetAttacker( v )
        dmgInfo:SetDamageType( DMG_NERVEGAS )

        if (IsValid(v) and v:GetState() == ZRUSH_STATE_NEEDBURNER and v:GetGas() > 0) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

            for s, w in pairs(zclib.Player.List) do
                if (IsValid(w) and w:IsPlayer() and w:Alive() and zclib.util.InDistance(w:GetPos(),v:GetPos(),zrush.config.Machine["DrillHole"].ButanGas_DamageRadius)) then
                    w:TakeDamageInfo( dmgInfo )
                end
            end
        end
    end
end

timer.Simple(1,function()
    local timerid = "zrush_butangas_damagetimer_id"
    zclib.Timer.Remove(timerid)
    zclib.Timer.Create(timerid, zrush.config.Machine["DrillHole"].ButanGas_Speed, 0, ButanGas_DamagePlayers)
end)
