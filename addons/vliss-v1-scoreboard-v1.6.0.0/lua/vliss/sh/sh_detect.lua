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
*   loader > detect gamemode
*/

local function gm_detect( )

    /*
    *   readable bools
    */

    local bUTime            = Utime and 'Enabled' or 'Disabled'
    local bFAdmin           = FAdmin and 'Enabled' or 'Disabled'

    /*
    *   declare > colors
    */

    local clr_n             = Color( 255, 255, 0 )
    local clr_e             = Color( 255, 0, 0 )
    local clr_t             = Color( 255, 255, 255 )
    local clr_s             = Color( 255, 255, 0 )

    /*
    *   console > plugins
    */

    MsgC( clr_s, '\n\n\n [ Plugins ] .........................................\n\n' )
    MsgC( clr_t, '       UTime .......................... [' .. bUTime .. ']\n' )
    MsgC( clr_t, '       FAdmin ......................... [' .. bFAdmin .. ']\n' )

    /*
    *   console > gamemode
    */

    MsgC( clr_s, '\n [ Gamemode ] ........................................\n\n' )

    local bFound, id, name = handle:GetGamemode( )
    if bFound then

        /*
        *   console > gamemode > found
        */

        MsgC( clr_t, '       Gamemode ....................... [' .. name .. '] \n' )

        MsgC( clr_n, '\n ....................................................................\n\n' )
        MsgC( clr_n, ' Vliss has completed loading everything. If you experience any \n' )
        MsgC( clr_n, ' issues please make sure to contact the script author.\n\n' )
        MsgC( clr_n, ' ....................................................................\n\n' )

        base[ id ].Enabled = bFound
    else

        /*
        *   console > gamemode > unknown
        */

        MsgC( clr_t, '       Gamemode ....................... [' .. name .. '] \n' )
        MsgC( clr_e, '\n ....................................................................\n\n' )
        MsgC( clr_e, ' Unable to detect server gamemode. Does Vliss support this? \n' )
        MsgC( clr_e, ' Defaulting to SANDBOX; contact the developer \n\n' )
        MsgC( clr_e, ' ....................................................................\n\n' )

        base[ 'sb' ].Enabled = true
    end

    /*
    *   hook > gm loaded
    */

    timer.Simple( 2, function( )
        hook.Run( 'vliss_gm_loaded' )
    end )
end
hook.Add( 'PostGamemodeLoaded', 'vliss_gm_detect', gm_detect )