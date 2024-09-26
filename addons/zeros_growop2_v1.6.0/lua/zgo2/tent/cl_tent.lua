/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Tent = zgo2.Tent or {}
zgo2.Tent.List = zgo2.Tent.List or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

	Growboxes are used for small scale grow operations
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

*/
function zgo2.Tent.Initialize(Tent)
	Tent:DrawShadow(false)
	Tent:DestroyShadow()

	timer.Simple(0.2, function()
		if IsValid(Tent) then
			Tent.m_Initialized = true
		end
	end)
end

/*
	Draw ui and light stuff
*/
function zgo2.Tent.OnDraw(Tent)
	if not zclib.Convar.GetBool("zclib_cl_drawui") then return end
	if zclib.util.InDistance(Tent:GetPos(), LocalPlayer():GetPos(), 600) == false then return end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

function zgo2.Tent.OnThink(Tent)
	zgo2.Tent.List[Tent] = true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b
