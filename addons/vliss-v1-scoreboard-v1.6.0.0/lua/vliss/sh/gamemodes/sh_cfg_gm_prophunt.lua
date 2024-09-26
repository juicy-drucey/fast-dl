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
local handle                = base.handle
local prophunt              = base.ph

/*
*   enable gamemode
*
*   the setting below is what tells this script which gamemode you are using.
*   most of the time; vliss can detect which gamemode you're running, however,
*   if vliss reports in console that you have an 'Unknown Gamemode'; you can
*   force a specific gamemode by enabling the setting below:
*/

prophunt.Enabled            = prophunt.Enabled or false

/*
*   settings > prophunt > teams
*/

prophunt.TeamPropsTitle             = 'Props'
prophunt.TeamHuntersTitle           = 'Hunters'
prophunt.SpectatorsTitle            = 'Spectators'
prophunt.SpeclistBoxHeight          = 35
prophunt.SpeclistBoxColor           = Color( 0, 0, 0, 250 )
prophunt.SpeclistBoxBorderlineColor = Color( 255, 255, 255, 255 )
prophunt.SpeclistTitleTextColor     = Color( 230, 25, 25, 255 )
prophunt.SpeclistPlayersTextColor   = Color( 255, 255, 255, 255 )
prophunt.UnassignedEnabled          = true
prophunt.UnassignedTitle            = 'Unassigned'
prophunt.ForceTeamCooldown          = 5

/*
*   settings > prophunt > permissions
*/

prophunt.allow_move_player =
{
    [ 'superadmin' ]                = true,
    [ 'admin' ]                     = true,
    [ 'supervisor' ]                = true,
    [ 'operator' ]                  = true,
}

/*
*   settings > prophunt > set teams
*
*   this will set the correct teams for the gamemode you are running
*   edit the team IDs within vliss\lua\vliss\sh\sh_cfg_gm.lua
*/

local function set_teams( )
    if not prophunt.Enabled then return end

    prophunt.TeamHunters            = handle:GetGNData( )[ 'teams' ][ 'hunters' ]
    prophunt.TeamProps              = handle:GetGNData( )[ 'teams' ][ 'props' ]
    prophunt.TeamSpectators         = handle:GetGNData( )[ 'teams' ][ 'spec' ]
    prophunt.TeamUnassigned         = 1001
end
hook.Add( 'vliss_gm_loaded', 'vliss_cfg_teams_set', set_teams )