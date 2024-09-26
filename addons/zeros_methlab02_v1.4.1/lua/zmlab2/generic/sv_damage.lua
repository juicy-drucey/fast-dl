/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

if not SERVER then return end
zmlab2 = zmlab2 or {}
zmlab2.Damage = zmlab2.Damage or {}

function zmlab2.Damage.OnTake(entity, dmginfo)
	if (not entity.m_bApplyingDamage) then
		entity.m_bApplyingDamage = true

		entity:TakeDamageInfo(dmginfo)

		zmlab2.Damage.Inflict(entity,dmginfo)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358

		entity.m_bApplyingDamage = false
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

local MethClass = {
	["zmlab2_item_meth"] = true,
	["zmlab2_item_crate"] = true,
	["zmlab2_item_palette"] = true
}

function zmlab2.Damage.Inflict(entity,dmg)

	if zmlab2.config.Damageable[entity:GetClass()] and zmlab2.config.Damageable[entity:GetClass()] <= -1 then return end

	entity:SetHealth(entity:Health() - dmg:GetDamage())

	if dmg:GetDamageType() == DMG_BURN then
		local val = (255 / entity:GetMaxHealth()) * entity:Health()
		entity:SetColor(Color(val, val, val, 255))
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- ba138edb66f94512b587e9baaccbcfca07e21df5c3e51aaa0a3d137b1e065575
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    if entity:Health() <= 0 then

        // If the entity was a meth object and the attacker was police then give him some cash
		if MethClass[entity:GetClass()] then
			hook.Run("zmlab2_OnMethObjectDestroyed", entity, dmg)
		else
			if entity:GetClass() == "zmlab2_item_acid" then
				zclib.Damage.Explosion(entity, entity:GetPos(), 50, DMG_ACID, 15,true)
				zclib.NetEvent.Create("acid_explo",{[1] = entity:GetPos()})
			elseif entity:GetClass() == "zmlab2_item_lox" then
				zclib.NetEvent.Create("lox_explo",{[1] = entity:GetPos()})
			elseif entity:GetClass() == "zmlab2_item_aluminium" then
				zclib.NetEvent.Create("alu_explo",{[1] = entity:GetPos()})
			elseif entity:GetClass() == "zmlab2_item_methylamine" then
				zclib.Damage.Explosion(entity, entity:GetPos(), 50, DMG_ACID, 15,true)
				zclib.NetEvent.Create("methylamin_explo",{[1] = entity:GetPos()})
			else
				zclib.Damage.Effect(entity, "HelicopterMegaBomb")
				zclib.Sound.EmitFromPosition(entity:GetPos(), "machine_explode")
			end
		end

        // Stop moving if you have physics
        -- if entity.PhysicsDestroy then entity:PhysicsDestroy() end

		local phys = entity:GetPhysicsObject()
		if IsValid(phys) then phys:EnableMotion(false) end

        // Hide entity
        if entity.SetNoDraw then entity:SetNoDraw(true) end

        // This got taken from a Physcollide function but maybe its needed to prevent a crash
        local deltime = FrameTime() * 2
        if not game.SinglePlayer() then deltime = FrameTime() * 6 end
        SafeRemoveEntityDelayed(entity, deltime)
    end
end

function zmlab2.Damage.InflictBurn(entity, dmg)
	local d = DamageInfo()
	d:SetDamage(dmg)
	d:SetAttacker(entity)
	d:SetDamageType(DMG_BURN)
	zmlab2.Damage.Inflict(entity, d)
end
