/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Tent = zgo2.Tent or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

/*

	Tents are used to provide the Tents with light, depending on the Tent it can have diffrent colors, muliply bulbs and a wider light cone
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

*/

/*
	Get the UniqueID
*/
function zgo2.Tent.GetID(ListID)
    return zgo2.Tent.GetData(ListID).uniqueid
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

/*
	Get the list id
*/
function zgo2.Tent.GetListID(UniqueID)
    return zgo2.config.Tents_ListID[UniqueID] or 0
end

/*
	Get the Tent config data
*/
function zgo2.Tent.GetData(UniqueID)
    if UniqueID == nil then return end

    // If its a list id then lets return its data
    if zgo2.config.Tents[UniqueID] then return zgo2.config.Tents[UniqueID] end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    // If its a uniqueid then lets get its list id and return the data
    local id = zgo2.Tent.GetListID(UniqueID)
    if UniqueID and id and zgo2.config.Tents[id] then
        return zgo2.config.Tents[id]
    end
end

/*
	Returns true if the provided position is inside the model bounds (Inside the tent itself)
*/
function zgo2.Tent.IsInside(Tent,Pos)
	local min,max = Tent:GetModelBounds()

	local lPos = Tent:WorldToLocal(Pos)
	if lPos.x < max.x and lPos.x > min.x and lPos.y < max.y and lPos.y > min.y and lPos.z < max.z and lPos.z > min.z then
		return true
	else
		return false
	end
end

/*
	Returns the height of the tent
*/
function zgo2.Tent.GetHeight(Tent)
	local _,max = Tent:GetModelBounds()
	return max.z
end

/*
	Returns the plant name
*/
function zgo2.Tent.GetName(UniqueID)
    local dat = zgo2.Tent.GetData(UniqueID)
	if not dat then return "Unknown" end
	return dat.name or "Unknown"
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
