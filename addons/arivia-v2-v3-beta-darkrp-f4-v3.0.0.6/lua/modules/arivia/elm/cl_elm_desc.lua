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
*	localized
*/

local level                 = mod.plugins.level
local prestige              = mod.plugins.prestige

/*
*	panels
*/

local PANEL = { }

/*
*	init
*/

function PANEL:Init( )

    /*
    *	parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :nodraw                         (                                       )

    /*
    *	scroll
    */

    self.scr                        = ui.new( 'rlib.elm.sp.v2', self        )
    :fill                           (                                       )
    :param                          ( 'SetbElastic', true                   )

end

/*
*   data > set
*
*   @param  : str txt
*/

function PANEL:SetData( txt )

    /*
    *   data > container
    */

    self.container                  = ui.new( 'pnl', self.scr, 1            )
    :top                            (                                       )

    /*
    *   data > dt
    */

    self.dt                         = ui.new( 'entry', self.container       )
    :fill                           (                                       )
    :text                           ( txt                                   )
    :multiline                      ( true                                  )
    :drawbg                         ( false                                 )
    :enabled                        ( true                                  )
    :font                           ( pref( 'sel_tab_info_desc' )           )
    :textclr                        ( Color( 255, 255, 255, 255 )           )
    :canedit                        ( false                                 )

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
    if cfg.dev.bDisableAnim then
        design.box( 0, 0, w - 10, h, clr )
        return
    end

    local x, y, fw, fh = 0, 0, math.Round( w * s.OnHoverFill ), h
    design.box( x, y, fw - 10, fh, clr )
end

/*
*   PerformLayout
*
*   welcome to the hackiest way of screwing with a DTextEntry and
*   that stupid vscrollbar.
*
*   working on something more 'offical' with a new dtextentry element.
*   kinda see why developers dont really try to "reinvent it" now.
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:PerformLayout( w, h )
    local title_sz_w, title_sz_h    = helper.str:len( self.dt:GetValue( ), pref( 'sel_tab_info_desc' ) )
    title_sz_h                      = title_sz_h + 75

    self.container:SetTall( title_sz_h )
end

/*
*   _Declare
*/

function PANEL:_Declare( )

    /*
    *	declare > general
    */

    self.cfg                        = cfg.tabs.jobs

    /*
    *	declare > plugins
    */

    self.bLevelEnabled              = level:bEnabled( )
    self.bPrestEnabled              = prestige:bEnabled( )

end

/*
*   register
*/

ui:create( mod, 'elm_desc', PANEL, 'pnl' )