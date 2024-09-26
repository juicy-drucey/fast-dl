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
*   SETTINGS > LOADOUT
*/

    /*
    *   LOADOUT > GENERAL
    */

        cfg.loadout.general =
        {
            clrs =
            {
                pnl_main                = Color( 30, 30, 30, 255 ),
                txt_noload              = Color( 150, 150, 150, 255 ),
                txt_desc                = Color( 255, 255, 255, 255 ),
                box_side                = Color( 255, 255, 255, 2 ),
                box_n                   = Color( 30, 30, 30, 255 ),
                box_h                   = Color( 69, 39, 37, 255 ),
            }
        }

    /*
    *   LOADOUT > LIST
    *
    *   a list of ents / sweps that can have their info overwritten.
    *   do not remove default half life items like weapon_bugbait, etc.
    *   they are handled differently than addons.
    */

        cfg.loadout.list =
        {
            [ 'weapon_pistol' ] =
            {
                name    = 'Pistol',
                desc    = 'A standard pistal',
                model   = 'models/weapons/w_pistol.mdl',
            },

            [ 'weapon_357' ] =
            {
                name    = '.357 Revolver',
                desc    = 'Powerful 5-shot',
                model   = 'models/weapons/w_357.mdl',
            },

            [ 'weapon_crossbow' ] =
            {
                name    = 'Crossbow',
                model   = 'models/weapons/w_crossbow.mdl',
            },

            [ 'weapon_crowbar' ] =
            {
                name    = 'Crowbar',
                model   = 'models/weapons/w_crowbar.mdl',
            },

            [ 'weapon_frag' ] =
            {
                name    = 'Grenade',
                model   = 'models/weapons/w_grenade.mdl',
            },

            [ 'weapon_physcannon' ] =
            {
                name    = 'Gravity Gun',
                model   = 'models/weapons/w_Physics.mdl',
            },

            [ 'weapon_ar2' ] =
            {
                name    = 'Pulse-Rifle',
                model   = 'models/weapons/w_irifle.mdl',
            },

            [ 'weapon_rpg' ] =
            {
                name    = 'RPG',
                desc    = 'Rocket-propelled grenades',
                model   = 'models/weapons/w_rocket_launcher.mdl',
            },

            [ 'weapon_slam' ] =
            {
                name    = 'SLAM',
                model   = 'models/weapons/w_slam.mdl',
            },

            [ 'weapon_shotgun' ] =
            {
                name    = 'Shotgun',
                model   = 'models/weapons/w_shotgun.mdl',
            },

            [ 'weapon_smg1' ] =
            {
                name    = 'SMG',
                model   = 'models/weapons/w_smg1.mdl',
            },

            [ 'weaponchecker' ] =
            {
                name    = 'Weapon Checker',
                fov     = 42,
            },

            [ 'door_ram' ] =
            {
                name    = 'Door Ram',
                desc    = 'Break doors',
            },

            [ 'weapon_deagle2' ] =
            {
                name    = 'Desert Eagle',
                desc    = 'Powerful pistol',
            },

            [ 'weapon_glock2' ] =
            {
                name    = 'Glock Pistol',
                desc    = '9mm pistol',
            },

            [ 'weapon_bugbait' ] =
            {
                desc    = 'Squishy nothingness',
                model   = 'models/weapons/w_bugbait.mdl',
            },

            [ 'weapon_bugbait' ] =
            {
                name    = 'Bugbait',
                model   = 'models/weapons/w_bugbait.mdl',
            },

            [ 'arrest_stick' ] =
            {
                desc    = 'Arrest players',
            },

            [ 'unarrest_stick' ] =
            {
                desc    = 'Unarrest players',
            },

            [ 'weapon_stunstick' ] =
            {
                name    = 'Stunstick',
                desc    = 'Stop players in motion',
                model   = 'models/weapons/w_stunbaton.mdl',
            },

            [ 'stunstick' ] =
            {
                name    = 'Stunstick',
                desc    = 'Stop players in motion',
                model   = 'models/weapons/w_stunbaton.mdl',
            },

            [ 'weaponchecker' ] =
            {
                desc    = 'Inspect player weapons',
            },

            [ 'lockpick' ] =
            {
                desc    = 'Helps unlock doors',
            },

            [ 'med_kit' ] =
            {
                desc    = 'Help yourself or others',
            },
        }