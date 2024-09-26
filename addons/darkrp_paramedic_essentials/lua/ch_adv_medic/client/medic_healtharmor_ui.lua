local mat_healtharmor_npc = Material( "craphead_scripts/medic_ui/healtharmor_ui.png" )
local mat_close_btn = Material( "craphead_scripts/medic_ui/close.png" )

net.Receive( "CH_AdvMedic_Net_HealthMenu", function()
	local scr_w = ScrW()
	local scr_h = ScrH()
	
	local GUI_Health_Frame = vgui.Create("DFrame")
	GUI_Health_Frame:SetTitle( "" )
	GUI_Health_Frame:SetSize( scr_w * 0.49325, scr_h * 0.27875 )
	GUI_Health_Frame:Center()
	GUI_Health_Frame.Paint = function( self, w, h )
		surface.SetDrawColor( color_white )
		surface.SetMaterial( mat_healtharmor_npc )
		surface.DrawTexturedRect( 0, 0, w, h )
		-- Draw the top title.
		draw.SimpleText( CH_AdvMedic.LangString( "Hospital" ), "MEDIC_UIFontTitle", w * 0.08, h * 0.045, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		
		draw.SimpleText( CH_AdvMedic.LangString( "Hey there," ), "MEDIC_UIText", w * 0.035, h * 0.27, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText( CH_AdvMedic.LangString( "If you are hurt I can help patch you up." ), "MEDIC_UIText", w * 0.035, h * 0.37, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText( CH_AdvMedic.LangString( "Just let me know which type of healing you need." ), "MEDIC_UIText", w * 0.035, h * 0.47, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
	end
	GUI_Health_Frame:MakePopup()
	GUI_Health_Frame:SetDraggable( false )
	GUI_Health_Frame:ShowCloseButton( false )
	
	local GUI_Main_Exit = vgui.Create( "DButton", GUI_Health_Frame )
	GUI_Main_Exit:SetSize( 16, 16 )
	GUI_Main_Exit:SetPos( GUI_Health_Frame:GetWide() - 27.5, 10 )
	GUI_Main_Exit:SetText( "" )
	GUI_Main_Exit.Paint = function( self, w, h )
		surface.SetMaterial( mat_close_btn )
		surface.SetDrawColor( color_white )
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	GUI_Main_Exit.DoClick = function()
		GUI_Health_Frame:Remove()
	end	

	local GUI_PurchaseHealth = vgui.Create("DButton", GUI_Health_Frame)	
	GUI_PurchaseHealth:SetSize( scr_w * 0.08, scr_h * 0.05 )
	GUI_PurchaseHealth:SetPos( scr_w * 0.311, scr_h * 0.2 )
	GUI_PurchaseHealth:SetText( "" )
	GUI_PurchaseHealth.Paint = function( self, w, h )
		draw.SimpleText( CH_AdvMedic.LangString( "Purchase Health" ), "MEDIC_UIText", w / 2, h * 0.35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		draw.SimpleText( CH_AdvMedic.LangString( "Price:" ) .." ".. DarkRP.formatMoney( CH_AdvMedic.Config.HealthPrice ), "MEDIC_UITextSmall", w / 2, h * 0.7, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
	GUI_PurchaseHealth.DoClick = function()
		net.Start("CH_AdvMedic_Net_PurchaseHealth")
		net.SendToServer()
		
		GUI_Health_Frame:Remove()
	end
	
	local GUI_PurchaseArmor = vgui.Create("DButton", GUI_Health_Frame)	
	GUI_PurchaseArmor:SetSize( scr_w * 0.08, scr_h * 0.05 )
	GUI_PurchaseArmor:SetPos( scr_w * 0.398, scr_h * 0.2 )
	GUI_PurchaseArmor:SetText( "" )
	GUI_PurchaseArmor.Paint = function( self, w, h )
		draw.SimpleText( CH_AdvMedic.LangString( "Purchase Armor" ), "MEDIC_UIText", w / 2, h * 0.35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		draw.SimpleText( CH_AdvMedic.LangString( "Price:" ) .." ".. DarkRP.formatMoney( CH_AdvMedic.Config.ArmorPrice ), "MEDIC_UITextSmall", w / 2, h * 0.7, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
	GUI_PurchaseArmor.DoClick = function()
		net.Start("CH_AdvMedic_Net_PurchaseArmor")
		net.SendToServer()
		
		GUI_Health_Frame:Remove()
	end
end)