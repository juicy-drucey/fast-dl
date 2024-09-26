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
local mf                    = base.mf
local cfg                   = base.cfg
local core                  = base.core

/*
*   SETTINGS > GENERAL
*/

    cfg.general =
    {
        size_w                      = 0.85,
        size_h                      = 0.85,
        size_btn_line               = 15,
        network_name                = 'Welcome',
        hide_spectators             = false,                                -- Set this to true if you don't want spectators shown on the scoreboard.
        team_mode                   = false,                                -- Set this to true if you want vliss to show players grouped in a team box. SHOULD BE TURNED OFF FOR MURDER.
        team_coloring               = false,                                -- Set this to true if you want the player rows to reflect their team coloring.
        menu_icons_only             = true,
        clrs =
        {
            network_txt             = Color( 255, 255, 255, 255 ),
            pl_row_txt              = Color( 255, 255, 255, 255 ),
            pl_row_txt_alt          = Color( 255, 255, 255, 60 ),
            pnl_header              = Color( 93, 37, 37, 255 ),
            pnl_middle              = Color( 29, 29, 29, 255 ),             -- middle bg color if static / live wallpapers turned OFF
            pnl_middle_bg           = Color( 0, 0, 0, 230 ),                -- middle bg color if static / live wallpapers turned ON
            pnl_left_middle         = Color( 24, 24, 24, 255 ),             -- left middle panel bg color if static / live wallpapers turned OFF
            pnl_left_middle_bg      = Color( 0, 0, 0, 240 ),                -- left middle panel bg color if static / live wallpapers turned ON
            pnl_left_top            = Color( 126, 42, 43, 255 ),
            btn_left_top_h          = Color( 40, 0, 0, 255 ),
            data_col                = Color( 45, 45, 45, 255 ),
            team_row                = Color( 25, 25, 25, 220 ),
            integrated_browser      = Color( 35, 35, 35, 200 ),
            separator               = Color( 255, 255, 255, 5 ),
            btn_line                = Color( 255, 255, 255, 255 ),
            pl_row_filter           = Color( 0, 0, 0, 100 ),
        }
    }

/*
*   SETTINGS > SLIDER MENU
*
*   interface that appears from the bottom when clicking on a player
*/

    cfg.slmenu =
    {
        clrs =
        {
            pl_name                 = Color( 255, 255, 255, 50 ),
            pl_money                = Color( 90, 175, 115, 255 ),
            pnl_allow               = Color( 28, 70, 108, 200 ),
            pnl_deny                = Color( 93, 37, 37, 200 ),
        }
    }

/*
*   SETTINGS > SPLIT BOARD
*
*   these settings are only for the 'split-board' interface, which enables
*   in gamesmodes such as murder / prophunt.
*/

    cfg.splitboard =
    {
        clrs =
        {
            lbl_nane_t1_box         = Color( 45, 45, 45, 255 ),             -- team 1 > name > label > box
            lbl_name_t1_txt         = Color( 255, 255, 255, 255 ),          -- team 1 > name > label > txt
            btn_join_t1_box         = Color( 41, 83, 120, 255 ),            -- team 1 > join > button
            btn_join_t1_box_li      = Color( 255, 255, 255, 5 ),            -- team 1 > join > button shadow
            btn_join_t1_txt         = Color( 255, 255, 255, 255 ),          -- team 1 > join > txt
            lbl_nane_t2_box         = Color( 45, 45, 45, 255 ),             -- team 2 > name > label > box
            lbl_name_t2_txt         = Color( 255, 255, 255, 255 ),          -- team 2 > name > label > txt
            btn_join_t2_box         = Color( 119, 59, 52, 255 ),            -- team 2 > join > button
            btn_join_t2_box_li      = Color( 255, 255, 255, 5 ),            -- team 2 > join > button shadow
            btn_join_t2_txt         = Color( 255, 255, 255, 255 ),          -- team 2 > join > txt
        }
    }

