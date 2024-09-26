/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Seed = zgo2.Seed or {}
zgo2.Seed.List = zgo2.Seed.List or {}

/*

	The player can grow plants in Seeds if the bot has soil in it

*/
function zgo2.Seed.Initialize(Seed)
	timer.Simple(0.25,function()
		if IsValid(Seed) then
			Seed.Initialized = true
		end
	end)
end

function zgo2.Seed.OnThink(Seed)
	if zgo2.Seed.List[Seed] == nil then
		zgo2.Seed.List[Seed] = true
	end
end

function zgo2.Seed.Draw(Seed)
	zgo2.HUD.Draw(Seed,function()
		draw.SimpleText(zgo2.Plant.GetName(Seed:GetPlantID()), zclib.GetFont("zclib_world_font_medium"), 0, -50, zclib.colors[ "text01" ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(Seed:GetCount() .. " / " .. zgo2.config.Seedbox.Count, zclib.GetFont("zclib_world_font_medium"), 0, 0, zclib.colors[ "text01" ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end)
end

net.Receive("zgo2.Seed.Place", function(len)
    zclib.Debug_Net("zgo2.Seed.Place", len)
	local Seed = net.ReadEntity()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	zclib.PointerSystem.Start(Seed, function()
		-- OnInit
		zclib.PointerSystem.Data.MainColor = zclib.colors[ "green01" ]
		zclib.PointerSystem.Data.ActionName = zgo2.language[ "Plant" ]
		zclib.PointerSystem.Data.CancelName = zgo2.language["Cancel"]
	end, function()
		-- OnLeftClick
		net.Start("zgo2.Seed.Place")
		net.WriteEntity(Seed)
		net.SendToServer()
		zclib.PointerSystem.Stop()
	end, function()

		local pot = zclib.PointerSystem.Data.HitEntity
		if IsValid(pot) and pot:GetClass() == "zgo2_pot" and pot:GetHasSoil() and not IsValid(pot:GetPlant()) then
			zclib.PointerSystem.Data.MainColor = zclib.colors[ "green01" ]
		else
			zclib.PointerSystem.Data.MainColor = zclib.colors[ "red01" ]
		end

		-- Update PreviewModel
		if IsValid(zclib.PointerSystem.Data.PreviewModel) then

			local ent = pot
			if IsValid(ent) then
				zclib.PointerSystem.Data.PreviewModel:SetModel(ent:GetModel())
				zclib.PointerSystem.Data.PreviewModel:SetColor(zclib.PointerSystem.Data.MainColor)
				zclib.PointerSystem.Data.PreviewModel:SetPos(ent:GetPos())
				zclib.PointerSystem.Data.PreviewModel:SetAngles(ent:GetAngles())
				zclib.PointerSystem.Data.PreviewModel:SetModelScale(ent:GetModelScale() or 1)
				zclib.PointerSystem.Data.PreviewModel:SetNoDraw(false)
			else
				zclib.PointerSystem.Data.PreviewModel:SetNoDraw(true)
				zclib.PointerSystem.Data.PreviewModel:SetColor(zclib.PointerSystem.Data.MainColor)
				zclib.PointerSystem.Data.PreviewModel:SetPos(zclib.PointerSystem.Data.Pos)
			end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

		end
	end, nil, function()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	end)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3
