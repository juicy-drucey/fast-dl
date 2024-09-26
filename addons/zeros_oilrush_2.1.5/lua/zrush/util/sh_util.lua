/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.util = zrush.util or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function zrush.Print(msg)
	print("[Zero´s OilRush] " .. msg)
end

if CLIENT then
	function zrush.util.LoopedSound(ent, soundfile, shouldplay,pitch)
		if shouldplay and zclib.util.InDistance(LocalPlayer():GetPos(), ent:GetPos(), 2000) then
			if ent.Sounds == nil then
				ent.Sounds = {}
			end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

			if ent.Sounds[soundfile] == nil then
				ent.Sounds[soundfile] = CreateSound(ent, soundfile)
			end

			// If the sound is not playing or it should be updated then start/restart the sound
			if ent.Sounds[soundfile]:IsPlaying() == false or ent.UpdateSound then
				ent.Sounds[soundfile]:Play()
				ent.Sounds[soundfile]:ChangeVolume(1, 0)
				ent.Sounds[soundfile]:ChangePitch(pitch, 1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

				ent.UpdateSound = false
			end
		else
			if ent.Sounds == nil then
				ent.Sounds = {}
			end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354

			if ent.Sounds[soundfile] ~= nil and ent.Sounds[soundfile]:IsPlaying() == true then
				ent.Sounds[soundfile]:ChangeVolume(0, 0)
				ent.Sounds[soundfile]:Stop()
				ent.Sounds[soundfile] = nil
			end
		end
	end
end
