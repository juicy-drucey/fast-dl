/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

zclib.NetEvent.AddDefinition("sell", {
	[1] = {
		type = "vector"
	},
}, function(received)
	zclib.Effect.ParticleEffect("zmlab2_purchase", received[1], angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "cash")
end)

zclib.NetEvent.AddDefinition("clean", {
	[1] = {
		type = "vector"
	},
}, function(received)
	zclib.Effect.ParticleEffect("zmlab2_cleaning", received[1], angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "cleaning_shrub")
	zclib.Sound.EmitFromPosition(received[1], "cleaning_splash")
end)

zclib.NetEvent.AddDefinition("extinguish", {
	[1] = {
		type = "vector"
	},
}, function(received)
	zclib.Effect.ParticleEffect("zmlab2_extinguish", received[1], angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "Extinguish")
end)

zclib.NetEvent.AddDefinition("methylamin_fill", {
	[1] = {
		type = "entity"
	},
}, function(received)
	zclib.Effect.ParticleEffect("zmlab2_methylamin_fill", received[1]:LocalToWorld(Vector(11,0,53)), angle_zero, received[1])
end)

zclib.NetEvent.AddDefinition("aluminium_fill", {
	[1] = {
		type = "entity"
	},
}, function(received)
	zclib.Effect.ParticleEffect("zmlab2_aluminium_fill", received[1]:LocalToWorld(Vector(11,0,60)), angle_zero, received[1])
end)

zclib.NetEvent.AddDefinition("acid_fill", {
	[1] = {
		type = "entity"
	},
}, function(received)
	zclib.Sound.EmitFromEntity("liquid_fill", received[1])
	zclib.Effect.ParticleEffect("zmlab2_acid_fill", received[1]:LocalToWorld(Vector(-5,0,62)), received[1]:LocalToWorldAngles(angle_zero), received[1])
end)

zclib.NetEvent.AddDefinition("acid_explo", {
	[1] = {
		type = "vector"
	},
}, function(received)

	zclib.Effect.ParticleEffect("zmlab2_acid_explo", received[1], angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "acid_explo")

	zclib.Effect.RandomDecals(received[1], "BeerSplash",50)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

zclib.NetEvent.AddDefinition("alu_explo", {
	[1] = {
		type = "vector"
	},
}, function(received)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358

	zclib.Effect.ParticleEffect("zmlab2_aluminium_explo", received[1] + Vector(0,0,10), angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "aluminium_explo")
end)

zclib.NetEvent.AddDefinition("methylamin_explo", {
	[1] = {
		type = "vector"
	},
}, function(received)

	zclib.Effect.ParticleEffect("zmlab2_methylamine_explo", received[1], angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "cleaning_splash")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723

	zclib.Effect.RandomDecals(received[1], "BeerSplash",75)
end)

zclib.NetEvent.AddDefinition("lox_explo", {
	[1] = {
		type = "vector"
	},
}, function(received)

	zclib.Effect.ParticleEffect("zmlab2_lox_explo", received[1] + Vector(0,0,10), angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "lox_explo")
end)

zclib.NetEvent.AddDefinition("meth_break", {
	[1] = {
		type = "vector"
	},
	[2] = {
		type = "uiint"
	},
}, function(received)

	local m_data = zmlab2.config.MethTypes[received[2]]
	if m_data == nil or m_data.visuals == nil or m_data.visuals.effect_breaking == nil then return end
	zclib.Effect.ParticleEffect(m_data.visuals.effect_breaking, received[1], angle_zero)
end)

zclib.NetEvent.AddDefinition("meth_explo", {
	[1] = {
		type = "vector"
	},
	[2] = {
		type = "uiint"
	},
}, function(received)

	local m_data = zmlab2.config.MethTypes[received[2]]
	if m_data == nil or m_data.visuals == nil or m_data.visuals.effect_exploding == nil then return end
	zclib.Effect.ParticleEffect(m_data.visuals.effect_exploding, received[1] + Vector(0,0,10), angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "progress_fillingcrate")
end)

zclib.NetEvent.AddDefinition("meth_fill", {
	[1] = {
		type = "vector"
	},
	[2] = {
		type = "uiint"
	},
}, function(received)
	local m_data = zmlab2.config.MethTypes[received[2]]
	if m_data == nil or m_data.visuals == nil or m_data.visuals.effect_filling == nil then return end
	zclib.Effect.ParticleEffect(m_data.visuals.effect_filling, received[1] + Vector(0,0,10), angle_zero)
	zclib.Sound.EmitFromPosition(received[1], "crate_fill")
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358
