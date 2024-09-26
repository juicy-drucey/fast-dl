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

    self.w, self.h          = ScrW( ) * cfg.general.size_w - 200, ScrH( ) * cfg.general.size_h

    self.PanelServerSettings = vgui.Create("DPanel", self)
    self.PanelServerSettings:Dock(FILL)
    self.PanelServerSettings:DockMargin(10, 0, 10, 20)
    self.PanelServerSettings:SetVisible(true)
    self.PanelServerSettings.Paint = function( s, w, h ) end

    self.PanelSSContainerT = vgui.Create("DPanel", self.PanelServerSettings)
    self.PanelSSContainerT:Dock(TOP)
    self.PanelSSContainerT:DockMargin(0, 0, 0, 0)
    self.PanelSSContainerT:SetTall(35)
    self.PanelSSContainerT.Paint = function( s, w, h ) end

    self.PanelSSContainer = vgui.Create("DPanel", self.PanelServerSettings)
    self.PanelSSContainer:Dock(FILL)
    self.PanelSSContainer:DockMargin(0, 0, 0, 0)
    self.PanelSSContainer.Paint = function( s, w, h ) end

    self.PanelSSContainerTL = vgui.Create("DPanel", self.PanelSSContainer)
    self.PanelSSContainerTL:Dock(LEFT)
    self.PanelSSContainerTL:SetWide( self.w * .32 )
    self.PanelSSContainerTL:DockMargin(0, 0, 0, 0)
    self.PanelSSContainerTL.Paint = function( s, w, h ) end

    self.PanelSSContainerTL2 = vgui.Create("DPanel", self.PanelSSContainer)
    self.PanelSSContainerTL2:Dock(LEFT)
    self.PanelSSContainerTL2:SetWide( self.w * .32 )
    self.PanelSSContainerTL2:DockMargin(0, 0, 0, 0)
    self.PanelSSContainerTL2.Paint = function( s, w, h ) end

    self.PanelSSContainerTL3 = vgui.Create("DPanel", self.PanelSSContainer)
    self.PanelSSContainerTL3:Dock(LEFT)
    self.PanelSSContainerTL3:SetWide( self.w * .32 )
    self.PanelSSContainerTL3:DockMargin(0, 0, 0, 0)
    self.PanelSSContainerTL3.Paint = function( s, w, h ) end

    self.PanelSSActions = vgui.Create( "DPanel", self.PanelSSContainerTL )
    self.PanelSSActions:SetSize( vliss.rp.FAdminActions.ButtonActionW, vliss.rp.FAdminActions.ButtonContainerH or 100 )
    self.PanelSSActions:Dock(FILL)
    self.PanelSSActions.Paint = function( ) end

    self.LayoutSSActions = vgui.Create("DIconLayout", self.PanelSSActions)
    self.LayoutSSActions:Dock(FILL)
    self.LayoutSSActions:DockMargin(7, 5, 0, 0)
    self.LayoutSSActions:SetSpaceY(5)
    self.LayoutSSActions:SetSpaceX(5)

    self.ButtonSS_ServerActionsTitle = vgui.Create("DButton", self.PanelSSContainerTL)
    self.ButtonSS_ServerActionsTitle:Dock(TOP)
    self.ButtonSS_ServerActionsTitle:SetText("")
    self.ButtonSS_ServerActionsTitle:DockMargin(5, 0, 5, 5)
    self.ButtonSS_ServerActionsTitle:SetTall(30)
    self.ButtonSS_ServerActionsTitle.Paint = function( s, w, h )
        draw.SimpleText( vliss.lang.server_actions, "VlissFontNetworkName", 0, h / 2, cfg.general.clrs.network_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

    for k, v in pairs( vliss.rp.ServerActions ) do

        if not FAdmin then return end
        if not v.enabled then continue end
        if not FAdmin.Access.PlayerHasPrivilege(LocalPlayer( ), v.perm, pl) then continue end

        self.ButtonServerItem = self.LayoutSSActions:Add("Button")
        self.ButtonServerItem:SetSize( 250, 40 )
        self.ButtonServerItem:SetText("")

        self.ButtonServerLabel = vgui.Create("DLabel", self.ButtonOptionShowIdentity)
        self.ButtonServerLabel:Dock( RIGHT )
        self.ButtonServerLabel:DockMargin(5,5,5,5)
        self.ButtonServerLabel:SetFont("VlissFontSandboxItemLabel")
        self.ButtonServerLabel:SetTextColor(vliss.mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
        self.ButtonServerLabel:SetSize( ButtonLabelW, ButtonActionH )
        self.ButtonServerLabel:SetText("")

        self.ButtonServerItem.Paint = function( s, w, h )
            local clr_btn_n     = v.clr_btn_n or Color(64, 105, 126, 190)
            local clr_btn_h     = v.clr_btn_h or Color(64, 105, 126, 240)
            local clr_txt_n     = v.clr_txt_n or Color(255, 255, 255, 255)
            local clr_txt_h     = v.clr_txt_h or Color(255, 255, 255, 255)
            local material      = Material(v.icon, "noclamp smooth")

            local color         = clr_btn_n
            local txtColor      = clr_txt_n

            if s:IsHovered( ) or s:IsDown( ) then
                color           = clr_btn_h
                txtColor        = clr_txt_h
            end

            surface.SetDrawColor    ( color )
            surface.DrawRect        ( 0, 0, w, h )

            /*
            surface.SetDrawColor    ( cfg.general.clrs.btn_line )
            surface.DrawLine        ( 0, cfg.general.size_btn_line, 0, 0 )
            surface.DrawLine        ( cfg.general.size_btn_line, 0, 0, 0 )
            surface.SetDrawColor    ( cfg.general.clrs.btn_line )
            surface.DrawLine        ( w - cfg.general.size_btn_line, h - 1, w, h - 1 )
            surface.DrawLine        ( w - 1, h, w - 1, h - cfg.general.size_btn_line )
            */

            if vliss.rp.SettingsIconsEnabled and material then
                surface.SetDrawColor        ( txtColor )
                surface.SetMaterial         ( material )
                surface.DrawTexturedRect    ( 10, ( h / 2 ) - ( 24 / 2 ), 24, 24 )
                draw.SimpleText( string.upper( v.name ), "VlissFontMenuItem", 44, h * .48, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText( string.upper( v.name ), "VlissFontMenuItem", 10, h * .48, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end

        self.ButtonServerItem.DoClick = v.func

    end

    self.PanelPlayerActions = vgui.Create( "DPanel", self.PanelSSContainerTL2 )
    self.PanelPlayerActions:SetSize( vliss.rp.FAdminActions.ButtonActionW, vliss.rp.FAdminActions.ButtonContainerH or 100 )
    self.PanelPlayerActions:Dock(FILL)
    self.PanelPlayerActions.Paint = function( ) end

    self.LayoutPlayerActions = vgui.Create("DIconLayout", self.PanelPlayerActions)
    self.LayoutPlayerActions:Dock(FILL)
    self.LayoutPlayerActions:DockMargin(7, 5, 0, 0)
    self.LayoutPlayerActions:SetSpaceY(5)
    self.LayoutPlayerActions:SetSpaceX(5)

    self.ButtonSS_PlayerActionsTitle = vgui.Create("DButton", self.PanelSSContainerTL2)
    self.ButtonSS_PlayerActionsTitle:Dock(TOP)
    self.ButtonSS_PlayerActionsTitle:SetText("")
    self.ButtonSS_PlayerActionsTitle:DockMargin(5, 0, 5, 5)
    self.ButtonSS_PlayerActionsTitle:SetTall(30)
    self.ButtonSS_PlayerActionsTitle.Paint = function( s, w, h )
        draw.SimpleText(vliss.lang.player_actions, "VlissFontNetworkName", 0, h / 2, cfg.general.clrs.network_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    for k, v in pairs( vliss.rp.PlayerActions ) do

        if not FAdmin then return end
        self.ButtonServerItem = self.LayoutPlayerActions:Add("Button")
        self.ButtonServerItem:SetSize(250, 50)
        self.ButtonServerItem:SetText("")

        self.ButtonLabel = vgui.Create("DLabel", self.ButtonOptionShowIdentity)
        self.ButtonLabel:Dock(RIGHT)
        self.ButtonLabel:DockMargin(5,5,5,5)
        self.ButtonLabel:SetFont("VlissFontSandboxItemLabel")
        self.ButtonLabel:SetTextColor(vliss.mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
        self.ButtonLabel:SetSize( ButtonLabelW, ButtonActionH )
        self.ButtonLabel:SetText("")

        self.ButtonServerItem.Paint = function( s, w, h )
            local clr_btn_n         = v.clr_btn_n or Color(64, 105, 126, 190)
            local clr_btn_h         = v.clr_btn_h or Color(64, 105, 126, 240)
            local clr_txt_n         = v.clr_txt_n or Color(255, 255, 255, 255)
            local clr_txt_h         = v.clr_txt_h or Color(255, 255, 255, 255)
            local material          = Material(v.icon, "noclamp smooth")
            local buttonText        = v.name or ""
            local buttonStatus      = v.status or ""

            local buttonColor       = clr_btn_n
            local txtColor          = clr_txt_n

            if s:IsHovered( ) or s:IsDown( ) then
                buttonColor         = clr_btn_h
                txtColor            = clr_txt_h
            end

            if v.convarAvail then
                if GetConVarNumber(v.convar) == v.convarDefault then
                    buttonColor = v.clr_btn_tog_n or Color(64, 105, 126, 190)
                    buttonStatus = v.toggledStatus or ""
                    material = Material(v.toggledIcon, "noclamp smooth")
                    if s:IsHovered( ) or s:IsDown( ) then
                        buttonColor = v.clr_btn_tog_h or Color(64, 105, 126, 190)
                    end

                end
            end

            surface.SetDrawColor(buttonColor)
            surface.DrawRect(0, 0, w, h)

            /*
            surface.SetDrawColor( cfg.general.clrs.btn_line )
            surface.DrawLine(0, cfg.general.size_btn_line, 0, 0)
            surface.DrawLine( cfg.general.size_btn_line, 0, 0, 0 )
            surface.SetDrawColor( cfg.general.clrs.btn_line )
            surface.DrawLine(w - cfg.general.size_btn_line, h - 1, w, h - 1)
            surface.DrawLine(w - 1, h, w - 1, h - cfg.general.size_btn_line )
            */


            -- [ TODO ]
            -- Bad way to do this. Next update I'm going to completely optimize the code.

            if vliss.rp.SettingsIconsEnabled and material then
                surface.SetDrawColor(txtColor)
                surface.SetMaterial(material)
                surface.DrawTexturedRect( 10, ( h / 2 ) - ( 24 / 2 ), 24, 24, 24, 24 )
                if v.status and v.toggledStatus then
                    draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", 44, h * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(string.upper(buttonStatus), "VlissFontMenuSubinfo", 44, h * .70, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", 44, h * .48, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(string.upper(buttonStatus), "VlissFontMenuSubinfo", 44, h * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end
            else
                draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", 15, h * .48, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(string.upper(buttonStatus), "VlissFontMenuSubinfo", 15, h * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end

        self.ButtonServerItem.DoClick = v.func

    end

    self.PanelServerSet = vgui.Create( "DPanel", self.PanelSSContainerTL3 )
    self.PanelServerSet:SetSize( vliss.rp.FAdminActions.ButtonActionW, vliss.rp.FAdminActions.ButtonContainerH or 100 )
    self.PanelServerSet:Dock(FILL)
    self.PanelServerSet.Paint = function( ) end

    self.LayoutServerSet = vgui.Create("DIconLayout", self.PanelServerSet)
    self.LayoutServerSet:Dock(FILL)
    self.LayoutServerSet:DockMargin(7, 5, 0, 0)
    self.LayoutServerSet:SetSpaceY(5)
    self.LayoutServerSet:SetSpaceX(5)

    self.ButtonSS_ServerSetTitle = vgui.Create("DButton", self.PanelSSContainerTL3)
    self.ButtonSS_ServerSetTitle:Dock(TOP)
    self.ButtonSS_ServerSetTitle:SetText("")
    self.ButtonSS_ServerSetTitle:DockMargin(5, 0, 5, 5)
    self.ButtonSS_ServerSetTitle:SetTall(30)
    self.ButtonSS_ServerSetTitle.Paint = function(self, w, h)
        draw.SimpleText(vliss.lang.server_settings, "VlissFontNetworkName", 0, h / 2, cfg.general.clrs.network_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    for k, v in pairs( vliss.rp.ServerSettings ) do

        if not FAdmin then return end
        self.ButtonServerItem = self.LayoutServerSet:Add("Button")
        self.ButtonServerItem:SetSize(250, 50)
        self.ButtonServerItem:SetText("")

        self.ButtonLabel = vgui.Create("DLabel", self.ButtonOptionShowIdentity)
        self.ButtonLabel:Dock(RIGHT)
        self.ButtonLabel:DockMargin(5,5,5,5)
        self.ButtonLabel:SetFont("VlissFontSandboxItemLabel")
        self.ButtonLabel:SetTextColor(vliss.mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
        self.ButtonLabel:SetSize( ButtonLabelW, ButtonActionH )
        self.ButtonLabel:SetText("")

        self.ButtonServerItem.Paint = function(self, w, h)
            local clr_btn_n         = v.clr_btn_n or Color( 64, 105, 126, 190 )
            local clr_btn_h         = v.clr_btn_h or Color( 64, 105, 126, 240 )
            local clr_txt_n         = v.clr_txt_n or Color( 255, 255, 255, 255 )
            local clr_txt_h         = v.clr_txt_h or Color( 255, 255, 255, 255 )
            local material          = Material( v.icon, "noclamp smooth" )
            local buttonText        = v.name or ""
            local buttonStatus      = v.status or ""

            local buttonColor       = clr_btn_n
            local txtColor          = clr_txt_n

            if self:IsHovered( ) or self:IsDown( ) then
                buttonColor         = clr_btn_h
                txtColor            = clr_txt_h
            end

            if v.convarAvail then
                if GetConVarNumber(v.convar) == v.convarDefault then
                    buttonColor = v.clr_btn_tog_n or Color(64, 105, 126, 190)
                    buttonStatus = v.toggledStatus or ""
                    material = Material(v.toggledIcon, "noclamp smooth")
                    if self:IsHovered( ) or self:IsDown( ) then
                        buttonColor = v.clr_btn_tog_h or Color(64, 105, 126, 190)
                    end

                end
            end

            surface.SetDrawColor    ( buttonColor )
            surface.DrawRect        ( 0, 0, w, h )

            /*
            surface.SetDrawColor( cfg.general.clrs.btn_line )
            surface.DrawLine( 0, cfg.general.size_btn_line, 0, 0 )
            surface.DrawLine( cfg.general.size_btn_line, 0, 0, 0 )
            surface.SetDrawColor( cfg.general.clrs.btn_line )
            surface.DrawLine( w - cfg.general.size_btn_line, h - 1, w, h - 1)
            surface.DrawLine( w - 1, h, w - 1, h - cfg.general.size_btn_line )
            */

            if vliss.rp.SettingsIconsEnabled and material then
                surface.SetDrawColor        ( txtColor )
                surface.SetMaterial         ( material )
                surface.DrawTexturedRect    ( 10, ( h / 2 ) - ( 24 / 2 ), 24, 24 )
                if v.status and v.toggledStatus then
                    draw.SimpleText( string.upper( buttonText ), "VlissFontMenuItem", 44, self:GetTall( ) * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText( string.upper( buttonStatus ), "VlissFontMenuSubinfo", 44, self:GetTall( ) * .70, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText( string.upper( buttonText ), "VlissFontMenuItem", 44, self:GetTall( ) * .48, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText( string.upper( buttonStatus ), "VlissFontMenuSubinfo", 44, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end
            else
                draw.SimpleText( string.upper( buttonText ), "VlissFontMenuItem", 15, self:GetTall( ) * .48, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText( string.upper( buttonStatus ), "VlissFontMenuSubinfo", 15, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end

        self.ButtonServerItem.DoClick = v.func

    end

end

vgui.Register( 'vliss_panel_serversettings', PANEL, 'EditablePanel' )