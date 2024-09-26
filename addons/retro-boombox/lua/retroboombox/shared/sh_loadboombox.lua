game.AddParticles( "particles/sterling/retro_vfx.pcf" )
PrecacheParticleSystem("music_notes_core")
PrecacheParticleSystem("music_notes_02")
PrecacheParticleSystem("music_stars")

hook.Add("PreGamemodeLoaded", "PreGamemodeLoaded.RetroBoombox", function()
	for sClass, tColors in pairs( RetroBoombox.Config.Boombox ) do

		local ENT = scripted_ents.Get( "retro_boombox_base" )
		
		ENT.PrintName = "Boombox : " .. sClass
		ENT.ClassName = sClass
		ENT.Spawnable = true
		ENT.Base = "retro_boombox_base"
		ENT.MainColor = tColors.MainColor
		ENT.MainLightsColor = tColors.MainLightsColor
		ENT.TubeLightsColor = tColors.TubeLightsColor
		ENT.SoundLightsColor = tColors.SoundLightsColor
		ENT.SecondaryColor = tColors.SecondaryColor
		ENT.ScreenBackgroundColor = tColors.ScreenBackgroundColor
		ENT.ScreenContentColor = tColors.ScreenContentColor

		scripted_ents.Register( ENT, sClass )
		
	end

end)
