local alpha = 0

net.Receive( "CH_AdvMedic_Net_DefibUpdateSeconds", function()
    CH_AdvMedic.NextRespawn = net.ReadInt( 32 )
end )

local function ADV_MEDIC_PlayerWithinBounds( ply, otherPly, dist )
	return ply:GetPos():DistToSqr( otherPly ) < ( dist*dist )
end

function CH_AdvMedic.HUDPaint()
	local ply = LocalPlayer()
	
	if ply:getDarkRPVar( "AFK" ) then -- DarkRP kills you when AFK, so if AFK we don't want to draw this shit show on their screen
		return
	end
	
	if ply:Alive() then
		if alpha != 0 then
			if alpha >= CH_AdvMedic.Config.DarkestAlpha then
				alpha = 0
			end
		end
	end
	
	local cur_time = CurTime()
	
	if not ply:Alive() and CH_AdvMedic.NextRespawn then
		local scr_w = ScrW()
		local scr_h = ScrH()
	
		if CH_AdvMedic.Config.BecomeDarkerWhenDead then
			alpha = math.Clamp( alpha + 0.1, 0, CH_AdvMedic.Config.DarkestAlpha )
			
			surface.SetDrawColor( 0, 0, 0, alpha )
			surface.DrawRect( 0, 0, scr_w, scr_h )
		end
		
		if CH_AdvMedic.NextRespawn - cur_time > 0 then
			draw.SimpleText( CH_AdvMedic.LangString( "You have died" ), "MEDIC_UIFontTitle", scr_w / 2, (scr_h / 2) - scr_h * 0.1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( CH_AdvMedic.LangString( "Paramedics can rescue you using defibrillators" ), "MEDIC_UIText", scr_w / 2, (scr_h / 2) - scr_h * 0.06, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( CH_AdvMedic.LangString( "Please wait" ) .." ".. math.Round( CH_AdvMedic.NextRespawn - cur_time ) .." ".. CH_AdvMedic.LangString( "seconds to respawn" ), "MEDIC_UIText", ScrW() / 2, (ScrH() / 2) - ScrH() * 0.04, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			if CH_AdvMedic.Config.ClickToRespawn then 
				draw.SimpleText( CH_AdvMedic.LangString( "Click to respawn" ), "MEDIC_UIText", scr_w / 2, scr_h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
        end
	end
end
hook.Add( "HUDPaint", "CH_AdvMedic.HUDPaint", CH_AdvMedic.HUDPaint )

function CH_AdvMedic.DrawLifeAlert()
	if not CH_AdvMedic.Config.LifeAlertDistance then
		return
	end
	
	local ply = LocalPlayer()
	
	if not ply:CH_AdvMedic_IsParamedic() then
		return
	end
	
	if not ply:Alive() then
		return
	end

	for k, corpse in ipairs( ents.FindByClass( "prop_ragdoll" ) ) do
		if corpse:GetNWBool( "CH_AdvMedic_RagdollIsCorpse" ) and corpse:GetNWBool( "CH_AdvMedic_HasLifeAlert" ) then
			local npcpos = corpse:GetPos()
			local pos = npcpos:ToScreen()
			
			if not ADV_MEDIC_PlayerWithinBounds( ply, corpse:GetPos(), 150 ) then
				surface.SetDrawColor( color_white )
				surface.SetMaterial( CH_AdvMedic.Config.LifeAlertIcon )
				surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
				
				surface.SetFont( "MEDIC_UITextSmall" )
				local x, y = surface.GetTextSize( CH_AdvMedic.LangString( "Distance" ) .." : ".. math.Round( npcpos:Distance( ply:GetPos() ) ) )
				draw.SimpleText( CH_AdvMedic.LangString( "Distance" ) .." : ".. math.Round( npcpos:Distance( ply:GetPos() ) ), "MEDIC_UITextSmall", pos.x - 35, pos.y + 20, color_white )
			end
		end
	end
end
hook.Add( "HUDDrawTargetID", "CH_AdvMedic.DrawLifeAlert", CH_AdvMedic.DrawLifeAlert )

function CH_AdvMedic.DrawLifeAlertHalo()
	if not CH_AdvMedic.Config.LifeAlertHalo then
		return
	end
	
	local ply = LocalPlayer()
	
	if not ply:CH_AdvMedic_IsParamedic() then
		return
	end
	
	if not ply:Alive() then
		return
	end
	
	local halo_corpse = {}
	local count = 0
	
	for k, corpse in ipairs( ents.FindByClass( "prop_ragdoll" ) ) do
		if corpse:GetNWBool( "CH_AdvMedic_RagdollIsCorpse" ) and corpse:GetNWBool( "CH_AdvMedic_HasLifeAlert" ) then
			count = count + 1
			halo_corpse[ count ] = corpse
		end
	end
	
	halo.Add( halo_corpse, CH_AdvMedic.Config.LifeAlertHaloColor, 1, 1, 2, true, true )
end
hook.Add( "PreDrawHalos", "CH_AdvMedic.DrawLifeAlertHalo", CH_AdvMedic.DrawLifeAlertHalo )