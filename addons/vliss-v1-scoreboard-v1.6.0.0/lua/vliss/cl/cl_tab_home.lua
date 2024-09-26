/*
*   @package        : rcore
*   @module         : vliss
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2016 - 2020
*   @website        : https://rlib.io
*   @docs           : https://docs.rlib.io
*
*   LICENSOR HEREBY GRANTS LICENSEE PERMISSION TO MODIFY AND/OR CREATE DERIVATIVE WORKS BASED AROUND THE
*   SOFTWARE HEREIN, ALSO, AGREES AND UNDERSTANDS THAT THE LICENSEE DOES NOT HAVE PERMISSION TO SHARE,
*   DISTRIBUTE, PUBLISH, AND/OR SELL THE ORIGINAL SOFTWARE OR ANY DERIVATIVE WORKS. LICENSEE MUST ONLY
*   INSTALL AND USE THE SOFTWARE HEREIN AND/OR ANY DERIVATIVE WORKS ON PLATFORMS THAT ARE OWNED/OPERATED
*   BY ONLY THE LICENSEE.
*
*   YOU MAY REVIEW THE COMPLETE LICENSE FILE PROVIDED AND MARKED AS LICENSE.TXT
*
*   BY MODIFYING THIS FILE -- YOU UNDERSTAND THAT THE ABOVE MENTIONED AUTHORS CANNOT BE HELD RESPONSIBLE
*   FOR ANY ISSUES THAT ARISE FROM MAKING ANY ADJUSTMENTS TO THIS SCRIPT. YOU UNDERSTAND THAT THE ABOVE
*   MENTIONED AUTHOR CAN ALSO NOT BE HELD RESPONSIBLE FOR ANY DAMAGES THAT MAY OCCUR TO YOUR SERVER AS A
*   RESULT OF THIS SCRIPT AND ANY OTHER SCRIPT NOT BEING COMPATIBLE WITH ONE ANOTHER.
*/

/*
*   standard tables and localization
*/

local base                  = vliss
local cfg                   = base.cfg
local handle                = base.handle
local ln                    = base.lang

/*
*   localize gamemodes
*/

local rp                    = base.rp
local dr                    = base.dr
local sb                    = base.sb
local mu                    = base.mu
local ph                    = base.ph
local zs                    = base.zs
local mb                    = base.mb
local ttt                   = base.ttt

local PANEL = {}

function PANEL:Init( )

    self.tab_home = vgui.Create("DPanel", self)
    self.tab_home:Dock(FILL)
    self.tab_home:DockMargin(0, 0, 0, 0)
    self.tab_home:SetWide(200)
    self.tab_home.Paint = function( s, w, h )
        if vliss.core.BackgroundBlurEnabled then
            DrawBlurPanel( s, 3 )
        end
        local clr_bg = ( cfg.bg.static.enabled or cfg.bg.live.enabled ) and cfg.general.clrs.pnl_left_middle_bg or cfg.general.clrs.pnl_left_middle
        draw.RoundedBox(0, 0, 0, w, h, clr_bg )
        draw.RoundedBox( 0, w - 1, 0, 1, h, cfg.general.clrs.separator )
    end

    -----------------------------------------------------------------
    -- [ BUTTONS ]
    -----------------------------------------------------------------
    -- These are the standard buttons that a user can click on
    -- in order to navigate to different network areas including
    -- steam workshop collections, a network website, or even a
    -- donation link.
    -----------------------------------------------------------------

    for k, v in pairs(vliss.cfg.HomeTab.Buttons) do
        if v.enabled then
            self.ButtonTabCustom = vgui.Create("DButton", self.tab_home)
            self.ButtonTabCustom:SetText("")
            self.ButtonTabCustom:SetSize(190, 50)
            self.ButtonTabCustom:Dock(TOP)
            self.ButtonTabCustom:DockMargin(5,5,5,0)
            local mat = false

            if v.icon and vliss.cfg.Menu.IconsTextEnabled then
                mat = Material(v.icon, "noclamp smooth")
                self.ButtonTabCustom:SetSize(self.ButtonTabCustom:GetWide( ), self.ButtonTabCustom:GetTall( ))
            elseif v.icon and cfg.general.menu_icons_only then
                mat = Material(v.icon, "noclamp smooth")
                self.ButtonTabCustom:SetSize(64, self.ButtonTabCustom:GetTall( ))
            end

            self.ButtonTabCustom.Paint = function(self, w, h)
                local color = v.clr_btn_n
                local txtColor = v.clr_txt_n
                local widthAdjust = 15

                if self:IsHovered( ) or self:IsDown( ) then
                    color = v.clr_btn_h
                    txtColor = v.clr_txt_h
                end

                surface.SetDrawColor(color)
                surface.DrawRect(0, 0, w, h)
                draw.VlissBoxEffects(w, h)

                if vliss.cfg.Menu.IconsTextEnabled and mat then
                    widthAdjust = 36
                    surface.SetDrawColor(txtColor)
                    surface.SetMaterial(mat)
                    surface.DrawTexturedRect(6, 12, 24, 24)
                end

                draw.SimpleText(string.upper(v.name), "VlissFontMenuItem", widthAdjust, self:GetTall( ) * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(string.upper(v.description), "VlissFontMenuSubinfo", widthAdjust, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            end

            self.ButtonTabCustom.DoClick = v.func

        end
    end

end

vgui.Register( 'vliss_panel_tab_home', PANEL, 'EditablePanel' )