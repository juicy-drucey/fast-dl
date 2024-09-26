local PMETA = FindMetaTable( "Player" )
local EMETA = FindMetaTable( "Entity" )

function PMETA:CH_AdvMedic_GetUnconciousTime()
	local death_time = CH_AdvMedic.Config.UnconsciousTime

	for k, v in pairs( CH_AdvMedic.Config.RankDeathTime ) do
		if serverguard then
			if v.UserGroup == serverguard.player:GetRank( self ) then
				return v.Time
			end
		elseif sam then
			if v.UserGroup == sam.player.get_rank( self:SteamID() ) then
				return v.Time
			end
		else
			if v.UserGroup == self:GetUserGroup() then
				return v.Time
			end
		end
	end

	return death_time
end

function PMETA:CH_AdvMedic_IsParamedic()
	return CH_AdvMedic.Config.AllowedTeams[ team.GetName( self:Team() ) ]
end

function EMETA:CH_AdvMedic_IsAmbulance()
	return self:GetModel() == CH_AdvMedic.Config.VehicleModel
end