/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99

function ENT:Initialize()
	self.InsertEffect = ParticleEmitter(self:GetPos())
	zrmine.f.EntList_Add(self)
end

function ENT:ReturnStorage()
	return self:GetCoal() + self:GetIron() + self:GetBronze() + self:GetSilver() + self:GetGold()
end

function ENT:SplittSound()
	local MoveSound = CreateSound(self, "zrmine_sfx_conveyorbelt_move")

	if (self:GetCurrentState() == 1) then
		if self.SoundObj == nil then
			self.SoundObj = MoveSound
		end

		if self.SoundObj:IsPlaying() == false then
			self.SoundObj:Play()
			self.SoundObj:ChangeVolume(0, 0)
			self.SoundObj:ChangeVolume(GetConVar("zrms_cl_audiovolume"):GetFloat(), 1)
		end
	else
		if self.SoundObj == nil then
			self.SoundObj = MoveSound
		end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

		if self.SoundObj:IsPlaying() == true then
			self.SoundObj:ChangeVolume(0, 1)
			if ((self.lastSoundStop or CurTime()) > CurTime()) then return end
			self.lastSoundStop = CurTime() + 5

			timer.Simple(2, function()
				if (IsValid(self)) then
					self.SoundObj:Stop()
				end
			end)
		end
	end
end

function ENT:OnRemove()
	if (self.SoundObj ~= nil and self.SoundObj:IsPlaying()) then
		self.SoundObj:Stop()
	end
end

function ENT:Think()
	if zrmine.f.InDistance(self:GetPos(), LocalPlayer():GetPos(), 1000) then
		self:SplittSound()
	end
	self:SetNextClientThink(CurTime())
	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Draw()
	self:DrawModel()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

	if self.ShowInfo then
		zrmine.f.Belt_DrawInfo(self)
	end
end

function ENT:DrawTranslucent()
	self:Draw()
end
