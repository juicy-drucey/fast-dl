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

/*
*   declare > panel
*/

local PANEL                 = { }

-----------------------------------------------------------------
-- [ MATERIALS ]
-----------------------------------------------------------------

local m_btn_close           = "vliss/vliss_btn_close.png"
local m_btn_tog_off         = "vliss/vliss_btn_switch_off.png"
local m_btn_tog_on          = "vliss/vliss_btn_switch_on.png"
local m_ico_lim             = "vliss/vliss_btn_limits.png"

-----------------------------------------------------------------
-- [ NETWORK RECEIVERS ]
-----------------------------------------------------------------

net.Receive("VlissMessageSet", function( len )
    local msg = net.ReadTable( )
    chat.AddText( unpack( msg ) )
end )

-----------------------------------------------------------------
-- [ DARKRP: SERVER SETTINGS ]
-----------------------------------------------------------------
-- As of v1.2: This is for DarkRP as the original scoreboard had.
-- It allows the admin to manage certain aspects of the server
-- in regards to toggling Player VS Player, global godmode etc.
-- Later, it will include features for sandbox and other
-- gamemodes as well.
-----------------------------------------------------------------

function PANEL:VlissServerSettings( )
    if not rp.Enabled then return end

    Vliss_PanelServSettings = vgui.Create( 'vliss_panel_serversettings', PanelRightContainer )
    Vliss_PanelServSettings:Dock(FILL)
    Vliss_PanelServSettings:DockMargin(10, 0, 10, 10)
end

function draw.VlissBox( x, y, w, h, color )
    surface.SetDrawColor( color )
    surface.DrawRect( x, y, w, h )
end

-----------------------------------------------------------------
-- [ BUILD ADMINLIST ]
-----------------------------------------------------------------
-- This builds the list of staff members on the server so
-- everyone can see the current staff online.
-----------------------------------------------------------------

