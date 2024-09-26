/*
    Addon id: a36a6eee-6041-4541-9849-360baff995a2
    Version: v1.4.1 (stable)
*/

zmlab2 = zmlab2 or {}
zmlab2.Player = zmlab2.Player or {}

function zmlab2.Player.IsMethCook(ply)
    if BaseWars then return true end
	if zmlab2.config.Jobs == nil then return true end
	if table.Count(zmlab2.config.Jobs) <= 0 then return true end

	if zmlab2.config.Jobs[zclib.Player.GetJob(ply)] then
		return true
	else
		return false
	end
end

function zmlab2.Player.IsMethSeller(ply)
    if BaseWars then return true end
	if zmlab2.config.SellJobs == nil then return true end
	if table.Count(zmlab2.config.SellJobs) <= 0 then return true end

	if zmlab2.config.SellJobs[zclib.Player.GetJob(ply)] then
		return true
	else
		return false
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

// Returns the dropoff point if the player has one assigned
function zmlab2.Player.GetDropoff(ply)
	return ply.zmlab2_Dropoff
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

// Does the player has meth?
function zmlab2.Player.HasMeth(ply)
	if (ply.zmlab2_MethList and #ply.zmlab2_MethList > 0) then
		return true
	else
		return false
	end
end

function zmlab2.Player.OnMeth(ply)
	if ply.zmlab2_MethDuration and ply.zmlab2_MethStart and (ply.zmlab2_MethDuration + ply.zmlab2_MethStart) > CurTime() then
		return true
	else
		return false
	end
end

// Checks if the player is allowed to interact with the entity
function zmlab2.Player.CanInteract(ply, ent)
    if zmlab2.Player.IsMethCook(ply) == false then
        zclib.Notify(ply, zmlab2.language["Interaction_Fail_Job"], 1)

        return false
    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- a423d64e09a7ff35771e274d2c802c4d68af8d151714a29b1df4c0432d376358

    if zmlab2.config.SharedEquipment == true then
        return true
    else
        // Is the entity a public entity?
        if ent.IsPublic == true then return true end

        if zclib.Player.IsOwner(ply, ent) then
            return true
        else
            zclib.Notify(ply, zmlab2.language["YouDontOwnThis"], 1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 904975b3b3dbe3f4337208147d7caa58bdde3c3feca3828dba7cf4a7246a8723

            return false
        end
    end
end
