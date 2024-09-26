/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.NPC = zgo2.NPC or {}
zgo2.NPC.List = zgo2.NPC.List or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

/*

	Players can buy bongs and sell weed at the npc

*/

function zgo2.NPC.Initialize(NPC)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

end

function zgo2.NPC.Draw(NPC)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	local name = NPC:GetClass() == "zgo2_npc" and zgo2.language[ "Weed Dealer" ] or zgo2.language[ "Export Manager" ]
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	zgo2.HUD.Draw(NPC,function()
		local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_big")) * 1.2
		draw.RoundedBox(0, -boxSize / 2, -35, boxSize, 70, zclib.colors["black_a100"])
		draw.SimpleText(name, zclib.GetFont("zclib_world_font_big"), 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		zclib.util.DrawOutlinedBox(-boxSize / 2, -35, boxSize, 70, 4, color_white)
	end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
