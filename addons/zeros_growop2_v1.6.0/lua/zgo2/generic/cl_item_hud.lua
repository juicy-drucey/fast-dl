/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.HUD = zgo2.HUD or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

function zgo2.HUD.Draw(ent,func,scale)
	if not zclib.Convar.GetBool("zclib_cl_drawui") then return end
	if zclib.util.InDistance(ent:GetPos(), LocalPlayer():GetPos(), zgo2.util.RenderDistance_UI) == false then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	local height = ((ent:OBBMaxs().z + ent:OBBMins().z) / 2) + 10
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	cam.Start3D2D(ent:LocalToWorld(ent:OBBCenter()) + Vector(0, 0, height + 1 * math.sin(CurTime() * 2)), zclib.HUD.GetLookAngles(),scale or 0.1)
		pcall(func)
	cam.End3D2D()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
