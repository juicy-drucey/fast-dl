/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Plant = zgo2.Plant or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

/*

	Setsup all the diffrent plant shapes
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

*/
zgo2.Plant.Shapes = {}
local function AddPlantShape(data) return table.insert(zgo2.Plant.Shapes,data) end
AddPlantShape("models/zerochain/props_growop2/zgo2_plant01.mdl")
AddPlantShape("models/zerochain/props_growop2/zgo2_plant02.mdl")
AddPlantShape("models/zerochain/props_growop2/zgo2_plant03.mdl")
AddPlantShape("models/zerochain/props_growop2/zgo2_plant04.mdl")

/*

	Small system to force update the plants model if requested by the SERVER
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

*/
if SERVER then
	util.AddNetworkString("zgo2.Plant.UpdateModel")

	function zgo2.Plant.UpdateModel(Plant)
		net.Start("zgo2.Plant.UpdateModel", true)
		net.WriteEntity(Plant)
		net.Broadcast()
	end
else
	net.Receive("zgo2.Plant.UpdateModel", function(len)
		zclib.Debug_Net("zgo2.Plant.UpdateModel", len)
		local Plant = net.ReadEntity()
		if not IsValid(Plant) then return end
		if not Plant:IsValid() then return end
		zgo2.Plant.UpdateModel(Plant)
	end)
end
