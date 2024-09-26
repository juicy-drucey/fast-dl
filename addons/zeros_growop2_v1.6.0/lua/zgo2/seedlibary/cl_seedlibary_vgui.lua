/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.SeedLibary = zgo2.SeedLibary or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab

/*

	The seedlibary stores the players seeds

*/

local SeedList = {}
local SeedLibary
net.Receive("zgo2.SeedLibary.Open", function(len, ply)
	zclib.Debug_Net("zgo2.SeedLibary.Open", len)

	SeedLibary = net.ReadEntity()

	SeedList = {}
	local count = net.ReadUInt(32)
	for i = 1, count do
		SeedList[ net.ReadUInt(32) ] = {
			id = net.ReadString(),
			count = net.ReadUInt(32),
		}
	end

	zgo2.SeedLibary.Open()
end)

net.Receive("zgo2.SeedLibary.ResetInactivity", function(len)
	zclib.Debug_Net("zgo2.SeedLibary.ResetInactivity", len)
	zgo2.SeedLibary.Open()
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

function zgo2.SeedLibary.Open()
	zclib.vgui.Page(zgo2.language[ "SeedLibary" ], function(main, top)
		main:SetSize(1000 * zclib.wM, 700 * zclib.hM)

		zgo2.vgui.ImageButton(top, zclib.Materials.Get("close"), zclib.colors[ "red01" ], function()
			main:Close()
		end, function() return false end, zgo2.language[ "Close" ])

		local seperator = zclib.vgui.AddSeperator(top)
		seperator:SetSize(5 * zclib.wM, 50 * zclib.hM)
		seperator:Dock(RIGHT)
		seperator:DockMargin(10 * zclib.wM, 0 * zclib.hM, 0 * zclib.wM, 0 * zclib.hM)

		if zgo2.config.SeedLibary.InactivityReset then
			zgo2.vgui.ImageButton(top, zclib.Materials.Get("refresh"), zclib.colors[ "blue02" ], function()
				// Send net message to reset any spliced weed seed in the players libary
				net.Start("zgo2.SeedLibary.ResetInactivity")
				net.SendToServer()
			end, function() return false end, zgo2.language["seedlibary_reset_tooltip"])
		end

		local content = vgui.Create("DPanel", main)
		content:Dock(FILL)
		content:DockMargin(50 * zclib.wM, 0 * zclib.hM, 50 * zclib.wM, 10 * zclib.hM)
		content.Paint = function(s, w, h) end
		content:InvalidateLayout(true)
		content:InvalidateParent(true)


		local list, scroll = zclib.vgui.List(content)
		list:DockMargin(0 * zclib.wM, 0 * zclib.hM, 0 * zclib.wM, 0 * zclib.hM)
		scroll:DockMargin(0 * zclib.wM, 5 * zclib.hM, 0 * zclib.wM, 0 * zclib.hM)
		scroll.Paint = function(s, w, h) end
		list.Paint = function(s, w, h) end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

		for i = 1, 10 do
			local itm = list:Add("DPanel")
			itm:SetSize(171 * zclib.wM, 265 * zclib.hM)
			itm.Paint = function(s, w, h)
				draw.RoundedBox(5, 0, 0, w, h, zclib.colors[ "black_a100" ])
			end

			local SlotData = SeedList[i]
			if not SlotData then continue end

			local PlantData = zgo2.Plant.GetData(SlotData.id)
			if not PlantData then
				continue
			end

			local imgpnl = vgui.Create("DImageButton", itm)
			imgpnl:SetTall(166 * zclib.wM)
			imgpnl:Dock(TOP)
			local img = zclib.Snapshoter.Get({
				class = "zgo2_seed",
				model = "models/zerochain/props_growop2/zgo2_weedseeds.mdl",
				PlantID = SlotData.id,
			}, imgpnl)
			imgpnl:SetImage(img and img or "materials/zerochain/zerolib/ui/icon_loading.png")

			imgpnl.PaintOver = function(s, w, h)
				surface.SetDrawColor(zclib.colors[ "black_a200" ])
				surface.SetMaterial(zclib.Materials.Get("linear_gradient"))
				surface.DrawTexturedRectRotated(w / 2, h / 2, h, w, -90)

				draw.SimpleText("x"..SlotData.count, zclib.GetFont("zclib_font_mediumsmall"), w - (10 * zclib.wM), 0 * zclib.hM, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

				if s:IsHovered() then draw.RoundedBox(5, 0, 0, w, h, zclib.colors[ "white_a15" ]) end
			end
			imgpnl.DoClick = function()
				zclib.vgui.PlaySound("UI/buttonclick.wav")

				// Call net message to drop this seed entity from the libary
				net.Start("zgo2.SeedLibary.Drop")
				net.WriteEntity(SeedLibary)
				net.WriteUInt(i,32)
				net.SendToServer()

				imgpnl:SetDisabled(true)

				timer.Simple(1.5,function()
					if IsValid(imgpnl) then
						imgpnl:SetDisabled(false)
					end
				end)
			end

			if PlantData.SplicedConfig then

				local function AddLabel(txt,font,color)
					local lbl = vgui.Create("DLabel", itm)
					lbl:SetSize(500, 30 * zclib.hM)
					lbl:Dock(TOP)
					//lbl:DockMargin(0 * zclib.wM, 0 * zclib.hM, 0 * zclib.wM,5 * zclib.hM)
					lbl:SetFont(font)
					lbl:SetTextColor(color)
					lbl:SetText(txt)
					lbl:SetContentAlignment(5)
					lbl.Paint = function(s, w, h)
						draw.RoundedBox(0, 0, 0, w, h, zclib.colors[ "black_a100" ])
					end
				end

				AddLabel(tostring(PlantData.name),zclib.GetFont("zclib_font_small"),color_white)

				AddLabel(tostring(PlantData.creator_name),zclib.GetFont("zclib_font_small"),zclib.colors[ "text01" ])

				local Activity = PlantData.Activity
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

				local lbl = vgui.Create("DLabel", itm)
				lbl:SetSize(500, 30 * zclib.hM)
				lbl:Dock(FILL)
				lbl:SetFont(zclib.GetFont("zclib_font_small"))
				lbl:SetTextColor(zclib.colors[ "text01" ])
				lbl:SetText("")
				lbl:SetContentAlignment(5)
				lbl.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, zclib.colors[ "black_a100" ]) end
				lbl.PaintOver = function(s, w, h)

					local SecondsLeft = (Activity + zgo2.Plant.GetLifeTime(SlotData.id)) - os.time()
					SecondsLeft = string.FormattedTime( SecondsLeft )

					local hours,minutes,seconds = SecondsLeft.h,SecondsLeft.m,SecondsLeft.s
					if hours < 10 then hours = "0"..hours end
					if minutes < 10 then minutes = "0"..minutes end
					if seconds < 10 then seconds = "0"..seconds end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb

					lbl:SetText(hours .. ":" .. minutes .. ":" .. seconds)
				end
			else
				local lbl = vgui.Create("DLabel", itm)
				lbl:Dock(FILL)
				lbl:SetFont(zclib.GetFont("zclib_font_small"))
				lbl:SetTextColor(color_white)
				lbl:SetText("-")
				lbl:SetContentAlignment(5)
				lbl.Paint = function(s, w, h) draw.RoundedBox(0, 0, 0, w, h, zclib.colors[ "black_a100" ]) end
			end
		end
	end)
end
