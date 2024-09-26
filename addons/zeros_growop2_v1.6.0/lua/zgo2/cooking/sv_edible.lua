/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Edible = zgo2.Edible or {}
zgo2.Edible.List = zgo2.Edible.List or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

/*

	Edibles can be consumed by players and could make them high

*/

function zgo2.Edible.Initialize(Edible)
	zgo2.Destruction.SetupHealth(Edible)
	zclib.EntityTracker.Add(Edible)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	timer.Simple(0,function()
		if IsValid(Edible) and Edible:GetWeedID() > 0 then Edible:SetBodygroup(0,1) end
	end)
end

function zgo2.Edible.USE(Edible,ply)
	if not IsValid(Edible) then return end
	if not IsValid(ply) then return end

	if Edible:GetWeedID() > 0 then
		zgo2.HighEffect.Start(Edible:GetWeedID(),Edible:GetWeedTHC(),30,ply)
	end

	local EdibleData = zgo2.Edible.GetData(Edible:GetEdibleID())
	if EdibleData == nil then SafeRemoveEntity(Edible) return end

	local _health = EdibleData.health

	local _NewHealth

	// Give the player Energy instead of health if we can find the var for it
	if zclib.Gamemode.Hungermod(ply) then
		_NewHealth = math.Clamp((ply:getDarkRPVar("Energy") or 100) + _health, 0, EdibleData.healthcap)
		ply:setDarkRPVar("Energy", _NewHealth)
	else
		_NewHealth = math.Clamp(ply:Health() + _health, 0, EdibleData.healthcap)
		ply:SetHealth(_NewHealth)
	end

	zclib.Sound.EmitFromPosition(ply:GetPos(),"zgo2_muffin_eat")

	SafeRemoveEntity(Edible)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

concommand.Add("zgo2_spawn_edibles", function(ply, cmd, args)
	if zclib.Player.IsAdmin(ply) then
		local tr = ply:GetEyeTrace()

		if tr and tr.Hit and tr.HitPos then
			undo.Create("zgo2_spawn_edibles")

			for i = 1, 25 do
				local edible_id = math.random(#zgo2.config.Edibles)
				local edible_data = zgo2.Edible.GetData(edible_id)
				local ent = ents.Create("zgo2_edible")
				ent:SetPos(tr.HitPos + zclib.util.GetRandomPositionInsideCircle(25, 100, 15))
				ent:SetAngles(Angle(0, math.random(360), 0))

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

				if math.random(10) > 5 then
					ent:SetWeedID(zgo2.Plant.GetRandomID())
					ent:SetWeedAmount(edible_data.weed_capacity)
					ent:SetWeedTHC(100)
				end


				zclib.Player.SetOwner(ent, ply)
				ent:Spawn()
				ent:Activate()
				ent:SetModel(edible_data.edible_model)
				ent:SetEdibleID(edible_id)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

				if ent:GetWeedID() > 0 then
					ent:SetBodygroup(0, 1)
				end
				undo.AddEntity(ent)
				undo.SetPlayer(ply)
			end

			undo.Finish()
		end
	end
end)
