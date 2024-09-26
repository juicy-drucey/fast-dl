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

local base                  = vliss
local sandbox               = base.sb

/*
*   enable gamemode
*
*   the setting below is what tells this script which gamemode you are using.
*   most of the time; vliss can detect which gamemode you're running, however,
*   if vliss reports in console that you have an 'Unknown Gamemode'; you can
*   force a specific gamemode by enabling the setting below:
*/

sandbox.Enabled                     = sandbox.Enabled or false

/*
*   ent / prop count list
*
*   this table lists all of the entities / props a player has.
*/

sandbox.CountList =
{
    {
        enabled                     = true,
        name                        = 'Props',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'props' ) end
    },
    {
        enabled                     = true,
        name                        = 'Hoverballs',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'hoverballs' ) end
    },
    {
        enabled                     = true,
        name                        = 'Thrusters',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'thrusters' ) end
    },
    {
        enabled                     = true,
        name                        = 'Balloons',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'balloons' ) end
    },
    {
        enabled                     = true,
        name                        = 'Buttons',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'buttons' ) end
    },
    {
        enabled                     = true,
        name                        = 'Dynamite',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'dynamite' ) end
    },
    {
        enabled                     = true,
        name                        = 'Sents',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'sents' ) end
    },
    {
        enabled                     = true,
        name                        = 'Ragdolls',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'ragdolls' ) end
    },
    {
        enabled                     = true,
        name                        = 'Effects',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'effects' ) end
    },
    {
        enabled                     = true,
        name                        = 'Vehicles',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'vehicles' ) end
    },
    {
        enabled                     = true,
        name                        = 'NPCs',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'npcs' ) end
    },
    {
        enabled                     = true,
        name                        = 'Emitters',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'emitters' ) end
    },
    {
        enabled                     = true,
        name                        = 'Lamps',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'lamps' ) end
    },
    {
        enabled                     = true,
        name                        = 'Spawners',
        textColor                   = Color( 255, 255, 255, 255 ),
        buttonColor                 = Color( 124, 51, 50, 190 ),
        buttonColorHover            = Color( 124, 51, 50, 240 ),
        func                        = function( pl ) return pl:GetCount( 'spawners' ) end
    }
}