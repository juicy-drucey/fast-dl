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

local VlissButtonToggleOff  = "vliss/vliss_btn_switch_off.png"
local VlissButtonToggleOn   = "vliss/vliss_btn_switch_on.png"
local VlissBtnLimits        = "vliss/vliss_btn_limits.png"

local PANEL = { }

function PANEL:Init( )

    self.tab_actions = vgui.Create("DPanel", self)
    self.tab_actions:Dock(FILL)
    self.tab_actions:DockMargin(0, 0, 0, 0)
    self.tab_actions:SetWide(200)
    self.tab_actions:SetVisible(true)
    self.tab_actions.Paint = function(self, w, h)
        if vliss.core.BackgroundBlurEnabled then
            DrawBlurPanel(self, 3)
        end
        local clr_bg = ( cfg.bg.static.enabled or cfg.bg.live.enabled ) and cfg.general.clrs.pnl_left_middle_bg or cfg.general.clrs.pnl_left_middle
        draw.RoundedBox(0, 0, 0, w, h, clr_bg )
        draw.RoundedBox( 0, w - 1, 0, 1, h, cfg.general.clrs.separator )
    end

    -----------------------------------------------------------------
    -- BUTTON: Toggle Scoreboard
    -----------------------------------------------------------------
    self.ButtonToggleScoreboard = vgui.Create("DButton", self.tab_actions)
    self.ButtonToggleScoreboard:SetText("")
    self.ButtonToggleScoreboard:Dock(TOP)
    self.ButtonToggleScoreboard:DockMargin(5,5,5,0)
    self.ButtonToggleScoreboard:SetSize(190, 50)

    local mat = false

    if vliss.cfg.Menu.IconsTextEnabled then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleScoreboard:SetSize(self.ButtonToggleScoreboard:GetWide( ), self.ButtonToggleScoreboard:GetTall( ))
    elseif cfg.general.menu_icons_only then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleScoreboard:SetSize(64, self.ButtonToggleScoreboard:GetTall( ))
    end

    self.ButtonToggleScoreboard.Paint = function(self, w, h)
        local clr_btn_n = Color(124, 51, 50, 190)
        local clr_btn_h = Color(124, 51, 50, 240)
        local clr_txt_n = Color(255, 255, 255, 255)
        local clr_txt_h = Color(255, 255, 255, 255)
        local buttonText = vliss.lang.toggle_off
        local buttonDesc = vliss.lang.set_toggle_on
        local material = Material(VlissButtonToggleOn, "noclamp smooth")
        local widthAdjust = 15

        if GetConVarNumber("vliss_scoreboardtoggle") == 1 then
            clr_btn_n = Color(64, 200, 126, 190)
            clr_btn_h = Color(64, 220, 126, 240)
            buttonText = vliss.lang.toggle_on
            buttonDesc = vliss.lang.set_toggle_off
            material = Material(VlissButtonToggleOff, "noclamp smooth")
        end

        local color = clr_btn_n
        local txtColor = clr_txt_n
        if self:IsHovered( ) or self:IsDown( ) then
            color = clr_btn_h
            txtColor = clr_txt_h
        end

        surface.SetDrawColor(color)
        surface.DrawRect(0, 0, w, h)
        draw.VlissBoxEffects(w, h)

        if vliss.cfg.Menu.IconsTextEnabled and material then
            widthAdjust = 36
            surface.SetDrawColor(txtColor)
            surface.SetMaterial(material)
            surface.DrawTexturedRect(6, 12, 24, 24)
        end

        draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", widthAdjust, self:GetTall( ) * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(string.upper(buttonDesc), "VlissFontMenuSubinfo", widthAdjust, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    end

    self.ButtonToggleScoreboard.DoClick = function( )
        local cmd = "1"

        if GetConVarNumber("vliss_scoreboardtoggle") == 1 then
            cmd = "0"
        end

        RunConsoleCommand("vliss_scoreboardtoggle", cmd)
        GetScoreboardPanel( ):SetVisible(false)
        gui.EnableScreenClicker(false)
    end

    -----------------------------------------------------------------
    -- [ BUTTON : TOGGLE ADMIN VIEW ]
    -- Toggles the admin list for the server.
    -----------------------------------------------------------------
    self.ButtonToggleAdminView = vgui.Create("DButton", self.tab_actions)
    self.ButtonToggleAdminView:SetText("")
    self.ButtonToggleAdminView:SetSize(190, 50)
    self.ButtonToggleAdminView:Dock(TOP)
    self.ButtonToggleAdminView:DockMargin(5,5,5,0)

    local mat = false

    if vliss.cfg.Menu.IconsTextEnabled then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleAdminView:SetSize(self.ButtonToggleAdminView:GetWide( ), self.ButtonToggleAdminView:GetTall( ))
    elseif cfg.general.menu_icons_only then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleAdminView:SetSize(64, self.ButtonTabCustom:GetTall( ))
    end

    self.ButtonToggleAdminView.Paint = function(self, w, h)
        local clr_btn_n = Color(124, 51, 50, 190)
        local clr_btn_h = Color(124, 51, 50, 240)
        local clr_txt_n = Color(255, 255, 255, 255)
        local clr_txt_h = Color(255, 255, 255, 255)
        local buttonText = vliss.lang.staff_view
        local buttonDesc = vliss.lang.view_online_staff
        local material = Material(VlissButtonToggleOn, "noclamp smooth")
        local widthAdjust = 15

        if IsValid(Vliss_PanelInnerBottom) and not Vliss_PanelInnerBottom:IsVisible( ) then
            clr_btn_n = Color(64, 200, 126, 190)
            clr_btn_h = Color(64, 220, 126, 240)
            buttonText = vliss.lang.scoreboard_view
            buttonDesc = vliss.lang.view_all_players
            material = Material(VlissButtonToggleOff, "noclamp smooth")
        end

        local color = clr_btn_n
        local txtColor = clr_txt_n
        if self:IsHovered( ) or self:IsDown( ) then
            color = clr_btn_h
            txtColor = clr_txt_h
        end

        surface.SetDrawColor(color)
        surface.DrawRect(0, 0, w, h)
        draw.VlissBoxEffects(w, h)

        if vliss.cfg.Menu.IconsTextEnabled and material then
            widthAdjust = 36
            surface.SetDrawColor(txtColor)
            surface.SetMaterial(material, "noclamp smooth")
            surface.DrawTexturedRect(6, 12, 24, 24)
        end

        draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", widthAdjust, self:GetTall( ) * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(string.upper(buttonDesc), "VlissFontMenuSubinfo", widthAdjust, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    end

    self.ButtonToggleAdminView.DoClick = function( )
        if IsValid(self.PanelIBAdminList) then
            self.PanelIBAdminList:SetVisible(false)
        end

        if IsValid(GetScoreboardPanel( )) and Vliss_PanelInnerBottom:IsVisible( ) then
            Vliss_PanelInnerBottom:SetVisible(false)
            self.PanelInnerTop:SetVisible(false)
            self.PanelIBAdminList:SetVisible(true)
            self.PanelInnerTopAdmins:SetVisible(true)
        elseif IsValid(GetScoreboardPanel( )) and IsValid(self.PanelAV) and self.PanelAV:IsVisible( ) then
            self.PanelAV:SetVisible(false)
            self.PanelInnerTop:SetVisible(false)
            self.PanelIBAdminList:SetVisible(true)
            self.PanelInnerTopAdmins:SetVisible(true)
        elseif IsValid(GetScoreboardPanel( )) and IsValid(self.PanelServerSettings) and self.PanelServerSettings:IsVisible( ) then
            self.PanelServerSettings:SetVisible(false)
            self.PanelInnerTop:SetVisible(false)
            self.PanelIBAdminList:SetVisible(true)
            self.PanelInnerTopAdmins:SetVisible(true)
        else
            self.PanelInnerTopAdmins:SetVisible(false)
            self.PanelIBAdminList:SetVisible(false)
            self.PanelInnerTop:SetVisible(true)
            Vliss_PanelInnerBottom:SetVisible(true)
        end
    end

    -----------------------------------------------------------------
    -- [ BUTTON : TOGGLE SCOREBOARD ]
    -----------------------------------------------------------------
    -- Scoreboard has two modes, toggle and tap. This button allows
    -- a player to decide how they want to activate the scoreboard
    -- and sets a Convar for that player.
    -----------------------------------------------------------------

    if FAdmin and (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] or LocalPlayer( ):IsSuperAdmin( )) then

        self.ButtonServerSettings = vgui.Create("DButton", self.tab_actions)
        self.ButtonServerSettings:SetText("")
        self.ButtonServerSettings:SetSize(190, 50)
        self.ButtonServerSettings:Dock(TOP)
        self.ButtonServerSettings:DockMargin(5,5,5,0)
        if vliss.DarkRP.Enabled then
            self.ButtonServerSettings:SetVisible(true)
        else
            self.ButtonServerSettings:SetVisible(false)
        end

        local mat = false

        if vliss.cfg.Menu.IconsTextEnabled then
            mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
            self.ButtonServerSettings:SetSize(self.ButtonServerSettings:GetWide( ), self.ButtonServerSettings:GetTall( ))
        elseif cfg.general.menu_icons_only then
            mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
            self.ButtonServerSettings:SetSize(64, self.ButtonServerSettings:GetTall( ))
        end

        self.ButtonServerSettings.Paint = function(self, w, h)
            local clr_btn_n = Color(64, 105, 126, 190)
            local clr_btn_h = Color(64, 105, 126, 240)
            local clr_txt_n = Color(255, 255, 255, 255)
            local clr_txt_h = Color(255, 255, 255, 255)
            local buttonText = vliss.lang.server_settings
            local buttonDesc = vliss.lang.server_settings_desc
            local material = Material(VlissBtnLimits, "noclamp smooth")
            local widthAdjust = 15

            local color = clr_btn_n
            local txtColor = clr_txt_n
            if self:IsHovered( ) or self:IsDown( ) then
                color = clr_btn_h
                txtColor = clr_txt_h
            end

            surface.SetDrawColor(color)
            surface.DrawRect(0, 0, w, h)
            draw.VlissBoxEffects(w, h)

            if vliss.cfg.Menu.IconsTextEnabled and material then
                widthAdjust = 36
                surface.SetDrawColor(txtColor)
                surface.SetMaterial(material)
                surface.DrawTexturedRect(6, 12, 24, 24)
            end

            draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", widthAdjust, self:GetTall( ) * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(string.upper(buttonDesc), "VlissFontMenuSubinfo", widthAdjust, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        end

        self.ButtonServerSettings.DoClick = function( )
            if IsValid(self.PanelServerSettings) then
                self.PanelServerSettings:Remove( )
            end
            self:VlissServerSettings( )
            if IsValid(GetScoreboardPanel( )) and Vliss_PanelInnerBottom:IsVisible( ) then
                Vliss_PanelInnerBottom:SetVisible(false)
                self.PanelInnerTop:SetVisible(false)
                self.PanelServerSettings:SetVisible(true)
            elseif IsValid(GetScoreboardPanel( )) and IsValid(self.PanelIBAdminList) and self.PanelIBAdminList:IsVisible( ) then
                self.PanelInnerTopAdmins:SetVisible(false)
                self.PanelIBAdminList:SetVisible(false)
                self.PanelInnerTop:SetVisible(false)
                self.PanelServerSettings:SetVisible(true)
            elseif IsValid(GetScoreboardPanel( )) and IsValid(self.PanelAV) and self.PanelAV:IsVisible( ) then
                self.PanelAV:SetVisible(false)
                self.PanelInnerTop:SetVisible(false)
                self.PanelServerSettings:SetVisible(true)
            else
                self.PanelServerSettings:SetVisible(false)
                self.PanelInnerTop:SetVisible(true)
                Vliss_PanelInnerBottom:SetVisible(true)
            end
        end

    end

    -----------------------------------------------------------------
    -- [ BUTTON : ACTIONS ]
    -----------------------------------------------------------------
    -- Action buttons allow users to perform certain actions on
    -- themselves. Typically this would be anything related to
    -- cleaning up their props, local stopsound, or whatever else
    -- you can think of.
    -----------------------------------------------------------------
    for k, v in pairs(vliss.cfg.ActionsTab.Buttons) do
        if v.enabled then
            self.ButtonTabCustom = vgui.Create("DButton", self.tab_actions)
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

vgui.Register( 'vliss_panel_tab_actions', PANEL, 'EditablePanel' )