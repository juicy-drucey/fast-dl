--[[
	XP SUPPORT
--]]
function CH_AdvMedic.LevelSupport( ply, amount, reason )
	if tonumber( amount ) <= 0 then
		return
	end
	
	-- Give XP (Vronkadis DarkRP Level System)
	if LevelSystemConfiguration then
		ply:addXP( amount, true )
	end
	
	-- Give XP (Sublime Levels)
	if Sublime and Sublime.Config and Sublime.Config.BaseExperience then
		ply:SL_AddExperience( amount, reason )
	end
	
	-- Give XP (Elite XP system)
	if EliteXP then
		EliteXP.CheckXP( ply, amount )
	end
	
	-- Give XP (DarkRP essentials & Brick's Essentials)
	if ( BRICKS_SERVER and BRICKS_SERVER.CONFIG and BRICKS_SERVER.CONFIG.LEVELING ) or ( DARKRP_ESSENTIALS and DARKRP_ESSENTIALS.CONFIG and DARKRP_ESSENTIALS.CONFIG.Enable_Leveling ) then
		ply:AddExperience( amount, reason )
	end

	-- Give XP (GlorifiedLeveling)
	if GlorifiedLeveling then
		GlorifiedLeveling.AddPlayerXP( ply, amount )
	end
end