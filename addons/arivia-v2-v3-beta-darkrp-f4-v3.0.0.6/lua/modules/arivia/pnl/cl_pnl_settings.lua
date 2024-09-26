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
    :nodraw                         (                                       )
    :fill                           (                                       )

    /*
    *   main
    */

    self.main                       = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 10, 0                         )

    /*
    *   main > body
    */

    self.main.sub                   = ui.new( 'pnl', self.main, 1           )
    :fill                           ( 'm', 10, 5, 10, 5                     )

    /*
    *   main > stats
    */

    self.stats                      = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 20, 10, 20, 10                   )

    /*
    *   stats > title
    */

    self.stats.t                    = ui.new( 'pnl', self.stats             )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'settings_sec_stats_name' ), pref( 'settings_sect_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   stats > header
    */

    self.stats.sp                   = ui.new( 'pnl', self.stats             )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   stats > body
    */

    self.main.sub                   = ui.new( 'pnl', self.stats             )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( ln( 'settings_msg_soon' ), pref( 'settings_msg' ), w / 2, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   settings > container ( level 1 )
    */

    self.cfg                        = ui.new( 'pnl', self                   )
    :right                          ( 'm', 0, 0, 0, 0                       )
    :wide                           ( 270                                   )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_u.right.clrs.panel )
                                        design.box( 0, 0, 1, h, self.clr_sep )
                                    end )

    /*
    *   settings > container > sub ( level 2 )
    */

    self.cfg.sub                    = ui.new( 'pnl', self.cfg               )
    :fill                           ( 'm', 20, 10, 20, 10                   )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_pnl_icon_lg' ), w / 2, h / 2, self.clr_ico_acc , TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   settings > title
    */

    self.cfg.t                      = ui.new( 'pnl', self.cfg.sub           )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'settings_sec_main_name' ), pref( 'settings_sect_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   settings > header
    */

    self.cfg.h                      = ui.new( 'pnl', self.cfg.sub           )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   settings > cvar > parent
    */

    self.cfg.sub.l2                 = ui.new( 'pnl', self.cfg.sub, 1        )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 200                                   )

    /*
    *   settings > indicator
    *
    *   displays 'changes saved' when cvar settings adjusted
    */

    self.lb_save                    = ui.new( 'lbl', self.cfg.sub, 1        )
    :bottom                         ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 30                                    )
    :align                          ( 5                                     )
    :font                           ( pref( 'cvar_status_msg' )             )
    :clr                            ( Color( 255, 255, 255 )                )
    :notext                         (                                       )
    :alpha                          ( 0                                     )

    /*
    *   settings > cvar
    */

    local pl_cvars                  = { }

    /*
    *   settings > cvar > populate settings
    */

    if istable( self.cf_d.cvarlst ) then
        for k, v in helper:sortedkeys( self.cf_d.cvarlst ) do
            pl_cvars[ #pl_cvars + 1 ] = v
        end

        table.sort( pl_cvars, function( r1, r2 ) return r1.sid < r2.sid end )

        for k, v in pairs( pl_cvars ) do
            if base._def.elements_ignore[ v.type ] then continue end
            cvar:Setup( v.type, v.id, v.default, v.values, v.forceset, v.desc )
        end
    end

    /*
    *   settings > cvar > loop
    */

    local i = 0
    for k, v in helper.get.table( pl_cvars ) do

        /*
        *   settings > cvar > visible
        */

        if not v.enabled then continue end

        /*
        *   settings > cvar > condition
        */

        if v.condition then
            local condition = v.condition( LocalPlayer( ) )
            if not condition then continue end
        end

        /*
        *   settings > cvar > declarations
        */

        local cfg_type                  = v.type
        local cv                        = GetConVar( v.id )

        /*
        *   settings > cvar > type > checkbox
        */

        if cfg_type == 'checkbox' then
            self:ElmCheckbox( cv, v )
        end

        /*
        *   settings > cvar > count
        */

        i = i + 1

    end

    /*
    *   settings > parent : adjust height
    */

    self.cfg.sub.l2:SetTall         ( i * 20 + 40 + 20                      )

end

/*
*   ElmCheckbox
*/

function PANEL:ElmCheckbox( cv, v )

    /*
    *   elm > cbox > ct
    */

    self.cb                         = ui.new( 'pnl', self.cfg.sub.l2, 1     )
    :top                            ( 'm', 4, 5, 0, 0                       )
    :tall                           ( 20                                    )

    /*
    *   selm > cbox > val
    */

    self.cb.val                     = ui.new( 'lbl', self.cb, 1             )
    :fill                           ( 'm', 0                                )
    :font                           ( pref( 'cvar_cbox_label' )             )
    :text                           ( v.name                                )
    :clr                            ( self.cf_u.main.clrs.dt_txt            )
    :autosize                       (                                       )

    /*
    *   selm > cbox > obj
    */

    self.cb.obj                     = ui.new( 'rlib.ui.cbox.v2', self.cb    )
    :right                          ( 'm', 0                                )
    :param                          ( 'SetCVar', cv                         )
    :tip                            ( v.desc or v.name                      )

                                    :ooc( function( s )
                                        local msg = v.status or 'Setting changed'
                                        self.lb_save:SetText( msg )
                                        self.lb_save:alphato( 255, 1.0, 0, function( )
                                            self.lb_save:alphato( 0, 1.0, 3, function( )
                                                self.lb_save:SetText( '' )
                                            end )
                                        end )

                                        timex.simple( 1, function( )
                                            if v.execute then
                                                v.execute( )
                                            end
                                        end )
                                    end )


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
*   HoverFill
*
*   animation to make buttons appear as if they are being filled
*   with color when player hovers over
*
*   @param  : pnl s
*   @param  : int w
*   @param  : int h
*   @param  : clr clr
*/

function PANEL:HoverFill( s, w, h, clr )
    if self.cf_d.bDisableAnim then
        design.box( 0, 0, w, h, clr )
        return
    end

    local x, y, fw, fh = 0, 0, math.Round( w * s.OnHoverFill ), h
    design.box( x, y, fw, fh, clr )
end

/*
*   GetTextTitleColor
*
*   @return : str
*/

function PANEL:GetTextTitleColor( )
    return self.clr_name or self.clr_txt_sec
end

/*
*   SetTextTitleColor
*
*   @param  : clr clr
*/

function PANEL:SetTextTitleColor( clr )
    self.clr_name = clr
end

/*
*   Declarations
*/

function PANEL:_Declare( )

    /*
    *	declare > main configs
    */

    self.cf_u                       = cfg.ui
    self.cf_d                       = cfg.dev
end

/*
*   Colorize
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
    self.clr_txt_leg                = Color( 255, 255, 255, 255 )
    self.clr_gr_lines               = Color( 255, 255, 255, 15 )
    self.clr_gr_plot                = Color( 253, 52, 110, 255 )
    self.clr_gr_refval              = Color( 31, 133, 222, 255 )
end

/*
*   register
*/

ui:create( mod, 'pnl_settings', PANEL, 'pnl' )