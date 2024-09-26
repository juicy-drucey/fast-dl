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
local storage               = base.s

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return rlib.get:pref( str, state )
end

/*
*	localized plugin
*/

local prestige              = mod.plugins.prestige

/*
*   plugins > prestige > enabled
*
*   :   LevelSystemPrestigeConfiguration
*       darkrp prestige system
*
*   @param  : void
*   @return : bool
*/

function prestige:bEnabled( )
    if not cfg.plugins.prestige then return false end
    if ( not LevelSystemPrestigeConfiguration ) then return false end

    return true
end

/*
*   plugins > prestige > get
*
*   returns required level of job / ent
*
*   @param  : ent item
*   @param  : bool bPrefix
*   @return : int
*/

function prestige:Get( item, bPrefix )
    local val = item.prestige or item.prest or 0
    return ( bPrefix and string.format( 'Prestige: %i', val ) ) or val
end

/*
*   plugins > prestige > player has level
*
*   determines if the specified player has the required prestige level
*   for something ( switch job, entity, etc. )
*
*   @param  : ply pl
*   @param  : int req
*   @return : bool
*/

function prestige:HasReq( pl, req )
    local pr_player = pl:getprestige( ) or 1
    local pr_object = self:Get( req )

    if pr_player < pr_object then return false end

    return true
end