/*
    Addon id: 53a02d3e-9f6a-4fcf-a0e0-1b6e5030f80a
    Version: v2.3.5 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	self.LastStorage = 0

	timer.Simple(0.25,function()
		if IsValid(self) then self.Initialized = true end
	end)
end

function ENT:Draw()
	self:DrawModel()

	if zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 150) and not zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 15) then
		self:DrawInfo()
	end
end

function ENT:DrawTranslucent()
	self:Draw()
end


// UI STUFF
local size = 75
function ENT:DrawResourceItem(Info, color, offsetY)

	draw.RoundedBox(1, -2, 69 + offsetY, 4, 7, zrmine.default_colors["white01"])
	surface.SetDrawColor(zrmine.default_colors["white03"])
	surface.SetMaterial(zrmine.default_materials["Circle"])
	surface.DrawTexturedRect(-38, offsetY, size, size)

	surface.SetDrawColor(color)
	surface.SetMaterial(zrmine.default_materials["Ore"])
	surface.DrawTexturedRect(-38, offsetY, size, size)

	draw.DrawText(Info .. zrmine.config.BuyerNPC_Mass, "zrmine_gravelcrate_font1", 1, offsetY + 32, zrmine.default_colors["white02"], TEXT_ALIGN_CENTER)
end

function ENT:DrawInfo()
	local rTable = {
		["Coal"] = {a = math.Round(self:GetCoal(), 1),c = zrmine.default_colors["Coal"]},
		["Iron"] = {a = math.Round(self:GetIron(), 1),c = zrmine.default_colors["Iron"]},
		["Bronze"] = {a = math.Round(self:GetBronze(), 1),c = zrmine.default_colors["Bronze"]},
		["Silver"] = {a = math.Round(self:GetSilver(), 1),c = zrmine.default_colors["Silver"]},
		["Gold"] = {a = math.Round(self:GetGold(), 1),c = zrmine.default_colors["Gold"]},
	}

	cam.Start3D2D(self:LocalToWorld(Vector(0,0,27)), Angle(0, LocalPlayer():EyeAngles().y - 90, LocalPlayer():EyeAngles().z + 90), 0.15)
		local oY = -35

		for k, v in pairs(rTable) do
			if (rTable[k].a > 0) then
				self:DrawResourceItem(rTable[k].a, rTable[k].c, oY)
				oY = oY - 70
			end
		end
	cam.End3D2D()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f1849cde4e345dc510f53fbc77f4b3d19e9f7ae22a9a6747c929a9ca610e07ca


// Visual Update
function ENT:Think()
	self:UpdateVisuals()
end

function ENT:UpdateVisuals()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if self.Initialized and zrmine.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 1000) then

		local Iron = self:GetIron()
		local Bronze = self:GetBronze()
		local Silver = self:GetSilver()
		local Gold = self:GetGold()
		local Coal = self:GetCoal()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e2cff8b15e84b9731e7b1ac69adba0a375d06eed99ccee16134bf62ce0aadf90

		local storedAmount = Iron + Bronze + Silver + Gold + Coal

		if self.LastStorage ~= storedAmount then
			self.LastStorage = storedAmount

			if (storedAmount >= zrmine.config.GravelCrates_Capacity) then
				self:SetBodygroup(0, 3)
			elseif (storedAmount >= zrmine.config.GravelCrates_Capacity / 2) then
				self:SetBodygroup(0, 2)
			elseif (storedAmount > 0) then
				self:SetBodygroup(0, 1)
			elseif (storedAmount <= 0) then
				self:SetBodygroup(0, 0)
			end

			local rTable = {
				["Coal"] = Coal,
				["Iron"] = Iron,
				["Bronze"] = Bronze,
				["Silver"] = Silver,
				["Gold"] = Gold,
			}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 1616bf01a934d3729516d5b25e4a760b38b3815c71cce4ec1a37365f322bdef6

			local rSkin
			local HasMultipleRessources = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8ec16fe319ffa8f48fc58153dc623393675217dea42f94e8360eb7f2bb7f94d2

			for k, v in pairs(rTable) do
				if v > 0 then
					if rSkin == nil then
						rSkin = k
					else
						HasMultipleRessources = true
						break
					end
				end
			end

			if storedAmount > 0 then
				if HasMultipleRessources then
					self:SetSkin(0)
					zrmine.f.Debug("GravelCrate has Multiple Ressources.")

				else
					if rSkin == "Coal" then
						self:SetSkin(5)
					elseif rSkin == "Iron" then
						self:SetSkin(1)
					elseif rSkin == "Bronze" then
						self:SetSkin(2)
					elseif rSkin == "Silver" then
						self:SetSkin(3)
					elseif rSkin == "Gold" then
						self:SetSkin(4)
					end
					zrmine.f.Debug("GravelCrate only has: " .. rSkin)
				end
			end
		end
	else
		self.LastStorage = -1
	end
end
