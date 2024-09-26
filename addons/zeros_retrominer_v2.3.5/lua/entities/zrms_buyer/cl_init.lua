/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	self.LastState = -1
end

function ENT:Draw()
	self:DrawModel()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 250) then
		self:DrawInfo()

		if zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 100) then
			self:DrawDetailInfo()
		end
	end
end

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:DrawInfo()
	cam.Start3D2D(self:LocalToWorld(Vector(0,0,80 + 1 * math.abs(math.sin(CurTime()) * 1) )), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)

		draw.RoundedBox(25, -200, 50, 400, 50, zrmine.default_colors["black01"])
		local sellProfit = self:GetBuyRate()
		sellProfit = sellProfit - 100
		local pColor = zrmine.default_colors["red02"]

		if (sellProfit < 0) then
			sellProfit = sellProfit
			pColor = zrmine.default_colors["red02"]
		else
			sellProfit = "+ " .. sellProfit
			pColor = zrmine.default_colors["green01"]
		end

		draw.DrawText(zrmine.language.NPC_SellProfit, "zrmine_npc_font2", -175, 60, zrmine.default_colors["white02"], TEXT_ALIGN_LEFT)
		draw.DrawText(sellProfit .. "%", "zrmine_npc_font2", 190, 62, pColor, TEXT_ALIGN_RIGHT)
		draw.SimpleTextOutlined(zrmine.language.NPC_Title, "zrmine_npc_font1", 0, 20, zrmine.default_colors["white02"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, zrmine.default_colors["black02"])
	cam.End3D2D()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

local offsetX, offsetY = -140, 185
function ENT:DrawResourceItem(OreType, xpos, ypos, size)
	surface.SetDrawColor(zrmine.f.GetOreColor(OreType))
	surface.SetMaterial(zrmine.default_materials["MetalBar"])
	surface.DrawTexturedRect(xpos + offsetX, ypos + offsetY, size, size)

	local Info = ": " .. zrmine.config.Currency .. math.Round(zrmine.config.BarValue[OreType] * (self:GetBuyRate() / 100))
	draw.DrawText(Info, "zrmine_npc_font4", xpos + offsetX + 30, ypos + offsetY + size * 0.25, zrmine.default_colors["white02"], TEXT_ALIGN_LEFT)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function ENT:DrawDetailInfo()
	cam.Start3D2D(self:LocalToWorld(Vector(0,0,80 + 1 * math.abs(math.sin(CurTime()) * 1) )), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)

		draw.RoundedBox(25, -200, 110, 120, 160, zrmine.default_colors["black01"])
		draw.DrawText(zrmine.language.NPC_CashPerBar, "zrmine_npc_font3", -140, 120, zrmine.default_colors["white02"], TEXT_ALIGN_CENTER)

		self:DrawResourceItem("Iron", -55, -50, 30)
		self:DrawResourceItem("Bronze", -55, -25, 30)
		self:DrawResourceItem("Silver", -55, 0, 30)
		self:DrawResourceItem("Gold", -55, 25, 30)
	cam.End3D2D()
end

function ENT:Think()
	self:AnimationHandler()
	self:SetNextClientThink(CurTime())
	return true
end


function ENT:AnimationHandler()

	local CurrentState = self:GetCurrentState()

	if self.LastState ~= CurrentState then
		self.LastState = CurrentState
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

		if self.LastState == 0 then
			zrmine.f.Animation(self, zrmine.config.MetalBuyer.anim_idle[math.random(#zrmine.config.MetalBuyer.anim_idle)], 2)
		elseif self.LastState == 1 then
			zrmine.f.Animation(self, zrmine.config.MetalBuyer.anim_sell[math.random(#zrmine.config.MetalBuyer.anim_sell)], 2)

			zrmine.f.EmitSoundENT("zrmine_npc_sell",self)
		elseif self.LastState == 2 then

			zrmine.f.EmitSoundENT("zrmine_npc_wrongjob",self)

		end
	end
end
