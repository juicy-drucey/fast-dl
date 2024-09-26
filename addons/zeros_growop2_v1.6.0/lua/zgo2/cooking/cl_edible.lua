/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Edible = zgo2.Edible or {}
zgo2.Edible.List = zgo2.Edible.List or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	Edibles can be consumed by players and could make them high
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

*/


function zgo2.Edible.Initialize(Edible)
	Edible:DestroyShadow()

	timer.Simple(0.5, function()
		if IsValid(Edible) then
			Edible.m_Initialized = true
		end
	end)
end

function zgo2.Edible.Think(Edible)
	if zgo2.Plant.UpdateMaterials[ Edible ] == nil then
		zgo2.Plant.UpdateMaterials[ Edible ] = true
	end
end

function zgo2.Edible.Draw(Edible)
	Edible:DrawModel()

	if not LocalPlayer().zgo2_Initialized then return end
	if not zclib.Convar.GetBool("zclib_cl_drawui") then return end
	if zclib.util.InDistance(Edible:GetPos(), LocalPlayer():GetPos(), zgo2.util.RenderDistance_UI) == false then return end

	if zclib.Entity.GetLookTarget() ~= Edible then return end

	local edible_id = Edible:GetEdibleID()
	if edible_id and edible_id > 0 then
		zgo2.HUD.Draw(Edible,function()

			local id = Edible:GetWeedID()

			if id and id > 0 then

				local name = zgo2.Edible.GetName(edible_id)
				local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_medium")) * 1.5

				draw.RoundedBox(20, -boxSize / 2, -370, boxSize, 60, zclib.colors[ "black_a200" ])
				draw.SimpleText(name, zclib.GetFont("zclib_world_font_medium"), 0, -340, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

				local name = zgo2.Plant.GetName(id)
				local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_medium")) * 1.5
				draw.RoundedBox(20, -boxSize / 2, -300, boxSize, 180, zclib.colors[ "black_a200" ])
				draw.SimpleText(name, zclib.GetFont("zclib_world_font_medium"), 0, -270, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(Edible:GetWeedAmount() .. zgo2.config.UoM, zclib.GetFont("zclib_world_font_medium"), 0, -220, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(Edible:GetWeedTHC() .. "%", zclib.GetFont("zclib_world_font_medium"), 0, -160, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("▼", zclib.GetFont("zclib_world_font_large"), 0, -50, zclib.colors[ "black_a200" ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				local name = zgo2.Edible.GetName(edible_id)
				local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_medium")) * 1.5

				draw.RoundedBox(20, -boxSize / 2, -300, boxSize, 100, zclib.colors[ "black_a200" ])
				draw.SimpleText(name, zclib.GetFont("zclib_world_font_medium"), 0, -250, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("▼", zclib.GetFont("zclib_world_font_large"), 0, -150, zclib.colors["black_a200"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end,0.05)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
