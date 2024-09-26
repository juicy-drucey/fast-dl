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
*   materials
*/

local m_btn_close           = 'vliss/vliss_btn_close.png'
local m_ico_dead            = 'vliss/vliss_plystatus_dead.png'
local m_ico_mute            = 'vliss/vliss_btn_speakmute.png'
local m_ico_unmute          = 'vliss/vliss_btn_speakenabled.png'
local m_ico_profile         = 'vliss/vliss_btn_steam.png'
local m_ico_act_cid         = 'vliss/vliss_btn_copy.png'
local m_ico_act_cip         = 'vliss/vliss_btn_ipaddress.png'

/*
*   declare > panel
*/

local PANEL = { }

/*
*   Init
*/

function PANEL:Init( )

    self.cols                       = { }
    self.sandboxlabels              = { }

    self:SetText                    ( ''                                    )
    /*
    self:Dock                       ( TOP                                   )
    self:DockMargin                 ( 0, 0, 0, 0                            )
    */

    self.av                         = vgui.Create( 'AvatarImage', self      )
    self.av:SetSize                 ( 32, 32                                )
    self.av:SetPos                  ( 4, 4                                  )
    self.av:Dock                    ( LEFT                                  )
    self.av:DockMargin              ( 3, 3, 3, 3                            )

    self.b_pic                      = vgui.Create( 'DButton', self          )
    self.b_pic:SetSize              ( 34, 34                                )
    self.b_pic:SetPos               ( 3, 3                                  )
    self.b_pic:SetText              ( ''                                    )
    self.b_pic:DockMargin           ( 3, 3, 3, 3                            )
    self.b_pic:Dock                 ( LEFT                                  )

    self.b_av                       = vgui.Create( 'DButton', self          )
    self.b_av:SetText               ( ''                                    )
    self.b_av:SetSize               ( 32, 32                                )
    self.b_av:SetPos                ( 2, 2                                  )
    self.b_av.Paint                 = function( ) end

    self.rank                       = vgui.Create( 'DLabel', self           )
    self.rank:SetVisible            ( false                                 )

    self.name_real                  = vgui.Create( 'DLabel', self           )
    self.name_fake                  = vgui.Create( 'DLabel', self           )
    self.ratio                      = vgui.Create( 'DLabel', self           )

    if cfg.Column.bKillSkull and ( ph.Enabled or dr.Enabled ) then
        self.healthstatus           = vgui.Create( 'DButton', self          )
        self.healthstatus:SetText   ( ''                                    )
        self.healthstatus.Paint     = function( )
                                        local is_dead = Material(m_ico_dead, 'noclamp smooth')
                                        if IsValid(self.ply) and not self.ply:Alive( ) then
                                            surface.SetDrawColor            ( cfg.Column.KillSkullColor or Color( 255, 255, 255, 255 ) )
                                            surface.SetMaterial             ( is_dead )
                                            surface.DrawTexturedRect        ( 0, 0, 22, 22 )
                                        end
                                    end
    end

    if not mu.Enabled and not ph.Enabled and not zs.Enabled then
        if cfg.Column.PingEnabled then
            self:AddColumn          ( ln.ping, function( ply ) return '' end )
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

            self:AddColumn( v.name, v.func, v.width, v.clr_txt_res, v.specialColor, v.bIsDeath, v.bIsMute, rset )
        end
    end

end

/*
*   AddColumn
*/

function PANEL:AddColumn( label, func, width, textcolor, special, bIsDeath, bIsMute, rset )
    self.cols                       = self.cols or { }

    local lbl                       = vgui.Create( 'DLabel', self )
    lbl.GetPlayerText               = func
    lbl.GetSpecial                  = special
    lbl.bIsDeath                    = bIsDeath
    lbl.bIsMute                     = bIsMute
    lbl.IsHeading                   = false
    lbl.rset                        = rset
    lbl.Width                       = width or 55

    lbl:SetFont                     ( 'vliss_sb_column_ply' )
    lbl:SetTextColor                ( textcolor or Color( 255, 255, 255, 255 ) )
    lbl.Paint                       = function( s, w, h )

                                    end

    table.insert( self.cols, lbl )

    return lbl
end


/*
*   SetPlayer
*/

