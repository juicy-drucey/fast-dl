--[[
local function CH_AdvMedic_OnBodyRemoved( pPlayer, bRevived )
    print( pPlayer )
	print( bRevived )
end
hook.Add( "CH_AdvMedic_OnBodyRemoved", "CH_AdvMedic_OnBodyRemoved", CH_AdvMedic_OnBodyRemoved )
--]]

-- DEFIB HOOKS
function CH_AdvMedic.PlayerSpawn( ply )
    -- Remove the players body ragdoll if it exists.
	if IsValid( ply.CH_AdvMedic_DeathRagdoll ) then
        ply.CH_AdvMedic_DeathRagdoll:Remove()
		
		-- Check if player was revived and call compatibility hook
		if ply.CH_AdvMedic_WasRevived then
			-- Additional support for https://www.gmodstore.com/market/view/2791
			if nlre then
				nlre.clearLatestNLRSphere( ply )
			end
			
			-- Additional support for https://www.gmodstore.com/market/view/4308
			if SPZones then
				SPZones.ClearZones( ply )
			end
			
			-- Promote back to the job they were when they got knocked unconscious
			if CH_AdvMedic.Config.PromoteToPreviouslyJobOnRevive then
				timer.Simple( 0.1, function()
					ply:changeTeam( ply.CH_AdvMedic_PreviousTeam, true )
				end )
			end
			
			hook.Run( "CH_AdvMedic_OnBodyRemoved", ply, true )
			ply.CH_AdvMedic_WasRevived = false
		else
			hook.Run( "CH_AdvMedic_OnBodyRemoved", ply, false )
			ply.CH_AdvMedic_WasRevived = false
		end
		
		-- Set life alert to false for the player if they fully die and doesn't get revived.
		if ply.CH_AdvMedic_HasLifeAlert then
			ply.CH_AdvMedic_HasLifeAlert = false
		end
    end
	
	if not ply:changeAllowed( ply:Team() ) and not CH_AdvMedic.Config.PromoteToPreviouslyJobOnRevive then
		ply:changeTeam( GAMEMODE.DefaultTeam, true )
	end
	
	-- Unspectate to stop ghosting your own corpse.
    ply:UnSpectate()
	
	-- Reset spawn timer
	ply.CH_AdvMedic_NextRespawn = 0
	
	-- Fix injuries if they've got any
	if ply:CH_AdvMedic_HasInjury() then
		CH_AdvMedic.FixPlayerInjuries( ply, false )
	end
	
	-- If auto life alert is enabled, then give the player a life alert.
	timer.Simple( 1, function()
		if CH_AdvMedic.Config.AutoLifeAlert then
			ply.CH_AdvMedic_HasLifeAlert = true
		end
	end )
end
hook.Add( "PlayerSpawn", "CH_AdvMedic.PlayerSpawn", CH_AdvMedic.PlayerSpawn )

function CH_AdvMedic.PlayerDisconnected( ply )
	-- Remove the players body ragdoll if it exists.
	if IsValid( ply.CH_AdvMedic_DeathRagdoll ) then
        ply.CH_AdvMedic_DeathRagdoll:Remove()
    end
end
hook.Add( "PlayerDisconnected", "CH_AdvMedic.PlayerDisconnected", CH_AdvMedic.PlayerDisconnected )

function CH_AdvMedic.PlayerDeath( victim, inflictor, attacker )	
    -- Store the players weapon so we can give them back upon saved
	local player_weapons = victim:GetWeapons()
	
    victim.WeaponsOnKilled = {}
    for k, wep in ipairs( player_weapons ) do
        table.insert( victim.WeaponsOnKilled, wep:GetClass() )
    end
	
	-- Store the players previous team if we need it for revived
	if CH_AdvMedic.Config.PromoteToPreviouslyJobOnRevive then
		victim.CH_AdvMedic_PreviousTeam = victim:Team()
	end
	
	-- Exit vehicle to properly spawn corpse
    if victim:InVehicle() then
		victim:ExitVehicle()
	end
	
    -- Remove default corpse
	if IsValid( victim:GetRagdollEntity() ) then
		victim:GetRagdollEntity():Remove()
	end
	
	-- Stop bleeding timer
	if timer.Exists( victim:EntIndex() .."_StartInternalBleeding" ) then
		timer.Remove( victim:EntIndex() .."_StartInternalBleeding" )
	end
	
	-- Create ragdoll
    local corpse = victim:CH_AdvMedic_CreateCorpse()
	
    -- Set the view on the ragdoll
    victim:Spectate( OBS_MODE_CHASE )
    victim:SpectateEntity( corpse )
	
	victim:SetNWEntity( "CH_AdvMedic_PlayersRagdoll", corpse )
	
	-- Start moaning sounds if enabled
	if CH_AdvMedic.Config.EnableDeathMoaning then
		CH_AdvMedic.StartMoaning( victim, corpse )
	end
	
	-- Network respawn countdown
	local cur_time = CurTime()
	
	local ParamedicCount = 0
	local RequiredPlayersCounted = 0

	for k, ply in ipairs( player.GetAll() ) do
		RequiredPlayersCounted = RequiredPlayersCounted + 1
		
		if ply:CH_AdvMedic_IsParamedic() then
			ParamedicCount = ParamedicCount + 1
		end
		
		if RequiredPlayersCounted == #player.GetAll() then
			-- All counted
			if ParamedicCount <= 0 then -- No medics time applied (overwrite donator times if enabled)
				victim.CH_AdvMedic_NextRespawn = cur_time + CH_AdvMedic.Config.UnconsciousIfNoMedicTime
			elseif CH_AdvMedic.Config.EnableRankDeathTimes then
				victim.CH_AdvMedic_NextRespawn = cur_time + victim:CH_AdvMedic_GetUnconciousTime()
			else
				victim.CH_AdvMedic_NextRespawn = cur_time + CH_AdvMedic.Config.UnconsciousTime
			end

			net.Start( "CH_AdvMedic_Net_DefibUpdateSeconds" )
				net.WriteInt( victim.CH_AdvMedic_NextRespawn, 32 )
			net.Send( victim )
		end
	end
