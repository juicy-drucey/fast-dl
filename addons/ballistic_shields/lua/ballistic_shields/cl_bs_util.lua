if SERVER then return end
include( "bs_config.lua" )

net.Receive( "bs_shield_info", function( len, pl )
	LocalPlayer().bs_shieldIndex = net.ReadUInt(16)	
end )

bshields.materialstoload = bshields.materialstoload or {
	{bshields.config.hShieldTexture, 256, 256},
	{bshields.config.rShieldTexture, 256, 256},
	{bshields.config.dShieldTexture, 256, 256}
}
bshields.hShieldTexture = bshields.hShieldTexture or bshields.config.hShieldTexture
bshields.rShieldTexture = bshields.rShieldTexture or bshields.config.rShieldTexture
bshields.dShieldTexture = bshields.dShieldTexture or bshields.config.dShieldTexture
local Delay = 0
function bshields_materials_reload()
	for _,v in pairs(bshields.materialstoload) do
		Delay = Delay + 0.2
		timer.Simple( Delay, function() surface.GetURL(v[1], v[2], v[3]) end )
	end
end
bshields_materials_reload()
hook.Add( "InitPostEntity", "bshields_init_client", function()
	bshields_materials_reload()
end)
      
surface.CreateFont( "bshields.HudFont", {
	font = "BFHud",
	size = ScrH()/1080*18
})