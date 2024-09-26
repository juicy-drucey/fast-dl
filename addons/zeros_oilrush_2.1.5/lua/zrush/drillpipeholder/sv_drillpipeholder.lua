/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if CLIENT then return end
zrush = zrush or {}
zrush.DrillpipeHolder = zrush.DrillpipeHolder or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

function zrush.DrillpipeHolder.Initialize(DrillpipeHolder)
    zclib.EntityTracker.Add(DrillpipeHolder)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

function zrush.DrillpipeHolder.OnRemove(DrillpipeHolder)
    zclib.EntityTracker.Remove(DrillpipeHolder)
end

function zrush.DrillpipeHolder.OnTouch(DrillpipeHolder, other)
    zclib.Debug("zrush.DrillpipeHolder.OnTouch")
    if not IsValid(DrillpipeHolder) then return end
    if not IsValid(other) then return end
    if other:GetClass() ~= "zrush_drillpipe_holder" then return end
    if zclib.util.CollisionCooldown(other) then return end

	if zclib.Entity.GettingRemoved(other) then return end

    if DrillpipeHolder.NextMerge and CurTime() < DrillpipeHolder.NextMerge then return end
    DrillpipeHolder.NextMerge = CurTime() + 1
	other.NextMerge = CurTime() + 1

    local countA = DrillpipeHolder:GetPipeCount()
    local countB = other:GetPipeCount()

    local FreeSpace = 10 - countA
    if FreeSpace <= 0 then return end

    local MoveAmount = math.Clamp(countB, 0, FreeSpace)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

    other:SetPipeCount(countB - MoveAmount)
    if other:GetPipeCount() <= 0 then
        DropEntityIfHeld(other)
        zclib.Entity.SafeRemove(other)
    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

    DrillpipeHolder:SetPipeCount(countA + MoveAmount)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22
