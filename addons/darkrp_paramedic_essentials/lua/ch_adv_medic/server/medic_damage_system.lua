-- Paramedic Essential Damage System
-- Contains hooks that scale the players damage and applies injuries.

function CH_AdvMedic.ScaleDamage( ply, hitgroup, dmginfo )
	-- Check if disabled in config
	if not CH_AdvMedic.Config.EnableInjurySystem then
		return
	end

	local prev_health = ply:Health()
	
	timer.Simple( 0.1, function()
		-- Check if ply is valid
		if not IsValid( ply ) then
			return
		end
		
		-- Check if their health has actually changed (to support godmode, spawn protection, etc)
		if prev_health == ply:Health() then
			return
		end

		-- In case the variable does not exist, then create it.
		if not ply.CH_AdvMedic_DamageHitCount then
			ply.CH_AdvMedic_DamageHitCount = 0
		end
	
		-- If injuries are disabled for certain teams, check for teams.
		if CH_AdvMedic.Config.DisableInjuriesForCertainTeams then
			if CH_AdvMedic.Config.ImmuneInjuriesTeams[ team.GetName( ply:Team() ) ] then
				return
			end
		end
		
		-- Add another hit to the players count.
		ply.CH_AdvMedic_DamageHitCount = ply.CH_AdvMedic_DamageHitCount + 1
		
		-- Return end if not enough hits to register injuries yet
		if ply.CH_AdvMedic_DamageHitCount <= CH_AdvMedic.Config.HitsBeforeInjuries then
			return
		end
		
		local attacker = istable( dmginfo ) and dmginfo:GetAttacker() or nil
		local inflictor = istable( dmginfo ) and dmginfo:GetInflictor() or nil
		
		-- Check where players are hit, modify damage and check for injuries.
		if hitgroup == HITGROUP_HEAD then
			-- Might want to expand here later
		elseif hitgroup == HITGROUP_CHEST then
			if ply.CH_AdvMedic_HasInternalBleedings then
				return
			end

			ply.CH_AdvMedic_HasInternalBleedings = true
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You are experiencing internal bleedings. Find a paramedic as soon as possible." ) )
			
			local random_bleed_damage = math.random( CH_AdvMedic.Config.DamageFromBleedingMin, CH_AdvMedic.Config.DamageFromBleedingMax )
			
			timer.Create( ply:EntIndex() .."_StartInternalBleeding", CH_AdvMedic.Config.InternalBleedingInterval, 0, function()
				ply:TakeDamage( random_bleed_damage, attacker, inflictor )
				
				if CH_AdvMedic.Config.EnableBleedingHurtSounds then
					if ply:CH_AdvMedic_GetPlayersSex() == "Male" then
						ply:EmitSound( "vo/npc/male01/imhurt0".. math.random( 1, 2 ) ..".wav" )
					elseif ply:CH_AdvMedic_GetPlayersSex() == "Female" then
						ply:EmitSound( "vo/npc/female01/imhurt0".. math.random( 1, 2 ) ..".wav" )
					end
				end
			end )
		elseif hitgroup == HITGROUP_STOMACH then
			if ply.CH_AdvMedic_HasInternalBleedings then
				return
			end

			ply.CH_AdvMedic_HasInternalBleedings = true
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You are experiencing internal bleedings. Find a paramedic as soon as possible." ) )
			
			local random_bleed_damage = math.random( CH_AdvMedic.Config.DamageFromBleedingMin, CH_AdvMedic.Config.DamageFromBleedingMax )
			
			timer.Create( ply:EntIndex() .."_StartInternalBleeding", CH_AdvMedic.Config.InternalBleedingInterval, 0, function()
				ply:TakeDamage( random_bleed_damage, attacker, inflictor )
				
				if CH_AdvMedic.Config.EnableBleedingHurtSounds then
					if ply:CH_AdvMedic_GetPlayersSex() == "Male" then
						ply:EmitSound( "vo/npc/male01/imhurt0".. math.random( 1, 2 ) ..".wav" )
					elseif ply:CH_AdvMedic_GetPlayersSex() == "Female" then
						ply:EmitSound( "vo/npc/female01/imhurt0".. math.random( 1, 2 ) ..".wav" )
					end
				end
			end )
		elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
			if ply.CH_AdvMedic_HasBrokenArm then
				return
			end
			
			ply.CH_AdvMedic_HasBrokenArm = true
			
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your arm has broken!" ) )
		elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
			if ply.CH_AdvMedic_HasBrokenLeg then
				return
			end
			
			-- Store players current walk/run speed for setting it once fixing injuries.
			ply.CHMedic_OldWalkSpeed = ply:GetWalkSpeed()
			ply.CHMedic_OldRunSpeed = ply:GetRunSpeed()
			
			ply.CH_AdvMedic_HasBrokenLeg = true
			ply:SetWalkSpeed( CH_AdvMedic.Config.BrokenLegWalkSpeed )
			ply:SetRunSpeed( CH_AdvMedic.Config.BrokenLegRunSpeed )
			
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your leg has broken!" ) )
		end
    end )
end
hook.Add( "ScalePlayerDamage", "CH_AdvMedic.ScaleDamage", CH_AdvMedic.ScaleDamage )

-- Disable equipping some weapons if they have a broken arm.
function CH_AdvMedic.PlayerSwitchWeapons( ply, oldwep, newwep )
	if ply.CH_AdvMedic_HasBrokenArm then
		if CH_AdvMedic.Config.DisallowedBrokenArmWeapons[ newwep:GetClass() ] then
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You cannot equip this weapon with a broken arm!" ) )
			return true
		end
	end
end
hook.Add( "PlayerSwitchWeapon", "CH_AdvMedic.PlayerSwitchWeapons", CH_AdvMedic.PlayerSwitchWeapons )

-- Function to fix injuries
function CH_AdvMedic.FixPlayerInjuries( ply, notify )
	if not CH_AdvMedic.Config.EnableInjurySystem then
		return
	end
	
	if ply.CH_AdvMedic_HasBrokenLeg then
		ply.CH_AdvMedic_HasBrokenLeg = false
		
		ply:SetWalkSpeed( ply.CHMedic_OldWalkSpeed or GAMEMODE.Config.walkspeed )
		ply:SetRunSpeed( ply.CHMedic_OldRunSpeed or GAMEMODE.Config.runspeed )
		
		if notify then
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your leg injury has been healed." ) )
		end
	end
	
	if ply.CH_AdvMedic_HasBrokenArm then
		ply.CH_AdvMedic_HasBrokenArm = false
		
		if notify then
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your broken arm has been healed." ) )
		end
	end
	
	if ply.CH_AdvMedic_HasInternalBleedings then
		ply.CH_AdvMedic_HasInternalBleedings = false
		
		if timer.Exists( ply:EntIndex() .."_StartInternalBleeding" ) then
			timer.Remove( ply:EntIndex() .."_StartInternalBleeding" )
		end
		
		if notify then
			DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "Your internal bleedings has been healed." ) )
		end
	end
	
	ply.CH_AdvMedic_DamageHitCount = 0
end