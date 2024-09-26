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
*   SETTINGS > NAV BUTTONS
*/

    /*
    *	menu buttons [ top header menu ]
    *
    *	buttons that will display at the very top of the UI, which house buttons such as your community
    *   forums, rules, website, donations, etc.
    *
    *   these settings allow you to specify what link the button will go to.
    *
    *       int    :   true     button will open website in integrated browser built into script
    *                           please note that using this feature relies on an outdated framework provided by
    *                           facepunch which may cause certain websites to not load properly.
    *
    *               :   false   button will open website in steam web browser overlay
    *
    *   @note   :   to translate the button names/description, open addons manifest file and change the language
    */

    /*
    *	nav > button > network rules
    */

        cfg.nav.btn.rules_url               = 'https://arivia.rlib.io/internal/rules'
        cfg.nav.btn.rules_int               = true

    /*
    *	nav > button > donations
    */

        cfg.nav.btn.donate_url              = 'https://arivia.rlib.io/internal/demo'
        cfg.nav.btn.donate_int              = true

    /*
    *	nav > button > discord
    */

        cfg.nav.btn.discord_url             = 'https://discord.com'
        cfg.nav.btn.discord_int             = true

    /*
    *	nav > button > community website
    */

        cfg.nav.btn.website_url             = 'https://arivia.rlib.io/internal/demo'
        cfg.nav.btn.website_int             = true

    /*
    *	nav > button > steam workshop collection
    */

        cfg.nav.btn.workshop_url            = 'https://steamcommunity.com/sharedfiles/filedetails/?id=3330825764'
        cfg.nav.btn.workshop_int            = true

/*
*   navigation menu
*
*   settings related to the main menu that appears to the left of the interface
*
*   >   btn_show_icon
*       determines if icon will display to the left of the button text
*
*   >   btn_show_desc
*       determines if description will display under button name
*
*   >   btn_show_cornerlines
*       displays lines in the top left and bottom right corner of each button
*
*   >   clrs
*       list of colors associated to this section
*/

    cfg.nav.general =
    {
        btn_show_icon               = true,
        btn_show_desc               = true,
        btn_show_cornerlines        = false,
        clrs =
        {
            corner_lines            = Color( 255, 255, 255, 75 ),
            btn_web_box             = Color( 48, 61, 103, 255 ),
            btn_web_txt             = Color( 255, 255, 255, 255 ),
        }
    }

/*
*   nav > integrated web browser
*
*   settings related to the main menu that appears to the left of the interface
*/

    cfg.nav.ibws =
    {
        clrs =
        {
            box             = Color( 48, 61, 103, 255 ),
            txt             = Color( 255, 255, 255, 255 ),
            cur             = Color( 200, 200, 200, 255 ),
            highlight       = Color( 25, 25, 25, 255 ),
        }
    }

