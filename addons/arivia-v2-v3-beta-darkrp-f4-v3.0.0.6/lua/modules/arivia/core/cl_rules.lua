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
*   Localized res func
*/

local function resources( t, ... )
    return base:resource( mod, t, ... )
end

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
*   rules > initialize
*
*   @param  : str uri
*   @param  : bool bUseIntweb
*   @param  : bool bStandalone
*/

function mod.rules:Initialize( uri, bUseIntweb, bStandalone )
    ui:dispatch( '$pnl_rules',   mod )
    ui:dispatch( '$pnl_web',     mod )

    local snd                       = CreateSound( LocalPlayer( ), resources( 'snd', 'swipe_01' ) )
    snd:PlayEx                      ( 0.1, 100                              )

    local parent                    = ui:call( '$pnl_content', mod          )
                                    if not ui:ok( parent ) then return end

    local element                   = ( not cfg.rules.use_text and bUseIntweb and 'pnl_rules_web' ) or 'pnl_rules'

    local pnl_rules                 = ui.rlib( mod, element, parent         )
    :param                          ( 'SetRules', cfg.rules.text or ln( 'rules_text_missing' ) )
    :param                          ( 'SetStandalone', bStandalone          )
    :param                          ( 'SetURL', cfg.nav.btn.rules_url       )
    :register                       ( '$pnl_rules', mod                     )
end

/*
*   rules > open
*
*   determines what to do when a player clicks the rules button
*   has the ability to open up an external website or to use in-game text.
*
*   :   uri
*       link to external website (if text-based not used)
*
*   :   bUseIntweb
*       uses the integrated browser built into script
*
*   :   bStandalone
*       allows ui to open without parent pnl, good for opening rules / terms by themselves using
*       the concommand
*
*   @param  : str uri
*   @param  : bool bUseIntweb
*   @param  : bool bStandalone
*/

function mod.rules:Open( uri, bUseIntweb, bStandalone )
    ui:dispatch( '$pnl_rules',   mod )
    ui:dispatch( '$pnl_web',     mod )

    if bUseIntweb then
        self:Initialize( uri, bUseIntweb, bStandalone )
    else
        gui.OpenURL( uri or mod.url )
    end
end