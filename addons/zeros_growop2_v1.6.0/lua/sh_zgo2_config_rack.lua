/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.config = zgo2.config or {}
zgo2.config.Racks = {}
zgo2.config.Racks_ListID = zgo2.config.Racks_ListID or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

local function AddRack(data)
	local PlantID = table.insert(zgo2.config.Racks,data)
	zgo2.config.Racks_ListID[data.uniqueid] = PlantID
	return PlantID
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

AddRack({
	uniqueid = "fasdgalkj343",
	class = "zgo2_rack",
	name = zgo2.language[ "Rack" ],
	mdl = "models/zerochain/props_growop2/zgo2_rack01.mdl",
	price = 1000,
	jobs = zgo2.config.Jobs.Pro,
	PotPositions = {
		[ 1 ] = { Vector(30, 0, 12), Angle(0, -90, 0) },
		[ 2 ] = { Vector(-30, 0, 12), Angle(0, -90, 0) }
	}
})

AddRack({
	uniqueid = "fsk48ffsf588",
	class = "zgo2_rack",
	name = zgo2.language[ "Rack" ],
	mdl = "models/zerochain/props_growop2/zgo2_rack.mdl",
	price = 2000,
	jobs = zgo2.config.Jobs.Pro,
	PotPositions = {
		[ 1 ] = { Vector(30, 30, 12), Angle(0, -90, 0) },
		[ 2 ] = { Vector(-30, 30, 12), Angle(0, -90, 0) },
		[ 3 ] = { Vector(30, 0, 41), Angle(0, -90, 0) },
		[ 4 ] = { Vector(-30, 0, 41), Angle(0, -90, 0) },
	}
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
