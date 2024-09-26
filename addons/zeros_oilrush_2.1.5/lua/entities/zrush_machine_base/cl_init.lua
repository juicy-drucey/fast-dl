/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

function ENT:Draw()
	self:DrawModel()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:UpdatePitch()
	local maxSpeed = zrush.config.Machine[self.MachineID].Speed * 2
	local current_Speed = zrush.config.Machine[self.MachineID].Speed * (1 + self:GetSpeedBoost())
	self.SoundPitch = math.Clamp((140 / maxSpeed) * current_Speed, 0, 140) // Maybe replace 140 with 200 idk
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

// This Updates some of the Sound Info
function ENT:UpdateSoundInfo()
	self:UpdatePitch()
	self.UpdateSound = true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2
