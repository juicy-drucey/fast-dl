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
*	get cvars
*
*   returns the specified cvar OR cvar table if no id provided
*
*   @param  : str id
*   @return : tbl, str
*/

function mod:GetCvar( id )
    if not helper.str:valid( id ) then return cfg.dev.cvarlst end
    return cfg.dev.cvarlst[ id ]
end

/*
*   precache :: initialize
*
*   will precache ply mdls if gamemode is derived from darkrp
*   only executes if cfg.precache.models = true in config file
*/

function mod.precache:initialize( )
    if not cfg.precache.models then return end
    if not istable( RPExtraTeams ) then return end

    local i = 0
    for v in helper.get.data( RPExtraTeams ) do
        if istable( v.model ) then
            for mdl in helper.get.data( v.model ) do
                if string.GetExtensionFromFilename( mdl ) ~= 'mdl' then continue end
                util.PrecacheModel( mdl )
                if cfg.precache.listall then
                    base:log( 1, '+ darkrp mdl [ %s ]', mdl )
                end
                i = i + 1
            end
        else
            if string.GetExtensionFromFilename( v.model ) ~= 'mdl' then continue end
            util.PrecacheModel( v.model )
            if cfg.precache.listall then
                base:log( 1, '+ precached mdls: [ %s ]', v.model )
            end
            i = i + 1
        end
    end

    base:log( 1, '+ darkrp mdl [ %s total ]', tostring( i ) )

end
rhook.new.gmod( 'InitPostEntity', 'arivia_sh_precache', mod.precache.initialize )