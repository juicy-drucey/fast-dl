/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Pump = zgo2.Pump or {}
zgo2.Pump.List = zgo2.Pump.List or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	Pumps move water from watertanks to pots
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

*/
function zgo2.Pump.IsInput(Pump,ent)
	if not IsValid(ent) then return false end
	if string.sub(ent:GetClass(),1,14) == "zgo2_watertank" then return true end
	return false
end

function zgo2.Pump.IsOutput(Pump,ent)
	if not IsValid(ent) then return false end
	if ent:GetClass() == "zgo2_pot" and zgo2.Pot.HasHoseConnection(ent) then return true end
	return false
end
