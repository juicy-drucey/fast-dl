/*
*   @package        : rcore
*   @module         : arivia
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2015 - 2021
*   @website        : https://rlib.io
*   @docs           : https://arivia.rlib.io
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

local base                  = rlib
local access                = base.a
local helper                = base.h
local design                = base.d
local ui                    = base.i
local mats                  = base.m
local cvar                  = base.v

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   Localized translation func
*/

local function ln( ... )
    return base:translate( mod, ... )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return base.get:pref( str, state )
end

/*
*   panel
*/

local PANEL = { }

/*
*   initialize
*/

function PANEL:Init( )

    /*
    *   parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :fill                           (                                       )

    /*
    *   sub
    */

    self.p_sub                      = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 10, 0                         )

    /*
    *   sub > body
    */

    self.ct_body                    = ui.new( 'pnl', self.p_sub, 1          )
    :fill                           ( 'm', 10, 5, 10, 5                     )

    /*
    *   stats > container
    */

    self.ct_section                 = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 20, 10, 20, 10                   )

    /*
    *   stats > name
    */

    self.ct_name                    = ui.new( 'pnl', self.ct_section, 1     )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'staff_sect_name' ), pref( 'staff_sect_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   stats > header
    */

    self.ct_header                  = ui.new( 'pnl', self.ct_section, 1     )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   stats > body
    */

    self.ct_body                    = ui.new( 'pnl', self.ct_section, 1     )
    :fill                           ( 'm', 0, 15, 0, 0                      )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_pnl_icon_lg' ), w, h - 50, self.clr_ico_acc , TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   icon layout
    */

    self.list                       = ui.new( 'dico', self.ct_body          )
    :fill                           ( 'm', 0, 0, 0                          )
    :pos                            ( 0, 0                                  )
    :spacing                        ( 5, 5                                  )

    /*
    *   loop > players
    */

    local src                       = not self.cf_d.unlockall and helper.get.players( ) or helper.get.data( self:PopulateDemo( ) )

    local i = 0
    for v in src do

        /*
        *   check > not staff
        */

        if not self.cf_d.unlockall and not cfg.ugroups.staff[ v:getgroup( true ) ] then continue end

        /*
        *   declare
        */

        local pl_alias              = helper.str:truncate( not self.cf_d.unlockall and v:palias( ) or v.name, 20 )
        local pl_grp                = not self.cf_d.unlockall and v:getgroup( true ) or v.group
        local pl_grp_name           = cfg.ugroups.titles[ pl_grp ] or ln( 'staff_type_usr' )
        local pl_grp_clr            = cfg.ugroups.clrs[ pl_grp ]
        local sz_sec_width          = ui:SmartScaleH( true, 1, 2, 3, 3, 4, 4, 5, 5 )
        local sz_sec_w              = self:GetParent( ):GetWide( )
        local m_tip                 = ( self.cf_d.unlockall or v:IsBot( ) and ln( 'staff_tip_bot' ) ) or ln( 'staff_tip_usr' )
        local clr_hover             = Color( 30, 30, 30, 255 )

        /*
        *   icon layout > container
        */

        self.list.ct                = ui.new( 'btn', self.list              )
        :bsetup                     (                                       )
        :sz                         ( ( sz_sec_w / sz_sec_width ) - ( 60 / sz_sec_width ), 64 )
        :anim_click_ol              ( Color( 255, 255, 255, 5 ), 0.4, 1, self.cf_d.bDisableAnim )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, pl_grp_clr )
                                        design.rbox( 5, 1, 1, w - 2, h - 2, clr_hover )
                                    end )

        /*
        *   icon layout > avatar
        */

        self.sub                    = ui.new( 'pnl', self.list.ct, 1        )
        :fill                       ( 'm', 5                                )

        /*
        *   icon layout > avatar
        */

        self.avatar                 = ui.new( 'av', self.sub                )
        :left                       ( 'm', 0, 0, 0, 0                       )
        :wide                       ( 53                                    )
        :ply                        ( v, 45                                 )

        /*
        *   right
        */

        self.ct_r                   = ui.new( 'pnl', self.sub, 1            )
        :fill                       ( 'm', 0                                )

        /*
        *   right > top
        */

        self.ct_r_t                 = ui.new( 'pnl', self.ct_r              )
        :fill                       ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( pl_alias, pref( 'staff_card_pl_name' ), 10, h / 2 - 13, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( pl_grp_name, pref( 'staff_card_pl_rank' ), 10, h / 2 + 13, Color( pl_grp_clr.r, pl_grp_clr.g, pl_grp_clr.b, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *   icon layout > steam profile
        */

        self.b_steam                = ui.new( 'btn', self.ct_r_t            )
        :bsetup                     (                                       )
        :fill                       ( 'm', 0                                )
        :tip                        ( m_tip                                 )
        :anim_click_ol              ( Color( 255, 255, 255, 10 ), 0.4, 1, self.cf_d.bDisableAnim )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            local a	    = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                            a		    = math.Clamp( a, 0, 140 )

                                            clr_hover   = Color( 20, 20, 20, a )
                                        else
                                            clr_hover   = Color( 31, 31, 31, 255 )
                                        end
                                    end )

                                    :oc( function( s )
                                        if helper.ok.ply( v ) then v:ShowProfile( ) end
                                    end )

        i = i + 1

    end

    /*
    *   servers
    */

    self.ct_serv_par                = ui.new( 'pnl', self, 1                )
    :bottom                         ( 'm', 0                                )
    :tall                           ( 48                                    )

    /*
    *   pnl > servers
    */

    self.ct_serv_sub                = ui.rlib( mod, 'pnl_servers', self.ct_serv_par, 1 )
    :fill                           ( 'm', 0                                )
    :register                       ( '$pnl_servers', mod                   )
    :box                            ( self.cf_s.clrs.parent                 )
    :state                          ( cfg.servers.enabled                   )

end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    self.bInitialized = true
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )

    /*
    *   initialize only
    */

    if not self.bInitialized then
        if not ui:ok( self ) then return end
        self:FirstRun( )
    end
end

/*
*   PopulateDemo
*
*   used for demo purposes only
*
*   @return : tbl
*/

function PANEL:PopulateDemo( )

    local pl_list =
    {
        {
            name            = 'Egg McMuffin',
            steamid         = '765611981359XXXXX',
            group           = 'super_admin',
        },
        {
            name            = 'Benny Bucktooth',
            steamid         = '765611981359XXXXX',
            group           = 'admin',
        },
        {
            name            = 'Xivana Xeera',
            steamid         = '765611981359XXXXX',
            group           = 'admin',
        },
        {
            name            = 'Deidré Woohwoo',
            steamid         = '765611981359XXXXX',
            group           = 'supervisor',
        },
        {
            name            = 'Ariana Mocha',
            steamid         = '765611981359XXXXX',
            group           = 'supervisor',
        },
        {
            name            = 'Sarah Fakathot',
            steamid         = '765611981359XXXXX',
            group           = 'operator',
        },
        {
            name            = 'Vinny Viscahbob',
            steamid         = '765611981359XXXXX',
            group           = 'operator',
        },
        {
            name            = 'Paula Pinkfeet',
            steamid         = '765611981359XXXXX',
            group           = 'operator',
        },
        {
            name            = 'David Buminator',
            steamid         = '765611981359XXXXX',
            group           = 'trialmod',
        },
        {
            name            = 'Porky Hartbringer',
            steamid         = '765611981359XXXXX',
            group           = 'gamemaster',
        },
    }

    return pl_list

end

/*
*   GetLabel
*
*   @return : str
*/

function PANEL:GetLabel( )
    return isstring( self.label ) and self.label or ln( 'staff_sect_name' )
end

/*
*   SetLabel
*
*   @param  : str str
*/

function PANEL:SetLabel( str )
    self.label = str
end

/*
*   GetTextTitleColor
*
*   @return : str
*/

function PANEL:GetTextTitleColor( )
    return self.clr_name_txt or self.clr_txt_sec
end

/*
*   SetTextTitleColor
*
*   @param  : clr clr
*/

function PANEL:SetTextTitleColor( clr )
    self.clr_name_txt = clr
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h ) end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *	declare > main configs
    */

    self.cf_u                       = cfg.ui
    self.cf_s                       = cfg.servers
    self.cf_r                       = cfg.rules
    self.cf_d                       = cfg.dev

    /*
    *   declare > colors
    */

    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_ico_sec                = self.cf_u.main.clrs.ico_section
    self.clr_txt_sec                = self.cf_u.main.clrs.txt_section
    self.clr_ico_acc                = self.cf_u.main.clrs.ico_accent

    self.clr_def_txt                = self.cf_u.main.clrs.dt_txt
    self.clr_def_cur                = self.cf_u.main.clrs.dt_cur
    self.clr_def_hl                 = self.cf_u.main.clrs.dt_hl

end

/*
*   register
*/

ui:create( mod, 'pnl_staff', PANEL, 'pnl' )