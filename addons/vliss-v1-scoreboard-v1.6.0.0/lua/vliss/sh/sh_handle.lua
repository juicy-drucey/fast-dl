/*
*   @package        : rcore
*   @module         : vliss
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2016 - 2020
*   @website        : https://rlib.io
*   @docs           : https://docs.rlib.io
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
*   locals
*/

local base                  = vliss
local cfg                   = base.cfg
local handle                = base.handle

/*
*   pmeta
*/

local pmeta                 = FindMetaTable( 'Player' )

/*
*   pmeta > group > get
*
*   returns the group assigned to the player
*
*   @param  : bool bLower
*   @return : mixed
*/

function pmeta:group( bReg )
    local group = self:GetUserGroup( )
    return bReg and group or handle.util.clean( group )
end

/*
*   handle > gamemode
*
*   return the server gamemode
*
*   @param  : bool bCombine
*   @param  : bool bLower
*   @param  : bool bClean
*   @return : str, str
*/

function handle:WhichGamemode( bCombine, bLower, bClean )
    return engine.ActiveGamemode( ) or 'unknown'
end

/*
*   handle > gamemode > get
*
*   return the server gamemode
*
*   @param  : str forced
*   @return : bool, str, str
*/

function handle:GetGamemode( forced )
    local gm, other 	= self:WhichGamemode( false, true )
    gm 					= handle.util.clean( gm )
    gm 					= isstring( forced ) and forced or gm

    local src           = ( gm and cfg.Gamemodes[ gm ] ) or cfg.Gamemodes[ 'default' ]
    local bFound        = ( src and src.id and true ) or false
    local gm_id         = ( src and src.id ) or 'sandbox'
    local gm_name       = ( src and src.name ) or 'Unknown'

    return bFound, gm_id, gm_name
end

/*
*   handle > gamemode > data
*
*   return data for a gamemode
*
*   @return : bool, str, str
*/

function handle:GetGNData( )
    local gm, other 	= self:WhichGamemode( false, true )
    gm 					= handle.util.clean( gm )
    gm 					= isstring( forced ) and forced or gm

    local data          = cfg.Gamemodes[ gm ] or { }

    return data
end

/*
*   str > empty str
*
*   checks for a valid string but also checks for blank or space chars

*   @param  : str str
*   @return : bool
*/

function handle:isempty( str )
    if not isstring( str ) then return false end

    local text  = str:gsub( '%s', '' )
    if not isstring( text ) or text == '' or text == 'NULL' or text == NULL or tostring( text ) == 'nil' then return true end
    return false
end

/*
*   handle > group > title
*
*   returns the player group color

*   @param  : ply pl
*/

function handle:GroupTitle( pl )
    local grp   = cfg.dev.simulate[ pl:Name( ):lower( ) ] and cfg.dev.simulate[ pl:Name( ):lower( ) ].group or pl:group( )
    grp         = cfg.groups.titles[ grp ] and cfg.groups.titles[ grp ] or grp

    return grp
end

/*
*   handle > group > clr
*
*   returns the player group color

*   @param  : ply pl
*/

function handle:GroupColor( pl )
    local col   = cfg.dev.simulate[ pl:Name( ):lower( ) ] and cfg.dev.simulate[ pl:Name( ):lower( ) ].group or pl:group( )
    col         = cfg.groups.colors[ col ] and cfg.groups.colors[ col ] or Color( 37, 37, 37, 255 )

    return col
end

/*
*   handle > is staff
*
*   returns the player group color

*   @param  : ply pl
*   @return : bool
*/

function handle:bIsStaff( pl )
    if pl:IsSuperAdmin( ) then return true end
    if cfg.perms.is_staff[ pl:group( ) ] then return true end
    return false
end

/*
*   handle > perms
*
*   returns if player has access to the specified perm

*   @param  : str perm
*   @param  : ply pl
*   @return : bool
*/

function handle:HasPerm( perm, pl )
    if pl:IsSuperAdmin( ) then return true end
    if cfg.perms[ perm ] and cfg.perms[ perm ][ pl:group( ) ] then return true end
    return false
end

/*
*   handle > perms > gamemode
*
*   returns if player has access to gm perm (  murder, prophunt, etc. )

*   @param  : obj root
*   @param  : str perm
*   @param  : ply pl
*   @return : bool
*/

function handle:HasGMPerm( root, perm, pl )
    if pl:IsSuperAdmin( ) then return true end
    if root and root[ perm ] and root[ perm ][ pl:group( ) ] then return true end
    return false
end

/*
*   handle > util > clean
*
*   @param  : str str
*   @param  : bool bRemove
*   @return : str
*/

function handle.util.clean( str, bRemove )
    str = isstring( str ) and str or tostring( str )
    str = str:lower( )
    str = bRemove and str:gsub( '%s+', '' ) or str:gsub( '%s+', '_' )

    return str
end

/*
*   handle > util > str ok
*
*   checks for a valid string but also checks for blank or space chars
*
*   @param  : str str
*   @return : bool
*/

function handle.util.str( str )
    if not isstring( str ) then return false end

    local text = str:gsub( '%s', '' )
    if isstring( text ) and text ~= '' and text ~= 'NULL' and text ~= NULL then return true end
    return false
end