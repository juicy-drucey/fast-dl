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

    -----------------------------------------------------------------
    -- [ CONTROLS ]
    -----------------------------------------------------------------
    -- Specified in the configuration file, these are buttons that
    -- users can click on in order to perform certain tasks.
    -- This could be things like executing Pointshop, the context
    -- menu, or other features that have keybinds or you can even
    -- force playersays for chat commands.
    -----------------------------------------------------------------

    self.tab_ctrls = vgui.Create("DPanel", self)
    self.tab_ctrls:Dock(FILL)
    self.tab_ctrls:DockMargin(0, 0, 0, 0)
    self.tab_ctrls:SetWide(200)
    self.tab_ctrls:SetVisible(true)
    self.tab_ctrls.Paint = function( s, w, h )
        if vliss.core.BackgroundBlurEnabled then
            DrawBlurPanel( s, 3 )
        end
        local clr_bg = ( cfg.bg.static.enabled or cfg.bg.live.enabled ) and cfg.general.clrs.pnl_left_middle_bg or cfg.general.clrs.pnl_left_middle
        draw.RoundedBox(0, 0, 0, w, h, clr_bg )
        draw.RoundedBox( 0, w - 1, 0, 1, h, cfg.general.clrs.separator )
    end

    self.LayoutListControls = vgui.Create("DIconLayout", self.tab_ctrls)
    self.LayoutListControls:Dock(FILL)
    self.LayoutListControls:DockMargin(7, 5, 0, 0)
    self.LayoutListControls:SetPos(0, 0)
    self.LayoutListControls:SetSpaceY(5)
    self.LayoutListControls:SetSpaceX(5)

    for k, v in pairs(vliss.cfg.ControlsTab.Buttons) do
        if v.enabled then
            self.ButtonControlsList = self.LayoutListControls:Add("Button")
            self.ButtonControlsList:SetSize(90, 90)
            self.ButtonControlsList:SetText("")
            self.ButtonControlsList.Paint = function(self, w, h)
                local color = v.color
                if self:IsHovered( ) or self:IsDown( ) then
                    color = v.colorHover
                end
                draw.RoundedBox(4, 0, 0, w, h, color)
            end
            self.ButtonControlsList.DoClick = v.func

            self.ButtonControlsTrigger = vgui.Create("DLabel", self.ButtonControlsList)
            self.ButtonControlsTrigger:SetText(v.control)
            self.ButtonControlsTrigger:SetPos(8, 0)
            self.ButtonControlsTrigger:SetFont("VlissFontControlKey")
            self.ButtonControlsTrigger:SizeToContents( )

            self.ButtonControlsDesc = vgui.Create("DLabel", self.ButtonControlsList)
            self.ButtonControlsDesc:SetText(v.description)
            self.ButtonControlsDesc:SetPos(8, 45)
            self.ButtonControlsDesc:SetFont("VlissFontControlDesc")
            self.ButtonControlsDesc:SizeToContents( )
        end
    end

end

vgui.Register( 'vliss_panel_tab_controls', PANEL, 'EditablePanel' )