/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Weedblock = zgo2.Weedblock or {}
zgo2.Weedblock.List = zgo2.Weedblock.List or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	Weedblocks can hold more weed then jars

*/

function zgo2.Weedblock.Initialize(Weedblock)
	Weedblock:DestroyShadow()

	timer.Simple(0.5, function()
		if IsValid(Weedblock) then
			Weedblock.m_Initialized = true
		end
	end)
end

function zgo2.Weedblock.Think(Weedblock)
	if zgo2.Plant.UpdateMaterials[ Weedblock ] == nil then
		zgo2.Plant.UpdateMaterials[ Weedblock ] = true
	end
end

function zgo2.Weedblock.Draw(Weedblock)
	if not LocalPlayer().zgo2_Initialized then return end
	if not zclib.Convar.GetBool("zclib_cl_drawui") then return end
	if zclib.util.InDistance(Weedblock:GetPos(), LocalPlayer():GetPos(), zgo2.util.RenderDistance_UI) == false then return end

	if zclib.Entity.GetLookTarget() ~= Weedblock then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

	local id = Weedblock:GetWeedID()
	if id and id > 0 then
		zgo2.HUD.Draw(Weedblock,function()
			local name = zgo2.Plant.GetName(id)
			local boxSize = zclib.util.GetTextSize(name, zclib.GetFont("zclib_world_font_medium")) * 1.2
			draw.RoundedBox(20, -boxSize/2,-190, boxSize, 130, zclib.colors["black_a200"])
			draw.SimpleText(name, zclib.GetFont("zclib_world_font_medium"), 0, -150, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(zgo2.config.Packer.Capacity .. zgo2.config.UoM, zclib.GetFont("zclib_world_font_medium"), 0, -100, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			draw.SimpleText("▼", zclib.GetFont("zclib_world_font_large"), 0, -20, zclib.colors["black_a200"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end,0.08)
	end

	if Weedblock:GetProgress() <= 0 then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	if Weedblock.NextSound == nil or CurTime() > Weedblock.NextSound then
		zclib.Sound.EmitFromEntity("zgo2_plant_cut", Weedblock)
		Weedblock.NextSound = CurTime() + math.Rand(0.5,0.7)
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

	cam.Start2D()
		local pos = Weedblock:GetPos():ToScreen()
		zgo2.util.DrawBar(300, 40, zclib.Materials.Get("zgo2_icon_scissor"), zclib.colors[ "green01" ], pos.x, pos.y, math.Clamp((1 / 100) * Weedblock:GetProgress(), 0, 1))
	cam.End2D()
end
