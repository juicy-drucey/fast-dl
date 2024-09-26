include( "shared.lua" )

function ENT:Initialize()
end

local ent_textcolor = Color( 160, 0, 0, 255 )

function ENT:Draw()
	self:DrawModel()
	
	local ply = LocalPlayer()
	
	if ply:GetPos():DistToSqr( self:GetPos() ) > 100000 then
		return
	end
	
	local pos = self:GetPos() + Vector( 0, 0, 1 ) * math.sin( CurTime() * 2 ) * 1
	local PlayersAngle = ply:GetAngles()
	local ang = Angle( 0, PlayersAngle.y - 180, 0 )
	
	ang:RotateAroundAxis( ang:Right(), -90 )
	ang:RotateAroundAxis( ang:Up(), 90 )
	
	cam.Start3D2D( pos, ang, 0.05 )
		draw.SimpleTextOutlined( CH_AdvMedic.LangString( "Health Kit" ), "ADV_MEDIC_EntHeader", 0, -250, ent_textcolor, 1, 1, 1.5, color_black )
		draw.SimpleTextOutlined( "+50 ".. CH_AdvMedic.LangString( "Health" ), "ADV_MEDIC_EntText", 0, -200, ent_textcolor, 1, 1, 1.5, color_black )
    cam.End3D2D()
end