/*
*   @package        : rcore
*   @module         : vliss
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c ) 2016 - 2020
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
local ttt                   = base.ttt

/*
*   enable gamemode
*
*   the setting below is what tells this script which gamemode you are using.
*   most of the time; vliss can detect which gamemode you're running, however,
*   if vliss reports in console that you have an 'Unknown Gamemode'; you can
*   force a specific gamemode by enabling the setting below:
*/

ttt.Enabled                 = ttt.Enabled or false

/*
*   general
*/

ttt.ColorDetective          = Color( 25, 25, 200, 200 )
ttt.ColorTraitor            = Color( 200, 25, 25, 200 )
ttt.ColorTerrorist          = Color( 25, 200, 25, 200 )
ttt.ColorMIA                = Color( 130, 190, 130, 200 )
ttt.ColorDead               = Color( 130, 170, 10, 200 )
ttt.ColorSpec               = Color( 200, 200, 0, 200 )
ttt.ShowUsedTeamsOnly       = true -- Set this to true if you want only the teams that players are in to be shown in Terrortown.
ttt.RemainingTimeEnabled    = true
ttt.RemainingTimeText       = Color(  255, 255, 255, 255 )