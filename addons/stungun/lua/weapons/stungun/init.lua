
--[[
Stun gun SWEP Created by Donkie (http://steamcommunity.com/id/Donkie/)
For personal/server usage only, do not resell or distribute!
]]

AddCSLuaFile("shared.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

include("sv_stungun.lua")

-- Assets
resource.AddWorkshop("854872051")

function SWEP:Equip( ply )
	self.BaseClass.Equip(self,ply)
	self.lastowner = ply

	if STUNGUN.CanHolster then
		self:SetHolstered(true)
	end
end

util.AddNetworkString("tazerondrop")
function SWEP:OnDrop()
	self.BaseClass.OnDrop(self)

	if IsValid(self.lastowner) then
		net.Start("tazerondrop")
			net.WriteEntity(self)
		net.Send(self.lastowner)
	end

	self:Holster()
end

--[[
TTT Specifics
]]
if STUNGUN.IsTTT then
	function SWEP:WasBought(buyer)
		if not self.InfiniteAmmo then
			buyer:GiveAmmo(math.max(0, self.Ammo - 1), "ammo_stungun")
		end
	end
end
