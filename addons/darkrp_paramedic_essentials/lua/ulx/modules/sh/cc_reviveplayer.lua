function ulx.ch_adv_medic_revive_player( calling_ply, target_ply )
	if target_ply:Alive() then
		return
	end
	
	target_ply.WasRevived = true
	target_ply:Spawn()

	if IsValid( target_ply.DeathRagdoll ) then
		target_ply:SetPos( target_ply.DeathRagdoll:GetPos() )
	end

	for k, v in ipairs( target_ply.WeaponsOnKilled ) do
		target_ply:Give( v )
	end
	
	ulx.fancyLogAdmin( calling_ply, true, "#A revived #T", target_ply )
end
local ch_adv_medic_revive_player = ulx.command( "Paramedic Essentials", "ulx revive", ulx.ch_adv_medic_revive_player, "!reviveplayer", true )
ch_adv_medic_revive_player:addParam{ type = ULib.cmds.PlayerArg }
ch_adv_medic_revive_player:defaultAccess( ULib.ACCESS_ADMIN )
ch_adv_medic_revive_player:help( "Revive a player." )