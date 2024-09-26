hook.Add( "PostPlayerDraw", "PostPlayerDraw.RetroBoombox", function( pPlayer )
	if SERVER then return end

	local currentWeapon = pPlayer:GetActiveWeapon()
	if not IsValid( currentWeapon ) then return end
	if currentWeapon:GetClass() ~= "retroboombox_base" then return end

	if not currentWeapon.PlayMusic or not isfunction( currentWeapon.PlayMusic ) then return end

	currentWeapon:PlayMusic()
end )