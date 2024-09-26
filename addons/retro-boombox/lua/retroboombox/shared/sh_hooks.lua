hook.Add( "PlayerSwitchWeapon", "PlayerSwitchWeapon.RetroBoombox", function( pPlayer, eOldWeapon, eNewWeapon )
	if IsValid( eOldWeapon ) and eOldWeapon.GetClass and eOldWeapon:GetClass() == "retroboombox_base" and eOldWeapon.Holster and isfunction( eOldWeapon.Holster ) then
		eOldWeapon:Holster()
	end
end )