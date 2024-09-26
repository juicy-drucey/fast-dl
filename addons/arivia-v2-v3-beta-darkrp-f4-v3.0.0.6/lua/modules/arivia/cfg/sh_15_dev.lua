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
local access                = base.a

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   SETTINGS > DEVELOPER
*/

    /*
    *   developer > regeneration
    *
    *   if enabled; all pnls will be created each time the interface is opened.
    *   do not turn this on unless you know what you're doing.
    */

        cfg.dev.regeneration = false

    /*
    *   developer > disable animations
    */

        cfg.dev.bDisableAnim = false

    /*
    *   developer > cvars
    *
    *   settings listed in F4 menu which have toggle boxes.
    *   these appear in the "Commands, Stats, and Settings" tab.
    *
    *   to change a setting; edit the value 'default'. if you change the default value
    *   of a setting; it will not take affect for players whom have already connected
    *   to your server. it will ONLY affect new players.
    */

        cfg.dev.cvarlst =
        {
            { sid = 1, type = 'checkbox',   enabled = true,   id = 'arivia_cmds_aclose',       name = 'Autoclose Commands',        desc = 'auto-closes the interface when a command is clicked',                           forceset = false, default = 1, values = { }, condition = function( pl ) return true end },
            { sid = 2, type = 'checkbox',   enabled = true,   id = 'arivia_onbuy_aclose',      name = 'Autoclose OnBuy',           desc = 'auto-closes the interface when items are purchased',                            forceset = false, default = 1, values = { }, condition = function( pl ) return true end },
            { sid = 3, type = 'checkbox',   enabled = true,   id = 'arivia_popup_enabled',     name = 'Popup Notifications',       desc = 'enables popups when buying items or switching jobs if issues occur',            forceset = false, default = 1, values = { }, condition = function( pl ) return true end },
            { sid = 4, type = 'checkbox',   enabled = true,   id = 'arivia_mdls_3d',           name = 'Use 3D Models',             desc = 'jobs will show 3d player model if enabled instead of still images',             forceset = false, default = 1, values = { }, condition = function( pl ) return true end, execute = function( pl ) if CLIENT then mod.ui:Rehash( ) end end, status = 'Restarting interface...' },
            { sid = 5, type = 'checkbox',   enabled = true,   id = 'arivia_sa_tools',          name = 'SA: Tools',                 desc = 'superadmin > displays tips in cats and copy-to-clipboard feature',              forceset = false, default = 0, values = { }, condition = function( pl ) return access:bIsRoot( pl ) and true or false end },
            { sid = 6, type = 'checkbox',   enabled = true,   id = 'arivia_sa_debug',          name = 'SA: Debug Mode',            desc = 'superadmin > displays debugging info for superadmins',                          forceset = false, default = 0, values = { }, condition = function( pl ) return access:bIsRoot( pl ) and true or false end },
        }

    /*
    *   developer > admin override
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    */

        cfg.dev.admin_override = false

    /*
    *   developer > unlock all
    *
    *   toggles all interfaces to be activated / visible without any checks being required.
    *   only should be used by the developer
    */

        cfg.dev.unlockall = false

    /*
    *   developer > superadmin-only > tips
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    */

        cfg.dev.sadmin_tips =
        {
            [ 'jobs' ] =
[[Superadmin Tip

L-Click:     Copy job name
M-Click:    Copy job command
R-Click:     Copy job mdl path
]],
            [ 'ents' ] =
[[Superadmin Tip

L-Click:     Copy ent name
M-Click:    Copy ent id
R-Click:     Copy ent mdl path
]],
            [ 'weps' ] =
[[Superadmin Tip

L-Click:     Copy weapon name
M-Click:    Copy weapon command
R-Click:     Copy weapon mdl path
]],
            [ 'ammo' ] =
[[Superadmin Tip

L-Click:     Copy ammo name
M-Click:    Copy ammo id
R-Click:     Copy ammo mdl path
]],
            [ 'food' ] =
[[Superadmin Tip

L-Click:     Copy food name
M-Click:    Copy food id
R-Click:     Copy food mdl path
]],
            [ 'vehc' ] =
[[Superadmin Tip

L-Click:     Copy ent name
M-Click:    Copy ent id
R-Click:     Copy ent mdl path
]],
        }

    /*
    *   developer > jobs > descriptions
    *
    *   overriding ability on job descriptions for demo purposes.
    */

        cfg.dev.descriptions = { }

    /*
    *   developer > about > button
    *
    *   displays the about button ( eye icon ) in top-right corner of interface
    */

        cfg.dev.bShowAbout = true

    /*
    *   developer > OnTeamSwitch > send data
    *
    *   forces all data to rehash when a player switches teams.
    *   this is for testing purposes only; do not enable this.
    */

        cfg.dev.OnTeamSwitch_rnet = false

    /*
    *   developer > about > thanks
    *
    *   simply gives thanks for extra contributions
    */

        cfg.dev.contribs =
        {
            {
                name    = 'Threebow',
                desc    = 'functionality ideas from TDLib',
                url     = 'https://www.gmodstore.com/users/threebow/addons',
            },
            {
                name    = 'SneakySquid',
                desc    = 'circles library',
                url     = 'https://github.com/SneakySquid/Circles',
            },
            {
                name    = 'Richard',
                desc    = 'rlib',
                url     = 'https://rlib.io/',
            },
        }

    /*
    *   model viewer > general
    *
    *   various setting related to mviewer (model viewer) interface
    *
    *   :   ui.width, ui.height
    *       determines the size of the interface
    */

        cfg.dev.mdlv =
        {
            ui =
            {
                width               = 1000,
                height              = 900,
            },
        }

/*
*   SETTINGS > ANIMATIONS
*/

    /*
    *   anim > cat speed
    *
    *   various commands related to animations
    *
    *   :   cfg.anim.cat_speed
    *       how fast animations for categories will occur when categories are expanded / hidden
    */

        cfg.dev.anim_cat_speed      = 0.3

    /*
    *   anim > nofocus fade
    *
    *   if the model viewer ( mdlv ) is opened, the F4 interface will fade so that the mdlv is more easily seen.
    *   this value determines how much to fade it.
    *
    *   >   0       = completely invisible
    *   >   255     = completely visible
    */

        cfg.dev.anim_fade_nofocus   = 35