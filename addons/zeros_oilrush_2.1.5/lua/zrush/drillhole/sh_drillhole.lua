/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.DrillHole = zrush.DrillHole or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354

// Is the DrillHole ready for the machine?
function zrush.DrillHole.ReadyForMachine(DrillHole, MachineID, ply)
    local m_state = DrillHole:GetState()
    if (m_state == ZRUSH_STATE_NEEDPIPES and not DrillHole:HasDrill()) then
        if (MachineID ~= ZRUSH_DRILL) then
            if (SERVER) then
                zclib.Notify(ply, zrush.language["Needsdrilledfirst"], 1)
            end
        else
            return true
        end
    elseif (m_state == ZRUSH_STATE_NEEDBURNER and not DrillHole:HasBurner()) then
        if (MachineID ~= ZRUSH_BURNER) then
            if (SERVER) then
                zclib.Notify(ply, zrush.language["NeedsBurnerquick"], 1)
            end
        else
            return true
        end
    elseif (m_state == ZRUSH_STATE_PUMPREADY and not DrillHole:HasPump()) then
        if (MachineID ~= ZRUSH_PUMP) then
            if (SERVER) then
                zclib.Notify(ply, zrush.language["NeedsPump"], 1)
            end
        else
            return true
        end
    else
        if (SERVER) then
            zclib.Notify(ply, zrush.language["NotValidSpace"], 1)
        end
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2
