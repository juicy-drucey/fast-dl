/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Rack = zgo2.Rack or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

	Players can place pots on the rack, just so the pots just stand randomly in a room. Idk looks better

*/

/*
	Get the UniqueID
*/
function zgo2.Rack.GetID(ListID)
    return zgo2.Rack.GetData(ListID).uniqueid
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

/*
	Get the list id
*/
function zgo2.Rack.GetListID(UniqueID)
    return zgo2.config.Racks_ListID[UniqueID] or 0
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

/*
	Get the Rack config data
*/
function zgo2.Rack.GetData(UniqueID)
    if UniqueID == nil then return end

    // If its a list id then lets return its data
    if zgo2.config.Racks[UniqueID] then return zgo2.config.Racks[UniqueID] end

    // If its a uniqueid then lets get its list id and return the data
    local id = zgo2.Rack.GetListID(UniqueID)
    if UniqueID and id and zgo2.config.Racks[id] then
        return zgo2.config.Racks[id]
    end
end

/*
	Returns the name
*/
function zgo2.Rack.GetName(UniqueID)
	local dat = zgo2.Rack.GetData(UniqueID)
	if not dat then return "Unkown" end
	return dat.name
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
