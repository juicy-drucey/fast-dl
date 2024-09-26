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
local mf                    = base.mf
local handle                = base.handle

/*
*   localized funcs
*/

local function log( ... ) base:log( ... ) end

/*
*   enums :: logging
*/

VLISS_LOG_INFO                      = 1
VLISS_LOG_ERR                       = 2
VLISS_LOG_WARN                      = 3
VLISS_LOG_OK                        = 4
VLISS_LOG_STATUS                    = 5
VLISS_LOG_DEBUG                     = 6
VLISS_LOG_ADMIN                     = 7
VLISS_LOG_RESULT                    = 8
VLISS_LOG_RNET                      = 9
VLISS_LOG_NET                       = 10
VLISS_LOG_ASAY                      = 11
VLISS_LOG_DB                        = 12
VLISS_LOG_CACHE                     = 13
VLISS_LOG_SYSTEM                    = 14
VLISS_LOG_PERM                      = 15
VLISS_LOG_FONT                      = 16
VLISS_LOG_WS                        = 17
VLISS_LOG_FASTDL                    = 18
VLISS_LOG_SILENCED                  = 19

/*
*   define > titles > debug
*
*   different types of messages. these will be attached to the beginning of both console
*   and konsole msgs.
*
*   certain enums will not trigger msgs to be sent to the console unless debug mode is
*   enabled on the server when the msg is sent.
*
*   @ex     : [Info] <player> has joined
*/

base._def.debug_titles =
{
    [ VLISS_LOG_INFO ]              = 'info',
    [ VLISS_LOG_ERR ]               = 'error',
    [ VLISS_LOG_WARN ]              = 'warn',
    [ VLISS_LOG_OK ]                = 'ok',
    [ VLISS_LOG_STATUS ]            = 'status',
    [ VLISS_LOG_DEBUG ]             = 'debug',
    [ VLISS_LOG_ADMIN ]             = 'admin',
    [ VLISS_LOG_RESULT ]            = 'result',
    [ VLISS_LOG_RNET ]              = 'rnet',
    [ VLISS_LOG_NET ]               = 'net',
    [ VLISS_LOG_ASAY ]              = 'asay',
    [ VLISS_LOG_DB ]                = 'db',
    [ VLISS_LOG_CACHE ]             = 'cache',
    [ VLISS_LOG_SYSTEM ]            = 'sys',
    [ VLISS_LOG_PERM ]              = 'perm',
    [ VLISS_LOG_FONT ]              = 'font',
    [ VLISS_LOG_WS ]                = 'ws',
    [ VLISS_LOG_FASTDL ]            = 'fastdl',
    [ VLISS_LOG_SILENCED ]          = 'silenced',
}

/*
*   define > rgb6 assignments
*
*   returns the correct assigned rgb value for log
*   limited to the 6 rgb [ 3 primary - 3 pigments ]
*/

base._def.lc_rgb6 =
{
    [ VLISS_LOG_INFO ]              = Color( 255, 255, 255 ),       -- white
    [ VLISS_LOG_ERR ]               = Color( 255, 0, 0 ),           -- red
    [ VLISS_LOG_WARN ]              = Color( 255, 255, 0 ),         -- yellow
    [ VLISS_LOG_OK ]                = Color( 0, 255, 0 ),           -- green
    [ VLISS_LOG_STATUS ]            = Color( 0, 255, 0 ),           -- green
    [ VLISS_LOG_DEBUG ]             = Color( 255, 255, 0 ),         -- yellow
    [ VLISS_LOG_ADMIN ]             = Color( 255, 255, 0 ),         -- yellow
    [ VLISS_LOG_RESULT ]            = Color( 0, 255, 0 ),           -- green
    [ VLISS_LOG_RNET ]              = Color( 255, 0, 0 ),           -- red
    [ VLISS_LOG_NET ]               = Color( 255, 0, 0 ),           -- red
    [ VLISS_LOG_ASAY ]              = Color( 255, 255, 0 ),         -- yellow
    [ VLISS_LOG_DB ]                = Color( 255, 0, 255 ),         -- purple
    [ VLISS_LOG_CACHE ]             = Color( 255, 0, 255 ),         -- purple
    [ VLISS_LOG_SYSTEM ]            = Color( 255, 255, 0 ),         -- yellow
    [ VLISS_LOG_PERM ]              = Color( 255, 0, 255 ),         -- purple
    [ VLISS_LOG_FONT ]              = Color( 255, 0, 255 ),         -- purple
    [ VLISS_LOG_WS ]                = Color( 255, 0, 255 ),         -- purple
    [ VLISS_LOG_FASTDL ]            = Color( 255, 0, 255 ),         -- purple
    [ VLISS_LOG_SILENCED ]          = Color( 255, 0, 0 ),           -- red
}

