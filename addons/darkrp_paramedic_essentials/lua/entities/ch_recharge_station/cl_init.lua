include( "shared.lua" )

local col_black = Color( 2, 2, 2, 255 )

function ENT:DrawTranslucent()
	self:DrawModel()
	
	if LocalPlayer():GetPos():DistToSqr( self:GetPos() ) > CH_AdvMedic.Config.DistanceTo3D2D then
		return
	end
	
	-- Crate cooldown overhead text
	local pos = self:GetPos() + Vector( 0, 0, 70 )

	-- The front panel
	local PanelPos = self:GetAttachment( 1 ).Pos
	local PanelAng = self:GetAttachment( 1 ).Ang

	PanelAng:RotateAroundAxis( PanelAng:Forward(), 90 )

	cam.Start3D2D( PanelPos, PanelAng, 0.04 )
		draw.RoundedBoxEx( 0, 0, 0, 530, 405, CH_AdvMedic.Config.Design.BackgroundColor, false, false, false, false )
		
		draw.SimpleTextOutlined( CH_AdvMedic.LangString( "Recharge Station" ), "MEDIC_RechargeStationLarge", 270, 50, CH_AdvMedic.Config.Design.HeaderColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, CH_AdvMedic.Config.Design.HeaderOutline )
		
		draw.SimpleTextOutlined( CH_AdvMedic.LangString( "Recharges Available" ), "MEDIC_RechargeStationMedium", 270, 130, CH_AdvMedic.Config.Design.SecondHeaderColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, CH_AdvMedic.Config.Design.SecondHeaderOutline )
		if self:GetRechargesLeft() then
			draw.SimpleTextOutlined( self:GetRechargesLeft() .." ".. CH_AdvMedic.LangString( "Left" ), "MEDIC_RechargeStationSmall", 270, 170, CH_AdvMedic.Config.Design.ChargesLeftColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, CH_AdvMedic.Config.Design.ChargesLeftOutline )
		end
		
		draw.SimpleTextOutlined( CH_AdvMedic.LangString( "Only to be used by paramedics" ), "MEDIC_RechargeStationMedium", 270, 230, CH_AdvMedic.Config.Design.RechargeKeyColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, CH_AdvMedic.Config.Design.RechargeKeyOutline )
		draw.SimpleTextOutlined( CH_AdvMedic.LangString( "Press 'e' to recharge" ), "MEDIC_RechargeStationSmall", 270, 270, CH_AdvMedic.Config.Design.BottomTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, CH_AdvMedic.Config.Design.BottomTextOutline )	
	cam.End3D2D()
end