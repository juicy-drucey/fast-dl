/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if SERVER then return end
zrush = zrush or {}
zrush.Burner = zrush.Burner or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

function zrush.Burner.Initialize(Burner)
    Burner:UpdatePitch()
    Burner.UpdateSound = false
    Burner.LastState = "nil"
    zclib.EntityTracker.Add(Burner)
end

function zrush.Burner.Think(Burner)
    if zclib.util.InDistance(LocalPlayer():GetPos(), Burner:GetPos(), 1000) then
        // One time Effect Creation
        local cur_state = Burner:GetState()

        if Burner.LastState ~= cur_state then
            Burner.LastState = cur_state
            Burner:StopParticles()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

            if (Burner.LastState == ZRUSH_STATE_BURNINGGAS) then
                zclib.Effect.ParticleEffectAttach("zrush_burner", PATTACH_POINT_FOLLOW, Burner, 4)
            elseif (Burner.LastState == ZRUSH_STATE_OVERHEAT) then
                zclib.Effect.ParticleEffectAttach("zrush_burner_overheat", PATTACH_POINT_FOLLOW, Burner, 4)
            end
        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

        // Playing looped sound
        zrush.util.LoopedSound(Burner, "zrush_sfx_overheat_loop", Burner:IsOverHeating() == true and cur_state == ZRUSH_STATE_OVERHEAT, 70)
        zrush.util.LoopedSound(Burner, "zrush_sfx_refine", Burner:IsOverHeating() == false and cur_state == ZRUSH_STATE_BURNINGGAS, Burner.SoundPitch)
    else
        if Burner.LastState ~= nil then
            Burner.LastState = nil
            Burner:StopParticles()
        end
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function zrush.Burner.OnRemove(Burner)
    Burner:StopSound("zrush_sfx_overheat_loop")
    Burner:StopSound("zrush_sfx_refine")
    Burner:StopParticles()
    zclib.EntityTracker.Remove(Burner)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354
