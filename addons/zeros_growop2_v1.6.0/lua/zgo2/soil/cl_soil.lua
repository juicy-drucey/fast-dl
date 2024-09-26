/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Soil = zgo2.Soil or {}

net.Receive("zgo2.Soil.Place", function(len)
    zclib.Debug_Net("zgo2.Soil.Place", len)
	local Soil = net.ReadEntity()

	zclib.PointerSystem.Start(Soil, function()
		-- OnInit
		zclib.PointerSystem.Data.MainColor = zclib.colors[ "green01" ]
		zclib.PointerSystem.Data.ActionName =  zgo2.language[ "Place" ]
		zclib.PointerSystem.Data.CancelName = zgo2.language["Cancel"]
	end, function()
		-- OnLeftClick
		net.Start("zgo2.Soil.Place")
		net.WriteEntity(Soil)
		net.SendToServer()
		zclib.PointerSystem.Stop()
	end, function()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

		if IsValid(zclib.PointerSystem.Data.HitEntity) and zclib.PointerSystem.Data.HitEntity:GetClass() == "zgo2_pot" then
			zclib.PointerSystem.Data.MainColor = zclib.colors[ "green01" ]
		else
			zclib.PointerSystem.Data.MainColor = zclib.colors[ "red01" ]
		end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

		-- Update PreviewModel
		if IsValid(zclib.PointerSystem.Data.PreviewModel) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

			local ent = zclib.PointerSystem.Data.HitEntity
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

		end
	end, nil, function()

	end)
end)
