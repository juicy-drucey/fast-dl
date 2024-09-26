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
local helper                = base.h
local access                = base.a
local storage               = base.s
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
*	localized mat func
*/

local function mat( id )
    return mats:call( mod, id )
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
    :nodraw                         (                                       )
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
                                        draw.SimpleText( '', pref( 'ws_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'ws_sect_name' ), pref( 'ws_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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
    *   body
    */

    self.ct_body                    = ui.new( 'pnl', self.ct_section, 1     )
    :fill                           ( 'm', 0, 15, 0, 0                      )

    /*
    *   icon layout
    */

    self.list                       = ui.new( 'dico', self.ct_body          )
    :fill                           ( 'm', 0, 0, 0                          )
    :pos                            ( 0, 0                                  )
    :spacing                        ( 5, 5                                  )

    /*
    *   icon layout > ws > loop
    */

    for v in helper.get.data( self.cf_d ) do

        /*
        *   check enabled
        */

        if not v.enabled then continue end

        /*
        *   define > ws
        */

        local ws_serv               = string.match( cfg.nav.btn.workshop_url, '=(.*)' )
        local id                    = ( v.bLib and rcore.manifest.workshops and rcore.manifest.workshops[ 1 ] ) or ( v.bScript and storage:Get( mod, 'workshop' ) ) or ( v.bMain and ws_serv ) or v.id

                                    if helper.str:isempty( id ) or id:len( ) < 5 then continue end

        local tip                   = ( v.tip and ln( v.tip ) ) or nil
        local clr_hover             = Color( 30, 30, 30, 255 )
        local clr_box_h             = Color( 255, 255, 255, 0 )
        local clr_box_n             = v.clr or Color( 95, 35, 50, 222 )

        /*
        *   icon layout > ws > parent
        */

        self.list.serv              = ui.add( 'pnl', self.list              )
        :bsetup                     (                                       )
        :sz                         ( 250, self.sz_ico                      )


                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, self.clr_sep )
                                        design.rbox( 5, 1, 1, w - 2, h - 2, clr_hover )
                                    end )

        /*
        *   icon layout > ws > ico
        */

        self.list.ico               = ui.new( 'btn', self.list.serv         )
        :bsetup                     (                                       )
        :left                       ( 'm', 0                                )
        :wide                       ( self.sz_ico                           )
        :anim_click_ol              ( Color( 255, 255, 255, 10 ), 0.4, 1, self.cf_d.bDisableAnim )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            local a	    = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                            a		    = math.Clamp( a, 0, 140 )

                                            clr_box_h   = Color( 20, 20, 20, a )
                                        end

                                        design.rbox( 5, 3, 3, w - 6, h - 6, clr_box_n )
                                        design.rbox( 5, 2, 2, w - 4, h - 4, clr_box_h )
                                        draw.SimpleText( v.ico, pref( 'ws_card_ico' ), w / 2, h / 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        self:OnClickPre( )
                                        local url_pf = string.format( 'https://steamcommunity.com/workshop/filedetails/?id=%s', id )
                                        mod.web:Open( 'mnu_btn_workshop_name', url_pf, cfg.nav.btn.workshop_int or false )
                                    end )

        /*
        *   icon layout > ws > body
        */

        self.list.body              = ui.new( 'pnl', self.list.serv         )
        :fill                       (                                       )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( ln( v.name ), pref( 'ws_card_name' ), 10, h / 2 - 10, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( id, pref( 'ws_card_id' ), 10, h / 2 + 10, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *   icon layout > ws > overlay button
        */

        self.list.btn               = ui.new( 'btn', self.list.body         )
        :bsetup                     (                                       )
        :fill                       ( 'm', 0                                )
        :tip                        ( tip                                   )
        :anim_click_ol              ( Color( 255, 255, 255, 10 ), 0.4, 1, self.cf_d.bDisableAnim )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            local a	    = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                            a		    = math.Clamp( a, 0, 140 )

                                            clr_box_h   = Color( 20, 20, 20, a )
                                        else
                                            clr_box_h   = Color( 255, 255, 255, 0 )
                                        end
                                    end )

                                    :oc( function( s )
                                        self:OnClickPre( )
                                        local url_pf = string.format( 'https://steamcommunity.com/workshop/filedetails/?id=%s', id )
                                        mod.web:Open( 'mnu_btn_workshop_name', url_pf, cfg.nav.btn.workshop_int or false )
                                    end )

    end

    /*
    *   sub > desc > container
    */

    self.ct_desc                    = ui.new( 'pnl', self, 1                )
    :right                          ( 'm', 0, 0, 0, 0                       )
    :wide                           ( 270                                   )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 28, 28, 28, 255 ) )
                                        design.box( 0, 0, 1, h, self.clr_sep )
                                    end )

    /*
    *   sub > desc > container
    */

    self.ct_desc_i                  = ui.new( 'pnl', self.ct_desc, 1        )
    :fill                           ( 'm', 20                               )

    /*
    *   sub > desc > lbl
    */

    self.lb_desc                    = ui.new( 'lbl', self.ct_desc_i, 1      )
    :top                            ( 'm', 0, 0, 0, 20                      )
    :text                           ( ln( 'ws_sect_desc' )                  )
    :clr                            ( self.cf_u.main.clrs.dt_txt            )
    :font                           ( pref( 'ws_sect_desc' )                )
    :wrap                           ( true                                  )
    :autoverticle                   ( true                                  )
    :tall                           ( 150                                   )

    /*
    *   ws > right > icon
    */

    self.note                       = ui.new( 'pnl', self.ct_desc_i         )
    :fill                           ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_pnl_icon_lg' ), w / 2, h / 2, self.clr_ico_acc , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   ws > right > note > name
    */

    self.note_name                  = ui.new( 'pnl', self.note              )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'ws_note_admin_name' ), pref( 'settings_sect_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   ws > right > note > spacer
    */

    self.note_sp                    = ui.new( 'pnl', self.note              )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   ws > right > note > desc
    */

    self.note_desc                  = ui.new( 'lbl', self.note, 1           )
    :top                            ( 'm', 0, 0, 0, 20                      )
    :text                           ( ln( 'ws_note_admin_desc' )            )
    :clr                            ( Color( 255, 255, 255 )                )
    :font                           ( pref( 'ws_sect_desc' )                )
    :wrap                           ( true                                  )
    :autoverticle                   ( true                                  )
    :tall                           ( 150                                   )

end

/*
*   OnClickPre
*/

function PANEL:OnClickPre( )
    ui:unstage( '$pnl_ws', mod )
end

/*
*   GetWorkshopInfo
*/

function PANEL:GetWorkshopInfo( id )
    if not id then return end
    id = tostring( id )

    steamworks.FileInfo( id, function( res )
        if res and res.id then
            steamworks.DownloadUGC( tostring( res.id ), function( name, f )
                game.MountGMA( name or '' )
                local size = res.size / 1024

                return res
            end )
        end
    end )
end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    if ui:ok( self.dt_rules ) then
        self.dt_rules:SetData( self:GetRules( ) )
    end

    self.bInitialized = true
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )
    if not self.bInitialized then
        if not ui:ok( self ) then return end
        self:FirstRun( )
    end

    if not access:bIsRoot( LocalPlayer( ) ) then
        ui:hide( self.sub_note )
    end
