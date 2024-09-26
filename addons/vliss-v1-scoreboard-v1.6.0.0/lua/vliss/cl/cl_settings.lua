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

-----------------------------------------------------------------
-- [ DARKRP: SERVER SETTINGS ]
-----------------------------------------------------------------
-- As of v1.2: This is for DarkRP as the original scoreboard had.
-- It allows the admin to manage certain aspects of the server
-- in regards to toggling Player VS Player, global godmode etc.
-- Later, it will include features for sandbox and other
-- gamemodes as well.
-----------------------------------------------------------------

function PANEL:Init( )

    local VlissBtnClose = "vliss/vliss_btn_close.png"

    self.w, self.h = 550, 450
    self:SetSize(self.w, self.h)
    self:Center( )
    self:MakePopup( )
	self:SetMouseInputEnabled(true)
	self:SetKeyboardInputEnabled(false)
    self.Paint = function(self, w, h)
        DrawBlurPanel(self, 3)
        draw.RoundedBox(5, 0, 0, w, h, Color( 0, 0, 0, 230 ))
    end

    self.PanelInnerTop = vgui.Create("DPanel", self)
    self.PanelInnerTop:Dock(TOP)
    self.PanelInnerTop:DockMargin(5, 5, 5, 0)
    self.PanelInnerTop:SetTall(45)
    self.PanelInnerTop.Paint = function(self, w, h)
        draw.SimpleText("Settings", "VlissFontNetworkName", 8, 25, cfg.general.clrs.network_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.LabelConfirmMessage = vgui.Create("DLabel", self)
    self.LabelConfirmMessage:Dock(TOP)
    self.LabelConfirmMessage:SetTall(45)
    self.LabelConfirmMessage:DockMargin(15, 0, 5, 5)
    self.LabelConfirmMessage:SetFont("VlissFontConfirmText")
    self.LabelConfirmMessage:SetTextColor( cfg.staffcard.clrs.txt_pl_name )
    self.LabelConfirmMessage:SetWrap( true )
    self.LabelConfirmMessage:SetText("This area is still being developed - admins will be able to adjust settings here.")

    self.ButtonDoClose = vgui.Create("DButton", self)
    self.ButtonDoClose:SetColor(Color(255, 255, 255, 255))
    self.ButtonDoClose:SetFont("VlissFontCloseGUI")
    self.ButtonDoClose:SetText("")
    self.ButtonDoClose.Paint = function( )
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(Material(VlissBtnClose, "noclamp smooth"))
        surface.DrawTexturedRect(0, 10, 16, 16)
    end
    self.ButtonDoClose:SetSize(32, 32)
    self.ButtonDoClose:SetPos(self:GetWide( ) - 30, 0)
    self.ButtonDoClose.DoClick = function( )
        if IsValid(self) then
            self:Remove( )
        end
    end

end

vgui.Register("vliss_settings", PANEL, "EditablePanel")