/*
*	nav menu > list
*
*   >   enabled
*       determines if the menu item displays or not
*
*   >   name
*       name of menu item ( called from addon translation file )
*
*   >   desc
*       description ( called under menu name )
*
*   >   icon
*       icon to display ( registered in the addons manifest / env file )
*
*   >   clrs
*       table that provides all colors for interface
*
*   >   bNoClear
*       specified when a button doesnt need to clear all panels
*       used for actions that utilize external windows / methods
*
*   >   action
*       functionality that occurs when button is clicked
*/

    cfg.nav.list =
    {
        {
            enabled         = true,
            bIntegrated     = cfg.nav.btn.workshop_int,
            id              = 'staff',
            name            = 'mnu_btn_staff_name',
            desc            = 'mnu_btn_staff_desc',
            icon            = 'gen_staff_02',
            clrs =
            {
                box_n       = Color( 42, 76, 107, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                box_s       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            exec            = function( pnl )
                                if not CLIENT then return end
                                if not base.i:ok( pnl ) then return end

                                pnl:StaffOpen( )
                            end
        },
        {
            enabled         = true,
            bIntegrated     = cfg.nav.btn.rules_int,
            id              = 'rules',
            name            = 'mnu_btn_rules_name',
            desc            = 'mnu_btn_rules_desc',
            icon            = 'gen_rules_02',
            clrs =
            {
                box_n       = Color( 152, 121, 89, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                box_s       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            exec            = function( pnl )
                                mod.rules:Open( cfg.nav.btn.rules_url, cfg.nav.btn.rules_int )
                            end
        },
        {
            enabled         = true,
            bIntegrated     = cfg.nav.btn.donate_int,
            id              = 'donate',
            name            = 'mnu_btn_donate_name',
            desc            = 'mnu_btn_donate_desc',
            icon            = 'gen_donate_02',
            clrs =
            {
                box_n       = Color( 145, 71, 101, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                box_s       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            exec            = function( pnl ) mod.web:Open( 'mnu_btn_donate_name', cfg.nav.btn.donate_url, cfg.nav.btn.donate_int or false ) end
        },
        {
            enabled         = true,
            bIntegrated     = cfg.nav.btn.discord_int,
            id              = 'discord',
            name            = 'mnu_btn_discord_name',
            desc            = 'mnu_btn_discord_desc',
            icon            = 'gen_discord_02',
            clrs =
            {
                box_n       = Color( 76, 98, 150, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                box_s       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            exec            = function( pnl ) mod.web:Open( 'mnu_btn_discord_name', cfg.nav.btn.discord_url, cfg.nav.btn.discord_int or false ) end
        },
        {
            enabled         = true,
            bIntegrated     = cfg.nav.btn.website_int,
            id              = 'website',
            name            = 'mnu_btn_website_name',
            desc            = 'mnu_btn_website_desc',
            icon            = 'gen_website_03',
            clrs =
            {
                box_n       = Color( 54, 84, 67, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                box_s       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            exec            = function( pnl ) mod.web:Open( 'mnu_btn_website_name', cfg.nav.btn.website_url, cfg.nav.btn.website_int or false ) end
        },
        {
            enabled         = true,
            bIntegrated     = cfg.nav.btn.workshop_int,
            id              = 'workshop',
            name            = 'mnu_btn_workshop_name',
            desc            = 'mnu_btn_workshop_desc',
            icon            = 'gen_steam_02',
            clrs =
            {
                box_n       = Color( 61, 60, 80, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                box_s       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            exec            = function( pnl )
                                if cfg.nav.workshops_bAdv then
                                    mod.ui:Workshop( )
                                else
                                    mod.web:Open( 'mnu_btn_workshop_name', cfg.nav.btn.workshop_url, cfg.nav.btn.workshop_int or false )
                                end
                            end
        },
        {
            enabled         = true,
            id              = 'settings',
            name            = 'mnu_btn_settings_name',
            desc            = 'mnu_btn_settings_desc',
            icon            = 'gen_settings_01',
            clrs =
            {
                box_n       = Color( 64, 105, 126, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            bNoClear        = true,
            exec            = function( pnl )
                                rcc.run.gmod( 'gamemenucommand', 'openoptionsdialog' )
                                timex.simple( 0, function( ) rcc.run.gmod( 'gameui_activate' ) end )
                            end
        },
        {
            enabled         = false,
            id              = 'console',
            name            = 'mnu_btn_console_name',
            desc            = 'mnu_btn_console_desc',
            icon            = 'gen_console_02',
            clrs =
            {
                box_n       = Color( 25, 25, 25, 255 ),
                box_h       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            bNoClear        = true,
            exec            = function( pnl )
                                rcc.run.gmod( 'showconsole' )
                                timex.simple( 0, function( ) rcc.run.gmod( 'gameui_activate' ) end )
                            end
        },
        {
            enabled         = true,
            id              = 'disconnect',
            name            = 'mnu_btn_disconnect_name',
            desc            = 'mnu_btn_disconnect_desc',
            icon            = 'gen_disconnect_02',
            clrs =
            {
                box_n       = Color( 124, 51, 50, 190 ),
                box_h       = Color( 48, 48, 48, 255 ),
                txt_n       = Color( 255, 255, 255, 255 ),
            },
            bNoClear        = true,
            exec            = function( pnl )
                                if CLIENT then
                                    mod.dc:Initialize( )
                                end
                            end
        },
    }

/*
*   NAV > WORKSHOPS
*/

    /*
    *   workshops > advanced
    *
    *   if enabled; interface will display advanced workshop list, allowing for multiple workshops to be
    *   visible in a list.
    *
    *   disabled ( false ) will make the Workshops button go directly to the one workshop link provided in sh_3_nav.lua
    */

        cfg.nav.workshops_bAdv      = true

    /*
    *   workshops > list
    *
    *   list of workshops to display if cfg.nav.workshops_bAdv = true
    *
    *   @note   : the collection marked 'Server Collection' will not show unless
    *             a server collection id is provided in cfg.nav.btn.workshop_url
    */

        cfg.nav.workshops =
        {
            {
                enabled             = true,
                bScript             = false,
                bLib                = false,
                bMain               = true,
                ico                 = '',
                name                = 'ws_item_server_name',
                tip                 = 'ws_item_server_tip',
                clr                 = Color( 35, 95, 76, 100 ),
            },
            {
                enabled             = true,
                bScript             = false,
                bLib                = true,
                bMain               = false,
                ico                 = '',
                name                = 'ws_item_library_name',
                tip                 = 'ws_item_library_tip',
                clr                 = Color( 59, 71, 117, 100 ),
            },
            {
                enabled             = true,
                bScript             = true,
                bLib                = false,
                bMain               = false,
                ico                 = '',
                name                = 'ws_item_f4_name',
                tip                 = 'ws_item_f4_tip',
            },
            {
                enabled             = false,
                bScript             = false,
                bLib                = false,
                bMain               = false,
                ico                 = '',
                name                = 'ws_item_ws_name',
                id                  = 'ws_item_ws_desc',
                tip                 = '',
            },
        }
