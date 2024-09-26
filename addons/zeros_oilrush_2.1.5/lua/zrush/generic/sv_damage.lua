/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if CLIENT then return end
zrush = zrush or {}
zrush.Damage = zrush.Damage or {}

function zrush.Damage.Take(ent,dmginfo)
    if not ent.m_bApplyingDamage then
        ent.m_bApplyingDamage = true
        ent:TakePhysicsDamage(dmginfo)

        local class = ent:GetClass()
        local damage = dmginfo:GetDamage()
        local entHealth = zrush.config.Damageable[class]

        if (entHealth and entHealth > 0) then
            ent.CurrentHealth = (ent.CurrentHealth or entHealth) - damage

            if (ent.CurrentHealth <= 0) then

                if class == "zrush_burner" or class == "zrush_drilltower" or class == "zrush_pump" or class == "zrush_refinery" then

                    if class == "zrush_pump" then
                        local sBarrel = ent:GetBarrel()
        				if IsValid(sBarrel) then
        					zrush.Pump.DetachBarrel(ent)
        				end
                    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

                    if class == "zrush_refinery" then
                        // This detaches our barrels
        				zrush.Refinery.DetachBarrel(ent,1, ent:GetInputBarrel())
        				zrush.Refinery.DetachBarrel(ent,2, ent:GetOutputBarrel())
                    else
                        // This deletes the oilspot and the drillhole
                        local hole = ent:GetHole()
                        if IsValid(hole) and IsValid(hole.OilSpot) then
                            zrush.OilSpot.Remove(hole.OilSpot)
                        end
                    end
                end

                if class == "zrush_palette" then
                    local vPoint = ent:GetPos()
                    local effectdata = EffectData()
                    effectdata:SetStart(vPoint)
                    effectdata:SetOrigin(vPoint)
                    effectdata:SetScale(1)
                    util.Effect("WheelDust", effectdata)
                    SafeRemoveEntity(ent)
                else
                    zrush.Damage.EntityExplosion(ent, class, true)
                end
            end
        end

        ent.m_bApplyingDamage = false
    end
end

// This creates a explosion for a entity
function zrush.Damage.EntityExplosion(ent, EntityID, DoesDamage)

    if EntityID ~= "zrush_barrel" then
        // Close the interface for any player who has it open
        zrush.Machine.CloseUI(ent)
    end

    ent.IsDeconstructing = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

    zclib.Timer.Remove("zrush_working_" .. ent:EntIndex())
    zclib.Timer.Remove("zrush_explosiontimer_" .. ent:EntIndex())
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    if (DoesDamage) then
        for k, v in pairs(zclib.Player.List) do
            if (IsValid(v) and v:IsPlayer() and v:Alive() and zclib.util.InDistance(v:GetPos(), ent:GetPos(), 200)) and zrush.config.Machine[EntityID] and zrush.config.Machine[EntityID].OverHeat_Damage then
                v:TakeDamage(zrush.config.Machine[EntityID].OverHeat_Damage or 10, ent, ent)
            end
        end
    end

    local effectdata = EffectData()
    effectdata:SetStart(ent:GetPos())
    effectdata:SetOrigin(ent:GetPos())
    effectdata:SetScale((1 / 200) * 200)
    util.Effect("Explosion", effectdata)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354

    SafeRemoveEntityDelayed(ent,0.1)
end
