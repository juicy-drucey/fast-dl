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
local deathrun              = base.dr

/*
*   enable gamemode
*
*   the setting below is what tells this script which gamemode you are using.
*   most of the time; vliss can detect which gamemode you're running, however,
*   if vliss reports in console that you have an 'Unknown Gamemode'; you can
*   force a specific gamemode by enabling the setting below:
*/

deathrun.Enabled                    = deathrun.Enabled or false

-----------------------------------------------------------------
-- [ TEAM ASSIGNMENTS - ADVANCED DEVELOPERS ONLY ]
-----------------------------------------------------------------
-- Team assignments for the gamemode. You should not mess with
-- these unless you know what you're doing.
-----------------------------------------------------------------
-- [ MR GASH'S DEATHRUN ]
-- https://github.com/Mr-Gash/GMod-Deathrun
-----------------------------------------------------------------
-- deathrun.TeamHuman 		2
-- deathrun.TeamUndead 		3
-- deathrun.TeamSpectators 	1002
-----------------------------------------------------------------

deathrun.TeamDeath                  = 2
deathrun.TeamRunner                 = 3
deathrun.TeamSpectators             = 1002

-----------------------------------------------------------------
-- [ OTHER SETTINGS ]
-----------------------------------------------------------------

deathrun.TeamDeathTitle             = 'Death'
deathrun.TeamRunnerTitle            = 'Runners'
deathrun.SpectatorsTitle            = 'Spectating'