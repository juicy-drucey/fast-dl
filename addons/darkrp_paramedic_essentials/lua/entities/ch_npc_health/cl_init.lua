include( "shared.lua" )

local mat_overhead_icon = Material( "materials/craphead_scripts/medic_ui/hospital.png", "noclamp smooth" )

function ENT:DrawTranslucent()
	self:DrawModel()
	
	local ply = LocalPlayer()
	
	if ply:GetPos():DistToSqr( self:GetPos() ) >= CH_AdvMedic.Config.DistanceTo3D2D then
		return
	end
	
	local Ang = self:GetAngles()
	local AngEyes = ply:EyeAngles()

	Ang:RotateAroundAxis( Ang:Forward(), 90 )
	Ang:RotateAroundAxis( Ang:Right(), -90 )
	
	cam.Start3D2D( self:GetPos() + self:GetUp() * 85, Angle( 0, AngEyes.y - 90, 90 ), 0.05 )
		draw.RoundedBox( 8, -300, 20, 600, 200, Color( 20, 20, 20, 235 ) )
		
		-- Icon
		surface.SetDrawColor( color_white )
		surface.SetMaterial( mat_overhead_icon )
		surface.DrawTexturedRect( -280, 35, 165, 165 )
		
		local ply_name = "Hey" .." ".. ply:Nick() ..","
		if string.len( ply_name ) > 17 then
			ply_name = string.Left( ply_name, 17 ) ..".."
		end
		
		draw.SimpleTextOutlined( CH_AdvMedic.LangString( "Hospital" ), "MEDIC_NPC_Overhead", -90, 60, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black )
		draw.SimpleTextOutlined( ply_name, "MEDIC_NPC_OverheadSmall", -90, 125, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black )
		draw.SimpleTextOutlined( CH_AdvMedic.LangString( "Patch yourself up here!" ), "MEDIC_NPC_OverheadSmaller", -90, 180, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black )
	cam.End3D2D()
end