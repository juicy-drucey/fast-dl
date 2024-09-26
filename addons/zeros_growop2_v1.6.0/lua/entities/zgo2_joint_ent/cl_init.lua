/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	zclib.EntityTracker.Add(self)
	self.Last_IsBurning = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	timer.Simple(0.5, function()
		if IsValid(self) then
			self.m_Initialized = true
		end
	end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function ENT:Draw()
	self:DrawModel()
	self:DrawInfo()
end

function ENT:DrawTranslucent()
	self:Draw()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

function ENT:DrawInfo()
	if not LocalPlayer().zgo2_Initialized then return end
	if not zclib.Convar.GetBool("zclib_cl_drawui") then return end
	if zclib.util.InDistance(self:GetPos(), LocalPlayer():GetPos(), zgo2.util.RenderDistance_UI) == false then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if zclib.Entity.GetLookTarget() ~= self then return end

	local id = self:GetWeedID()
	if id and id > 0 then
		zgo2.HUD.Draw(self,function()
			local name = zgo2.Plant.GetName(id)
			local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_medium")) * 1.2
			draw.RoundedBox(20, -boxSize/2,-90, boxSize, 210, zclib.colors["black_a200"])
			draw.SimpleText(name, zclib.GetFont("zclib_world_font_medium"), 0, -45, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(self:GetWeedAmount() .. zgo2.config.UoM, zclib.GetFont("zclib_world_font_medium"), 0, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(self:GetWeedTHC() .. "%", zclib.GetFont("zclib_world_font_medium"), 0, 80, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			draw.SimpleText("▼", zclib.GetFont("zclib_world_font_large"), 0, 150, zclib.colors["black_a200"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end,0.05)
	end
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function ENT:Think()
	if not self.m_Initialized then return end
	if not LocalPlayer().zgo2_Initialized then return end

	if zclib.util.InDistance(self:GetPos(), LocalPlayer():GetPos(), zgo2.util.RenderDistance_UI) then
		local _IsBurning = self:GetIsBurning()

		if self.Last_IsBurning ~= _IsBurning then
			self.Last_IsBurning = _IsBurning

			if self.Last_IsBurning then
				self:SetSkin(1)
				zclib.Effect.ParticleEffectAttach("zgo2_ent_fire", PATTACH_POINT_FOLLOW, self, 1)
			else
				self:StopParticles()
			end
		end
	else
		if self.Last_IsBurning == true then
			self.Last_IsBurning = false
			self:StopParticles()
		end
	end
end
