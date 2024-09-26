/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.Fuel = zrush.Fuel or {}

function zrush.Fuel.GetData(id)
    return zrush.FuelTypes[id]
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function zrush.Fuel.GetName(id)
    local dat = zrush.Fuel.GetData(id)
    return dat.name
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

function zrush.Fuel.GetColor(id)
    local dat = zrush.Fuel.GetData(id)
    return dat.color
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

function zrush.Fuel.GetVCFuel(id)
    local dat = zrush.Fuel.GetData(id)
    return dat.vcmodfuel
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821


function zrush.Fuel.GetDarkenColor(id)
    return zrush.darken_fuelcolors[id]
end

function zrush.Fuel.GetTransColor(id)
    return zrush.trans_fuelcolors[id]
end