/*
*   SETTINGS > BACKGROUNDS
*/

    /*
    *   backgrounds > static
    */

        cfg.bg.static.enabled           = false
        cfg.bg.static.list =
        {
            'http://cdn.rlib.io/wp/s/1.jpg',
            'http://cdn.rlib.io/wp/s/2.jpg',
            'http://cdn.rlib.io/wp/s/3.jpg',
            'http://cdn.rlib.io/wp/s/4.jpg',
        }

    /*
    *   backgrounds > live
    */

        cfg.bg.live.enabled             = false
        cfg.bg.live.list =
        {
            'http://cdn.rlib.io/wp/l/index.php?id=default_1',
            'http://cdn.rlib.io/wp/l/index.php?id=default_2',
            'http://cdn.rlib.io/wp/l/index.php?id=default_3',
            'http://cdn.rlib.io/wp/l/index.php?id=default_4',
            'http://cdn.rlib.io/wp/l/index.php?id=default_5',
            'http://cdn.rlib.io/wp/l/index.php?id=default_6',
            'http://cdn.rlib.io/wp/l/index.php?id=default_7',
            'http://cdn.rlib.io/wp/l/index.php?id=default_8',
            'http://cdn.rlib.io/wp/l/index.php?id=default_9',
            'http://cdn.rlib.io/wp/l/index.php?id=default_10',
            'http://cdn.rlib.io/wp/l/index.php?id=default_11',
        }

    /*
    *   backgrounds > filter
    */

        cfg.bg.filter.color         = Color( 29, 29, 29, 0 )
        cfg.bg.filter.bBlur         = true

/*
*   SETTINGS > GROUPS
*/

    /*
    *   groups > general
    */

        cfg.groups.bColorsEnabled   = true  -- Set this to true if you want your user groups to have different coloring as defined below.

    /*
    *   groups > titles
    *
    *   this section allows you to override the usergroup that displays
    *   within a staff member's card.
    *
    *   @NOTE   : to prevent mismatched group names; make your usergroup
    *             name in the list below 'lowercase', and replace spaces
    *             with underscores.
    *
    *             Example >     Super Admin     == super_admin
    *                           Trial Mod       == trial_mod
    *                           Moderator       == moderator
    */

        cfg.groups.titles = { }
        cfg.groups.titles[ 'superadmin' ]   = 'Owner'
        cfg.groups.titles[ 'admin' ]        = 'Admin'
        cfg.groups.titles[ 'supervisor' ]   = 'Supervisor'
        cfg.groups.titles[ 'operator' ]     = 'Mod'
        cfg.groups.titles[ 'moderator' ]    = 'Mod'
        cfg.groups.titles[ 'trialmod' ]     = 'Trial Mod'
        cfg.groups.titles[ 'donator' ]      = 'Donator'
        cfg.groups.titles[ 'user' ]         = 'User'
        cfg.groups.titles[ 'noaccess' ]     = 'User'

    /*
    *   groups > colors
    *
    *   this section allows you to specify what color a staff member's card
    *   will have as the background.
    *
    *   @NOTE   : to prevent mismatched group names; make your usergroup
    *             name in the list below 'lowercase', and replace spaces
    *             with underscores.
    *
    *             Example >     Super Admin     == super_admin
    *                           Trial Mod       == trial_mod
    *                           Moderator       == moderator
    */

        cfg.groups.colors                   = { }
        cfg.groups.colors[ 'founder' ]      = Color( 136, 55, 56, 255 )
        cfg.groups.colors[ 'superadmin' ]   = Color( 136, 55, 56, 255 )
        cfg.groups.colors[ 'admin' ]        = Color( 136, 121, 65, 255 )
        cfg.groups.colors[ 'supervisor' ]   = Color( 102, 54, 68, 255 )
        cfg.groups.colors[ 'operator' ]     = Color( 54, 102, 55, 255 )
        cfg.groups.colors[ 'moderator' ]    = Color( 54, 102, 55, 255 )
        cfg.groups.colors[ 'trialmod' ]     = Color( 45, 48, 73, 255 )
        cfg.groups.colors[ 'donator' ]      = Color( 30, 60, 85, 255 )
        cfg.groups.colors[ 'user' ]         = Color( 43, 43, 43, 255 )
        cfg.groups.colors[ 'noaccess' ]     = Color( 43, 43, 43, 255 )

/*
*   SETTINGS > STAFF CARD
*
*   staff cards are the boxes that display within the 'staff' interface.
*   each staff member will have their avatar and rank displayed in a list.
*/

    /*
    *   staff card > general
    */

        cfg.staffcard =
        {
            general =
            {
                bBlurCard           = false,
                bUseRankColor       = true,                         -- Use rank color for staff card background color?
            },
            clrs =
            {
                card_bg             = Color( 0, 0, 0, 230 ),
                txt_pl_name         = Color( 255, 255, 255, 255 ),  -- Text color for player name
                txt_pl_rank         = Color( 255, 255, 255, 255 ),  -- Text color for player rank
            }
        }

