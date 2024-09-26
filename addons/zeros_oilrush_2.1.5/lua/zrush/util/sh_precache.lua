/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

AddCSLuaFile()

game.AddParticles("particles/zrush_burner_vfx.pcf")
PrecacheParticleSystem("zrush_burner")
PrecacheParticleSystem("zrush_burner_overheat")
PrecacheParticleSystem("zrush_butangas")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

game.AddParticles("particles/zrush_drill_vfx.pcf")
PrecacheParticleSystem("zrush_drillgas")
game.AddParticles("particles/zrush_refinery_vfx.pcf")
PrecacheParticleSystem("zrush_refinery_overheat")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

game.AddParticles("particles/zrush_oil_vfx.pcf")
PrecacheParticleSystem("zrush_barrel_oil_fill")
PrecacheParticleSystem("zrush_barrel_fuel_fill")
PrecacheParticleSystem("zrush_barrel_oil_splash")
PrecacheParticleSystem("zrush_drillhole_splash")


util.PrecacheModel( "models/zerochain/props_oilrush/zor_drillpipe.mdl" )
util.PrecacheModel( "models/zerochain/props_oilrush/zor_barrel.mdl" )
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

util.PrecacheSound("zrush/zrush_ui_hover.wav")
util.PrecacheSound("zrush/zrush_command.wav")
