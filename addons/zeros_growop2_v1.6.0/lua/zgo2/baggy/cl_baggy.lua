/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Baggy = zgo2.Baggy or {}

/*

	The weed Baggy holds weed

*/
function zgo2.Baggy.Think(Baggy)
	if zgo2.Plant.UpdateMaterials[ Baggy ] == nil then
		zgo2.Plant.UpdateMaterials[ Baggy ] = true
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

function zgo2.Baggy.Draw(Baggy)
	if not LocalPlayer().zgo2_Initialized then return end
	if not zclib.Convar.GetBool("zclib_cl_drawui") then return end
	if zclib.util.InDistance(Baggy:GetPos(), LocalPlayer():GetPos(), zgo2.util.RenderDistance_UI) == false then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	if zclib.Entity.GetLookTarget() ~= Baggy then return end

	local id = Baggy:GetWeedID()
	if id and id > 0 then
		zgo2.HUD.Draw(Baggy,function()
			local name = zgo2.Plant.GetName(id)
			local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_medium")) * 1.2
			draw.RoundedBox(20, -boxSize/2,-90, boxSize, 210, zclib.colors["black_a200"])
			draw.SimpleText(name, zclib.GetFont("zclib_world_font_medium"), 0, -45, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(Baggy:GetWeedAmount() .. zgo2.config.UoM, zclib.GetFont("zclib_world_font_medium"), 0, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(Baggy:GetWeedTHC() .. "%", zclib.GetFont("zclib_world_font_medium"), 0, 80, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

			draw.SimpleText("▼", zclib.GetFont("zclib_world_font_large"), 0, 150, zclib.colors["black_a200"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end,0.05)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
