/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Draw()
	self:DrawModel()

	if zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 300) then
		self:DrawInfo()
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:DrawInfo()
	local Text = math.Round(self:GetResourceAmount()) .. zrmine.config.BuyerNPC_Mass
	cam.Start3D2D(self:GetPos() + Vector(0, 0, 10), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)
		draw.DrawText(Text, "zrmine_resource_font1", 0, 15, zrmine.default_colors["white02"], TEXT_ALIGN_CENTER)
	cam.End3D2D()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a6f74c3a898a8afac5e678d2e5f1471086507e768f0d31961c53cd0d44817e99

function ENT:OnRemove()
	zrmine.f.EmitSoundENT("zrmine_resourcedespawn", self)
	zrmine.f.ParticleEffect("zrms_resource_despawn", self:GetPos(), self:GetAngles(), self)
end