function PANEL:SetPlayer( pl )

    if not IsValid( pl ) then return end

    local admin = LocalPlayer( )

    self.av:SetPlayer( pl )

    for i = 1, #self.cols do
        self.cols[ i ]:SetText( self.cols[ i ].GetPlayerText(pl, self.cols[ i ] ) )

        if self.cols[ i ].bIsDeath then
            local is_dead                   = Material( m_ico_dead, 'noclamp smooth' )
            self.AliveStatus                = vgui.Create( 'DPanel', self.cols[ i ] )
            self.AliveStatus:Dock           ( FILL )
            self.AliveStatus.Paint          = function(self, w, h)
                                                if IsValid(pl) and not pl:Alive( ) and ttt.Enabled then
                                                    local group                 = ScoreGroup(pl)
                                                                                if group ~= 3 then return end

                                                    surface.SetDrawColor        ( cfg.Column.KillSkullColor or Color( 255, 255, 255, 255 ) )
                                                    surface.SetMaterial         ( is_dead )
                                                    surface.DrawTexturedRect    ( 0, 0, 22, 22 )
                                                elseif IsValid(pl) and not pl:Alive( ) and !ttt.Enabled then
                                                    surface.SetDrawColor        ( cfg.Column.KillSkullColor or Color( 255, 255, 255, 255 ) )
                                                    surface.SetMaterial         ( is_dead )
                                                    surface.DrawTexturedRect    ( 0, 0, 22, 22 )
                                                end
                                            end
        end

        if self.cols[ i ].bIsMute then
            self.b_pl_mute                  = vgui.Create( 'DButton', self.cols[ i ] )
            self.b_pl_mute:Dock             ( FILL                                  )
            self.b_pl_mute:SetSize          ( 64, 64                                )
            self.b_pl_mute:SetText          ( ''                                    )
            self.b_pl_mute.Paint            = function( s, w, h )
                                                if not IsValid( pl ) or not pl:IsPlayer( ) then return end
                                                local plyMuteStatus = Material('vliss/vliss_btn_speakenabled.png', 'noclamp smooth')
                                                if pl:IsMuted( ) then
                                                    plyMuteStatus = Material('vliss/vliss_btn_speakmute.png', 'noclamp smooth')
                                                end

                                                surface.SetDrawColor        ( cfg.Column.KillSkullColor or Color( 255, 255, 255, 255 ) )
                                                surface.SetMaterial         ( plyMuteStatus )
                                                surface.DrawTexturedRect    ( 11, 4, 18, 18 )

                                                if s:IsHovered( ) then
                                                    surface.SetDrawColor    ( Color( 255, 255, 2, 255 ) )
                                                    surface.DrawRect        ( 0, 0, w, h )
                                                end
                                            end

        end

        if self.cols[ i ].GetSpecial and rp.Enabled then
            if rp.JobTextTeamColor then
                self.cols[ i ]:SetTextColor( self.cols[ i ].GetSpecial( pl, self.cols[ i ] ) )
            else
                self.cols[ i ]:SetTextColor( cfg.general.clrs.pl_row_txt )
            end
            if rp.JobColorBar then
                local barTeamColor          = self.cols[ i ].GetSpecial( pl, self.cols[ i ] )
                self.TeamBar                = vgui.Create( 'DPanel', self.cols[ i ] )
                self.TeamBar:Dock           ( FILL )
                self.TeamBar.Paint          = function( s, w, h )
                                                draw.RoundedBox( 0, 0, 0, w, 2, Color( barTeamColor.r, barTeamColor.g, barTeamColor.b, barTeamColor.a ) )
                                            end
            end
        end
    end

    self.b_av.DoClick = function( )
        if not IsValid( pl ) then return end
        pl:ShowProfile( )
    end

    local pl_name                   = pl:Nick( )
    pl_name                         = cfg.dev.simulate[ pl_name:lower( ) ] and cfg.dev.simulate[ pl_name:lower( ) ].name or pl_name

    local pl_group                  = handle:GroupTitle( pl )

    /*
    *   gm > murder
    */

    if mu.Enabled then
    	self.ratio:SetVisible(false)
        if pl:GetBystanderName( ) and pl:Team( ) == 2 then
            self.name_fake:SetText( pl:GetBystanderName( ) )
            if handle:HasGMPerm( mu, 'allow_see_realname', admin ) then
                self.name_real:SetText( pl_name )
                self.name_real:SetVisible(true)
                self.name_real:SetContentAlignment( 6 )
            else
                self.name_real:SetVisible(false)
            end
            if cfg.spiffyav.enable then
                self.av:SetVisible(false)
                self.b_pic:SetVisible(true)
            else
                self.name_fake:DockMargin( 5, 0, 0, 0)
                self.av:SetVisible(false)
                self.b_pic:SetVisible(false)
            end
        else
            self.name_fake:SetText( pl_name )
            self.name_real:SetVisible(false)
            self.av:SetVisible(true)
            self.b_pic:SetVisible(false)
        end

    /*
    *   gm > prophunt
    */

	elseif ph.Enabled then
        self.name_fake:SetText      ( pl_name                               )
        self.name_fake:DockMargin   ( 5, 0, 0, 0                            )
        self.rank:SetText           ( pl_group                              )
    	self.rank:SetVisible        ( true                                  )
        self.ratio:SetText          ( pl:Frags( ) .. ':' .. pl:Deaths( )    )
        self.ratio:SetContentAlignment( 6                                   )
        self.name_real:SetVisible   ( false                                 )
        if cfg.spiffyav.enable then
            self.b_pic:SetVisible   ( true                                  )
            self.av:SetVisible      ( false                                 )
        else
            self.b_pic:SetVisible   ( false                                 )
            self.av:SetVisible      ( true                                  )
        end

    /*
    *   gm > deathrun
    */

    elseif dr.Enabled then
        self.name_fake:SetText      ( pl_name                               )
        self.rank:SetText           ( pl_group                              )
        self.rank:SetVisible        ( true                                  )
    	self.ratio:SetVisible       ( true                                  )
        self.ratio:SetText          ( pl:Frags( ) .. ':' .. pl:Deaths( )    )
        self.name_real:SetVisible   ( false                                 )
        if cfg.spiffyav.enable then
            self.b_pic:SetVisible   ( true                                  )
            self.av:SetVisible      ( false                                 )
        else
            self.b_pic:SetVisible   ( false                                 )
            self.av:SetVisible      ( true                                  )
        end

    /*
    *   gm > zombie survival
    */

    elseif zs.Enabled then
        self.name_fake:SetText      ( pl_name                               )
        self.name_fake:DockMargin   ( 5, 0, 0, 0                            )
        self.rank:SetVisible        ( false                                 )
        self.ratio:SetText          ( pl:Frags( )                           )
        self.ratio:SetContentAlignment( 6                                   )
        self.name_real:SetVisible   ( false                                 )
        if cfg.spiffyav.enable then
            self.b_pic:SetVisible   ( true                                  )
            self.av:SetVisible      ( false                                 )
        else
            self.b_pic:SetVisible   ( false                                 )
            self.av:SetVisible      ( true                                  )
        end

    /*
    *   gm > others
    */

    else
        self.name_fake:SetText      ( pl_name                               )
        self.ratio:SetVisible       ( false                                 )
        self.name_real:SetVisible   ( false                                 )

        if cfg.dev.bDevMode then
            self.av:SetVisible      ( false                                 )
            self.b_pic:SetVisible   ( true                                  )
        else
            self.av:SetVisible      ( cfg.spiffyav.enable and false or true )
            self.b_pic:SetVisible   ( cfg.spiffyav.enable and true or false )
        end
    end

    self.name_fake:SetTextColor     ( cfg.general.clrs.pl_row_txt           )
    self.name_fake:SetFont          ( 'vliss_sb_pl_name_fake'               )

    self.ratio:SetTextColor         ( cfg.general.clrs.pl_row_txt           )
    self.ratio:SetFont              ( 'vliss_sb_pl_ratio'                   )
    self.ratio:SetWide              ( 110                                   )

    self.name_real:SetTextColor     ( cfg.general.clrs.pl_row_txt_alt       )
    self.name_real:SetFont          ( 'vliss_sb_pl_name_real'               )
    self.name_real:SetWide          ( 165                                   )

    self.column                     = { }
    self:LayoutColumns              ( )
    self.bg                         = Color( 38, 38, 38, 255 )

end

/*
*   LayoutColumns
*/

function PANEL:LayoutColumns( )

    local cx    = self:GetWide( )
    local oset  = 0
    cx          = cx + 25

    if not mu.Enabled then
        for k, v in ipairs( self.cols ) do
            cx          = cx - v.Width
            local ofs   = v.bIsMute and 0 or oset
            local roset = v.rset or 0

            v:SizeToContents( )
            if v.GetSpecial and rp.JobColorBar then
                v:SetPos    ( cx - v:GetWide( ) / 2 - ofs + roset, 11  )
            else
                v:SetPos    ( cx - v:GetWide( ) / 2 - ofs + roset, 11  )
            end
            if v.bIsDeath then
                v:SetPos    ( cx - v:GetWide( ) / 2, 11  )
                v:SetTall   ( 60                        )
            else
                v:SetPos    ( cx - v:GetWide( ) / 2 - ofs + roset, 11  )
            end
            if v.bIsMute then
                v:SetPos    ( cx - v:GetWide( ) / 2, 7  )
                v:SetTall   ( 60                        )
            else
                v:SetPos    ( cx - v:GetWide( ) / 2 - ofs + roset, 11  )
            end
        end
    end
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )

    if ph.Enabled or dr.Enabled then
        self.name_fake:SetPos           ( 45, 3                             )
        self.name_fake:SizeToContents   (                                   )
        self.rank:SetPos                ( 46, 19                            )
        self.rank:SetWide               ( 180                               )
    else
        self.name_fake:Dock             ( LEFT                              )
        self.name_fake:DockMargin       ( 5, 0, 0, 0                        )
        self.name_fake:SizeToContents   (                                   )
    end

    if cfg.Column.bKillSkull and ( ph.Enabled or dr.Enabled ) then
        local pos                       = ( ( ph.Enabled or dr.Enabled ) and RIGHT ) or LEFT
        self.healthstatus:Dock          ( pos                               )
        self.healthstatus:DockMargin    ( 0, 9, 0, 0                        )
        self.healthstatus:SizeToContents(                                   )
        self.healthstatus:SetSize       ( 22, 22                            )
    end

    self.ratio:Dock                     ( RIGHT                             )
    self.ratio:DockMargin               ( 0, 0, 60, 0                       )

    self.name_real:Dock                 ( RIGHT                             )
    self.name_real:DockMargin           ( 0, 0, 10, 0                       )
end

-----------------------------------------------------------------
-- [ PANEL:PAINT ]
-----------------------------------------------------------------

