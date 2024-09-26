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
*	localized > root
*/

function mod.ui:Root( )

    /*
    *   validate player
    */

    if not helper.ok.ply( LocalPlayer( ) ) then return end
    local pl = LocalPlayer( )

    /*
    *   rhook
    */

    rhook.run.rlib( 'arivia_fonts_register' )
    rhook.run.rlib( 'arivia_cl_init' )

    /*
    *   declare > demo mode
    */

    local bDemoMode                 = rcore:bInDemoMode( mod ) or false

    /*
    *   overlay
    */

    local ct_ol                     = ui.new( 'rlib.ui.overlay'             )
    :register                       ( '$pnl_root', mod                      )

    /*
    *   root
    */

    local ct_base                   = ui.rlib( mod, 'base', ct_ol, 1        )
    :candrag                        ( false                                 )
    :attachpar                      ( ct_ol, true                           )
    :register                       ( '$pnl_base', mod                      )

    /*
    *   declare > sizes
    */

    local sz_w, sz_h                = ScrW( ) * .83, ScrH( ) * .83
    local os_w, os_h                = ScrW( ) - sz_w, ScrH( ) - sz_h
    os_w                            = os_w / 2
    os_h                            = os_h / 2

    /*
    *   declare > pl info
    */

    local clr_text_plnfo            = Color( 255, 255, 255, 255 )

    /*
    *   overlay > pl info
    */

    local pinfo                     = ui.new( 'pnl', ct_ol                  )
    :tall                           ( 50                                    )
    :wide                           ( sz_w - 10                             )
    :pos                            ( os_w + 5, os_h - 30                   )

                                    :logic( function( s )
                                        if not s.nthink then s.nthink = 0 return end
                                        if s.nthink > CurTime( ) then return end

                                        s.pl_name       = bDemoMode and cfg.dev.demo.name or pl:palias( ):upper( )
                                        s.pl_job        = bDemoMode and cfg.dev.demo.sid or pl:getjob( ) or ''
                                        s.pl_money      = DarkRP.formatMoney( pl:getmoney( ) )
                                        s.pl_sal        = s.pl_job .. '  •  ' .. s.pl_money

                                        s.nthink        = CurTime( ) + 3
                                    end )

                                    :draw( function( s, w, h )
                                        if not s.pl_name then return end
                                        draw.SimpleText( string.format( '%s', s.pl_name ), pref( 'g_pl_name' ), 60, 15, clr_text_plnfo, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( s.pl_sal, pref( 'g_pl_salary' ), 60, 35, clr_text_plnfo, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( cfg.general.network_name, pref( 'g_nw_name' ), w, h / 2, clr_text_plnfo, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   overlay > pl avatar
    */

    local av                        = ui.new( 'rlib.ui.avatar', pinfo       )
    :size                           ( 50                                    )
    :pos                            ( 0, 0                                  )
    :player                         ( pl, 50                                )
    :rounded                        ( true                                  )

end