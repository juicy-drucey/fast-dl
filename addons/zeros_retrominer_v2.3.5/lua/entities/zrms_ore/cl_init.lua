/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:Draw()
	self:DrawModel()

	if zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 300) and not zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 15) then
		self:DrawInfo()
	end

	if zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 1000) then
		self:UpdateVisualsDraw()
	else
		self.LastAmount = -1
		self.LastType = -1
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:DrawTranslucent()
	self:Draw()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:DrawInfo()
	local amount = math.Round(self.LastAmount)
	local Text = amount .. zrmine.config.BuyerNPC_Mass

	if (amount <= 0) then
		Text = zrmine.language.Ore_Empty
	end

	cam.Start3D2D(self:LocalToWorld(Vector(0,0,60)), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.2)
		draw.DrawText(zrmine.f.GetOreTranslation(self.LastType), "zrmine_mineentrance_font1", 0, -50, zrmine.default_colors["white02"], TEXT_ALIGN_CENTER)
		draw.DrawText(Text, "zrmine_resource_font2", 0, 0, zrmine.default_colors["white02"], TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

function ENT:Initialize()
	self.InsertEffect = ParticleEmitter(self:GetPos())
	self.LastAmount = -1
	self.LastType = -1
end

function ENT:UpdateVisualsDraw()
	local rType = self:GetResourceType()
	local rAmount = self:GetResourceAmount()

	if self.LastAmount ~= rAmount or self.LastType ~= rType then
		self.LastAmount = rAmount
		self.LastType = rType
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90
