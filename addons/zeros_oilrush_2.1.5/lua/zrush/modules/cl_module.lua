/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if SERVER then return end
zrush = zrush or {}
zrush.Modules = zrush.Modules or {}

local l_pos = Vector(-5, -5, -4.6)
local l_ang = Angle(0, 0, 180)

function zrush.Modules.Draw(ModuleEnt)
	if zclib.Convar.Get("zclib_cl_drawui") == 1 and zclib.util.InDistance(LocalPlayer():GetPos(), ModuleEnt:GetPos(), 200) then
		cam.Start3D2D(ModuleEnt:LocalToWorld(l_pos), ModuleEnt:LocalToWorldAngles(l_ang), 0.1)
			zrush.Modules.DrawSimple(ModuleEnt:GetAbilityID(), 80, 80, 10, 10)
		cam.End3D2D()
	end
end


// Draw the circle with the module icon and correct color
function zrush.Modules.DrawSimple(m_id,w,h,x,y,bg_color)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

	x = x or 0
	y = y or 0

	draw.RoundedBox(w, x, y, w, h, bg_color or zclib.colors["ui01"])

	if m_id == nil then return end

	local data = zrush.Modules.GetData(m_id)
	if data == nil then return end

	local m_icon = zrush.Modules.GetIcon(data.type)
	if m_icon == nil then return end

	local m_color = data.color
	if m_color == nil then return end

	surface.SetDrawColor(m_color)
	surface.SetMaterial(m_icon)
	surface.DrawTexturedRect(x + (w * 0.2),y + (w * 0.2), w * 0.6, w * 0.6)
end

// Same as above but includes text which shows count / %
function zrush.Modules.DrawDetailed(m_id,w,h,x,y)

	x = x or 0
	y = y or 0

	draw.RoundedBox(w, x, y, w, h, zclib.colors["ui01"])

	draw.RoundedBox(8, x, y + h / 2, w, h / 2, zclib.colors["ui01"])

	if m_id == nil then return end

	local data = zrush.Modules.GetData(m_id)
	if data == nil then return end

	local m_icon = zrush.Modules.GetIcon(data.type)
	if m_icon == nil then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 962871514e7ac4c86328739cb4e47c532013e83bbaa7019e54bab2934af8b225
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	local m_color = data.color
	if m_color == nil then return end

	surface.SetDrawColor(m_color)
	surface.SetMaterial(m_icon)
	surface.DrawTexturedRect(x + (w * 0.2),y + (w * 0.12), w * 0.6, w * 0.6)

	local m_amount = data.amount
	if m_amount == nil then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

	local m_text
	if (data.type == "pipes") then
		m_text = "+" .. tostring(m_amount)
	else
		m_text = "+" .. tostring(100 * m_amount) .. "%"
	end
	if m_text == nil then return end

	draw.SimpleText(m_text, zclib.GetFont("zclib_font_mediumsmall"), x + (w / 2) , y + (h * 0.82), color_white, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	//draw.SimpleText(m_text, zclib.GetFont("zclib_font_medium"), w / 2 , h / 2, color_white, TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end