/*
*   sets up a log message to be formatted
*
*   @assoc  : rlib:log( )
*
*   @param  : int cat
*   @param  : str msg
*   @param  : varg { ... }
*/

local function logs_struct( cat, msg, ... )
    cat     = isnumber( cat ) and cat or 1
    msg     = msg .. table.concat( { ... }, ', ' )

    base:logs_beautify( cat, msg )
end

/*
*   log
*
*   debug logs sent to console
*   also writes any logs to a file located in data/rlib
*
*   when using the netmsg debugger, do not post the cat to anything other than id 9 otherwise you will
*   cause stack errors
*
*   @usage  : self:log( 4, 'Hello %s', 'world' )
*
*   @param  : int cat
*   @param  : str msg
*   @param  : varg { ... }
*/

function base:log( cat, msg, ... )
    local sf    = string.format
    local args  = { ... }
    cat         = isnumber( cat ) and cat or 0
    msg         = isstring( msg ) and msg or 'invalid msg'

    /*
    *   cat 0 returns blank line
    */

    if cat == 0 then print( ' ' ) return end

    /*
    *   debug only
    */

    if not cfg.dev.bDevMode then
        if cat == VLISS_LOG_DEBUG then return end
        if cat == VLISS_LOG_CACHE then return end
        if cat == VLISS_LOG_PERM then return end
        if cat == VLISS_LOG_FONT then return end
        if cat == VLISS_LOG_FASTDL then return end
    end

    /*
    *   rnet debug only
    */

    local resp, msg = pcall( sf, msg, unpack( args ) )

    if not resp then
        error( msg, 2 )
        return
    end

    logs_struct( cat, msg )
end

/*
*   logs :: beautify
*
*   takes the data that will be sent to the console and formats the way it displays in the
*   the console using columns.
*
*   @assoc  : log_netmsg( )
*   @assoc  : logs_struct( )
*
*   @param  : int cat
*   @param  : str msg
*/

function base:logs_beautify( cat, msg )
    local sf    = string.format
    cat         = isnumber( cat ) and cat or 1
    msg         = sf( '%s', msg )

    local c1    = sf( '%-9s', os.date( '%I:%M:%S' ) )
    local c2    = sf( '%-12s', '[' .. base._def.debug_titles[ cat ] .. ']' )
    local c3    = sf( '%-3s', '|' )
    local c4    = sf( '%-30s', msg )

    if cat ~= 8 then
        MsgC( Color( 0, 255, 0 ), '[' .. base.mf.name .. '] ', Color( 255, 255, 255 ), c1, base._def.lc_rgb6[ cat ] or base._def.lc_rgb6[ 1 ] or Color( 255, 255, 255 ), c2, Color( 255, 0, 0 ), c3, Color( 255, 255, 255 ), c4 .. '\n' )
    else
        MsgC( Color( 0, 255, 0 ), '[' .. base.mf.name .. '] ', Color( 255, 0, 0 ), c3, Color( 255, 255, 255 ), c4 .. '\n' )
    end
end

/*
*   msg > target
*
*   routes a message as either a private or broadcast based on the target
*
*   @param  : ply pl
*   @param  : str subcat [optional]
*   @param  : varg { ... }
*/

function base:msg( pl, subcat, ... )
    if not cfg or not cfg.umsg then
        log( 2, 'umsg vals missing' )
        return
    end

    local umsg  = cfg.umsg
    local args  = { ... }

    if IsColor( subcat ) then
        table.insert( args, 1, subcat )
    else
        subcat  = isstring( subcat ) and subcat or ''
    end

    for k, v in pairs( args ) do
        if not isstring( v ) then continue end
        args[ k ] = v .. ' '
    end

    local sub_c = ( handle.util.str( subcat ) and '[' .. subcat .. '] ' ) or ''

    if CLIENT then
        chat.AddText( umsg.clrs.c1, '[' .. umsg.to_private .. '] ', umsg.clrs.t4, sub_c, umsg.clrs.msg, unpack( args ) )
    else
        if pl and pl:IsPlayer( ) then
            pl:umsg( umsg.clrs.c1, '[' .. umsg.to_private .. '] ', umsg.clrs.t4, sub_c, umsg.clrs.msg, unpack( args ) )
        else
            base:umsg( umsg.clrs.t1, '[' .. umsg.to_server .. '] ', umsg.clrs.t4, sub_c, umsg.clrs.msg, unpack( args ) )
        end
    end
end