end
hook.Add( "PlayerDeath", "CH_AdvMedic.PlayerDeath", CH_AdvMedic.PlayerDeath )

-- Determine if the player can respawn
function CH_AdvMedic.PlayerDeathThink( ply )
	local cur_time = CurTime()
	
    if ply.CH_AdvMedic_NextRespawn and ply.CH_AdvMedic_NextRespawn > cur_time then
		return false
	end
	
	if not CH_AdvMedic.Config.ClickToRespawn then
		if ply.CH_AdvMedic_NextRespawn and ply.CH_AdvMedic_NextRespawn < cur_time then
			ply:Spawn()
		end
	end
end
hook.Add( "PlayerDeathThink", "CH_AdvMedic.PlayerDeathThink", CH_AdvMedic.PlayerDeathThink )

local function CH_AdvMedic_CanSeeChat( ply, text, teamchat )
	if not ply:Alive() then
		if CH_AdvMedic.Config.DisableChatWhenDead then
			if ply:IsAdmin() then
				if text == CH_AdvMedic.Config.AdminReviveCommand then
					ply.CH_AdvMedic_WasRevived = true
					ply:Spawn()
					
					if IsValid( ply.CH_AdvMedic_DeathRagdoll ) then
						ply:SetPos( ply.CH_AdvMedic_DeathRagdoll:GetPos() )
					end
					
					for k, v in ipairs( ply.WeaponsOnKilled ) do
						ply:Give( v )
					end
					
					return ""
				elseif text != "/afk" then
					return ""
				end
			elseif text != "/afk" then
				return ""
			end
		elseif ply:IsAdmin() then
			if text == CH_AdvMedic.Config.AdminReviveCommand then
				ply.CH_AdvMedic_WasRevived = true
				ply:Spawn()
				
				if IsValid( ply.CH_AdvMedic_DeathRagdoll ) then
					ply:SetPos( ply.CH_AdvMedic_DeathRagdoll:GetPos() )
				end
				
				for k, v in ipairs( ply.WeaponsOnKilled ) do
					ply:Give( v )
				end
				
				return
			end
		end
	end
end
hook.Add( "PlayerSay", "CH_AdvMedic_CanSeeChat", CH_AdvMedic_CanSeeChat )

-- Dead players can hear alive players voices within a distance https://wiki.facepunch.com/gmod/GM:PlayerCanHearPlayersVoice
local function CH_AdvMedic_PlayerCanHearPlayersVoice( listener, talker )
    if not listener:Alive() and IsValid( listener.CH_AdvMedic_DeathRagdoll ) then
        if listener.CH_AdvMedic_DeathRagdoll:GetPos():DistToSqr( talker:GetPos() ) < CH_AdvMedic.Config.DeadCanHearPlayersVoiceDistance then
            return true
        else
            return false
        end
    end
end
hook.Add( "PlayerCanHearPlayersVoice", "CH_AdvMedic_PlayerCanHearPlayersVoice", CH_AdvMedic_PlayerCanHearPlayersVoice )

local function CH_AdvMedic_CanGoAFK( ply, afk )
	if ply.CH_AdvMedic_NextRespawn and ply.CH_AdvMedic_NextRespawn > CurTime() then
		return false
	end
end
hook.Add( "canGoAFK", "CH_AdvMedic_CanGoAFK", CH_AdvMedic_CanGoAFK )

local function CH_AdvMedic_PlayerChangeTeam( ply )
	if ply.CH_AdvMedic_NextRespawn and ply.CH_AdvMedic_NextRespawn > CurTime() then
		DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "You can't change your team while you're unconscious!" ) )
		return false
	end
end
hook.Add( "playerCanChangeTeam", "CH_AdvMedic_PlayerChangeTeam", CH_AdvMedic_PlayerChangeTeam )

-- Player Death Moaning
function CH_AdvMedic.StartMoaning( ply, corpse )
	if not IsValid( ply ) then
		return
	end
	if not IsValid( corpse ) then
		return
	end
	
	local Gender = "male" -- return to male in-case no sex is found (model not found in male or female list)
	
	if ply:CH_AdvMedic_GetPlayersSex() == "Male" then
		Gender = "male"
	elseif ply:CH_AdvMedic_GetPlayersSex() == "Female" then
		Gender = "female"
	end

	local moan_file = "vo/npc/" .. Gender .. "01/moan0" .. math.random( 1, 5 ) .. ".wav"
	corpse:EmitSound( moan_file )
	
	timer.Simple( math.random( 5, 10 ), function()
		if IsValid( ply ) and not ply:Alive() then
			CH_AdvMedic.StartMoaning( ply, corpse )
		end
	end )
end