end

/*
*   GetRules
*
*   @return : str
*/

function PANEL:GetRules( )
    return self.rules
end

/*
*   SetRules
*
*   @param  : str str
*/

function PANEL:SetRules( str )
    self.rules = str
    self.dt_rules:SetText( str )
end

/*
*   GetStandalone
*
*   @return : bool
*/

function PANEL:GetStandalone( )
    return self.bStandalone
end

/*
*   SetStandalone
*
*   @param  : bool b
*/

function PANEL:SetStandalone( b )
    self.bStandalone = helper:val2bool( b )
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
*   Destroy
*/

function PANEL:Destroy( )
    ui:destroy( self, true, true )
end

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
    self.cf_d                       = cfg.nav.workshops

    /*
    *	declare > general
    */

    self.sz_col_w                   = ui:SmartScale( true, 100, 100, 100, 100, 100, 300, 300, 300 )
    self.sz_ico                     = 64

end

/*
*   _Colorize
*/

function PANEL:_Colorize( )
    self.clr_def_txt                = self.cf_u.main.clrs.dt_txt
    self.clr_def_cur                = self.cf_u.main.clrs.dt_cur
    self.clr_def_hl                 = self.cf_u.main.clrs.dt_hl
    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_txt_sec                = self.cf_u.main.clrs.txt_section
    self.clr_ico_sec                = self.cf_u.main.clrs.ico_section
    self.clr_ico_acc                = self.cf_u.main.clrs.ico_accent
    self.clr_box                    = cfg.rules.clrs.btn_web_box
    self.clr_web_txt                = cfg.rules.clrs.btn_web_txt
end

/*
*   create
*/

ui:create( mod, 'pnl_ws', PANEL, 'pnl' )