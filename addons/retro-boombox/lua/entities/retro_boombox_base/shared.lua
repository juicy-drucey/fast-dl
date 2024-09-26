ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Retro Boombox Base"
ENT.Category = "Retro Boombox"
ENT.Author = "Venatuss"
ENT.Spawnable = false

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Power" )
	self:NetworkVar( "Bool", 1, "Playing" )
	self:NetworkVar( "Float", 0, "Frequence" )
	self:NetworkVar( "Float", 1, "SoundLevel" )
	self:NetworkVar( "Float", 2, "LightMode" )
end

ENT.MainColor = "white"
ENT.SecondaryColor = "silver"
ENT.TubeLightsColor = "white"
ENT.MainLightsColor = "white"
ENT.SoundLightsColor = "red"
ENT.ScreenBackgroundColor = Color( 32, 32, 32, 255 )
ENT.ScreenContentColor = Color( 0, 255, 219, 255 )
