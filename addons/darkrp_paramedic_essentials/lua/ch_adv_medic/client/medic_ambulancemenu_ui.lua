local mat_col_spec = 76561199237832821

local mat_ambulance_npc = Material( "craphead_scripts/medic_ui/ambulance_ui.png" )
local mat_close_btn = Material( "craphead_scripts/medic_ui/close.png" )

net.Receive( "CH_AdvMedic_Net_AmbulanceMenu", function()
	local scr_w = ScrW()
	local scr_h = ScrH()
	
	local GUI_AmbulanceNPC_Frame = vgui.Create( "DFrame" )
	GUI_AmbulanceNPC_Frame:SetTitle("")
	GUI_AmbulanceNPC_Frame:SetSize( scr_w * 0.49325, scr_h * 0.27875 )
	GUI_AmbulanceNPC_Frame:Center()
	GUI_AmbulanceNPC_Frame.Paint = function( self, w, h )
		surface.SetDrawColor( color_white )
		surface.SetMaterial( mat_ambulance_npc )
		surface.DrawTexturedRect( 0, 0, w, h )
		-- Draw the top title.
		draw.SimpleText( CH_AdvMedic.LangString( "Ambulance Station" ), "MEDIC_UIFontTitle", w * 0.08, h * 0.045, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		
		draw.SimpleText( CH_AdvMedic.LangString( "As a paramedic you can retrieve an ambulance from this NPC." ), "MEDIC_UIText", w * 0.035, h * 0.27, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText( CH_AdvMedic.LangString( "Use it to quickly get to people who need to be healed." ), "MEDIC_UIText", w * 0.035, h * 0.37, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText( CH_AdvMedic.LangString( "You are equipped with a medkit." ), "MEDIC_UIText", w * 0.035, h * 0.47, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
	end
	GUI_AmbulanceNPC_Frame:MakePopup()
	GUI_AmbulanceNPC_Frame:SetDraggable( false )
	GUI_AmbulanceNPC_Frame:ShowCloseButton( false )
	
	local GUI_Main_Exit = vgui.Create("DButton", GUI_AmbulanceNPC_Frame)
	GUI_Main_Exit:SetSize( 16, 16 )
	GUI_Main_Exit:SetPos( GUI_AmbulanceNPC_Frame:GetWide() - 27.5, 10 )
	GUI_Main_Exit:SetText( "" )
	GUI_Main_Exit.Paint = function( self, w, h )
		surface.SetMaterial( mat_close_btn )
		surface.SetDrawColor( color_white )
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	GUI_Main_Exit.DoClick = function()
		GUI_AmbulanceNPC_Frame:Remove()
	end
	
	local VehIcon = vgui.Create( "DModelPanel", GUI_AmbulanceNPC_Frame )
	VehIcon:SetPos( scr_w * -0.02, scr_h * 0.015 )
	VehIcon:SetSize( scr_w * 0.19, scr_h * 0.41 )
	VehIcon:SetModel( CH_AdvMedic.Config.VehicleModel )
	VehIcon:GetEntity():SetAngles( Angle( -15, 30, 5 ) )
	
	local mn, mx = VehIcon.Entity:GetRenderBounds()
	local size = 0
	
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
	
	VehIcon:SetFOV( 55 )
	VehIcon:SetCamPos( Vector( size, size, size ) )
	VehIcon:SetLookAt( (mn + mx) * 0.5 )
	function VehIcon:LayoutEntity( Entity ) return end
	
	local VehRetrieveTruck = vgui.Create( "DButton", GUI_AmbulanceNPC_Frame )
	VehRetrieveTruck:SetPos( scr_w * 0.3385, scr_h * 0.2 )
	VehRetrieveTruck:SetSize( scr_w * 0.0675, scr_h * 0.05 )
	VehRetrieveTruck:SetToolTip( CH_AdvMedic.LangString( "Click here to retrieve an ambulance." ) )
	VehRetrieveTruck:SetText( "" )
	VehRetrieveTruck.Paint = function( self, w, h )
		draw.SimpleText( CH_AdvMedic.LangString( "Retrieve" ), "MEDIC_UIText", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	VehRetrieveTruck.DoClick = function()
		net.Start("CH_AdvMedic_Net_SpawnAmbulance")
		net.SendToServer()
		
		GUI_AmbulanceNPC_Frame:Remove()
	end

	local VehRemoveTruck = vgui.Create( "DButton", GUI_AmbulanceNPC_Frame )
	VehRemoveTruck:SetPos( scr_w * 0.409, scr_h * 0.2 )
	VehRemoveTruck:SetSize( scr_w * 0.0675, scr_h * 0.05 )
	VehRemoveTruck:SetToolTip( CH_AdvMedic.LangString( "Click here to remove your current ambulance." ) )
	VehRemoveTruck:SetText("")
	VehRemoveTruck.Paint = function( self, w, h )
		draw.SimpleText( CH_AdvMedic.LangString( "Remove" ), "MEDIC_UIText", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	VehRemoveTruck.DoClick = function()
		net.Start("CH_AdvMedic_Net_RemoveAmbulance")
		net.SendToServer()
		
		GUI_AmbulanceNPC_Frame:Remove()
	end
end )