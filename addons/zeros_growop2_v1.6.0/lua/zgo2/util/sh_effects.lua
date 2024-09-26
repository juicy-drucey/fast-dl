/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

zclib.NetEvent.AddDefinition("zgo2_clipper_play", {
	[1] = {
		type = "entity"
	}
}, function(received)
	local ent = received[1]
	if not IsValid(ent) then return end
	if not ent:IsValid() then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	zgo2.Plant.UpdateMaterial(ent,zgo2.Plant.GetData(ent:GetWeedID()))

	ent:SetBodygroup(4,1)

	zclib.Animation.PlayTransition(ent,"output", 1,"idle",1)

	// PLay weed bud fall sound effect
	ent:EmitSound("zgo2_clipper_weed_output")
end)

zclib.NetEvent.AddDefinition("zgo2_pot_adddirt", {
	[1] = {
		type = "entity"
	}
}, function(received)
	local ent = received[1]
	if not IsValid(ent) then return end
	if not ent:IsValid() then return end

	zclib.Effect.ParticleEffect("zgo2_dirt_fill", ent:GetPos(), ent:GetAngles(), ent)
end)

zclib.NetEvent.AddDefinition("zgo2_pot_expodedirt", {
	[1] = {
		type = "vector"
	}
}, function(received)
	local pos = received[1]
	if not pos then return end

	zclib.Effect.ParticleEffect("zgo2_dirt_explo", pos, angle_zero, nil)
end)

zclib.NetEvent.AddDefinition("zgo2_plant_leafexplode", {
	[1] = {
		type = "vector"
	},
	[2] = {
		type = "uiint"
	},
	[3] = {
		type = "uiint"
	},
}, function(received)
	local pos = received[1]
	if not pos then return end

	local PlantID = received[2]
	if not PlantID then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

	local scale = (received[3] or 100) / 100

	zclib.Sound.EmitFromPosition(pos,"zgo2_plant_cut")

	local PlantData = zgo2.Plant.GetData(PlantID)
	if not PlantData then return end

	zgo2.util.ParticleExplosion(pos,5,math.Round(10 * scale),1,function()
		return "!zgo2_plant_leaf0" .. math.random(1, 2) .. "_dried_" .. PlantData.uniqueid
	end)
end)

zclib.NetEvent.AddDefinition("zgo2_plant_leafrushling", {
	[1] = {
		type = "entity"
	},
	[2] = {
		type = "vector"
	},
}, function(received)

	local Plant = received[1]
	if not IsValid(Plant) then return end
	if not Plant:IsValid() then return end

	local AttackerPos = received[2]

	local pos = Plant:LocalToWorld(Plant:OBBCenter())
	if not pos then return end

	local PlantID = Plant:GetPlantID()
	if not PlantID then return end

	local scale = Plant:GetModelScale()

	zclib.Sound.EmitFromPosition(pos,"zgo2_leaf_rustling")

	// Causes the entity to jiggle
	Plant.JiggleDirection = Plant:GetPos() - AttackerPos
	Plant.JiggleStrength = 1

	local PlantData = zgo2.Plant.GetData(PlantID)
	if not PlantData then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	zgo2.util.ParticleExplosion(pos,3 * scale,math.Round(10 * scale),1,function()
		return "!zgo2_plant_leaf0" .. math.random(1, 2) .. "_dried_" .. PlantData.uniqueid
	end)
end)

zclib.NetEvent.AddDefinition("zgo2_buy", {
	[1] = {
		type = "vector"
	}
}, function(received)
	local pos = received[1]
	if pos == nil then return end
	zclib.Effect.ParticleEffect("zgo2_buy", pos, angle_zero, LocalPlayer())
	zclib.Sound.EmitFromPosition(pos,"cash")
end)

zclib.NetEvent.AddDefinition("zgo2_destruction", {
	[1] = {
		type = "entity"
	}
}, function(received)
	local ent = received[1]
	if not IsValid(ent) then return end

	local effect = zgo2.Destruction.Effects[ent:GetClass()]
	if effect then effect(ent) end
end)
