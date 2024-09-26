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

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   usergroups
*
*   allows the interface to display a list of staff currently on the server
*   for other plys to view.
*
*   each entry involves defining a title and a color.
*   to add a new entry, add an entry for each.
*
*   user groups should be entered using only lower-case letters
*   and underscores where spaces are. this helps with keeping
*   things clean. the system will automatically format groups
*   even if yours have cap letters.
*
*   @ex         :   My Admin Group
*                   staff.title[ 'my_admin_group' ]     = 'My Admin Group'
*                   staff.colors[ 'my_admin_group' ]    = Color( 255, 255, 255, 255 )
*
*   @type       : bool
*   @default    : false
*/

    /*
    *   list of user groups to be recognized by the script.
    *
    *   will display these at the bottom left of the motd under the players
    *   username
    *
    *   because different networks setup group names differently;
    *   please do the following when providing a group:
    *
    *       :   make all letters lowercase
    *       :   replace spaces with underscores
    *
    *   @ex :   SuperAdmin      =>      superadmin
    *           Trial Mod       =>      trial_mod
    */

        cfg.ugroups.titles =
        {
            [ 'superadmin' ]        = 'Owner',
            [ 'super_admin' ]       = 'Owner',
            [ 'admin' ]             = 'Admin',
            [ 'supervisor' ]        = 'Supervisor',
            [ 'gamemaster' ]        = 'Game Master',
            [ 'operator' ]          = 'Moderator',
            [ 'moderator' ]         = 'Moderator',
            [ 'trialmod' ]          = 'Trial Moderator',
            [ 'tmod' ]              = 'Trial Moderator',
            [ 'donator' ]           = 'Donator',
            [ 'enthralled' ]        = 'Enthralled',
            [ 'respected' ]         = 'Respected',
            [ 'user' ]              = 'User',
            [ 'noaccess' ]          = 'User',
        }

    /*
    *   associated with the ugroup titles above.
    *
    *   this will determine what color the text is that displays
    *   depending on what the players usergroup is
    *
    *   will display these at the bottom left of the motd under the players
    *   username
    *
    *   because different networks setup group names differently;
    *   please do the following when providing a group:
    *
    *       :   make all letters lowercase
    *       :   replace spaces with underscores
    *
    *   @ex :   SuperAdmin      =>      superadmin
    *           Trial Mod       =>      trial_mod
    */

        cfg.ugroups.clrs =
        {
            [ 'superadmin' ]        = Color( 179, 46, 46, 30 ),
            [ 'super_admin' ]       = Color( 179, 46, 46, 30 ),
            [ 'admin' ]             = Color( 195, 210, 48, 30 ),
            [ 'supervisor' ]        = Color( 246, 141, 67, 30 ),
            [ 'gamemaster' ]        = Color( 31, 133, 222, 30 ),
            [ 'operator' ]          = Color( 46, 101, 67, 30 ),
            [ 'moderator' ]         = Color( 46, 101, 179, 30 ),
            [ 'trialmod' ]          = Color( 246, 94, 179, 30 ),
            [ 'tmod' ]              = Color( 246, 94, 116, 30 ),
            [ 'donator' ]           = Color( 26, 127, 245, 30 ),
            [ 'user' ]              = Color( 255, 255, 255, 30 ),
            [ 'noaccess' ]          = Color( 200, 200, 200, 30 ),
        }

    /*
    *   usergroups > staff clarification
    *
    *   this table includes a list of all usergroups on the server
    *   that are classified as 'staff groups'.
    *
    *   set a value to FALSE if it is a regular group, set TRUE if the group
    *   should be displayed in the 'Staff' tab.
    */

        cfg.ugroups.staff =
        {
            [ 'superadmin' ]        = true,
            [ 'super_admin' ]       = true,
            [ 'admin' ]             = true,
            [ 'supervisor' ]        = true,
            [ 'gamemaster' ]        = true,
            [ 'operator' ]          = true,
            [ 'moderator' ]         = true,
            [ 'trialmod' ]          = true,
            [ 'tmod' ]              = true,
            [ 'donator' ]           = false,
            [ 'enthralled' ]        = false,
            [ 'respected' ]         = false,
            [ 'user' ]              = false,
            [ 'noaccess' ]          = false,
        }