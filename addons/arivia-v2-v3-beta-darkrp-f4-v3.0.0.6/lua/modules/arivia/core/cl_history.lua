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
*	history > storage
*
*   returns tab history of player.
*   storage history saves data related to which tabs a player has expanded or collapsed
*/

function mod.history:Storage( )
    mod.history.exp         = mod.history.exp or { }
    mod.history.jobs        = mod.history.jobs or { }
    mod.tabs.m              = mod.tabs.m or { }
end

/*
*	history > jobs > create id
*
*   @param  : str title
*/

function mod.history.jobs:CreateID( title )
    local cat   = title
    cat         = helper.str:clean( cat )

    return cat
end

/*
*	history > jobs > registered
*
*   @param  : str id
*   @return : bool
*/

function mod.history.jobs:Registered( id )
    mod.history:Storage(  )

    return mod.history.exp[ id ] and true or false
end

/*
*	history > jobs > get state
*/

function mod.history.jobs:GetState( id )
    mod.history:Storage( )

    return mod.history.exp[ id ]
end

/*
*	history > jobs > clear
*/

function mod.history.jobs:Clear( )
    mod.history:Storage( )

    mod.history.exp = { }
end

/*
*	history > jobs > write expanded
*/

function mod.history.jobs:WriteExpanded( id, pnl, val )
    mod.history:Storage( )

    mod.history.exp[ id ] = val
end