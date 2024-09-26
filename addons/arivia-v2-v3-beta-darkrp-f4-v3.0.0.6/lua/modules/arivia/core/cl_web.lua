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
*   web > open
*
*   activates buttons pressed in header
*
*   @param  : str name
*   @param  : str uri
*   @param  : bool bUseIntegrated
*/

function mod.web:Open( name, uri, bUseIntegrated )
    name        = isstring( name ) and name or ln( 'browser_untitled' )
                if not isstring( uri ) then return end

    if bUseIntegrated then
        ui:dispatch( '$pnl_rules',   mod )
        ui:dispatch( '$pnl_web',     mod )

        self:Integrated( ln( name ), uri )
        return
    end

    gui.OpenURL( uri or mod.url )
end

/*
*   web > integrated
*
*   opens a url using the integrated browser
*
*   @param  : str name
*   @param  : str uri
*/

function mod.web:Integrated( name, uri )
    ui:dispatch( '$pnl_rules',   mod )
    ui:dispatch( '$pnl_web',     mod )

    local par               = ui:call( '$pnl_content', mod )
                            if not ui:ok( par ) then return end

    local pnl_web           = ui.rlib( mod, 'pnl_ibws', par         )
    :show                   (                                       )
    :param                  ( 'SetMenuItem', name                   )
    :param                  ( 'SetWebURL', uri                      )
    :register               ( '$pnl_web', mod                       )
end