function PANEL:Paint( w, h )
    local ply                       = self.ply
                                    if not IsValid( ply ) then return end

    if not ply.VlissAvatarImage then
        local av_lst                = table.Random( cfg.spiffyav.list )
        local av_img                = Material( av_lst, 'noclamp smooth' )
        ply.VlissAvatarImage        = av_img
    end

    if ply.VlissAvatarImage then
        self.b_pic.Paint = function( )
            local av_def                = Material( 'vliss/avatars/vliss_avatar1.png', 'noclamp smooth' )
            surface.SetDrawColor        ( cfg.Column.KillSkullColor or Color( 255, 255, 255, 255 ) )
            surface.SetMaterial         ( ply.VlissAvatarImage or av_def )
            surface.DrawTexturedRect    ( 0, 0, 34, 34 )
        end
    end

    if cfg.general.team_coloring then
        if not IsValid( self.ply ) then return end

        local col = team.GetColor( self.ply:Team( ) )

        if ttt.Enabled then
            local group = ScoreGroup( self.ply )

            if group == 1 then
                col = ttt.ColorTerrorist or Color(25, 200, 25, 200)
            elseif group == 2 then
                col = ttt.ColorMIA or Color(130, 190, 130, 200)
            elseif group == 3 then
                col = ttt.ColorDead or Color(130, 170, 10, 200)
            elseif group == 4 then
                col = ttt.ColorSpec or Color(200, 200, 0, 200)
            end

            if self.ply:IsDetective( ) then
                col = ttt.ColorDetective or Color(25, 25, 200, 200)
            elseif self.ply:IsTraitor( ) then
                col = ttt.ColorTraitor or Color(200, 25, 25, 200)
            end
        end

        draw.VlissOutlinedBox(0, 0, w, h, Color(col.r, col.g, col.b, col.a) or Color(5, 5, 5, 220), Color(15, 15, 15, 100))
    elseif cfg.groups.bColorsEnabled then
        local col = handle:GroupColor( self.ply )

        draw.VlissOutlinedBox( 0, 0, w, h, Color(col.r, col.g, col.b, col.a) or Color(5, 5, 5, 220), Color(15, 15, 15, 255 ) )

        if cfg.general.bRow_filter then
            draw.RoundedBox( 0, 0, 0, w, h, cfg.general.clrs.pl_row_filter )
        end
    else
        draw.VlissOutlinedBox( 0, 0, w, h, Color( 5, 5, 5, 220 ), Color(15, 15, 15, 100 ) )
    end

    if not mu.Enabled or ( mu.Enabled and ply:Team( ) ~= 2 ) then

        if not cfg.Column.PingEnabled then return end

        local ping              = ply:Ping( ) or 0
        local name              = ply:Name( ):lower( )
        ping                    = cfg.dev.simulate[ name ] and cfg.dev.simulate[ name ].ping or ping

        local pingx, pingy      = self:GetWide( )
        pingx, pingy            = pingx - 40, 16

        if ply:IsValid( ) then
            if ping < 100 then
                draw.RoundedBox( 0, pingx, pingy + 8, 4, 4, Color( 0, 255, 0, 255 ) )
                draw.RoundedBox( 0, pingx + 5, pingy + 4, 4, 8, Color( 0, 255, 0, 255 ) )
                draw.RoundedBox( 0, pingx + 10, pingy, 4, 12, Color( 0, 255, 0, 255 ) )
            elseif ping < 225 then
                draw.RoundedBox( 0, pingx, pingy + 8, 4, 4, Color( 255, 255, 0, 255 ) )
                draw.RoundedBox( 0, pingx + 5, pingy + 4, 4, 8, Color( 255, 255, 0, 255 ) )
                draw.RoundedBox( 0, pingx + 10, pingy, 4, 12, Color( 155, 155, 155, 255 ) )
            else
                draw.RoundedBox( 0, pingx, pingy + 8, 4, 4, Color( 255, 0, 0, 255 ) )
                draw.RoundedBox( 0, pingx + 5, pingy + 4, 4, 8, Color( 155, 155, 155, 255 ) )
                draw.RoundedBox( 0, pingx + 10, pingy, 4, 12, Color( 155, 155, 155, 255 ) )
            end
            draw.SimpleText( ping, 'VlissFontCloseGUI', pingx + 17, pingy + cfg.Column.PingHeight or 0, cfg.general.clrs.pl_row_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        end

    end

end

-----------------------------------------------------------------
-- [ PANEL:DOSCOREBOARDACTIONPOPUP ]
-----------------------------------------------------------------

function PANEL:DoSecondaryMenuPanel( ply )

    local PlayerlistMenu = DermaMenu( )
    if not IsValid( ply ) then return end
    if not IsValid( LocalPlayer( ) ) then return end

    local admin         = LocalPlayer( )

    -----------------------------------------------------------------
    -- [OPTION] : DarkRP Money
    -----------------------------------------------------------------

    if rp.Enabled and ply:getDarkRPVar( 'money' ) then
         self.OptionTitle           = DarkRP.formatMoney( ply:getDarkRPVar( 'money' ) ) or 0
         self.OptionDarkrpMoney     = PlayerlistMenu:AddOption( self.OptionTitle )
         self.OptionDarkrpMoney:SetIcon( 'icon16/money.png' )

         PlayerlistMenu:AddSpacer( )
     end

    -----------------------------------------------------------------
    -- [OPTION] : Mute/unmute player
    -----------------------------------------------------------------

    if ply ~= admin then
        self.OptionTitleMute = ln.mute_player
        if ply:IsMuted( ) then
            self.OptionTitleMute = ln.unmute_player
        end
        self.OptionMute = PlayerlistMenu:AddOption( self.OptionTitleMute )
        self.OptionMute:SetIcon('icon16/sound_mute.png')
        function self.OptionMute:DoClick( )
            if IsValid( ply ) then ply:SetMuted( not ply:IsMuted( ) ) end
        end
        PlayerlistMenu:AddSpacer( )
    end

    -----------------------------------------------------------------
    -- [OPTION] : Copy Information
    -----------------------------------------------------------------

    if cfg.perms.is_staff[ string.lower( admin:GetUserGroup( ))] or admin:IsSuperAdmin( ) then

        net.Start                   ( 'VlissPlayerIP' )
        net.WriteEntity             ( ply )
        net.SendToServer            ( )

        net.Receive('VlissPlayerIP', function( )
            local ent = net.ReadString( )
            local ip = net.ReadString( )
            VlissFetchIPFiltered = tostring(string.sub(tostring(ip), 1, string.len(tostring(ip)) - 6))
        end )

        if VlissFetchIPFiltered and ply:SteamID( ) and ply:SteamID64( ) then
            self.OptionInformation, InformationCategory = PlayerlistMenu:AddSubMenu( ln.information )
            InformationCategory:SetIcon('icon16/information.png')

            if ply:IsPlayer( ) and IsValid(ply) and not ply:IsBot( ) and (cfg.perms.is_staff[string.lower( admin:GetUserGroup( ))] and cfg.perms.pl_get_sid[string.lower(LocalPlayer( ):GetUserGroup( ))]) or (LocalPlayer( ):IsSuperAdmin( )) then
                self.OptionInformation:AddOption( '[' .. ln.steam32 .. '] ' .. ply:SteamID( ), function( )
                    SetClipboardText(ply:SteamID( ))
                end )
            end

            if ply:IsPlayer( ) and IsValid(ply) and not ply:IsBot( ) and (cfg.perms.is_staff[string.lower( admin:GetUserGroup( ))] and cfg.perms.pl_get_sid[string.lower(LocalPlayer( ):GetUserGroup( ))]) or (LocalPlayer( ):IsSuperAdmin( )) then
                self.OptionInformation:AddOption( '[' .. ln.steam64 .. '] ' .. ply:SteamID64( ), function( )
                    SetClipboardText(ply:SteamID64( ))
                end )
            end

            if ply:IsPlayer( ) and IsValid(ply) and not ply:IsBot( ) and (cfg.perms.is_staff[string.lower( admin:GetUserGroup( ))] and cfg.perms.pl_get_ip[string.lower(LocalPlayer( ):GetUserGroup( ))]) or (LocalPlayer( ):IsSuperAdmin( )) then
                self.OptionInformation:AddOption( '[' .. ln.ip_address .. '] ' .. VlissFetchIPFiltered, function( )
                    SetClipboardText(VlissFetchIPFiltered)
                end )
            end
        end

    end

    if rp.Enabled and FAdmin and (FAdmin.Access.PlayerHasPrivilege( admin, 'SetAccess') or admin:IsSuperAdmin( )) then
        self.OptionSetAccess, AccessCategory = PlayerlistMenu:AddSubMenu( ln.set_access )
        AccessCategory:SetIcon('icon16/user_go.png')
        for k,v in SortedPairsByMemberValue(FAdmin.Access.Groups, 'ADMIN', true) do
            self.OptionSetAccess:AddOption(k, function( )
                if not IsValid(ply) then return end
                RunConsoleCommand('_FAdmin', 'setaccess', ply:UserID( ), k)
            end )
        end
    end

    if rp.Enabled and FAdmin and (FAdmin.Access.PlayerHasPrivilege( admin, 'SetTeam') or admin:IsSuperAdmin( )) then
        self.OptionSetTeam, TeamsCategory = PlayerlistMenu:AddSubMenu( ln.set_team )
        TeamsCategory:SetIcon( 'icon16/group.png' )
        for k, v in SortedPairsByMemberValue( team.GetAllTeams( ), 'Name' ) do
            local uid = ply:UserID( )
            self.OptionSetTeam:AddOption( v.Name, function( ) RunConsoleCommand( '_FAdmin', 'setteam', uid, k ) end )
        end

        PlayerlistMenu:AddSpacer( )
    end

    -----------------------------------------------------------------
    -- [OPTION] : Manage tab admin scripts (Ulx, Evolve, etc)
    -----------------------------------------------------------------
    -- [Admin Support]
    -----------------------------------------------------------------
    --      -> ULX
    --      -> Evolve
    --      -> FAdmin
    -----------------------------------------------------------------

    if (cfg.perms.is_staff[string.lower( admin:GetUserGroup( ))] or admin:IsSuperAdmin( )) then

        self.OptionManage, ManageCategory = PlayerlistMenu:AddSubMenu( ln.manage )
        ManageCategory:SetIcon('icon16/wand.png')

        PlayerlistMenu:AddSpacer( )

        local tab = (ULib and base.cmds.Ulx) or (evolve and base.cmds.Evolve) or { }
        local cmd = (ULib and 'ulx') or (evolve and 'ev') or 'wtfnoadminmod'

        for k, v in pairs( tab ) do
            self.OptionManage:AddOption( v.name, function( )
                if not admin:IsAdmin( ) then return end
                admin:ConCommand(cmd .. ' ' .. v.cmd .. ' \'' .. ply:Nick( ) .. '\'')
            end )
        end

    end

    -----------------------------------------------------------------
    -- [OPTION] [MURDER MODE] : Misc commands for gamemode
    -----------------------------------------------------------------
    --      Show Identity
    --      Move to Team
    --      Force Murderer Next Round
    --      Spectate Player
    -----------------------------------------------------------------

    if mu.Enabled and ply:Team( ) == 2 then

        if handle:HasGMPerm( mu, 'allow_see_realname', admin ) then
            self.ButtonOptionShowIdentity = PlayerlistMenu:AddOption( ln.show_identity )
            self.ButtonOptionShowIdentity:SetIcon( 'icon16/vcard.png' )
            function self.ButtonOptionShowIdentity:DoClick( )
                RunConsoleCommand('vliss_showidentity', ply:EntIndex( ))
            end
        end

        if handle:HasGMPerm( mu, 'allow_move_player', admin ) then
            self.ButtonOptionMovePlayer = PlayerlistMenu:AddOption( ln.move_to_spectators )
            self.ButtonOptionMovePlayer:SetIcon( 'icon16/status_busy.png' )
            function self.ButtonOptionMovePlayer:DoClick( )
                RunConsoleCommand('mu_movetospectate', ply:EntIndex( ))
            end
        end

        if handle:HasGMPerm( mu, 'allow_force_murderer', admin ) then
            self.ButtonOptionForceMurderer = PlayerlistMenu:AddOption( ln.force_murderer_next_round )
            self.ButtonOptionForceMurderer:SetIcon( 'icon16/delete.png' )
            function self.ButtonOptionForceMurderer:DoClick( )
                RunConsoleCommand('mu_forcenextmurderer', ply:EntIndex( ))
            end
        end

        if handle:HasGMPerm( mu, 'allow_spectate', admin ) and ply:Alive( ) then
            self.ButtonOptionSpectate = PlayerlistMenu:AddOption( ln.spectate_player )
            self.ButtonOptionSpectate:SetIcon( 'icon16/status_online.png' )
            function self.ButtonOptionSpectate:DoClick( )
                RunConsoleCommand('mu_spectate', ply:EntIndex( ))
            end
        end

    end

    -----------------------------------------------------------------
    -- [OPTION] [PROPHUNT MODE] : Misc commands for gamemode
    -----------------------------------------------------------------

    if ph.Enabled then
        if ( handle:HasGMPerm( ph, 'allow_move_player', admin ) ) and ( ply:Team( ) == ph.TeamHunters ) then
            self.ButtonOptionMovePlayer = PlayerlistMenu:AddOption( ln.move_to_props )
            self.ButtonOptionMovePlayer:SetIcon( 'icon16/status_busy.png' )
            function self.ButtonOptionMovePlayer:DoClick( )
                RunConsoleCommand('vliss_forcemovetoteam', ply:EntIndex( ), ph.TeamProps)
            end

        elseif ( handle:HasGMPerm( ph, 'allow_move_player', admin ) ) and ( ply:Team( ) == ph.TeamProps ) then

            self.ButtonOptionMovePlayer = PlayerlistMenu:AddOption( ln.move_to_hunters )
            self.ButtonOptionMovePlayer:SetIcon( 'icon16/status_busy.png' )
            function self.ButtonOptionMovePlayer:DoClick( )
                RunConsoleCommand('vliss_forcemovetoteam', ply:EntIndex( ), ph.TeamHunters)
            end
        end
    end

    -----------------------------------------------------------------
    -- [OPTION] : Transfer to Server
    -----------------------------------------------------------------

    if handle:HasPerm( 'pl_xfer', admin ) and ply:IsPlayer( ) and IsValid( ply )  then
        self.OptionXfer, AccessServers = PlayerlistMenu:AddSubMenu( ln.transfer_to_server )
        AccessServers:SetIcon('icon16/arrow_undo.png')
        for k, v in pairs( cfg.servers.list ) do
            self.OptionXfer:AddOption(v.hostname, function( )
                net.Start           ( 'VlissActionPlayerXfer'   )
                net.WriteEntity     ( ply                       )
                net.WriteString     ( v.ip                      )
                net.WriteString     ( v.hostname                )
                net.SendToServer    (                           )
            end )
        end
    end

    PlayerlistMenu:Open( )

end

-----------------------------------------------------------------
-- [ PANEL:DOCLICK ]
-----------------------------------------------------------------
-- If a player row is clicked, this will determine what
-- actions to perform on that player.
-----------------------------------------------------------------

function PANEL:DoClick( )

    local pl                = self.ply
    local ply               = pl
    local admin             = LocalPlayer( )

    if rp.Enabled and FAdmin then FAdmin.ScoreBoard.Player.Player = ply end
    if not IsValid( pl ) then return end

    local sboard = GetScoreboardPanel( )

    if IsValid(Vliss_PanelPlayer) then Vliss_PanelPlayer:Remove( ) end

    VlissPlayerList:SetSize( sboard.w - 10, sboard.h - 278 )
    if mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled then
        VlissSpectatorList:SetSize( sboard.w - 10, sboard.h - 278 )
        if not Vliss_PanelAltContainer:IsVisible( ) then Vliss_PanelAltContainer:SetVisible(true) end
    end

    if !mu.Enabled and !ph.Enabled and !zs.Enabled and !dr.Enabled and IsValid(Vliss_PanelInnerBottom) then
        Vliss_PanelPlayer = vgui.Create('DPanel', Vliss_PanelInnerBottom)
    elseif (mu.Enabled or ph.Enabled or zs.Enabled or dr.Enabled) and IsValid(Vliss_PanelAltContainer) then
        Vliss_PanelPlayer = vgui.Create('DPanel', Vliss_PanelAltContainer)
    end

    -----------------------------------------------------------------
    -- [ PLAYER PANEL ]
    -----------------------------------------------------------------
    -- Actual container for each player when clicked. Provides
    -- actions to perform on that player.
    -----------------------------------------------------------------

    Vliss_PanelPlayer:SetWide( sboard.w - 205 )
    Vliss_PanelPlayer:Dock( BOTTOM )
    Vliss_PanelPlayer:SetTall( 100 )
    Vliss_PanelPlayer.UpdatePlayerData = function( ) end
    Vliss_PanelPlayer.SetOpen = function( ) end
    Vliss_PanelPlayer:InvalidateLayout( )
    Vliss_PanelPlayer.Paint = function( s, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, cfg.acts.clrs.pnl_main )
    end
    Vliss_PanelPlayer.Think = function( s )
        if not IsValid( pl ) then s:Remove( ) end
    end

    self.PanelContainer = vgui.Create('DPanel', Vliss_PanelPlayer)
    self.PanelContainer:Dock(FILL)
    self.PanelContainer:DockMargin( 5, 5, 5, 5 )
    self.PanelContainer.Paint = function( s, w, h )

    end

    if ttt.Enabled then
        if not self.info then
            local g = ScoreGroup(pl)
            if g == GROUP_TERROR and pl ~= LocalPlayer( ) then
                self.info               = vgui.Create('TTTScorePlayerInfoTags', Vliss_PanelPlayer)
                self.info:SetWide       ( 600                               )
                self.info:SetPlayer     ( pl                                )
                self.info:SetPos        ( -50, 38                           )
            elseif g == GROUP_FOUND or g == GROUP_NOTFOUND then
                self.info = vgui.Create('TTTScorePlayerInfoSearch', Vliss_PanelPlayer)
                self.info:SetPlayer     ( pl                                )
                self.info:SetPos        ( 200, 0                            )
                self.info:SetSize       ( 500, self.info:GetTall( )         )
                self:InvalidateLayout   (                                   )
            end
        else
            self:InvalidateLayout( )
        end
    end

    -----------------------------------------------------------------
    -- [ MURDER MODE ]
    -----------------------------------------------------------------
    -- Different avatar setup.
    -- If player on team 'Player' (team 2)
    --      [x] Generate random avatar to others can't tell who it is.
    -- If player on team 'Spectator' (team 1)
    --      [x] Show player's normal avatar. No need to hide.
    -- If player is not in murder mode, then display normal avatar.
    -----------------------------------------------------------------
    -- Yes. This code needs to be cleaned up. Was in a rush with
    -- updates. Def needs optimized.
    -----------------------------------------------------------------

    if mu.Enabled then

        if pl:Team( ) == 2 then

            self.ct_pl_av               = vgui.Create( 'DButton', self.PanelContainer )
            self.ct_pl_av:SetSize       ( 64, 64                            )
            self.ct_pl_av:SetText       ( ''                                )
            self.ct_pl_av:Dock          ( LEFT                              )
            self.ct_pl_av:DockMargin    ( 3, 3, 3, 3                        )

            if not pl.VlissAvatarImage then
                local av_lst      = table.Random( cfg.spiffyav.list ) or 'vliss/avatars/vliss_avatar_1.png'
                local av_img    = Material( av_lst, 'noclamp smooth' )
                pl.VlissAvatarImage     = av_img
            end

            self.ct_pl_av.Paint = function( )
                surface.SetDrawColor    ( cfg.Column.KillSkullColor or Color(255,255,255,255 ) )
                surface.SetMaterial     ( pl.VlissAvatarImage )
                surface.DrawTexturedRect( 0, 0, 64, 64 )
            end

        else

            self.ct_pl_av               = vgui.Create( 'AvatarImage', self.PanelContainer )
            self.ct_pl_av:SetSize       ( 64, 64                            )
            self.ct_pl_av:Dock          ( LEFT                              )
            self.ct_pl_av:DockMargin    ( 3, 3, 3, 3                        )
            self.ct_pl_av:SetPlayer     ( pl, 64                            )

        end

    else

        self.ct_pl_av                   = vgui.Create( 'AvatarImage', self.PanelContainer )
        self.ct_pl_av:SetSize           ( 64, 64                            )
        self.ct_pl_av:SetPlayer         ( pl, 64                            )
        self.ct_pl_av:SetPos            ( 2, 2                              )

    end

    /*
    *   info box
    */

    self.ct_ibox                        = vgui.Create( 'DPanel', self.PanelContainer )
    self.ct_ibox:Dock                   ( LEFT                              )
    self.ct_ibox:DockMargin             ( 5, 0, 0, 0                        )
    self.ct_ibox:SetWide                ( 300                               )
    self.ct_ibox.Paint                  = function( ) end

    /*
    *   info box > player name
    */

    local pl_name                       = ( mu.Enabled and pl:Team( ) == 2 and pl:GetBystanderName( ) ) or pl:Nick( )
    pl_name                             = cfg.dev.simulate[ pl_name:lower( ) ] and cfg.dev.simulate[ pl_name:lower( ) ].name or pl_name
    local pl_money                      = DarkRP and DarkRP.formatMoney(pl:getDarkRPVar( 'money' )) or 0
    local pos_name                      = mu.Enabled and 0 or 68

    self.lb_pl_name                     = vgui.Create( 'DLabel', self.ct_ibox )
    self.lb_pl_name:SetPos              ( pos_name, 0                       )
    self.lb_pl_name:SetFont             ( 'vliss_slmenu_pl_name'            )
    self.lb_pl_name:SetWide             ( 200                               )
    self.lb_pl_name:SetTall             ( 24                                )
    self.lb_pl_name:SetText             ( pl_name                           )
    self.lb_pl_name:SetTextColor        ( cfg.slmenu.clrs.pl_name           )

    /*
    *   info box > player money
    *
    *   rp gamemode only
    */

    if rp.Enabled then

        surface.SetFont                 ( 'vliss_slmenu_pl_name' )
        local sz_name_w, _              = surface.GetTextSize( pl_name )
        sz_name_w                       = sz_name_w + 5

        local clr_txt                   = cfg.slmenu.clrs.pl_money

        self.lb_pl_money                = vgui.Create( 'DLabel', self.ct_ibox )
        self.lb_pl_money:SetPos         ( pos_name + sz_name_w, 0           )
        self.lb_pl_money:SetFont        ( 'vliss_slmenu_pl_money'           )
        self.lb_pl_money:SetColor       ( clr_txt                           )
        self.lb_pl_money:SetWide        ( 100                               )
        self.lb_pl_money:SetTall        ( 24                                )
        self.lb_pl_money:SetText        ( ''                                )
        self.lb_pl_money.Paint          = function( s, w, h )
                                            draw.SimpleText( pl_money, 'vliss_slmenu_pl_money', 0, h / 2 + 2, clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        end
    end

    -----------------------------------------------------------------
    -- [ DARKRP MODE ]
    -----------------------------------------------------------------
    -- If DarkRP mode enabled - display FAdmin system
    -----------------------------------------------------------------

    if rp.Enabled and FAdmin then

        local ButtonActionW             = rp.FAdminActions.ButtonActionW or 300
        local ButtonActionH             = rp.FAdminActions.ButtonActionH or 25
        local ButtonLabelW              = ButtonActionW - 10
        local ButtonNormalColor         = rp.FAdminActions.ButtonNormalColor or Color(64, 105, 126, 190)
        local ButtonHoverColor          = rp.FAdminActions.ButtonHoverColor or Color(64, 105, 126, 240)
        local ButtonToggledColor        = rp.FAdminActions.ButtonToggledColor or Color(4, 80, 4, 190)
        local ButtonToggledHoverColor   = rp.FAdminActions.ButtonToggledHoverColor or Color(4, 80, 4, 240)

        self.ct_fa_acts                 = vgui.Create( 'DPanel', self.PanelContainer )
        self.ct_fa_acts:SetSize         ( rp.FAdminActions.ButtonActionW, rp.FAdminActions.ButtonContainerH or 100 )
        self.ct_fa_acts:Dock            (FILL)
        self.ct_fa_acts.Paint           = function( ) end

        self.lo_fa_acts                 = vgui.Create('DIconLayout', self.ct_fa_acts)
        self.lo_fa_acts:Dock            ( FILL                              )
        self.lo_fa_acts:DockMargin      ( 7, 5, 0, 0                        )
        self.lo_fa_acts:SetSpaceY       ( 5                                 )
        self.lo_fa_acts:SetSpaceX       ( 5                                 )

        for k, v in pairs( base.cmds.DarkRP ) do

            if not v.bEnabled then continue end
            if not FAdmin.Access.PlayerHasPrivilege( LocalPlayer( ), v.perm, pl ) then continue end

            self.ButtonOptionShowIdentity = self.lo_fa_acts:Add('Button')
            self.ButtonOptionShowIdentity:SetSize(ButtonActionW, ButtonActionH)
            self.ButtonOptionShowIdentity:SetText('')

            local l_item = vgui.Create('DLabel', self.ButtonOptionShowIdentity)
            l_item:Dock(RIGHT)
            l_item:DockMargin(5,5,5,5)
            l_item:SetFont('VlissFontSandboxItemLabel')
            l_item:SetTextColor(mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
            if v.chk_state and ply:FAdmin_GetGlobal(v.chk_state) then
                l_item:SetText(v.rev_name)
                self.ButtonOptionShowIdentity.Paint = function( s, w, h )
                    local color = ButtonToggledColor
                    if s:IsHovered( ) or s:IsDown( ) then
                        color = ButtonToggledHoverColor
                    end
                    draw.RoundedBox( 4, 0, 0, w, h, color )
                end
            else
                l_item:SetText( v.for_name )
                self.ButtonOptionShowIdentity.Paint = function( s, w, h )
                    local color = ButtonNormalColor
                    if s:IsHovered( ) or s:IsDown( ) then
                        color = ButtonHoverColor
                    end
                    draw.RoundedBox( 4, 0, 0, w, h, color )
                end
            end

            l_item:SetSize( ButtonLabelW, ButtonActionH )

            function self.ButtonOptionShowIdentity:DoClick( )
                if (v.chk_state and not v.bSpecial) then
                    if not ply:FAdmin_GetGlobal(v.chk_state) then
                        RunConsoleCommand( '_FAdmin', v.for_cmd, pl:UserID( ) )
                        l_item:SetText(v.rev_name)
                        self.Paint = function( s, w, h )
                            local color = ButtonToggledColor
                            if s:IsHovered( ) or s:IsDown( ) then
                                color = ButtonToggledHoverColor
                            end
                            draw.RoundedBox(4, 0, 0, w, h, color)
                        end
                    else
                        RunConsoleCommand('_FAdmin', v.rev_cmd, pl:UserID( ))
                        l_item:SetText(v.for_name)
                        self.Paint = function( s, w, h )
                            local color = ButtonNormalColor
                            if s:IsHovered( ) or s:IsDown( ) then
                                color = ButtonHoverColor
                            end
                            draw.RoundedBox( 4, 0, 0, w, h, color )
                        end
                    end
                elseif (v.IsSeparate) then
                    RunConsoleCommand(v.for_cmd, pl:UserID( ))
                else
                    RunConsoleCommand('_FAdmin', v.for_cmd, pl:UserID( ))
                end
            end

        end


    elseif sb.Enabled then

        self.sb_ct_cnts = vgui.Create( 'DPanel', self.PanelContainer )
        self.sb_ct_cnts:SetSize( 550, 100 )
        self.sb_ct_cnts:Dock(LEFT)
        self.sb_ct_cnts.Paint = function( ) end

        self.sb_lo_cnts = vgui.Create('DIconLayout', self.sb_ct_cnts)
        self.sb_lo_cnts:Dock(FILL)
        self.sb_lo_cnts:DockMargin(7, 5, 0, 0)
        self.sb_lo_cnts:SetSpaceY(5)
        self.sb_lo_cnts:SetSpaceX(5)

        for k, v in pairs(sb.CountList) do
            if v.enabled then
                self:AddSandboxLabel(v.name, v.func, v.buttonColor, v.buttonColorHover, v.textColor)
            end
        end

        if istable( self.sandboxlabels ) then
            for i = 1, #self.sandboxlabels do
                local item = self.sandboxlabels[ i ].GetPlayerText(pl, self.sandboxlabels[ i ] )
                self.sandboxlabels[ i ].Paint = function( s, w, h )
                    draw.SimpleText( item, 'VlissFontSandboxItemAmt', w, h / 2, txtColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                end
            end
        end

    end

    -----------------------------------------------------------------
    -- [ MURDER MODE ]
    -- If player is on 'Player' Team - setup special buttons
    -----------------------------------------------------------------
    -- [ ADDITIONAL ADMIN BUTTONS ]
    -----------------------------------------------------------------
    --      Show Identity
    --      Move to Team
    --      Force Murderer Next Round
    --      Spectate Player
    -----------------------------------------------------------------

    if mu.Enabled and pl:Team( ) == 2 then

        local ButtonActionW         = mu.AdminFeatures.ButtonActionW or 100
        local ButtonActionH         = mu.AdminFeatures.ButtonActionH or 25
        local ButtonLabelW          = ButtonActionW - 10
        local ButtonNormalColor     = mu.AdminFeatures.ButtonNormalColor or Color(64, 105, 126, 190)
        local ButtonHoverColor      = mu.AdminFeatures.ButtonHoverColor or Color(64, 105, 126, 240)

        self.ct_gm_mu_acts          = vgui.Create( 'DPanel', self.PanelContainer )
        self.ct_gm_mu_acts:SetSize  ( mu.AdminFeatures.ButtonContainerW or 450, mu.AdminFeatures.ButtonContainerH or 100 )
        self.ct_gm_mu_acts:Dock     ( RIGHT )
        self.ct_gm_mu_acts.Paint    = function( ) end

        self.lo_gm_mu_acts          = vgui.Create('DIconLayout', self.ct_gm_mu_acts)
        self.lo_gm_mu_acts:Dock     ( FILL )
        self.lo_gm_mu_acts:DockMargin( 7, 5, 0, 0 )
        self.lo_gm_mu_acts:SetSpaceY( 5 )
        self.lo_gm_mu_acts:SetSpaceX( 5 )

        -----------------------------------------------------------------
        -- [ MURDER MODE ] Admin Option :: Show Identity
        -----------------------------------------------------------------

        if handle:HasGMPerm( mu, 'allow_see_realname', admin ) then

            self.ButtonOptionShowIdentity = self.lo_gm_mu_acts:Add('Button')
            self.ButtonOptionShowIdentity:SetSize(ButtonActionW, ButtonActionH)
            self.ButtonOptionShowIdentity:SetText('')
            self.ButtonOptionShowIdentity.Paint = function( s, w, h )
                local color = ButtonNormalColor
                if s:IsHovered( ) or s:IsDown( ) then
                    color = ButtonHoverColor
                end

                draw.RoundedBox( 4, 0, 0, w, h, color )
            end
            function self.ButtonOptionShowIdentity.DoClick( )
                RunConsoleCommand('vliss_showidentity', pl:EntIndex( ))
            end

            local l_item = vgui.Create('DLabel', self.ButtonOptionShowIdentity)
            l_item:Dock(RIGHT)
            l_item:DockMargin(5,5,5,5)
            l_item:SetFont('VlissFontSandboxItemLabel')
            l_item:SetTextColor(mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
            l_item:SetText(ln.show_identity)
            l_item:SetSize( ButtonLabelW, ButtonActionH )

        end

        -----------------------------------------------------------------
        -- [ MURDER MODE ] Admin Option :: Move Team
        -----------------------------------------------------------------

        if handle:HasGMPerm( mu, 'allow_move_player', admin ) then
            local btn_moveteam = self.lo_gm_mu_acts:Add('Button')
            btn_moveteam:SetSize(ButtonActionW, ButtonActionH)
            btn_moveteam:SetText('')
            btn_moveteam.Paint = function(self, w, h)
                local color = ButtonNormalColor

                if self:IsHovered( ) or self:IsDown( ) then
                    color = ButtonHoverColor
                end

                draw.RoundedBox(4, 0, 0, w, h, color)
            end
            function btn_moveteam.DoClick( )
                RunConsoleCommand('mu_movetospectate', pl:EntIndex( ))
            end

            local l_item = vgui.Create('DLabel', btn_moveteam)
            l_item:Dock(LEFT)
            l_item:DockMargin(5,5,5,5)
            l_item:SetFont('VlissFontSandboxItemLabel')
            l_item:SetTextColor(mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
            l_item:SetText(ln.move_to_spectators)
            l_item:SetSize( ButtonLabelW, ButtonActionH )
        end

        -----------------------------------------------------------------
        -- [ MURDER MODE ] Admin Option :: Move Team
        -----------------------------------------------------------------

        if (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] and mu.allow_force_murderer[string.lower(LocalPlayer( ):GetUserGroup( ))]) or LocalPlayer( ):IsSuperAdmin( ) then

            local optionForceMurderer = self.lo_gm_mu_acts:Add('Button')
            optionForceMurderer:SetSize(ButtonActionW, ButtonActionH)
            optionForceMurderer:SetText('')
            optionForceMurderer.Paint = function( s, w, h )
                local color = ButtonNormalColor

                if s:IsHovered( ) or s:IsDown( ) then
                    color = ButtonHoverColor
                end

                draw.RoundedBox( 4, 0, 0, w, h, color )
            end
            function optionForceMurderer.DoClick( )
                RunConsoleCommand('mu_forcenextmurderer', pl:EntIndex( ))
            end

            local l_item = vgui.Create('DLabel', optionForceMurderer)
            l_item:Dock(LEFT)
            l_item:DockMargin(5,5,5,5)
            l_item:SetFont('VlissFontSandboxItemLabel')
            l_item:SetTextColor(mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
            l_item:SetText(ln.force_murderer_next_round)
            l_item:SetSize( ButtonLabelW, ButtonActionH )

        end

        /*
        *   MURDER > options
        *
        *   spectate player
        */

        if (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] and mu.allow_spectate[string.lower(LocalPlayer( ):GetUserGroup( ))]) or LocalPlayer( ):IsSuperAdmin( ) then
            local b_spec = self.lo_gm_mu_acts:Add('Button')
            b_spec:SetSize(ButtonActionW, ButtonActionH)
            b_spec:SetText('')
            b_spec.Paint = function( s, w, h )
                local color = ButtonNormalColor

                if s:IsHovered( ) or s:IsDown( ) then
                    color = ButtonHoverColor
                end

                draw.RoundedBox(4, 0, 0, w, h, color)
            end
            function b_spec.DoClick( )
                RunConsoleCommand('mu_spectate', pl:EntIndex( ))
            end

            local l_item = vgui.Create('DLabel', b_spec)
            l_item:Dock(LEFT)
            l_item:DockMargin(5,5,5,5)
            l_item:SetFont('VlissFontSandboxItemLabel')
            l_item:SetTextColor(mu.AdminFeatures.ButtonTextColor or Color(255, 255, 255, 255))
            l_item:SetText(ln.spectate_player)
            l_item:SetSize( ButtonLabelW, ButtonActionH )
        end

    end

    local b_acts_pos_rp_h           = 72

    /*
    *   actions > mute
    */

    local b_mute = vgui.Create('DButton', Vliss_PanelPlayer)
    b_mute:SetText('')
    b_mute:SetSize(28, 28)
    if rp.Enabled and FAdmin then
        b_mute:SetPos( 5, b_acts_pos_rp_h )
    else
        b_mute:SetPos( 80, 39 )
    end
    b_mute.Paint = function(self, w, h)
        local playerMuted       = Material( m_ico_mute, 'noclamp smooth' )
        local playerUnmuted     = Material( m_ico_unmute, 'noclamp smooth' )

        if pl ~= LocalPlayer( ) and pl:IsPlayer( ) and IsValid(pl) then
            if pl:IsMuted( ) then
                surface.SetDrawColor(Color(255, 255, 255, 255))
                surface.SetMaterial(playerMuted)
                surface.DrawTexturedRect(3, 7, 17, 17)
                b_mute:SetTooltip(ln.unmute_player)
            else
                surface.SetDrawColor(Color(255, 255, 255, 255))
                surface.SetMaterial(playerUnmuted)
                surface.DrawTexturedRect(3, 7, 17, 17)
                b_mute:SetTooltip(ln.mute_player)
            end
        else
            surface.SetDrawColor(Color(255, 255, 255, 25))
            surface.SetMaterial(playerUnmuted)
            surface.DrawTexturedRect(3, 7, 17, 17)
            b_mute:SetTooltip(ln.disabled)
        end

        if self:IsHovered( ) or self:IsDown( ) then
            color = clr_btn_h
            txtColor = clr_txt_h
        end
    end

    b_mute.DoClick = function( )
        if IsValid(pl) then
            pl:SetMuted(not pl:IsMuted( ))
        end
    end

    /*
    *   actions > player profile
    *
    *   [ MURDER ]
    *   profile link will ONLY be clickable if the viewer is staff, they
    *   have permissions within vliss.core.is_staff or mu.AllowPlayerViewProfile is set to true.
    */

    local b_profile = vgui.Create('DButton', Vliss_PanelPlayer)
    b_profile:SetText('')
    b_profile:SetSize(28, 28)
    if rp.Enabled and FAdmin then
        b_profile:SetPos( 35, b_acts_pos_rp_h )
    else
        b_profile:SetPos( 110, 39 )
    end
    b_profile:SetTooltip(ln.view_steam_profile)
    b_profile.Paint = function( self, w, h )
        local m_prof        = Material(m_ico_profile, 'noclamp smooth')
        local clr_ico       = ( self:IsHovered( ) and Color( 255, 255, 255, 100 ) ) or Color( 255, 255, 255, 255 )

        if !mu.Enabled or (mu.Enabled and mu.AllowPlayerViewProfile) or (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] or LocalPlayer( ):IsSuperAdmin( )) then
            if pl:IsPlayer( ) and IsValid(pl) and not pl:IsBot( ) then
                surface.SetDrawColor( clr_ico )
                surface.SetMaterial(m_prof)
                surface.DrawTexturedRect(3, 7, 17, 17)
            else
                surface.SetDrawColor(Color(255, 255, 255, 25))
                surface.SetMaterial(m_prof)
                surface.DrawTexturedRect(3, 7, 17, 17)
            end
        else
            surface.SetDrawColor(Color(255, 255, 255, 25))
            surface.SetMaterial(m_prof)
            surface.DrawTexturedRect(3, 7, 17, 17)
            b_profile:SetTooltip(ln.disabled)
        end

        if self:IsHovered( ) or self:IsDown( ) then
            color = clr_btn_h
            txtColor = clr_txt_h
        end
    end

    if (mu.Enabled and mu.AllowPlayerViewProfile) or (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] or LocalPlayer( ):IsSuperAdmin( )) or (!mu.Enabled) then
        b_profile.DoClick = function( )
            if IsValid(pl) then
                pl:ShowProfile( )
            end
        end
    end

    /*
    *   actions > copy steamid
    */

    local b_csid = vgui.Create('DButton', Vliss_PanelPlayer)
    b_csid:SetText('')
    b_csid:SetSize(28, 28)
    if rp.Enabled and FAdmin then
        b_csid:SetPos( 65, b_acts_pos_rp_h )
    else
        b_csid:SetPos( 140, 39 )
    end
    b_csid:SetTooltip(ln.copy_player_steamid)
    b_csid.Paint = function(self, w, h)
        local m_copy    = Material(m_ico_act_cid, 'noclamp smooth')
        local clr_ico   = ( self:IsHovered( ) and Color( 255, 255, 255, 100 ) ) or Color( 255, 255, 255, 255 )

        if pl:IsPlayer( ) and IsValid(pl) and not pl:IsBot( ) and (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] and cfg.perms.pl_get_sid[string.lower(LocalPlayer( ):GetUserGroup( ))]) or (LocalPlayer( ):IsSuperAdmin( )) then
            surface.SetDrawColor( clr_ico )
            surface.SetMaterial(m_copy)
            surface.DrawTexturedRect(3, 7, 17, 17)
        else
            surface.SetDrawColor(Color(255, 255, 255, 25))
            surface.SetMaterial(m_copy)
            surface.DrawTexturedRect(3, 7, 17, 17)
        end
    end

    b_csid.DoClick = function( )
        if pl:IsPlayer( ) and IsValid(pl) and not pl:IsBot( ) and (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] and cfg.perms.pl_get_sid[string.lower(LocalPlayer( ):GetUserGroup( ))]) or (LocalPlayer( ):IsSuperAdmin( )) then
            SetClipboardText(pl:SteamID( ))
        end
    end

    /*
    *   actions > copy ip address
    */

    local b_cip = vgui.Create('DButton', Vliss_PanelPlayer)
    b_cip:SetText('')
    b_cip:SetSize(28, 28)
    if rp.Enabled and FAdmin then
        b_cip:SetPos( 95, b_acts_pos_rp_h )
    else
        b_cip:SetPos( 170, 39 )
    end
    b_cip:SetTooltip( ln.copy_player_ip_address )
    b_cip.Paint = function( self, w, h )
        local m_copy        = Material(m_ico_act_cip, 'noclamp smooth')
        local clr_ico       = ( self:IsHovered( ) and Color( 255, 255, 255, 100 ) ) or Color( 255, 255, 255, 255 )

        if pl:IsPlayer( ) and IsValid(pl) and not pl:IsBot( ) and (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] and cfg.perms.pl_get_ip[string.lower(LocalPlayer( ):GetUserGroup( ))]) or (LocalPlayer( ):IsSuperAdmin( )) then
            surface.SetDrawColor( clr_ico )
            surface.SetMaterial(m_copy)
            surface.DrawTexturedRect(3, 7, 17, 17)
        else
            surface.SetDrawColor(Color(255, 255, 255, 25))
            surface.SetMaterial(m_copy)
            surface.DrawTexturedRect(3, 7, 17, 17)
        end
    end

    b_cip.DoClick = function( )
        if pl:IsPlayer( ) and not pl:IsBot( ) and (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] and cfg.perms.pl_get_ip[string.lower(LocalPlayer( ):GetUserGroup( ))]) or (LocalPlayer( ):IsSuperAdmin( )) then
            net.Receive('VlissPlayerIP', function( )
                local ent = net.ReadString( )
                --if not IsValid(ent) then return end
                local ip = net.ReadString( )
                local plyIPFiltered = tostring(string.sub(tostring(ip), 1, string.len(tostring(ip)) - 6))
                SetClipboardText(plyIPFiltered)
            end )

            net.Start('VlissPlayerIP')
            net.WriteEntity(pl)
            net.SendToServer( )
        end
    end

    if not rp.Enabled or ( rp.Enabled and not FAdmin ) then

        self.Commands = vgui.Create('DIconLayout', Vliss_PanelPlayer)
        self.Commands:Dock(BOTTOM)
        self.Commands:SetTall(30)
        self.Commands.Paint = function( s, w, h )
            draw.RoundedBox(0, 0, 0, w, h, cfg.slmenu.clrs.pnl_deny )
            surface.SetDrawColor(base.core.CBoxLineColor or Color( 255, 255, 255, 255 ))
            surface.DrawLine(0, 0, w, 0)
            draw.DrawText( ln.no_additional_access, 'VlissFontServerInfo', 5, 5, base.core.CBoxTextColor or Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
        end

        if (cfg.perms.is_staff[string.lower(LocalPlayer( ):GetUserGroup( ))] or LocalPlayer( ):IsSuperAdmin( )) and (evolve or ULib) then

            self.Commands.Paint = function(self, w, h)
                draw.RoundedBox( 0, 0, 0, w, h, cfg.slmenu.clrs.pnl_allow )
                surface.SetDrawColor( cfg.general.clrs.separator )
                surface.DrawLine( 0, 0, w, 0 )
                draw.DrawText( ln.commands, 'VlissFontServerInfo', 5, 5, base.core.CBoxTextColor or Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
            end

            local tab = (ULib and base.cmds.Ulx) or (evolve and base.cmds.Evolve) or (Exsto and base.cmds.Exsto) or { }
            local cmd = (ULib and 'ulx') or (evolve and 'ev') or (exsto and 'exsto') or 'wtfnoadminmod'

            for k, v in pairs( tab ) do
                self.b_cmd = vgui.Create( 'DButton', self.Commands )
                self.b_cmd:SetText('')
                self.b_cmd:SetFont('VlissFontServerInfo')
                self.b_cmd:Dock(RIGHT)
                self.b_cmd:DockMargin( 0, 0, 5, 0 )
                self.b_cmd.DoClick = v.clickfunc or function( s )
                    LocalPlayer( ):ConCommand( cmd .. ' ' .. v.cmd .. ' \'' .. pl:Nick( ) .. '\'' )
                end
                self.b_cmd.Paint = function( s, w, h )
                    surface.SetFont('VlissFontServerInfo')
                    local color = Color(255, 255, 255, 255)

                    if s:IsHovered( ) or s:IsDown( ) then
                        color = Color( 50, 150, 255, 255 )
                    end

                    draw.DrawText(v.name, 'VlissFontServerInfo', w / 2, 5, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    surface.SetTextColor( Color( 255, 255, 255, 255 ) )
                end

                local sizex, _ = surface.GetTextSize( v.name )
                self.b_cmd:SetWide( sizex + 20 )
            end
        end

    end

    /*
    *   player panel > close
    */

    self.b_close = vgui.Create('DButton', Vliss_PanelPlayer)
    self.b_close:SetColor(base.core.CBoxCloseButtonColor or Color( 255, 255, 255, 255 ))
    self.b_close:SetFont('VlissFontCloseGUI')
    self.b_close:Dock(RIGHT)
    self.b_close:SetText('')
    self.b_close:SetSize(32, 32)
    self.b_close.Paint = function( s, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 37, 37, 37, 255 ) )

        surface.SetDrawColor        ( base.core.CBoxCloseButtonColor or Color( 255, 255, 255, 255 ) )
        surface.SetMaterial         ( Material( m_btn_close ) )
        surface.DrawTexturedRect    ( 0, 10, 16, 16 )
    end
    self.b_close.DoClick = function( )
        if not IsValid( Vliss_PanelPlayer ) then return end

        Vliss_PanelPlayer:MoveTo( 0, Vliss_PanelPlayer:GetWide( ) - 30, 1, 0, 2 )

        timer.Create( 'PanelPlayer_SlideDown', 0.5, 1, function( )
            Vliss_PanelPlayer:Remove( )
            VlissPlayerList:SetSize( sboard.w - 10, sboard.h - 170 )
            if mu.Enabled then
                if IsValid(Vliss_PanelAltContainer) then
                    Vliss_PanelAltContainer:SetVisible(false)
                end
                Vliss_PanelAltContainer:InvalidateParent( )
                VlissSpectatorList:SetSize( sboard.w - 10, sboard.h - 170 )
            end
        end )
    end

end

-----------------------------------------------------------------
-- [ SANDBOX MODE - ADD SANDBOX LABEL ]
-----------------------------------------------------------------
-- Adds each item that needs to be counted. IE: Sents, Props,
-- NPCs, Vehicles, etc.
-----------------------------------------------------------------

function PANEL:AddSandboxLabel( label, func, buttonColor, buttonColorH, textColor )
    self.sandboxlabels              = self.sandboxlabels or { }

    local b_item                    = self.sb_lo_cnts:Add( 'Button' )
    b_item:SetSize                  ( 70, 25                                )
    b_item:SetText                  ( ''                                    )
    b_item.Paint                    = function( s, w, h )
                                        local color = buttonColor or Color( 25, 25, 25, 200 )

                                        if s:IsHovered( ) or s:IsDown( ) then
                                            color = buttonColorH or Color( 35, 35, 35, 200 )
                                        end

                                        draw.RoundedBox( 4, 0, 0, w, h, color )
                                    end

    local l_item                    = vgui.Create( 'DLabel', b_item         )
    l_item:Dock                     ( LEFT                                  )
    l_item:DockMargin               ( 5, 5, 5, 5                            )
    l_item:SetFont                  ( 'VlissFontSandboxItemLabel'           )
    l_item:SetTextColor             ( textColor or Color(255, 255, 255, 255))
    l_item:SetText                  ( label                                 )

    local lbl                       = vgui.Create( 'DLabel', b_item         )
    lbl:Dock                        ( RIGHT                                 )
    lbl:DockMargin                  ( 5, 5, 5, 5                            )
    lbl:SetText                     ( ''                                    )
    lbl:SetTextColor                ( textColor or Color(255, 255, 255, 255))
    lbl:SetFont                     ( 'VlissFontSandboxItemAmt'             )
    lbl.IsHeading                   = false
    lbl.GetPlayerText               = func

    table.insert( self.sandboxlabels, lbl )

    return lbl
end

-----------------------------------------------------------------
-- [ RIGHT CLICK ACTION ]
-----------------------------------------------------------------
-- Launches Secondary Menu when panel of each player has been
-- right clicked on. Conditional gamemode options available
-- within PANEL:DoSecondaryMenuPanel
-----------------------------------------------------------------
-- [ NOTE ] : vliss.cmds.SecondaryMenuEnabled MUST BE
-- ENABLED FOR THE PANEL IT WORK.
-----------------------------------------------------------------

function PANEL:DoRightClick( )
    local pl        = self.ply
                    if not IsValid(pl) then return end

    local sboard    = GetScoreboardPanel( )
    self:DoSecondaryMenuPanel(pl)

end

-----------------------------------------------------------------
-- [ VGUI.REGISTER ]
-----------------------------------------------------------------

vgui.Register( 'vliss_playerrow', PANEL, 'DButton' )