function PANEL:BuildAdminList( )

    if IsValid(self.lo_admins) then self.lo_admins:Remove( ) end

    self.lo_admins = vgui.Create("DIconLayout", self.PanelIBAdminList)
    self.lo_admins:Dock(FILL)
    self.lo_admins:SetPos(0, 0)
    self.lo_admins:SetSpaceY(5)
    self.lo_admins:SetSpaceX(5)

    local countAdminOnline = 0

    for k, v in ipairs(player.GetAll( )) do
        if not cfg.perms.is_staff[string.lower(v:GetUserGroup( ))] then continue end

        if not v:SteamID( ) or v:SteamID( ) == "NULL" then
            playerSteamID = ln.no_steamid
        else
            playerSteamID = v:SteamID( )
        end

        self.PanelAdminsList = self.lo_admins:Add("DPanel")
        self.PanelAdminsList:SetSize(275, 72)
        self.PanelAdminsList.Paint = function(self, w, h)
            if cfg.staffcard.general.bBlurCard then
                DrawBlurPanel(self, 3)
            end

            if cfg.staffcard.general.bUseRankColor then
                draw.RoundedBox(5, 0, 0, w, h, cfg.groups.colors[v:GetUserGroup( )] and cfg.groups.colors[v:GetUserGroup( )] or cfg.staffcard.clrs.card_bg )
            else
                draw.RoundedBox(5, 0, 0, w, h, cfg.staffcard.clrs.card_bg )
            end
        end

        self.AvatarAdmin = vgui.Create("AvatarImage", self.PanelAdminsList)
        self.AvatarAdmin:SetSize(64, 64)
        self.AvatarAdmin:SetPos(4, 4)
        self.AvatarAdmin:SetPlayer(v, 64)

        self.LabelAdminNick = vgui.Create("DLabel", self.PanelAdminsList)
        self.LabelAdminNick:SetText(v:Nick( ))
        self.LabelAdminNick:SetPos(75, 3)
        self.LabelAdminNick:SetWide(self.PanelAdminsList:GetWide( ) - 110)
        self.LabelAdminNick:SetTall(25)
        self.LabelAdminNick:SetFont("VlissFontCardPlayerName")
        self.LabelAdminNick:SetTextColor( cfg.staffcard.clrs.txt_pl_name )

        self.LabelAdminRank = vgui.Create("DLabel", self.PanelAdminsList)
        self.LabelAdminRank:SetText( cfg.groups.titles[v:group( )] and cfg.groups.titles[v:group( )] or v:group( true ) )
        self.LabelAdminRank:SetPos(75, 30)
        self.LabelAdminRank:SetFont("VlissFontCardRank")
        self.LabelAdminRank:SetTextColor( cfg.staffcard.clrs.txt_pl_rank )
        self.LabelAdminRank:SizeToContents( )

        self.ButtonAdminViewProfile = vgui.Create("DButton", self.PanelAdminsList)
        self.ButtonAdminViewProfile:SetText("")
        self.ButtonAdminViewProfile:SetSize(190, 50)
        self.ButtonAdminViewProfile:SetPos(self.PanelAdminsList:GetWide( ) - 30, 0)
        self.ButtonAdminViewProfile.Paint = function(self, w, h)
            local ImgStaffSteamProfile = Material("vliss/vliss_btn_steam.png", "noclamp smooth")
            local ButtonAlpha = 25

            if v:IsPlayer( ) and IsValid(v) and not v:IsBot( ) then
                ButtonAlpha = 255
            end

            surface.SetDrawColor(Color(255, 255, 255, ButtonAlpha))
            surface.SetMaterial(ImgStaffSteamProfile)
            surface.DrawTexturedRect(3, 7, 19, 19)
        end
        self.ButtonAdminViewProfile.DoClick = function( )
            if IsValid(v) then
                v:ShowProfile( )
            end
        end

        countAdminOnline = countAdminOnline + 1

    end

    self.PanelInnerTopAdmins.Paint = function( s, w, h )
        draw.SimpleText(ln.online_staff, "VlissFontOnlineStaff", 18, 45, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(countAdminOnline .. " " .. ln.staff, "VlissFontServerStaffCount", w - 20, 45, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawLine(w - 20, 58, 15, 58)
    end

end

-----------------------------------------------------------------
-- [ INIT POST - TTT TIME/ROUND REMAINING ]
-----------------------------------------------------------------
-- Need to localize this in the next update.
-----------------------------------------------------------------

local function ttt_initialize( )
    if not ttt.Enabled then return end

    local GetPTranslation   = LANG.GetParamTranslation
    local function TTTCalcRemainingTime( )
        local remains_rnds   = math.max(0, GetGlobalInt("ttt_rounds_left", 6))
        local remains_time   = math.floor(math.max(0, ((GetGlobalInt("ttt_time_limit_minutes") or 60) * 60) - CurTime( )))

        local h              = math.floor(remains_time / 3600)
        remains_time         = remains_time - math.floor(h * 3600)
        local m              = math.floor(remains_time / 60)
        remains_time         = remains_time - math.floor(m * 60)
        local s              = math.floor(remains_time)

        return remains_rnds, string.format("%02i:%02i:%02i", h, m, s)
    end

    timer.Create( "TTTUpdateRemaining", 0.5, 0, function( )
        local r, t = TTTCalcRemainingTime( )
        Vliss_TTTRemaining = GetPTranslation("sb_mapchange", {num = r, time = t})
    end )
end
hook.Add("InitPostEntity", "VlissInit", ttt_initialize )

-----------------------------------------------------------------
-- [ PANEL: INIT ]
-----------------------------------------------------------------

function PANEL:Init( )

    self.w, self.h = ScrW( ) * cfg.general.size_w or 0.90, ScrH( ) * cfg.general.size_h or 0.90
    self:SetSize(self.w, self.h)
    self:Center( )
    self:MakePopup( )
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(false)
    self.Paint = function( s, w, h ) end

    -----------------------------------------------------------------
    -- [ BACKGROUND CONTAINER ]
    -----------------------------------------------------------------

    if ( cfg.bg.static.enabled or cfg.bg.live.enabled ) and ( cfg.bg.static.list or cfg.bg.live.list ) then
        local sourceTable = cfg.bg.static.list
        if cfg.bg.live.enabled then
            sourceTable = cfg.bg.live.list
        end
        local htm_bg = vgui.Create( "DHTML", self )
        htm_bg:SetSize( ScrW( ), ScrH( ) )
        htm_bg:SetScrollbars( false )
        htm_bg:SetVisible( true )
        htm_bg:SetHTML(
        [[
            <body style="overflow: hidden; height: 100%; width: 100%; margin:0px;">
                <iframe frameborder="0" width="100%" height="100%" src="]] .. table.Random( sourceTable ) .. [["></iframe>
            </body>
        ]])
        htm_bg.Paint = function( s, w, h ) end
    end

    -----------------------------------------------------------------
    -- [ MAIN BACKGROUND FILTER ]
    -----------------------------------------------------------------

    if cfg.bg.static.enabled and cfg.bg.static.list then
        local htm_bg_filter = vgui.Create( "DHTML", htm_bg )
        htm_bg_filter:SetSize( ScrW( ), ScrH( ) )
        htm_bg_filter:SetScrollbars( false )
        htm_bg_filter:SetVisible( true )
        htm_bg_filter.Paint = function( s, w, h )
            if cfg.bg.filter.bBlur then
                DrawBlurPanel( s, 3 )
            end
            draw.VlissBox( 0, 0, w, h, cfg.bg.filter.color or Color( 0, 0, 0, 230 ) )
        end
    end

    -----------------------------------------------------------------
    -- [ LEFT CONTAINER ]
    -----------------------------------------------------------------

    self.ct_left = vgui.Create("DPanel", self)
    self.ct_left:Dock(LEFT)
    self.ct_left:DockMargin(0, 0, 0, 0)
    self.ct_left:SetWide(200)
    self.ct_left.Paint = function( s, w, h ) end

    -----------------------------------------------------------------
    -- [ LEFT TOP CONTAINER ]
    -----------------------------------------------------------------

    self.ct_left_top = vgui.Create("DPanel", self.ct_left)
    self.ct_left_top:Dock(FILL)
    self.ct_left_top:DockMargin(0, 0, 0, 0)
    self.ct_left_top:SetSize(200, 50)
    self.ct_left_top.Paint = function( s, w, h ) end

    -----------------------------------------------------------------
    -- [ TAB CONTAINER ]
    -----------------------------------------------------------------

    self.ct_left_tabs = vgui.Create("DPanel", self.ct_left)
    self.ct_left_tabs:Dock(TOP)
    self.ct_left_tabs:DockMargin(0, 0, 0, 0)
    self.ct_left_tabs:SetSize( 200, 40 )
    self.ct_left_tabs.Paint = function( s, w, h )
        draw.RoundedBox(0, 0, 0, w, h, cfg.general.clrs.pnl_left_top )
    end

    -----------------------------------------------------------------
    -- [ TABS ]
    -----------------------------------------------------------------
    -- These are the tabs that lead to the (by default, 3) different
    -- sections of vliss. The home, actions, and controls tabs.
    -- I haven't fully decided how I want the system to work so for
    -- now there's a table within the code. Later I'll make it to
    -- allow owners of the script to create their own tabs.
    -----------------------------------------------------------------

    base.core.Tabs =
    {
        {
            enabled         = true,
            name            = "",
            tooltip         = "Home Tab",
            icon            = "vliss/vliss_btn_leftpanel_home.png",
            textColor       = Color( 255, 255, 255, 255 ),
            func            = function( )
                                if IsValid( base.PanelBrowser ) then
                                    base.PanelBrowser:SetVisible        ( false )
                                end

                                if IsValid( self.PanelInnerTopAdmins ) then
                                    self.PanelInnerTopAdmins:SetVisible( false )
                                end

                                if IsValid( self.PanelIBAdminList ) then
                                    self.PanelIBAdminList:SetVisible( false )
                                end

                                if IsValid( Vliss_PanelServSettings ) then
                                    Vliss_PanelServSettings:SetVisible( false )
                                end

                                self.tab_actions:SetVisible         ( false )
                                self.tab_ctrls:SetVisible           ( false )
                                self.tab_home:SetVisible            ( true )
                                Vliss_PanelInnerBottom:SetVisible   ( true )
                            end
        },
        {
            enabled         = true,
            name            = "",
            tooltip         = "Actions Tab",
            icon            = "vliss/vliss_btn_leftpanel_actions.png",
            textColor       = Color( 255, 255, 255, 255 ),
            func            = function( )
                                self.tab_home:SetVisible            ( false )
                                self.tab_ctrls:SetVisible           ( false )
                                self.tab_actions:SetVisible         ( true )
                            end
        },
        {
            enabled         = true,
            name            = "",
            tooltip         = "Controls Tab",
            icon            = "vliss/vliss_btn_leftpanel_controls.png",
            textColor       = Color( 255, 255, 255, 255 ),
            func            = function( )
                                self.tab_home:SetVisible            ( false )
                                self.tab_actions:SetVisible         ( false )
                                self.tab_ctrls:SetVisible           ( true )
                            end
        },
    }

    for k, v in pairs( base.core.Tabs ) do
        if not v.enabled then continue end
        local TabIconSize = 20

        self.b_tab = vgui.Create("DButton", self.ct_left_tabs)
        self.b_tab:Dock(LEFT)
        self.b_tab:DockMargin(20, 3, 0, 0)
        self.b_tab:SetSize(40, 40)
        self.b_tab:SetText("")
        self.b_tab:SetVisible(true)
        self.b_tab:SetTooltip(v.tooltip)
        self.b_tab.Paint = function(self, w, h)
            local mat   = Material(v.icon, "noclamp smooth")
            local color = Color(255, 255, 255, 255)

            if self:IsHovered( ) or self:IsDown( ) then
                color = cfg.general.clrs.btn_left_top_h
            end

            surface.SetDrawColor(color)
            surface.SetMaterial(mat)
            surface.DrawTexturedRect(8, 8, TabIconSize, TabIconSize)

            draw.SimpleText(v.name, "VlissFontClock", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end

        self.b_tab.DoClick = v.func
    end

    -----------------------------------------------------------------
    -- [ TABS CONTENT ]
    -----------------------------------------------------------------

    self.tab_home = vgui.Create( 'vliss_panel_tab_home', self.ct_left )
    self.tab_home:Dock(FILL)
    self.tab_home:SetWide(200)

    -- This section is next. Re-write this so that buttons are pulled from a table with the needed actions.
    -- Going to put these into a panel so the visual aspects are only called once.

    self.tab_actions = vgui.Create("DPanel", self.ct_left)
    self.tab_actions:Dock(FILL)
    self.tab_actions:DockMargin(0, 0, 0, 0)
    self.tab_actions:SetWide(200)
    self.tab_actions:SetVisible(false)
    self.tab_actions.Paint = function( s, w, h )
        if base.core.LeftMidPanelBlur then
            DrawBlurPanel( s, 3 )
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

    if cfg.Menu.IconsTextEnabled then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleScoreboard:SetSize(self.ButtonToggleScoreboard:GetWide( ), self.ButtonToggleScoreboard:GetTall( ))
    elseif cfg.general.menu_icons_only then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleScoreboard:SetSize(64, self.ButtonToggleScoreboard:GetTall( ))
    end

    self.ButtonToggleScoreboard.Paint = function(self, w, h)
        local clr_btn_n     = Color(124, 51, 50, 190)
        local clr_btn_h     = Color(124, 51, 50, 240)
        local clr_txt_n     = Color(255, 255, 255, 255)
        local clr_txt_h     = Color(255, 255, 255, 255)
        local buttonText    = ln.toggle_off
        local buttonDesc    = ln.set_toggle_on
        local material      = Material(m_btn_tog_on, "noclamp smooth")
        local widthAdjust   = 15

        if GetConVarNumber("vliss_scoreboardtoggle") == 1 then
            clr_btn_n       = Color(42, 107, 72, 190)
            clr_btn_h       = Color(42, 107, 72, 240)
            buttonText      = ln.toggle_on
            buttonDesc      = ln.set_toggle_off
            material        = Material(m_btn_tog_off, "noclamp smooth")
        end

        local color         = clr_btn_n
        local txtColor      = clr_txt_n
        if self:IsHovered( ) or self:IsDown( ) then
            color           = clr_btn_h
            txtColor        = clr_txt_h
        end

        surface.SetDrawColor(color)
        surface.DrawRect(0, 0, w, h)
        draw.VlissBoxEffects(w, h)

        if cfg.Menu.IconsTextEnabled and material then
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
    -- BUTTON: Toggle Scoreboard
    -----------------------------------------------------------------
    self.ButtonToggleKeyboard = vgui.Create("DButton", self.tab_actions)
    self.ButtonToggleKeyboard:SetText("")
    self.ButtonToggleKeyboard:Dock(TOP)
    self.ButtonToggleKeyboard:DockMargin(5,5,5,0)
    self.ButtonToggleKeyboard:SetSize(190, 50)

    local mat = false

    if cfg.Menu.IconsTextEnabled then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleKeyboard:SetSize(self.ButtonToggleKeyboard:GetWide( ), self.ButtonToggleKeyboard:GetTall( ))
    elseif cfg.general.menu_icons_only then
        mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
        self.ButtonToggleKeyboard:SetSize(64, self.ButtonToggleKeyboard:GetTall( ))
    end

    self.ButtonToggleKeyboard.Paint = function(self, w, h)
        local clr_btn_n = Color(124, 51, 50, 190)
        local clr_btn_h = Color(124, 51, 50, 240)
        local clr_txt_n = Color(255, 255, 255, 255)
        local clr_txt_h = Color(255, 255, 255, 255)
        local buttonText = ln.toggle_keyboard_off
        local buttonDesc = ln.set_toggle_keyboard_on
        local material = Material(m_btn_tog_on, "noclamp smooth")
        local widthAdjust = 15

        if GetConVarNumber("vliss_keyboardtoggle") == 0 then
            clr_btn_n = Color(42, 107, 72, 190)
            clr_btn_h = Color(42, 107, 72, 240)
            buttonText = ln.toggle_keyboard_on
            buttonDesc = ln.set_toggle_keyboard_off
            material = Material(m_btn_tog_off, "noclamp smooth")
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

        if cfg.Menu.IconsTextEnabled and material then
            widthAdjust = 36
            surface.SetDrawColor(txtColor)
            surface.SetMaterial(material)
            surface.DrawTexturedRect(6, 12, 24, 24)
        end

        draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", widthAdjust, self:GetTall( ) * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(string.upper(buttonDesc), "VlissFontMenuSubinfo", widthAdjust, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    end

    self.ButtonToggleKeyboard.DoClick = function( )
        local cmd = "1"

        if GetConVarNumber("vliss_keyboardtoggle") == 1 then
            cmd = "0"
        end

        RunConsoleCommand("vliss_keyboardtoggle", cmd)
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

    if cfg.Menu.IconsTextEnabled then
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
        local buttonText = ln.staff_view
        local buttonDesc = ln.view_online_staff
        local material = Material(m_btn_tog_on, "noclamp smooth")
        local widthAdjust = 15

        if IsValid(Vliss_PanelInnerBottom) and not Vliss_PanelInnerBottom:IsVisible( ) then
            clr_btn_n = Color(42, 107, 72, 190)
            clr_btn_h = Color(42, 107, 72, 240)
            buttonText = ln.scoreboard_view
            buttonDesc = ln.view_all_players
            material = Material(m_btn_tog_off, "noclamp smooth")
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

        if cfg.Menu.IconsTextEnabled and material then
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
            self.PanelInnerTop:SetVisible(true)
            if IsValid(self.PanelTTTCalc) then self.PanelTTTCalc:SetVisible(false) end
            self.PanelIBAdminList:SetVisible(true)
            self.PanelInnerTopAdmins:SetVisible(true)
        elseif IsValid(GetScoreboardPanel( )) and IsValid(Vliss_PanelAbout) and Vliss_PanelAbout:IsVisible( ) then
            Vliss_PanelAbout:SetVisible(false)
            self.PanelInnerTop:SetVisible(true)
            if IsValid(self.PanelTTTCalc) then self.PanelTTTCalc:SetVisible(false) end
            self.PanelIBAdminList:SetVisible(true)
            self.PanelInnerTopAdmins:SetVisible(true)
        elseif IsValid(GetScoreboardPanel( )) and IsValid(Vliss_PanelServSettings) and Vliss_PanelServSettings:IsVisible( ) then
            Vliss_PanelServSettings:SetVisible(false)
            self.PanelInnerTop:SetVisible(true)
              if IsValid(self.PanelTTTCalc) then self.PanelTTTCalc:SetVisible(false) end
            self.PanelIBAdminList:SetVisible(true)
            self.PanelInnerTopAdmins:SetVisible(true)
        else
            self.PanelInnerTopAdmins:SetVisible(false)
            self.PanelIBAdminList:SetVisible(false)
            self.PanelInnerTop:SetVisible(true)
            if IsValid(self.PanelTTTCalc) then self.PanelTTTCalc:SetVisible(true) end
            Vliss_PanelInnerBottom:SetVisible(true)
        end
        if IsValid(base.PanelBrowser) and base.PanelBrowser:IsVisible( ) then base.PanelBrowser:Remove( ) end
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
        if rp.Enabled then
            self.ButtonServerSettings:SetVisible(true)
        else
            self.ButtonServerSettings:SetVisible(false)
        end

        local mat = false

        if cfg.Menu.IconsTextEnabled then
            mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
            self.ButtonServerSettings:SetSize(self.ButtonServerSettings:GetWide( ), self.ButtonServerSettings:GetTall( ))
        elseif cfg.general.menu_icons_only then
            mat = Material("vliss/vliss_btn_mainmenu.png", "noclamp smooth")
            self.ButtonServerSettings:SetSize(64, self.ButtonServerSettings:GetTall( ))
        end

        self.ButtonServerSettings.Paint = function(self, w, h)
            local clr_btn_n         = Color(64, 105, 126, 190)
            local clr_btn_h         = Color(64, 105, 126, 240)
            local clr_txt_n         = Color(255, 255, 255, 255)
            local clr_txt_h         = Color(255, 255, 255, 255)
            local buttonText        = ln.server_settings
            local buttonDesc        = ln.server_settings_desc
            local material          = Material(m_ico_lim, "noclamp smooth")
            local widthAdjust       = 15

            local color             = clr_btn_n
            local txtColor          = clr_txt_n
            if self:IsHovered( ) or self:IsDown( ) then
                color               = clr_btn_h
                txtColor            = clr_txt_h
            end

            surface.SetDrawColor(color)
            surface.DrawRect(0, 0, w, h)
            draw.VlissBoxEffects(w, h)

            if cfg.Menu.IconsTextEnabled and material then
                widthAdjust = 36
                surface.SetDrawColor(txtColor)
                surface.SetMaterial(material)
                surface.DrawTexturedRect(6, 12, 24, 24)
            end

            draw.SimpleText(string.upper(buttonText), "VlissFontMenuItem", widthAdjust, self:GetTall( ) * .35, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(string.upper(buttonDesc), "VlissFontMenuSubinfo", widthAdjust, self:GetTall( ) * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        end

        self.ButtonServerSettings.DoClick = function( )
            if IsValid(Vliss_PanelServSettings) then Vliss_PanelServSettings:Remove( ) end
            self:VlissServerSettings( )
            if IsValid(GetScoreboardPanel( )) and Vliss_PanelInnerBottom:IsVisible( ) then
                Vliss_PanelInnerBottom:SetVisible(false)
                self.PanelInnerTop:SetVisible(true)
                Vliss_PanelServSettings:SetVisible(true)
            elseif IsValid(GetScoreboardPanel( )) and IsValid(self.PanelIBAdminList) and self.PanelIBAdminList:IsVisible( ) then
                self.PanelInnerTopAdmins:SetVisible(false)
                self.PanelIBAdminList:SetVisible(false)
                self.PanelInnerTop:SetVisible(true)
                Vliss_PanelServSettings:SetVisible(true)
            elseif IsValid(GetScoreboardPanel( )) and IsValid(Vliss_PanelAbout) and Vliss_PanelAbout:IsVisible( ) then
                Vliss_PanelAbout:SetVisible(false)
                self.PanelInnerTop:SetVisible(true)
                Vliss_PanelServSettings:SetVisible(true)
            elseif IsValid(GetScoreboardPanel( )) and IsValid(base.PanelBrowser) and base.PanelBrowser:IsVisible( ) then
                base.PanelBrowser:SetVisible(false)
                self.PanelInnerTop:SetVisible(true)
                Vliss_PanelServSettings:SetVisible(true)
            else
                Vliss_PanelServSettings:SetVisible(false)
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
    for k, v in pairs(cfg.ActionsTab.Buttons) do
        if v.enabled then
            self.ButtonTabCustom = vgui.Create("DButton", self.tab_actions)
            self.ButtonTabCustom:SetText("")
            self.ButtonTabCustom:SetSize(190, 50)
            self.ButtonTabCustom:Dock(TOP)
            self.ButtonTabCustom:DockMargin(5,5,5,0)
            local mat = false

            if v.icon and cfg.Menu.IconsTextEnabled then
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
                if cfg.Menu.IconsTextEnabled and mat then
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

    self.tab_ctrls = vgui.Create( 'vliss_panel_tab_controls', self.ct_left )
    self.tab_ctrls:Dock(FILL)
    self.tab_ctrls:SetWide(200)
    self.tab_ctrls:SetVisible(false)

    -----------------------------------------------------------------
    -- [ WIDGET ]
    -----------------------------------------------------------------
    -- Originally just the clock, I added the ability to change how
    -- this section could be utilized. As time goes on, I'll add more
    -- things that players can select from.
    -----------------------------------------------------------------
    -- [ cfg.widget.type ]
    --
    -- This setting determines how will show in the widget.
    --      cfg.widget.type = 1   :: Displays a clock
    --      cfg.widget.type = 2   :: Current map / # of players
    -----------------------------------------------------------------

    if cfg.widget.enabled then
        self.ct_widget = vgui.Create("DPanel", self.ct_left)
        self.ct_widget:Dock(BOTTOM)
        self.ct_widget:SetSize(200, 60)
        self.ct_widget.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, cfg.widget.clr_box )
            if cfg.widget.type == 1 then
                draw.SimpleText(os.date(cfg.widget.format), "VlissFontClock", w / 2, h / 2, cfg.widget.clr_txt or Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            elseif cfg.widget.type == 2 then
                draw.SimpleText("Map:", "VlissFontServerInfo", 10, 15, cfg.widget.clr_txt or Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(game.GetMap( ), "VlissFontServerInfo", w - 10, 15, cfg.widget.clr_txt or Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

                draw.SimpleText("Players:", "VlissFontServerInfo", 10, 40, cfg.widget.clr_txt or Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(table.Count(player.GetAll( )) .. " / " .. game.MaxPlayers( ), "VlissFontServerInfo", w - 10, 40, cfg.widget.clr_txt or Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Invalid Widget Type", "VlissFontClock", w / 2, h / 2, cfg.widget.clr_txt or Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end

    -----------------------------------------------------------------
    -- Panel: Right Container
    -----------------------------------------------------------------

    PanelRightContainer = vgui.Create("DPanel", self)
    PanelRightContainer:Dock(FILL)
    PanelRightContainer.Paint = function( s, w, h )
        local clr_bg = ( cfg.bg.static.enabled or cfg.bg.live.enabled ) and cfg.general.clrs.pnl_middle_bg or cfg.general.clrs.pnl_middle
        draw.RoundedBox( 0, 0, 0, w, h, clr_bg )
    end

    -----------------------------------------------------------------
    -- Panel: Inner Top
    -- Holds Network Name, server players, and current map
    -----------------------------------------------------------------

    self.PanelInnerTop = vgui.Create("DPanel", PanelRightContainer)
    self.PanelInnerTop:Dock(TOP)
    self.PanelInnerTop:DockMargin( 0, 0, 0, 0 )
    self.PanelInnerTop:SetTall( 40 )
    self.PanelInnerTop.Paint = function( s, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, cfg.general.clrs.pnl_header )
        draw.SimpleText( cfg.general.network_name or 'Welcome', 'vliss_g_header', w - 10, h / 2 + 2, cfg.general.clrs.network_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    end

    -----------------------------------------------------------------
    -- [ TTT : ROUND STATUS ]
    -- Code which determines how many rounds or how much time is left
    -- on the current map.
    -----------------------------------------------------------------

    if ttt.Enabled and ttt.RemainingTimeEnabled then

        self.PanelTTTCalc = vgui.Create("DPanel", PanelRightContainer)
        self.PanelTTTCalc:SetTall(14)
        self.PanelTTTCalc:SetPos(2, 50)
        self.PanelTTTCalc:SetWide(300)
        self.PanelTTTCalc.Paint = function(self, w, h)
            draw.SimpleText( Vliss_TTTRemaining, "VlissFontTTTRemaining", 40, 5, ttt.RemainingTimeText or Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        end

    end

    -----------------------------------------------------------------
    -- Panel: Inner Bottom
    -- Holds the VlissPlayerList
    -----------------------------------------------------------------

    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then
        Vliss_PanelInnerBottom = vgui.Create("DPanel", PanelRightContainer)
        Vliss_PanelInnerBottom:Dock(FILL)
        Vliss_PanelInnerBottom:DockMargin( 11, 5, 6, 5 )
        Vliss_PanelInnerBottom.Paint = function(self, w, h) end

        Vliss_PanelAltContainer = vgui.Create("DPanel", Vliss_PanelInnerBottom)
        Vliss_PanelAltContainer:Dock(BOTTOM)
        Vliss_PanelAltContainer:SetTall(100)
        Vliss_PanelAltContainer:DockMargin(0, 0, 0, 0)
        Vliss_PanelAltContainer:SetVisible(false)
        Vliss_PanelAltContainer.Paint = function(self, w, h) end

        self.VlissPMurderPlayers = vgui.Create("DPanel", Vliss_PanelInnerBottom)
        self.VlissPMurderPlayers:Dock(FILL)
        self.VlissPMurderPlayers:DockMargin(0, 0, 5, 0)
        self.VlissPMurderPlayers.Paint = function(self, w, h) end

        self.VlissPMurderSpec = vgui.Create("DPanel", Vliss_PanelInnerBottom)
        self.VlissPMurderSpec:Dock(RIGHT)
        self.VlissPMurderSpec:DockMargin(0, 0, 5, 0)
        self.VlissPMurderSpec.Paint = function(self, w, h) end

        -- Hacky ass way to do this. Need to make a better method later.
        Vliss_PanelInnerBottom.Think = function(this)
            self.VlissPMurderPlayers:SetWide(this:GetWide( )/2)
            self.VlissPMurderSpec:SetWide(this:GetWide( )/2)
        end

    else
        Vliss_PanelInnerBottom = vgui.Create("DPanel", PanelRightContainer)
        Vliss_PanelInnerBottom:Dock(FILL)
        Vliss_PanelInnerBottom:DockMargin(5, 5, 5, 5)
        Vliss_PanelInnerBottom.Paint = function(self, w, h) end
    end

    -----------------------------------------------------------------
    -- Panel: Inner Top Admins
    -- Displays current staff # and Online Staff text
    -----------------------------------------------------------------

    self.PanelInnerTopAdmins = vgui.Create("DPanel", PanelRightContainer)
    self.PanelInnerTopAdmins:Dock(TOP)
    self.PanelInnerTopAdmins:DockMargin(5, 5, 5, 0)
    self.PanelInnerTopAdmins:SetTall(60)
    self.PanelInnerTopAdmins:SetVisible(false)

    self.PanelIBAdminList = vgui.Create("DPanel", PanelRightContainer)
    self.PanelIBAdminList:Dock(FILL)
    self.PanelIBAdminList:DockMargin(25, 20, 10, 10)
    self.PanelIBAdminList:SetVisible(false)
    self.PanelIBAdminList.Paint = function(self, w, h) end

    -----------------------------------------------------------------
    -- Panel: Inner Cols
    -- Player list top column names
    -----------------------------------------------------------------

    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then
        self.PanelInnerCols = vgui.Create("DPanel", self.VlissPMurderPlayers)

        local t2_label
        local t2_id
        local t2_score
        if mu.Enabled then
            t2_label    = mu.t2_label
        elseif ph.Enabled then
            t2_id       = ph.TeamProps
            t2_score    = team.GetScore( t2_id )
            t2_label    = ph.TeamPropsTitle .. " ( " .. t2_score .. " wins )"
        elseif zs.Enabled then
            t2_id       = zs.TeamUndead
            t2_score    = team.GetScore( t2_id )
            t2_label    = zs.TeamUndeadTitle
        elseif dr.Enabled then
            t2_id       = dr.TeamRunner
            t2_score    = team.GetScore( t2_id )
            t2_label    = dr.TeamRunnerTitle
        end

        self.PanelInnerColsSpec = vgui.Create("DPanel", self.VlissPMurderSpec)
        self.PanelInnerColsSpec:Dock(TOP)
        self.PanelInnerColsSpec:DockMargin(0, 5, 0, 0)
        self.PanelInnerColsSpec:SetTall(30)
        self.PanelInnerColsSpec.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w - 1, h, cfg.splitboard.clrs.lbl_nane_t2_box )
            draw.SimpleText( t2_label, "vliss_sb_team_name", 6, 15, cfg.splitboard.clrs.lbl_name_t2_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        -----------------------------------------------------------------
        -- [ ALT SECONDARY LIST ]
        -----------------------------------------------------------------

        self.ButtonTeamAltJoin = vgui.Create("DButton", self.PanelInnerColsSpec)
        self.ButtonTeamAltJoin:Dock(RIGHT)
        self.ButtonTeamAltJoin:SetText( '' )
        self.ButtonTeamAltJoin:SetTextColor( cfg.splitboard.clrs.btn_join_t2_txt )
        self.ButtonTeamAltJoin:SetFont("vliss_sb_team_join")
        if zs.Enabled or dr.Enabled then
            self.ButtonTeamAltJoin:SetVisible(false)
        end
        self.ButtonTeamAltJoin.DoClick = function( )
            local t2_id
            if mu.Enabled then
                t2_id = 1
            elseif ph.Enabled then
                t2_id = ph.TeamProps
            elseif zs.Enabled then
                t2_id = zs.TeamUndead
            elseif dr.Enabled then
                t2_id = dr.TeamRunner
            end
            RunConsoleCommand( "vliss_jointeam", t2_id )
        end
        self.ButtonTeamAltJoin.Paint = function(self, w, h)
            surface.SetDrawColor( cfg.splitboard.clrs.btn_join_t2_box )
            surface.DrawRect(0, 0, w - 1, h)

            surface.SetDrawColor( cfg.splitboard.clrs.btn_join_t2_box_li )
            surface.DrawRect( 0, 0, w - 1, h * 0.45 )

            if self:IsDown( ) then
                surface.SetDrawColor(50,50,50,120)
                surface.DrawRect(1, 1, w - 2, h - 2)
            elseif self:IsHovered( ) then
                surface.SetDrawColor(255,255,255,30)
                surface.DrawRect(1, 1, w - 2, h - 2)
            end

            draw.SimpleText( mu.t2_label_join_btn, 'vliss_sb_team_join', w / 2, h / 2, cfg.splitboard.clrs.btn_join_t2_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end

    else
        self.PanelInnerCols = vgui.Create("DPanel", Vliss_PanelInnerBottom)
    end

    self.PanelInnerCols:Dock(TOP)
    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then
        self.PanelInnerCols:DockMargin( 0, 5, 0, 0 )
    else
        self.PanelInnerCols:DockMargin( 35, 5, 0, 0 )
    end

    self.PanelInnerCols:SetTall(30)

    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then

        self.PanelInnerCols.Paint = function(self, w, h)
            local t1_label
            local t1_id
            local t1_score
            if mu.Enabled then
                t1_label    = mu.t1_label
            elseif ph.Enabled then
                t1_id       = ph.TeamHunters
                t1_score    = team.GetScore( t1_id )
                t1_label    = ph.TeamHuntersTitle .. " ( " .. t1_score .. " wins )"
            elseif zs.Enabled then
                t1_id       = zs.TeamHuman
                t1_score    = team.GetScore( 1 )
                t1_label    = zs.TeamHumanTitle
            elseif dr.Enabled then
                t1_id       = dr.TeamDeath
                t1_score    = team.GetScore( 1 )
                t1_label    = dr.TeamDeathTitle
            end
            draw.RoundedBox(0, 0, 0, w - 1, h, cfg.splitboard.clrs.lbl_nane_t1_box )
            draw.SimpleText( t1_label, "vliss_sb_team_name", 6, 15, cfg.splitboard.clrs.lbl_name_t1_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        -----------------------------------------------------------------
        -- [ MURDER MODE ]
        -- Join players button
        -----------------------------------------------------------------

        self.ButtonTeamPlayersJoin = vgui.Create("DButton", self.PanelInnerCols)
        self.ButtonTeamPlayersJoin:Dock(RIGHT)
        self.ButtonTeamPlayersJoin:SetText( '' )
        self.ButtonTeamPlayersJoin:SetTextColor( cfg.splitboard.clrs.btn_join_t1_txt )
        self.ButtonTeamPlayersJoin:SetFont("vliss_sb_team_join")
        if zs.Enabled or dr.Enabled then
            self.ButtonTeamPlayersJoin:SetVisible(false)
        end
        self.ButtonTeamPlayersJoin.DoClick = function( )
            local t1_id
            if mu.Enabled then
                t1_id = 2
            elseif ph.Enabled then
                t1_id = ph.TeamHunters
            elseif zs.Enabled then
                t1_id = zs.TeamUndead
            elseif dr.Enabled then
                t1_id = dr.TeamRunner
            end
            RunConsoleCommand( "vliss_jointeam", t1_id )
        end
        self.ButtonTeamPlayersJoin.Paint = function(self, w, h)
            surface.SetDrawColor( cfg.splitboard.clrs.btn_join_t1_box )
            surface.DrawRect(0, 0, w - 1, h)

            surface.SetDrawColor( cfg.splitboard.clrs.btn_join_t1_box_li )
            surface.DrawRect(0, 0, w - 1, h * 0.45 )

            if self:IsDown( ) then
                surface.SetDrawColor(50,50,50,120)
                surface.DrawRect(1, 1, w - 2, h - 2)
            elseif self:IsHovered( ) then
                surface.SetDrawColor(255,255,255,30)
                surface.DrawRect(1, 1, w - 2, h - 2)
            end

            draw.SimpleText( mu.t1_label_join_btn, 'vliss_sb_team_join', w / 2, h / 2, cfg.splitboard.clrs.btn_join_t1_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end

    else

        self.PanelInnerCols.Paint = function( s, w, h ) end

        self.lblname                = vgui.Create( 'DButton', self.PanelInnerCols )
        self.lblname:Dock           ( LEFT                                  )
        self.lblname:SetWide        ( 100                                   )
        self.lblname:SetText        ( ''                                    )
        self.lblname.DoClick        = function( s )
                                        RunConsoleCommand( 'vliss_playersort', 0 )
                                        self:UpdateScoreboard( )
                                    end
        self.lblname.Paint          = function( s, w, h )
                                        --draw.RoundedBox( 0, 5, 0, w, h, cfg.general.clrs.data_col )
                                        draw.SimpleText( ln.name, 'vliss_sb_column_title_name', 10, h / 2 + cfg.dev.general.size_col_oset_h, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end

        self.cols = { }

        /*
        *   ping
        */

        if cfg.Column.PingEnabled then
            self:AddColumn( ln.ping )
        end

        /*
        *   sorting
        */

        local cols = table.Copy( cfg.Columns )
        table.sort( cols, function( a, b )
            local aso = a.sort or 100
            local bso = b.sort or 100

            return aso < bso or aso == bso and a.name < b.name
        end )

        for k, v in pairs( cols ) do
            if not v.enabled then continue end
            if not v.condition then continue end

            local condition         = v.condition( )
                                    if not condition then continue end

            local rset              = v.rset or 0

            self:AddColumn( v.name, v.func, v.width, v.clr_txt_title, k, v.clr_dev, rset )
        end

    end

    -----------------------------------------------------------------
    -- [ PLAYER LIST ]
    -----------------------------------------------------------------
    -- Generates the needed lists for players. Certain gamemodes use
    -- a different layout.
    -----------------------------------------------------------------

    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then
        VlissPlayerList = vgui.Create('DPanelList', self.VlissPMurderPlayers)
        VlissSpectatorList = vgui.Create('DPanelList', self.VlissPMurderSpec)
        VlissSpectatorList:Dock(TOP)
        VlissSpectatorList:SetSpacing(-1)
        VlissSpectatorList:EnableVerticalScrollbar(false)
        VlissSpectatorList.Paint = function(self, w, h) end
    else
        VlissPlayerList = vgui.Create('DPanelList', Vliss_PanelInnerBottom)
    end

    VlissPlayerList:Dock(TOP)
    VlissPlayerList:SetSpacing(-1)
    VlissPlayerList:EnableVerticalScrollbar(false)
    VlissPlayerList.Paint = function(self, w, h) end

    -----------------------------------------------------------------
    -- [ SERVER LIST ]
    -----------------------------------------------------------------
    -- This allows for the server owner to specify servers that
    -- players can click on in order to connect to.
    -----------------------------------------------------------------

    if table.Count( cfg.servers.list ) > 0 and cfg.servers.general.enabled then
        self.PanelServerlistBox = vgui.Create( 'vliss_panel_serverconn', PanelRightContainer )
        self.PanelServerlistBox:Dock(BOTTOM)
        self.PanelServerlistBox:SetTall(60)
    end

    -----------------------------------------------------------------
    -- Function vliss:OpenURL
    -----------------------------------------------------------------
    -- Takes a URL and opens it within the custom browser.
    -----------------------------------------------------------------
    function base:OpenExternal(title, data, isText)

        if IsValid(Vliss_PanelServSettings) then Vliss_PanelServSettings:Remove( ) end
        if IsValid(Vliss_PanelAbout) then Vliss_PanelAbout:Remove( ) end
        if IsValid(base.PanelBrowser) then base.PanelBrowser:Remove( ) end
        if Vliss_PanelInnerBottom:IsVisible( ) then Vliss_PanelInnerBottom:Hide( ) end

        base.PanelBrowser = vgui.Create( "DFrame", PanelRightContainer )
        base.PanelBrowser:Dock( FILL )
        base.PanelBrowser:DockMargin(5,5,5,5)
        base.PanelBrowser:ShowCloseButton(false)
        base.PanelBrowser:SetTitle( "" )
        base.PanelBrowser.Paint = function( s, w, h )
            draw.RoundedBox( 4, 0, 0, w, h, cfg.general.clrs.integrated_browser )
            draw.DrawText( title, "VlissFontBrowserTitle", base.PanelBrowser:GetWide( ) / 2, 8, cfg.BrowserTitleTextColor or Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
        end

        if isText then

            self.dt = vgui.Create( "DTextEntry", base.PanelBrowser )
            self.dt:SetMultiline( true )
            self.dt:Dock(FILL)
            self.dt:DockMargin(20, 20, 20, 20)
            self.dt:SetDrawBackground( false )
            self.dt:SetEnabled( true )
            self.dt:SetVerticalScrollbarEnabled( true )
            self.dt:SetFont( "VlissFontStandardText" )
            self.dt:SetText( data )
            self.dt:SetTextColor( cfg.RulesTextColor or Color(255, 255, 255, 255) )

        else

            self.dhtml = vgui.Create( "DHTML", base.PanelBrowser )
            self.dhtml:SetSize( ScrW( ) - 200, 300 )
            self.dhtml:DockMargin( 5, 10, 5, 10 )
            self.dhtml:Dock( FILL )
            if cfg.BrowserControlsEnabled then
                self.DHTMLControlsBar = vgui.Create( "DHTMLControls", base.PanelBrowser )
                self.DHTMLControlsBar:Dock( TOP )
                self.DHTMLControlsBar:SetWide( ScrW( ) - 200 )
                self.DHTMLControlsBar:SetPos( 0, 0 )
                self.DHTMLControlsBar:SetHTML( self.dhtml )
                self.DHTMLControlsBar.AddressBar:SetText( data or base.mf.site )

                self.dhtml:MoveBelow( self.DHTMLControlsBar )
            end
            self.dhtml:OpenURL( data or base.mf.site )

        end

        self.b_close = vgui.Create("DButton", base.PanelBrowser )
        self.b_close:SetColor(Color(255, 255, 255, 255))
        self.b_close:SetFont("VlissFontStandardText")
        self.b_close:SetSize(32, 32)
        self.b_close:SetPos(10, 0)
        self.b_close:SetText("")
        self.b_close.Paint = function( )
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.SetMaterial(Material("vliss/vliss_btn_close.png"))
            surface.DrawTexturedRect(0, 10, 16, 16)
        end
        self.b_close.DoClick = function( )
            base.PanelBrowser:Remove( )
            Vliss_PanelInnerBottom:SetVisible(true)
        end

    end

    self:UpdateScoreboard( )
    self:StartUpdateTimer( )

end

function PANEL:AddColumn( label, func, width, titleColor, valkey, devclr, rset )
    self.cols           = self.cols or { }
    local lbl           = vgui.Create( 'DButton', self.PanelInnerCols )
    lbl:SetText         ( label                             )
    lbl:SetFont         ( 'vliss_sb_column_title_data'      )
    lbl:SetTextColor    ( Color( 255, 255, 255, 0 )         )
    lbl:SetWide(         width or 55                        )
    lbl.IsHeading       = true
    lbl.Width           = width or 55
    lbl.rset            = rset or 0
    lbl.Paint           = function( s, w, h )
                            if devclr then
                                draw.RoundedBox( 0, 0, 0, w, h, devclr )
                            end

                            draw.SimpleText( label, 'vliss_sb_column_title_data', w / 2, h / 2 + cfg.dev.general.size_col_oset_h, titleColor or Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
    lbl.DoClick         = function( )
                            RunConsoleCommand( 'vliss_playersort', valkey )
                            self:UpdateScoreboard( )
                        end
    table.insert( self.cols, lbl )

    return lbl
end

local oldconfig
local madeteams

function PANEL:UpdateScoreboard(force)
    if not force and not self:IsVisible( ) then return end
    local layout = true

    if oldconfig ~= cfg.general.team_mode then
        if IsValid(VlissPlayerList) then VlissPlayerList:Clear( ) end
        if IsValid(VlissSpectatorList) then VlissSpectatorList:Clear( ) end
    end

    if not madeteams or ( IsValid(VlissPlayerList) and table.Count(VlissPlayerList:GetChildren( )) < 1 ) then
        self:LayoutTeams( )
        madeteams = true
    end

    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then
        if not madeteams or ( IsValid(VlissSpectatorList) and table.Count(VlissSpectatorList:GetChildren( )) < 1 ) then
            self:LayoutTeams( )
            madeteams = true
        end
    end

    if ttt.Enabled then
        self:LayoutPlayersTTTMode( )
    elseif not cfg.general.team_mode then
        self:LayoutPlayersNoTeams( )
        if mu.Enabled then
            self:LayoutPlayersMurderMode( )
        elseif ph.Enabled then
            self:LayoutPlayersProphuntMode( )
        elseif zs.Enabled then
            self:LayoutPlayersZSurvivalMode( )
        elseif dr.Enabled then
            self:LayoutPlayersDeathrunMode( )
        end
    else
        self:LayoutPlayers( )
    end

    if layout then self:PerformLayout( ) else self:InvalidateLayout( ) end

    if IsValid(self.PanelSpectatorlistBox) then self.PanelSpectatorlistBox:Remove( ) end
    if IsValid(self.PanelUnassignedlistBox) then self.PanelUnassignedlistBox:Remove( ) end

    self:BuildAdminList( )
    self:GenerateSpectatorsList( )
    PanelRightContainer:InvalidateLayout( )
    oldconfig = cfg.general.team_mode
end

-----------------------------------------------------------------
-- [ UPDATE TIMER ]
-- Tick tock on the clock but the party don't stop.
-----------------------------------------------------------------

function PANEL:StartUpdateTimer( )
    if timer.Exists("VlissScoreboardUpdater") then return end

    timer.Create("VlissScoreboardUpdater", cfg.Column.RefreshTime or 1, 0, function( )
        local VlissPanel = GetScoreboardPanel( )
        if IsValid(VlissPanel) then VlissPanel:UpdateScoreboard( ) end
    end )
end

-----------------------------------------------------------------
-- [ SPECTATORS LIST ]
-- Will generate a list of spectators on your server.
-----------------------------------------------------------------

function PANEL:GenerateSpectatorsList( )

    if ph.Enabled or zs.Enabled or dr.Enabled then

        local spectatorList = ""
        local specCount = 0
        for k, v in pairs(player.GetAll( )) do
            if ph.Enabled then
                if ph.UnassignedEnabled then
                    if v:Team( ) == ph.TeamHunters or v:Team( ) == ph.TeamProps or v:Team( ) == ph.TeamUnassigned then continue end
                else
                    if v:Team( ) == ph.TeamHunters or v:Team( ) == ph.TeamProps then continue end
                end
            elseif dr.Enabled then
                if ph.UnassignedEnabled then
                    if v:Team( ) == dr.TeamDeath or v:Team( ) == dr.TeamRunner or v:Team( ) == ph.TeamUnassigned then continue end
                else
                    if v:Team( ) == dr.TeamDeath or v:Team( ) == dr.TeamRunner then continue end
                end
            end
            specCount = specCount + 1
            spectatorList = v:Name( ) .. "      " .. spectatorList
        end

        if specCount > 0 then

            local bFound, id, name = handle:GetGamemode( )

            local lb_spect  = "Spectators"
            if bFound then
                lb_spect    = base[ id ].SpectatorsTitle or "Spectators"
            end

            self.PanelSpectatorlistBox = vgui.Create("DPanel", PanelRightContainer)
            self.PanelSpectatorlistBox:Dock(BOTTOM)
            self.PanelSpectatorlistBox:SetTall(ph.SpeclistBoxHeight or 35)
            self.PanelSpectatorlistBox.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, ph.SpeclistBoxColor or Color(0, 0, 0, 250))
                surface.SetDrawColor(ph.SpeclistBoxBorderlineColor or Color( 255, 255, 255, 255 ))
                surface.DrawLine(0, 0, w, 0)
            end

            self.LabelSpectatorsTitle = vgui.Create("DLabel", self.PanelSpectatorlistBox)
            self.LabelSpectatorsTitle:DockMargin( 15, 5, 5, 5 )
            self.LabelSpectatorsTitle:Dock(LEFT)
            self.LabelSpectatorsTitle:SetTall(15)
            self.LabelSpectatorsTitle:SetWide(100)
            self.LabelSpectatorsTitle:SetFont("VlissFontPHSpecTitle")
            self.LabelSpectatorsTitle:SetText(string.upper(lb_spect or "SPECTATORS"))
            self.LabelSpectatorsTitle:SetTextColor(ph.SpeclistTitleTextColor)
            self.LabelSpectatorsTitle.Paint = function(w, h) end

            self.LabelSpectatorsList = vgui.Create("DLabel", self.PanelSpectatorlistBox)
            self.LabelSpectatorsList:DockMargin( 15, 5, 5, 5 )
            self.LabelSpectatorsList:Dock(FILL)
            self.LabelSpectatorsList:SetTall(15)
            self.LabelSpectatorsList:SetFont("VlissFontPHSpecList")
            self.LabelSpectatorsList:SetText(spectatorList)
            self.LabelSpectatorsList:SetTextColor(ph.SpeclistPlayersTextColor)
            self.LabelSpectatorsList.Paint = function(w, h) end

        end

        if ph.UnassignedEnabled then

            local unassignedList = ""
            local unassignedCount = 0
            for k, v in pairs(player.GetAll( )) do
                if v:Team( ) ~= ph.TeamUnassigned then continue end
                unassignedCount = unassignedCount + 1
                unassignedList = v:Name( ) .. "      " .. unassignedList
            end

            if unassignedCount > 0 then

                self.PanelUnassignedlistBox = vgui.Create("DPanel", PanelRightContainer)
                self.PanelUnassignedlistBox:Dock(BOTTOM)
                self.PanelUnassignedlistBox:SetTall(ph.SpeclistBoxHeight or 35)
                self.PanelUnassignedlistBox.Paint = function(self, w, h)
                    draw.RoundedBox(0, 0, 0, w, h, ph.SpeclistBoxColor or Color(0, 0, 0, 250))
                    surface.SetDrawColor(ph.SpeclistBoxBorderlineColor or Color( 255, 255, 255, 255 ))
                    surface.DrawLine(0, 0, w, 0)
                end

                self.LabelUnassignedTitle = vgui.Create("DLabel", self.PanelUnassignedlistBox)
                self.LabelUnassignedTitle:DockMargin( 15, 5, 5, 5 )
                self.LabelUnassignedTitle:Dock(LEFT)
                self.LabelUnassignedTitle:SetTall(15)
                self.LabelUnassignedTitle:SetWide(70)
                self.LabelUnassignedTitle:SetFont("VlissFontPHSpecTitle")
                self.LabelUnassignedTitle:SetText("UNASSIGNED")
                self.LabelUnassignedTitle:SetTextColor(ph.SpeclistTitleTextColor)
                self.LabelUnassignedTitle.Paint = function(w, h) end

                self.LabelUnassignedList = vgui.Create("DLabel", self.PanelUnassignedlistBox)
                self.LabelUnassignedList:DockMargin( 15, 5, 5, 5 )
                self.LabelUnassignedList:Dock(FILL)
                self.LabelUnassignedList:SetTall(15)
                self.LabelUnassignedList:SetFont("VlissFontPHSpecList")
                self.LabelUnassignedList:SetText(unassignedList)
                self.LabelUnassignedList:SetTextColor(ph.SpeclistPlayersTextColor)
                self.LabelUnassignedList.Paint = function(w, h) end

            end

        end

    end

end

function PANEL:PerformLayout( )

    if not IsValid( VlissPlayerList ) then return end

    if IsValid(Vliss_PanelPlayer) then
        VlissPlayerList:SetSize(self.w - 10, self.h - 278)
        if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then VlissSpectatorList:SetSize(self.w - 10, self.h - 170) end
    else
        VlissPlayerList:SetSize(self.w - 10, self.h - 170)
        if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then VlissSpectatorList:SetSize(self.w - 10, self.h - 170) end
    end

    if base.ScrollbarEnable then
        VlissPlayerList:EnableVerticalScrollbar(true)
        if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then VlissSpectatorList:EnableVerticalScrollbar(true) end
    else
        VlissPlayerList:EnableVerticalScrollbar(false)
        if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then VlissSpectatorList:EnableVerticalScrollbar(false) end
    end

    VlissPlayerList:SetPos( 5, 90 )
    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then VlissSpectatorList:SetPos( 5, 90 ) end

    local cx    = self.w - 220
    local oset  = 0

    self.cols   = self.cols or { }

    for k, v in ipairs( self.cols ) do
        local rset  = v.rset or 0
        cx          = cx - v.Width

        v:SizeToContents( )
        v:SetPos( cx - v:GetWide( ) / 2 + rset , 4 )
    end

end

-----------------------------------------------------------------
-- [ LAYOUT PLAYERS : NO TEAMS ]
-----------------------------------------------------------------

function PANEL:LayoutPlayersNoTeams( sortvar )
    if not IsValid( VlissPlayerList ) then return end

    VlissPlayerList:Clear( )
    self.SortedPlayers = { }

    for k, v in ipairs( player.GetAll( ) ) do
        self.SortedPlayers[ k ] = v
    end

    local varPlayerSort     = GetConVarNumber( 'vliss_playersort' ) or 1
    local sortOrder         = cfg.Column.DefaultOrder

    if varPlayerSort ~= 0 then
        sortOrder           = cfg.Columns[ varPlayerSort ].sortvar
    end

    table.sort( self.SortedPlayers, sortOrder )

    for k, v in ipairs( self.SortedPlayers ) do
        if IsValid( v ) and ( v:Team( ) ~= TEAM_CONNECTING ) then
            if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then
                local TeamID
                if mu.Enabled then
                    TeamID = 2
                elseif ph.Enabled then
                    TeamID = ph.TeamHunters
                elseif zs.Enabled then
                    TeamID = zs.TeamHuman
                elseif dr.Enabled then
                    TeamID = dr.TeamDeath
                end
                if v:Team( ) == TeamID then
                    local row = vgui.Create("vliss_playerrow")
                    row.ply = v
                    row:SetSize(VlissPlayerList:GetWide( ), 40)
                    row:SetPos(0, 0)
                    row:SetPlayer(v)
                    row:SetParent(VlissPlayerList)
                    VlissPlayerList:AddItem(row)
                end
            else
                local row = vgui.Create("vliss_playerrow")
                row.ply = v
                row:SetSize(VlissPlayerList:GetWide( ), 40)
                row:SetPos(0, 0)
                row:SetPlayer(v)
                row:SetParent(VlissPlayerList)
                VlissPlayerList:AddItem(row)
            end
        end
    end

end

local i = 0

-----------------------------------------------------------------
-- [ LIST OF PLAYERS - USED FOR ALL GAMEMODES ]
-----------------------------------------------------------------

function PANEL:MakeTeamPanel(tm)
    if not IsValid( VlissPlayerList ) then return end

    i = 10
    VlissPlayerList[tm] = vgui.Create("DPanelList", VlissPlayerList)
    VlissPlayerList[tm]:SetPos(0, 0)
    VlissPlayerList[tm]:Dock(TOP)
    VlissPlayerList[tm]:SetTall(60)
    VlissPlayerList[tm].team = tm
    VlissPlayerList[tm].rows = 0
    VlissPlayerList[tm].Paint = function(self, w, h) end

    VlissPlayerList:AddItem(VlissPlayerList[tm])
end

-----------------------------------------------------------------
-- [ LIST OF SPECTATORS - USED FOR CERTAIN GAMEMODES ]
-----------------------------------------------------------------

function PANEL:VlissSpectatorList(tm)
    i = 10
    VlissSpectatorList[tm] = vgui.Create("DPanelList", VlissSpectatorList)
    VlissSpectatorList[tm]:SetPos(0, 0)
    VlissSpectatorList[tm]:Dock(TOP)
    VlissSpectatorList[tm]:SetTall(60)
    VlissSpectatorList[tm].team = tm
    VlissSpectatorList[tm].rows = 0
    VlissSpectatorList[tm].Paint = function(self, w, h) end

    VlissSpectatorList:AddItem(VlissSpectatorList[tm])
end

-----------------------------------------------------------------
-- [ LAYOUT TEAMS : STANDARD ]
-----------------------------------------------------------------

function PANEL:LayoutTeams(tm, rm)

    if rm then
        if IsValid(VlissPlayerList[tm]) then
            VlissPlayerList[tm]:Remove( )
        end
        return
    end

    if tm and not IsValid(VlissPlayerList[tm]) then
        self:MakeTeamPanel(tm)
        return
    end

    if ttt.Enabled then
        for g = 1, cfg.general.hide_spectators and 3 or 4 do
            self:MakeTeamPanel(g)
        end
        self:LayoutPlayersTTTMode( )
        return
    end

    for k, v in pairs(team.GetAllTeams( )) do
        if table.Count(team.GetPlayers(k)) == 0 or (cfg.general.hide_spectators and (k == TEAM_SPECTATOR or k == TEAM_SPEC)) then
            if IsValid( VlissPlayerList ) and VlissPlayerList[ k ] then
                VlissPlayerList[ k ]:Remove( )
            end
            continue
        end
        self:MakeTeamPanel(k)
    end

    self:LayoutPlayers( )

end

-----------------------------------------------------------------
-- [ TTT TEAMS ]
-----------------------------------------------------------------

local TTTNames = { }
TTTNames[1] = "Terrorists"
TTTNames[2] = "Missing in Action"
TTTNames[3] = "Dead"
TTTNames[4] = "Spectators"

-----------------------------------------------------------------
-- [ GENERATE TEAM NAMES ]
-----------------------------------------------------------------

function PANEL:MakeTeamName(k)

    VlissPlayerList[k].teamname = vgui.Create("DPanel", VlissPlayerList[k])
    VlissPlayerList[k].teamname:SetTall(20)
    VlissPlayerList[k].teamname:Dock(TOP)

    if ColumnStyleMatch then
        VlissPlayerList[k].teamname:DockMargin(0,0,0,0)
    else
        VlissPlayerList[k].teamname:DockMargin(35,0,0,0)
    end

    local name = "Unknown"
    if team.GetName(k) then
        name = team.GetName(k) .. " (" ..  VlissPlayerList[k].rows .. ")"
    elseif base.TeamNames and base.TeamNames[team.GetName(k)] then
        name = base.TeamNames[team.GetName(k)]
    end

    if ttt.Enabled then
        name = TTTNames[k] .. " (" ..  VlissPlayerList[k].rows .. ")"
    end

    surface.SetFont("VlissFontCloseGUI")
    local sizex, _ = surface.GetTextSize(name)
    VlissPlayerList[k].teamname:SetWide(sizex + 10)

    VlissPlayerList[k].teamname.Paint = function(self, w, h)

        if ttt.Enabled and TTTNames[k] then
            name = TTTNames[k] .. " (" ..  VlissPlayerList[k].rows .. ")"
        end

        draw.VlissBox(0, 0, w, h, cfg.general.clrs.team_row )
        draw.DrawText(name, "VlissFontCloseGUI", 5, 3, color_white, TEXT_ALIGN_LEFT)
    end
    VlissPlayerList[k]:AddItem(VlissPlayerList[k].teamname)

end

-----------------------------------------------------------------
-- [ LAYOUT PLAYERS : TTT GAMEMODE ]
-----------------------------------------------------------------

function PANEL:LayoutPlayersTTTMode( )

    for g = 1, cfg.general.hide_spectators and 3 or 4 do
        if IsValid(VlissPlayerList[g]) then
            VlissPlayerList[g]:Clear( )
            VlissPlayerList[g].rows = 0
            self:MakeTeamName(g)
        else
            self:MakeTeamPanel(g)
        end
    end

    for k, v in pairs(player.GetAll( )) do
        if not IsValid(v) then continue end
        local group = ScoreGroup(v)

        if cfg.general.hide_spectators and (v:Team( ) == TEAM_SPECTATOR) then
            if IsValid(VlissPlayerList[group]) then VlissPlayerList[group]:Remove( ) end
            continue
        end

        local row = vgui.Create("vliss_playerrow", VlissPlayerList[group])
        row.ply = v
        row:SetSize(VlissPlayerList[group]:GetWide( ), 40)
        row:SetPlayer(v)
        VlissPlayerList[group]:AddItem(row)
        VlissPlayerList[group].rows = VlissPlayerList[group].rows and VlissPlayerList[group].rows + 1 or 1
    end

    for r = 1, cfg.general.hide_spectators and 3 or 4 do
        if !IsValid(VlissPlayerList[r]) then continue end
        VlissPlayerList[r]:SetTall(20 + ( ( VlissPlayerList[r].rows or 0 ) * 40))
        if ttt.ShowUsedTeamsOnly and VlissPlayerList[r].rows < 1 then VlissPlayerList[r]:Remove( ) end
    end
end

-----------------------------------------------------------------
-- [ LAYOUT PLAYERS : MURDER GAMEMODE ]
-----------------------------------------------------------------

function PANEL:LayoutPlayersMurderMode( )
    if IsValid(VlissSpectatorList) then VlissSpectatorList:Clear( ) end
    self.SortedPlayers = { }

    for k, v in ipairs(player.GetAll( )) do
        self.SortedPlayers[k] = v
    end

    local sortSpecs = cfg.Column.DefaultOrder
    table.sort(self.SortedPlayers, sortSpecs)

    for k, v in ipairs(self.SortedPlayers) do
        if IsValid(v) and (v:Team( ) ~= TEAM_CONNECTING) then
            if v:Team( ) == 2 then continue end
            local row = vgui.Create("vliss_playerrow")
            row.ply = v
            row:SetSize(VlissSpectatorList:GetWide( ), 40)
            row:SetPos(0, 0)
            row:SetPlayer(v)
            row:SetParent(VlissSpectatorList)
            VlissSpectatorList:AddItem(row)
        end
    end
end

-----------------------------------------------------------------
-- [ LAYOUT PLAYERS : PROPHUNT GAMEMODE ]
-----------------------------------------------------------------

function PANEL:LayoutPlayersProphuntMode( )
    if IsValid(VlissSpectatorList) then VlissSpectatorList:Clear( ) end
    self.SortedPlayers = { }

    for k, v in ipairs(player.GetAll( )) do
        self.SortedPlayers[k] = v
    end

    local sortSpecs = cfg.Column.DefaultOrder
    table.sort(self.SortedPlayers, sortSpecs)

    for k, v in ipairs(self.SortedPlayers) do
        if IsValid(v) and (v:Team( ) ~= TEAM_CONNECTING) then
            if v:Team( ) == ph.TeamProps then
                local row = vgui.Create("vliss_playerrow")
                row.ply = v
                row:SetSize(VlissSpectatorList:GetWide( ), 40)
                row:SetPos(0, 0)
                row:SetPlayer(v)
                row:SetParent(VlissSpectatorList)
                VlissSpectatorList:AddItem(row)
            end
        end
    end
end

-----------------------------------------------------------------
-- [ LAYOUT PLAYERS : PROPHUNT GAMEMODE ]
-----------------------------------------------------------------

function PANEL:LayoutPlayersZSurvivalMode( )
    if IsValid(VlissSpectatorList) then VlissSpectatorList:Clear( ) end
    self.SortedPlayers = { }

    for k, v in ipairs(player.GetAll( )) do
        self.SortedPlayers[k] = v
    end

    local sortSpecs = cfg.Column.DefaultOrder
    table.sort(self.SortedPlayers, sortSpecs)

    for k, v in ipairs(self.SortedPlayers) do
        if IsValid(v) and (v:Team( ) ~= TEAM_CONNECTING) then
            if v:Team( ) == zs.TeamUndead then
                local row = vgui.Create("vliss_playerrow")
                row.ply = v
                row:SetSize(VlissSpectatorList:GetWide( ), 40)
                row:SetPos(0, 0)
                row:SetPlayer(v)
                row:SetParent(VlissSpectatorList)
                VlissSpectatorList:AddItem(row)
            end
        end
    end
end

-----------------------------------------------------------------
-- [ LAYOUT PLAYERS : DEATHRUN GAMEMODE ]
-----------------------------------------------------------------

function PANEL:LayoutPlayersDeathrunMode( )
    if IsValid(VlissSpectatorList) then VlissSpectatorList:Clear( ) end
    self.SortedPlayers = { }

    for k, v in ipairs(player.GetAll( )) do
        self.SortedPlayers[k] = v
    end

    local sortSpecs = cfg.Column.DefaultOrder
    table.sort(self.SortedPlayers, sortSpecs)

    for k, v in ipairs(self.SortedPlayers) do
        if IsValid(v) and (v:Team( ) ~= TEAM_CONNECTING) then
            if v:Team( ) == dr.TeamRunner then
                local row = vgui.Create("vliss_playerrow")
                row.ply = v
                row:SetSize(VlissSpectatorList:GetWide( ), 40)
                row:SetPos(0, 0)
                row:SetPlayer(v)
                row:SetParent(VlissSpectatorList)
                VlissSpectatorList:AddItem(row)
            end
        end
    end
end

-----------------------------------------------------------------
-- [ LAYOUT PLAYERS : STANDARD ]
-----------------------------------------------------------------

function PANEL:LayoutPlayers( )
    if not IsValid( VlissPlayerList ) then return end

    self.SortedPlayers = { }

    for k, v in pairs(team.GetAllTeams( )) do
        if not IsValid(VlissPlayerList[k]) and table.Count(team.GetPlayers(k)) > 0 then
            self:LayoutTeams(k)
            continue
        end

        if table.Count(team.GetPlayers(k)) == 0 or (cfg.general.hide_spectators and k == TEAM_SPECTATOR) then
            self:LayoutTeams(k, true)
            continue
        end

        VlissPlayerList[k]:Clear( )
        self:MakeTeamName(k)
        VlissPlayerList[k].rows = 0

        for _k, _v in pairs(team.GetPlayers(k)) do
            if not IsValid(_v) then continue end
            if _v:Team( ) == TEAM_CONNECTING then continue end
            if cfg.general.hide_spectators and (_v:Team( ) == 1) then continue end
            local row = vgui.Create("vliss_playerrow", VlissPlayerList[k])
            row.ply = _v
            row:SetSize(VlissPlayerList[k]:GetWide( ), 40)
            row:SetPlayer(_v)
            VlissPlayerList[k]:AddItem(row)
            VlissPlayerList[k].rows = VlissPlayerList[k].rows and VlissPlayerList[k].rows + 1 or 1
        end

        VlissPlayerList[k]:SetTall(20 + (VlissPlayerList[k].rows * 40))
    end
end

function PANEL:Paint( w, h )
    draw.VlissBox( 0, 0, w, 40, Color(255, 255, 255, 255 ) )
end

concommand.Add("vliss_settings", function( )
    if not LocalPlayer( ):IsSuperAdmin( ) then return end
    vgui.Create( "vliss_settings" )
end )

vgui.Register("vliss_scoreboard", PANEL, "EditablePanel")