-----------------------------------------------------------------
-- [ GUI - COMMAND BOX ]
-----------------------------------------------------------------
-- These settings deal with the command box colors.
-- The command box is the box that appears when you click on a
-- players name in the scoreboard and the box at the bottom
-- appears.
-----------------------------------------------------------------

    cfg.acts =
    {
        clrs =
        {
            pnl_main                    = Color( 37, 37, 37, 255 )
        },
    }

    core.CBoxLineColor                  = Color( 255, 255, 255, 255 )
    core.CBoxTextColor                  = Color( 255, 255, 255, 255 )
    core.CBoxCloseButtonColor           = Color( 255, 255, 255, 255 )

/*
*   SETTINGS > WIDGET
*
*   the area that displays a clock.
*
*   >   type                : 1     ( displays a clock )
*   >   type                : 2     ( current map / # of players )
*/

    cfg.widget.enabled              = true
    cfg.widget.type                 = 1
    cfg.widget.format               = '%a, %I:%M:%S %p'
    cfg.widget.clr_txt              = Color( 255, 255, 255, 255 )
    cfg.widget.clr_box              = Color( 126, 42, 43, 250 )

/*
*   SETTINGS > SPIFFY AVATARS
*
*   this feature replaces standard player avatars with spiffy ones
*
*   NOTE:   [ MURDER ]: Players won't have avatars by default, but enabling
*           this will at least put an avatar to the left of the player
*           and give it more of a visual enhancement.
*
*           [ OTHER GAMEMODES ] By default, players will display their
*           actual steam profile avatars. Using this will remove the
*           profile picture for each player and use the random avatar
*           system.
*/

    /*
    *   spiffy > general
    */

        cfg.spiffyav.enable         = false

    /*
    *   spiffy > list
    */

        cfg.spiffyav.list           =
        {
            'vliss/avatars/vliss_avatar_1.png',
            'vliss/avatars/vliss_avatar_2.png',
            'vliss/avatars/vliss_avatar_3.png',
            'vliss/avatars/vliss_avatar_4.png',
            'vliss/avatars/vliss_avatar_5.png',
            'vliss/avatars/vliss_avatar_6.png',
            'vliss/avatars/vliss_avatar_7.png',
            'vliss/avatars/vliss_avatar_8.png',
            'vliss/avatars/vliss_avatar_9.png',
            'vliss/avatars/vliss_avatar_10.png',
            'vliss/avatars/vliss_avatar_11.png',
            'vliss/avatars/vliss_avatar_12.png',
            'vliss/avatars/vliss_avatar_13.png',
            'vliss/avatars/vliss_avatar_14.png',
            'vliss/avatars/vliss_avatar_15.png',
            'vliss/avatars/vliss_avatar_16.png',
            'vliss/avatars/vliss_avatar_17.png',
            'vliss/avatars/vliss_avatar_18.png',
            'vliss/avatars/vliss_avatar_19.png',
            'vliss/avatars/vliss_avatar_20.png',
            'vliss/avatars/vliss_avatar_21.png'
        }

/*
*   SETTINGS > PERMISSIONS
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
    *   permission > is staff
    *
    *   this is a list of usergroups classified as 'staff';
    *   they will appear in the staff listing interface
    */

        cfg.perms.is_staff =
        {
            [ 'superadmin' ]        = true,
            [ 'admin' ]             = true,
            [ 'supervisor' ]        = true,
            [ 'operator' ]          = true,
            [ 'trial' ]             = true,
        }

    /*
    *   permission > transfer player to server
    *
    *   this permission allows a usergroup to have access to 'transfering players'.
    *   they will be able to force a player to another server in the list.
    */

        cfg.perms.pl_xfer =
        {
            [ 'superadmin' ]        = true,
            [ 'admin' ]             = false,
            [ 'supervisor' ]        = false,
            [ 'operator' ]          = false,
            [ 'trial' ]             = false,
        }

    /*
    *   permission > get > steamid
    *
    *   allows a staff member to copy another player's steamid to their clipboard.
    *   ( ctrl + c ).
    */

        cfg.perms.pl_get_sid =
        {
            [ 'superadmin' ]        = true,
            [ 'admin' ]             = true,
            [ 'supervisor' ]        = true,
            [ 'operator' ]          = true,
            [ 'trial' ]             = true,
        }

    /*
    *   permission > get > ip address
    *
    *   allows a staff member to copy another player's ip address to their clipboard.
    *   ( ctrl + c ).
    */

        cfg.perms.pl_get_ip =
        {
            [ 'superadmin' ]        = true,
            [ 'admin' ]             = true,
            [ 'supervisor' ]        = true,
            [ 'operator' ]          = true,
            [ 'trial' ]             = false,
        }

