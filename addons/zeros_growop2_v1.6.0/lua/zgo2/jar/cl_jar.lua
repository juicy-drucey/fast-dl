/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Jar = zgo2.Jar or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

/*

	The weed jar holds weed
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

*/
function zgo2.Jar.Think(Jar)
	if zgo2.Plant.UpdateMaterials[ Jar ] == nil then
		zgo2.Plant.UpdateMaterials[ Jar ] = true
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

function zgo2.Jar.Draw(Jar)
	if not LocalPlayer().zgo2_Initialized then return end
	if not zclib.Convar.GetBool("zclib_cl_drawui") then return end
	if zclib.util.InDistance(Jar:GetPos(), LocalPlayer():GetPos(), zgo2.util.RenderDistance_UI) == false then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

	if zclib.Entity.GetLookTarget() ~= Jar then return end

	local id = Jar:GetWeedID()
	if id and id > 0 then
		zgo2.HUD.Draw(Jar,function()
			local name = zgo2.Plant.GetName(id)
			local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_medium")) * 1.2
			draw.RoundedBox(20, -boxSize/2,-90, boxSize, 210, zclib.colors["black_a200"])
			draw.SimpleText(name, zclib.GetFont("zclib_world_font_medium"), 0, -45, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(Jar:GetWeedAmount() .. zgo2.config.UoM, zclib.GetFont("zclib_world_font_medium"), 0, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(Jar:GetWeedTHC() .. "%", zclib.GetFont("zclib_world_font_medium"), 0, 80, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			draw.SimpleText("▼", zclib.GetFont("zclib_world_font_large"), 0, 150, zclib.colors["black_a200"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end,0.05)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
