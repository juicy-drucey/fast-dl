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
local murder                = base.mu

/*
*   enable gamemode
*
*   the setting below is what tells this script which gamemode you are using.
*   most of the time; vliss can detect which gamemode you're running, however,
*   if vliss reports in console that you have an 'Unknown Gamemode'; you can
*   force a specific gamemode by enabling the setting below:
*/

    murder.Enabled                  = murder.Enabled or false

/*
*   murder > team 1
*/

    murder.t1_label                 = 'Players'
    murder.t1_label_join_btn        = 'Join'

/*
*   murder > team 2
*/

    murder.t2_label                 = 'Spectators'
    murder.t2_label_join_btn        = 'Join'

/*
*   murder > general
*/

    murder.AllowPlayerViewProfile   = false  -- This will disable the button so players cannot see other player's profile links in murder.

    murder.AdminFeatures =
    {
        ButtonContainerW            = 450,
        ButtonContainerH            = 100,
        ButtonActionW               = 100,
        ButtonActionH               = 25,
        ButtonNormalColor           = Color(64, 105, 126, 190),
        ButtonHoverColor            = Color(64, 105, 126, 240),
        ButtonTextColor             = Color(255,255,255,255),
    }

/*
*   MURDER > PERMISSIONS
*
*   @NOTE   : to prevent mismatched group names; make your usergroup
*             name in the list below 'lowercase', and replace spaces
*             with underscores.
*
*             Example >     Super Admin     == super_admin
*                           Trial Mod       == trial_mod
*                           Moderator       == moderator
*/

    /*
    *   murder > permission > view identity
    *
    *   the murder gamemode hides people's real names.
    *   enable this permission on usergroups that will be able to see the
    *   players' fake name AND real name.
    */

        murder.allow_see_realname =
        {
            [ 'superadmin' ]            = true,
            [ 'admin' ]                 = true,
            [ 'supervisor' ]            = false,
            [ 'operator' ]              = false,
        }

    /*
    *   murder > permission > move player
    *
    *   allows a usergroup permission to move players to different teams
    */

        murder.allow_move_player =
        {
            [ 'superadmin' ]            = true,
            [ 'admin' ]                 = true,
            [ 'supervisor' ]            = true,
            [ 'operator' ]              = true,
        }

    /*
    *   murder > permission > force murderer
    *
    *   allows a usergroup to force players to become murderer
    */

        murder.allow_force_murderer =
        {
            [ 'superadmin' ]            = true,
            [ 'admin' ]                 = true,
            [ 'supervisor' ]            = true,
            [ 'operator' ]              = false,
        }

    /*
    *   murder > permission > allow spectate
    *
    *   allows a usergroup to spectate other players
    */

        murder.allow_spectate =
        {
            [ 'superadmin' ]            = true,
            [ 'admin' ]                 = true,
            [ 'supervisor' ]            = true,
            [ 'operator' ]              = false,
        }