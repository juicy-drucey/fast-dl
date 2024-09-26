/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if SERVER then return end
zrush = zrush or {}
zrush.DrillTower = zrush.DrillTower or {}

function zrush.DrillTower.Initialize(DrillTower)
	DrillTower:UpdatePitch()
	DrillTower.UpdateSound = false
	DrillTower.LastPipeCount = -1
	DrillTower.ClientPipesRebuild = false
end

function zrush.DrillTower.Think(DrillTower)
	if zclib.util.InDistance(LocalPlayer():GetPos(), DrillTower:GetPos(), 1000) then

		if (DrillTower.LastPipeCount ~= DrillTower:GetPipes()) or DrillTower.ClientPipesRebuild == false then
			zrush.DrillTower.RebuildPipes(DrillTower)
			DrillTower.LastPipeCount = DrillTower:GetPipes()
		end

		// One time Effect Creation
		local cur_state = DrillTower:GetState()

		// Playing looped sound
		zrush.util.LoopedSound(DrillTower, "zrush_sfx_jammed", DrillTower:IsJammed() == true, 70)
		zrush.util.LoopedSound(DrillTower, "zrush_sfx_drill", DrillTower:IsJammed() == false and cur_state == ZRUSH_STATE_ISDRILLING, DrillTower.SoundPitch)
	else
		zrush.DrillTower.RemovePipes(DrillTower)
		DrillTower.ClientPipesRebuild = false
	end
end

function zrush.DrillTower.OnRemove(DrillTower)
	DrillTower:StopSound("zrush_sfx_drill")
	DrillTower:StopSound("zrush_sfx_jammed")
	DrillTower:StopParticles()
	zrush.DrillTower.RemovePipes(DrillTower)
end

function zrush.DrillTower.RemovePipes(DrillTower)
	if (DrillTower.Pipes) then
		for i = 1, table.Count(DrillTower.Pipes) do
			local pipe = DrillTower.Pipes[i]

			if IsValid(pipe) then
				zclib.ClientModel.Remove(pipe)
			end
		end
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

local s_ang = Angle(-90, 0, 0)

// This spawns the visual pipes in the tower
function zrush.DrillTower.RebuildPipes(DrillTower)
	local PipesInMachine = DrillTower:GetBoostValue("pipes")

	// If the pipecount change then we rebuild the pipes
	zrush.DrillTower.RemovePipes(DrillTower)
	DrillTower.Pipes = {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354

	for i = 0, PipesInMachine - 1 do

		local pipe = zclib.ClientModel.AddProp()
		local attach = DrillTower:LookupAttachment("pipe")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

		if (IsValid(pipe) and attach) then
			pipe:SetPos(DrillTower:LocalToWorld(Vector(0, 0, 50 + 85 * i)))
			pipe:SetModel("models/zerochain/props_oilrush/zor_drillpipe.mdl")
			pipe:SetAngles(DrillTower:LocalToWorldAngles(s_ang))
			pipe:Spawn()
			pipe:Activate()
			pipe:SetParent(DrillTower, attach)
			pipe:SetRenderMode(RENDERMODE_NORMAL)
			pipe:SetNoDraw(true)
			table.insert(DrillTower.Pipes, pipe)
		end
	end

	// Here we set the Pipes visibility
	for i = 1, table.Count(DrillTower.Pipes) do
		local pipe = DrillTower.Pipes[i]
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

		if IsValid(pipe) then
			if (i <= DrillTower:GetPipes()) then
				pipe:SetNoDraw(false)
			else
				pipe:SetNoDraw(true)
			end
		end
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	DrillTower.ClientPipesRebuild = true
end
