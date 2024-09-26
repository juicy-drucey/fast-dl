local PMETA = FindMetaTable( "Player" )

function PMETA:CH_AdvMedic_CreateCorpse()
    -- Create the corpse and connect it with the player
    local corpse = ents.Create( "prop_ragdoll" )
    corpse:SetPos( self:GetPos() )
    corpse:SetAngles( self:GetAngles() )
    corpse:SetModel( self:GetModel() )
    corpse:SetOwner( self )
    corpse:SetNWBool( "CH_AdvMedic_RagdollIsCorpse", true )
	if self.CH_AdvMedic_HasLifeAlert then
		corpse:SetNWBool( "CH_AdvMedic_HasLifeAlert", true )
		
		if CH_AdvMedic.Config.LifeAlertNotifyMedic then
			for k, ply in ipairs( player.GetAll() ) do
				if ply:CH_AdvMedic_IsParamedic() then
					DarkRP.notify( ply, 1, CH_AdvMedic.Config.NotificationTime, CH_AdvMedic.LangString( "A player with a life alert has died. Their location is marked on your map!" ) )
				end
			end
		end
	end
	
	-- Thanks to https://wiki.garrysmod.com/page/Entity/GetPhysicsObjectCount and https://wiki.garrysmod.com/page/Entity/GetPhysicsObjectNum and a bit of looking at TTT code :)
    for i = 0, corpse:GetPhysicsObjectCount() - 1 do
        local bone = self:GetPhysicsObjectNum( i )

        if IsValid( bone ) then
            local bonepos, boneang = self:GetBonePosition( corpse:TranslatePhysBoneToBone( i ) )

            if bonepos and boneang then
                bone:SetPos( bonepos )
                bone:SetAngles( boneang )
            end
        end
    end

    corpse:Spawn()
    corpse:Activate()
	corpse:AddEFlags( EFL_IN_SKYBOX )
	
	-- Update bodygroups, color and skin accordingly
	corpse:SetColor( self:GetColor() )
	corpse:SetRenderMode( RENDERMODE_TRANSCOLOR )
	corpse:SetSkin( self:GetSkin() )
	
    for k, v in pairs( self:GetBodyGroups() ) do
        corpse:SetBodygroup( k - 1, self:GetBodygroup( k - 1 ) )
    end
	
    self.CH_AdvMedic_DeathRagdoll = corpse
    return corpse
end

function PMETA:CH_AdvMedic_GetPlayersSex()
	if string.find( string.sub( self:GetModel(), 2 ), "f" ) then
		return "Female"
	elseif CH_AdvMedic.Config.AlternativeFemaleModels[ self:GetModel() ] then
		return "Female"
	elseif string.find( string.sub( self:GetModel(), 2 ), "m" ) then
		return "Male"
	elseif CH_AdvMedic.Config.AlternativeMaleModels[ self:GetModel() ] then
		return "Male"
	end
end

function PMETA:CH_AdvMedic_HasInjury()
	if self.CH_AdvMedic_HasBrokenArm or self.CH_AdvMedic_HasBrokenLeg or self.CH_AdvMedic_HasInternalBleedings then
		return true
	else 
		return false
	end
end