/*
*   SETTINGS > UMSGS
*
*   user messages display text in chat when certian actions have been
*   performed by staff / players.
*
*   these settings should not need to be modified unless you absolutely
*   know what you are doing.
*/

    /*
    *   umsgs > general
    */

        cfg.umsg =
        {
            id                  = mf.name,
            to_private          = 'PRIVATE',
            to_server           = 'SERVER',
            to_staff            = 'STAFF',
            to_admins           = 'ADMINS',
            to_console          = 'CONSOLE',
            to_rsay             = 'RSAY',
            to_self             = 'YOU',
            clrs =
            {
                msg             = Color( 255, 255, 255 ),       -- white
                c1              = Color( 255, 89, 0 ),          -- red / orange
                c2              = Color( 255, 255, 25 ),        -- yellow
                t1              = Color( 25, 200, 25 ),         -- green
                t2              = Color( 180, 20, 20 ),         -- dark red
                t3              = Color( 13, 134, 255 ),        -- blue
                t4              = Color( 255, 255, 25 ),        -- yellow
                t5              = Color( 255, 107, 250 ),       -- pink
                t6              = Color( 25, 200, 25 ),         -- green
            }
        }

/*
*   SETTINGS > DEVELOPER
*
*   these features perform special functions. these settings below should
*   not be modified for any reason.
*
*   no support will be provided for anything that goes wrong while utilizing
*   these features.
*/

    /*
    *   developer > general
    *
    *   >   bWorkshopEnabled            : force workshop collection download on player automatically
    *   >   bFastDL                     : utilize resource.AddFile on mats, sounds, and fonts
    *   >   bDevMode                    : regenerates all panels each time interface closed and opened again
    */

        cfg.dev.bWorkshopEnabled        = true
        cfg.dev.bFastDL                 = true
        cfg.dev.bDevMode                = false

        cfg.dev.general =
        {
            size_col_oset_h             = 2,
        }

    /*
    *   developer > simulate players
    *
    *   this table is for demo purposes only.
    *   it should not be touched.
    */

        cfg.dev.simulate =
        {
            [ 'def' ] =
            {
                name                    = 'Mark Maddux',
                group                   = 'superadmin',
            },
            [ 'bot01' ] =
            {
                name                    = 'Benny Bird',
                group                   = 'supervisor',
                ping                    = 34,
            },
            [ 'bot02' ] =
            {
                name                    = 'Danica',
                group                   = 'moderator',
                ping                    = 17,
            },
            [ 'bot03' ] =
            {
                name                    = 'Sir Walker Asscoaster',
                group                   = 'moderator',
                ping                    = 44,
            },
            [ 'bot04' ] =
            {
                name                    = 'Undertaker',
                group                   = 'admin',
                ping                    = 38,
            },
            [ 'bot05' ] =
            {
                name                    = 'LDaddy',
                group                   = 'trialmod',
                ping                    = 63,
            },
            [ 'bot06' ] =
            {
                name                    = 'SizzleMyFizzle',
                group                   = 'donator',
                ping                    = 80,
            },
            [ 'bot07' ] =
            {
                name                    = 'WheresTheBeef?',
                group                   = 'user',
                ping                    = 75,
            },
            [ 'bot08' ] =
            {
                name                    = 'paddox',
                group                   = 'user',
                ping                    = 78,
            },
            [ 'bot09' ] =
            {
                name                    = 'skillkiller',
                group                   = 'user',
                ping                    = 29,
            },
            [ 'bot10' ] =
            {
                name                    = 'Jeff',
                group                   = 'user',
                ping                    = 31,
            },
            [ 'bot11' ] =
            {
                name                    = 'McDaddy',
                group                   = 'user',
                ping                    = 46,
            },
            [ 'bot12' ] =
            {
                name                    = 'Ann Frank',
                group                   = 'user',
                ping                    = 52,
            },
        }