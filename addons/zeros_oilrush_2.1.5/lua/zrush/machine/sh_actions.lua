/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.MachineActions = {}
local function AddAction(data) table.insert(zrush.MachineActions,data) end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

// DeConstruct the Machine
AddAction({
	name = zrush.language["Disassemble"],
	icon = zrush.default_materials["zrush_dissamble_icon"],
	color = zclib.colors["orange01"],
	check = function(ent)
		return not ent:IsRunning() and not ent:HasChaosEvent()
	end,
	func =  function(ply, ent)

		if (not zclib.Player.IsOwner(ply, ent) and zrush.config.EquipmentSharing == false) then
			zclib.Notify(ply, zrush.language["YouDontOwnThis"], 1)
			return
		end

		ent.IsDeconstructing = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

		zclib.NetEvent.Create("zrush_action_deconnect", {ent})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

		// Close the interface for any person who uses the machine right now
		zrush.Machine.CloseUI(ent)

		// Call some custom stuff for the specific machine
		ent:Deconstruct(ply)

		// This makes the machine too a box
		zrush.Machinecrate.DeConstruct(ent)
	end
})

// UnJam the Machine
AddAction({
	name = zrush.language["Repair"],
	icon = zrush.default_materials["zrush_dissamble_icon"],
	color = zclib.colors["orange02"],
	check = function(ent)
		return ent:IsJammed()
	end,
	func =  function(ply, ent)
		zrush.EventManager.JamFix(ent)
	end
})

// CoolDown the Machine
AddAction({
	name = zrush.language["CoolDown"],
	icon = zrush.default_materials["zrush_cooldown_icon"],
	color = zclib.colors["blue01"],
	check = function(ent)
		return ent:IsOverHeating()
	end,
	func =  function(ply, ent)
		zrush.EventManager.HeatFix(ent)
	end
})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

// Start the machine
AddAction({
	name = zrush.language["Start"],
	icon = zrush.default_materials["zrush_start_icon"],
	color = zclib.colors["green01"],
	check = function(ent)
		return not ent:HasChaosEvent() and not ent:IsRunning()
	end,
	func =  function(ply, ent)
		if (not zclib.Player.IsOwner(ply, ent) and zrush.config.EquipmentSharing == false) then
			zclib.Notify(ply, zrush.language["YouDontOwnThis"], 1)
			return
		end
		ent:Toggle(ply)
	end
})

// Stop the machine
AddAction({
	name = zrush.language["Stop"],
	icon = zrush.default_materials["zrush_stop_icon"],
	color = zclib.colors["red01"],
	check = function(ent)
		return not ent:HasChaosEvent() and ent:IsRunning()
	end,
	func =  function(ply, ent)
		if (not zclib.Player.IsOwner(ply, ent) and zrush.config.EquipmentSharing == false) then
			zclib.Notify(ply, zrush.language["YouDontOwnThis"], 1)
			return
		end
		ent:Toggle(ply)
	end
})

if SERVER then

	local EntityActionClasses = {
		["zrush_drilltower"] = true,
		["zrush_burner"] = true,
		["zrush_pump"] = true,
		["zrush_refinery"] = true
	}

	util.AddNetworkString("zrush_machine_Action")
	net.Receive("zrush_machine_Action", function(len, ply)
		if zclib.Player.Timeout(nil,ply) then return end
		zclib.Debug("zrush_machine_Action Net " .. len)

		local ent = net.ReadEntity()
		local actionID = net.ReadInt(16)

		zclib.Debug("ent " .. tostring(ent))
		zclib.Debug("actionID " .. tostring(actionID))
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225

		if (IsValid(ent) and EntityActionClasses[ent:GetClass()]) then

			// Add checks for disdtance, is allowed etc
			if zclib.util.InDistance(ent:GetPos(), ply:GetPos(), 300) == false then
				zclib.Notify(ply, zrush.language["TooFarAway"], 1)
				return
			end

			zrush.MachineActions[actionID].func(ply, ent)
		end
	end)
end
