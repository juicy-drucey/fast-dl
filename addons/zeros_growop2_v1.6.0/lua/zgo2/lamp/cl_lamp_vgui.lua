/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Lamp = zgo2.Lamp or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

net.Receive("zgo2.Lamp.SelectColor", function(len, ply)
	zclib.Debug_Net("zgo2.Lamp.SelectColor", len)
	local Lamp = net.ReadEntity()
	zgo2.Lamp.OpenColorSelector(Lamp)
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

function zgo2.Lamp.OpenColorSelector(Lamp)
	zclib.vgui.Page(zgo2.language[ "Light Color" ], function(main, top)
		main:SetSize(400 * zclib.wM, 300 * zclib.hM)
		main:DockPadding(0, 15, 0, 10)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

		zgo2.vgui.ImageButton(top, zclib.Materials.Get("close"), zclib.colors[ "red01" ], function()
			main:Close()
		end, function() return false end, zgo2.language[ "Close" ])

		local seperator = zclib.vgui.AddSeperator(top)
		seperator:SetSize(5 * zclib.wM, 50 * zclib.hM)
		seperator:Dock(RIGHT)
		seperator:DockMargin(10 * zclib.wM, 0 * zclib.hM, 0 * zclib.wM, 0 * zclib.hM)
		local color = Lamp:GetLampColor()
		color = Color(color.x, color.y, color.z)

		local paint_color = zclib.vgui.Colormixer(main, color, function(col) end, function(col, s)
			net.Start("zgo2.Lamp.SelectColor")
			net.WriteEntity(Lamp)
			net.WriteUInt(col.r, 8)
			net.WriteUInt(col.g, 8)
			net.WriteUInt(col.b, 8)
			net.SendToServer()
		end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

		paint_color:DockMargin(10, 0, 10, 0)
		paint_color:Dock(FILL)
		paint_color:SetWangs(false)
		paint_color:SetAlphaBar(false)
	end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
