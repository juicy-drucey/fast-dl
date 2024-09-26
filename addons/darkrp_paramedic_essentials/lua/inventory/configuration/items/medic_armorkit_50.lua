local ITEM = XeninInventory:CreateItemV2()
ITEM:SetMaxStack(5)
ITEM:SetModel("models/Items/battery.mdl")
ITEM:SetDescription("Gives 50% armor when consumed.")

ITEM:AddDrop(function(self, ply, ent, tbl, tr)
    local data = tbl.data
end)

function ITEM:GetData(ent)
end

function ITEM:GetName(item)
	return "Armor Kit +50"
end

ITEM:Register("medic_armorkit_50")
