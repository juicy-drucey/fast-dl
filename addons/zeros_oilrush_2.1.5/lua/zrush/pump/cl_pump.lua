/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if SERVER then return end
zrush = zrush or {}
zrush.Pump = zrush.Pump or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function zrush.Pump.Initialize(Pump)
    Pump:UpdatePitch()
    Pump.UpdateSound = false
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

function zrush.Pump.Think(Pump)
    if zclib.util.InDistance(LocalPlayer():GetPos(), Pump:GetPos(), 1000) then
        -- One time Effect Creation
        local cur_state = Pump:GetState()
        -- Playing looped sound
        zrush.util.LoopedSound(Pump, "zrush_sfx_jammed", Pump:IsJammed() == true and cur_state == ZRUSH_STATE_JAMMED, 70)
        zrush.util.LoopedSound(Pump, "zrush_sfx_pump", Pump:IsJammed() == false and cur_state == ZRUSH_STATE_PUMPING, Pump.SoundPitch)
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

function zrush.Pump.OnRemove(Pump)
    Pump:StopSound("zrush_sfx_pump")
    Pump:StopSound("zrush_sfx_jammed")
    Pump:StopParticles()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22
