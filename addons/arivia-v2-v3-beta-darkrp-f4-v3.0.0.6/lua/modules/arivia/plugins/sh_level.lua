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
*	localized plugin
*/

local level                 = mod.plugins.level

/*
*   plugins > leveling > enabled
*
*   :   LevelSystemConfiguration
*       darkrp leveling system
*       req PlayXP timer to be running
*
*   :   rlib.modules:bInstalled( 'xp' )
*       richard's leveling system
*
*   :   rlib.modules:bInstalled( 'years' )
*       richard's leveling system for hogwartsrp servers
*
*   @param  : void
*   @return : bool
*/

function level:bEnabled( )
    if not cfg.plugins.levels then return false end
    if ( ( not LevelSystemConfiguration or LevelSystemConfiguration and timer.Exists( 'PlayXP' ) ) and not rlib.modules:bInstalled( 'xp' ) and not rlib.modules:bInstalled( 'years' ) ) then return false end

    return true
end

/*
*   plugins > leveling > get
*
*   returns required level of job / ent
*
*   @param  : ent item
*   @param  : bool bPrefix
*   @return : int
*/

function level:Get( item, bPrefix )
    local val = item.level or item.lvl or item.year or 1
    return ( bPrefix and string.format( 'Level: %i', val ) ) or val
end

/*
*   plugins > leveling > player has level
*
*   determines if the specified player has the required level
*   for something ( switch job, entity, etc. )
*
*   @param  : ply pl
*   @param  : int req
*   @return : bool
*/

function level:HasReq( pl, req )
    local lvl_player = pl:getlevel( ) or 1
    local lvl_object = self:Get( req )

    if lvl_player < lvl_object then return false end

    return true
end