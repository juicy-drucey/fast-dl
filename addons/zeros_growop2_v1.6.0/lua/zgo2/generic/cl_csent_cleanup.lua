/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

/*
	Quick system to cleanup client models out of distance
*/
zgo2.ClientModels = zgo2.ClientModels or {}
zclib.Timer.Remove("zgo2_clientmodel_cleanup")

zclib.Timer.Create("zgo2_clientmodel_cleanup", 10, 0, function()
	if zgo2.ClientModels then
		for _, ent in pairs(zgo2.ClientModels) do
			if not IsValid(ent) then continue end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

			if not IsValid(ent:GetParent()) then
				ent:Remove()
				continue
			end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

			if zclib.util.InDistance(ent:GetPos(), LocalPlayer():GetPos(), 1000) == false then
				ent:Remove()
			end
		end
	end
end)
