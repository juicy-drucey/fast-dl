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
*   tabs > general
*/

    cfg.tabs.general =
    {

        /*
        *   each item in a  category ( all buyable entities or jobs )
        */

        slot =
        {
            styleB                  = true,                                 -- will make slots use alternative layout
            mdl_size                = 65,                                   -- size of model
            mdl_unavail_bFade       = true,                                 -- fade if job / item unavailable
            mdl_unavail_fade        = 100,                                  -- fade amount of mode if item unavailable
            box_unavail_bFade       = true,                                 -- fade entire box if job / item unavailable
            box_unavail_fade        = 15,                                   -- fade entire box to x amount item unavailable
            box_unavail_fade_gra    = 150,                                  -- fade egradient if job / item unavailable
            cir_size                = 58,                                   -- diameter of circle on right of slot
            cir_line                = 3,                                    -- thickness of curcke line on right of slot
            cir_line_def_a          = 15,                                   -- circle > line > default > alpha
            cir_line_val_a          = 55,                                   -- circle > line > valid > alpha
            txt_left_w              = 80,                                   -- how far from the left that text will start
            grad_w                  = 0.4,                                  -- gradient width
            grad_o                  = 2,                                    -- gradient orientation ( 1 = left | 2 = right )
            qacts                   =
            {
                bUseIcons           = true,                                 -- if enabled, quick action btn will use an icon instead of text
                oset_txt_h          = 11,                                   -- text heigh offset
                oset_ico_h          = 14,                                   -- icon heigh offset
                clrs =
                {
                    bg_switch       = Color( 0, 0, 0, 150 ),                -- quick action btn > jobs > switch button
                    bg_locked       = Color( 99, 19, 26, 150 ),             -- quick action btn > locked
                    bg_buy          = Color( 0, 0, 0, 150 ),                -- quick action btn > buy button
                    ico_buy         = Color( 115, 158, 93 ),                -- quick action btn > icon color > buy / become job
                    ico_lock        = Color( 187, 84, 83 ),                 -- quick action btn > icon color > locked item / job
                    txt_buy         = Color( 255, 255, 255 ),               -- quick action btn > text color > buy / become job
                    txt_lock        = Color( 187, 84, 83 ),                 -- quick action btn > text color > locked item / job
                },
            },
            clrs =
            {
                bg_sel              = Color( 0, 0, 0, 50 ),                 -- box color when slot selected,
                cir_inner           = Color( 0, 0, 0, 100 ),                -- color of circle inner ( slot count / amount )
                cir_line_def        = Color( 120, 120, 120 ),               -- color of circle line ( default )
                btn_box_h_nojoin    = Color( 0, 0, 0, 100 ),                -- color of box when unavail to join and hovered
            },
        },

        /*
        *   colors associated to an item actually clicked on to select in the list of items
        *   ( right side box of F4 menu )
        */

        sel =
        {
            bBlur                   = true,                                 -- blur will be applied to sel bg gradient to smooth it
            bShowIcon               = true,
            ico_job                 = '',
            ico_buy                 = '',
            ico_vote                = '',
            ico_unavail             = '',
            indic_sz_w              = 95,
            indic_sz_h              = 23,
            clrs =
            {

                /*
                *   skins interface / count
                *
                *   displays at the top of the selected job on far top right
                */

                txt_skin_i          = Color( 230, 230, 230, 255 ),          -- skin count
                btn_skin_n          = Color( 255, 255, 255, 255 ),          -- skin > btn > normal
                btn_skin_h          = Color( 166, 14, 89, 255 ),            -- skin > btn > hover
                btn_skin_u          = Color( 255, 255, 255, 5 ),            -- skin > btn > unavaill
                box_skin_p          = Color( 255, 255, 255, 2 ),            -- skin > box > primary
                ico_mdlv_n          = Color( 255, 255, 255, 255 ),          -- model viewer > icon > normal

                /*
                *   action button
                *
                *   the button that a player must click on to become a job or buy an item ( bottom right of ui )
                */

                btn_act_h               = Color( 0, 0, 0, 100 ),                -- hover
                btn_act_s               = Color( 255, 255, 255, 4 ),            -- top-half shadow
                btn_act_allowed         = Color( 16, 95, 56, 255 ),             -- clr when allowed to buy
                btn_act_unavail         = Color( 27, 27, 27, 255 ),             -- btn clr when unavailable
                btn_act_vote            = Color( 37, 58, 85, 255 ),             -- btn clr when vote needed
                btn_act_ico             = Color( 255, 255, 255, 100 ),          -- ico clr for action button
                btn_act_txt             = Color( 255, 255, 255, 255 ),          -- txt clr for action button
                btn_act_curr            = Color( 63, 77, 118 ),                 -- btn clr for job that is currently used by player ( btn_gra_j has priority unless empty )
                btn_mdl_n               = Color( 64, 34, 64, 255 ),             -- btn clr when model preview button normal
                btn_mdl_h               = Color( 93, 42, 42, 255 ),             -- btn clr when model preview button hovered
                btn_mdl_s               = Color( 255, 255, 255, 5 ),            -- model viewer > btn > shadow

                indic_box               = Color( 35, 35, 35, 255 ),             -- tip box above tabs
                indic_bor               = Color( 255, 255, 255, 5 ),            -- tip box above tabs
                indic_ico_edit          = Color( 187, 84, 84, 255 ),            -- indicator icon > admin edit
                indic_ico_nocook        = Color( 215, 96, 178, 255 ),           -- indicator icon > not cook
                indic_ico_nojob         = Color( 78, 141, 237, 255 ),           -- indicator icon > not required job
                indic_ico_noafford      = Color( 60, 170, 102, 255 ),           -- indicator icon > cannot afford
                indic_ico_vote          = Color( 212, 219, 112, 255 ),          -- indicator icon > requires vote

                /*
                *   action msgs
                *
                *   colored boxes that display above the 'Switch / Buy' buttons.
                *   these give players notices if they cannot become a job or buy something for a particular reason
                */

                amsg =
                {
                    def_box                 = Color( 150, 47, 47, 255 ),            -- box clr for item with custom fail msg
                    def_txt                 = Color( 255, 255, 255, 255 ),          -- txt clr for item with custom fail msg
                    cus_box                 = Color( 100, 39, 38, 255 ),            -- custom fail > box
                    cus_txt                 = Color( 255, 255, 255, 255 ),          -- custom fail > txt
                    admin_only_box          = Color( 33, 41, 62, 255 ),             -- box clr for item admin only
                    admin_only_txt          = Color( 255, 255, 255, 255 ),          -- txt clr for item admin only
                    admin_ovr_box           = Color( 85, 37, 47, 255 ),             -- box clr for item when admin override on
                    admin_ovr_txt           = Color( 255, 255, 255, 255 ),          -- txt clr for item when admin override on
                },
            },
        },

        /*
        *   line pattern which displays on item slots and in category header
        */

        pattern =
        {
            cats =
            {
                enabled             = false,
                material            = 'pattern_hdiag',
                clr                 = Color( 0, 0, 0, 45 ),
                oset_h              = 5,
            },
            members =
            {
                enabled             = false,
                material            = 'pattern_hdiag',
                clr                 = Color( 0, 0, 0, 20 ),
            }
        },
    }

/*
*   tabs > jobs
*
*   >   bEnabled
*       determines if a tab is visible at all within the interface
*
*   >   name
*       name of the tab displayed on the left side of the interface
*
*   >   desc
*       description of the tab displayed on the left side of the interface
*       under the tab name
*
*   >   icon
*       material that displays to the left of a tab's name and description
*
*   >   unavail
*       various settings that allow you to determine if items show or not
*       if they are unavailable to a player
*
*       >   bShow
*           if enabled; items will show even if a player cannot buy the
*           item or become the job
*
*       >   bFade_box
*           if enabled, text in box will be faded in order to indicate that
*           the item is unavailable
*
*       >   bShowCustoms
*           if enabled, custom jobs will display for all players, even if
*           the player cannot ever become that job ( useful for advertising donator roles )
*/

    cfg.tabs.jobs =
    {
        bEnabled                    = true,                                 -- tab enabled
        bRawData                    = true,                                 -- returns jobs based on RPExtraTeams instead of DarkRP.getCategories( ).jobs
        id                          = 'jobs',
        name                        = 'Jobs',                               -- name of tab
        desc                        = 'Earn your worth',                    -- description of tab
        icon                        = 'tab_store_jobs',                     -- icon for tab. must be registered in sh_env.lua file
        pnl                         = 'arivia.pnl.tab.jobs',
        bShowCurrJob                = true,                                 -- determines if a players current job will also list with the others.
        bAllowFavs                  = true,                                 -- allows for jobs to be favorited
        bFavsOnce                   = true,                                 -- if enabled, favoriteed jobs will ONLY show at the top in the favs cat. disabled will make it show at the top, and in its normal category
        bLoadouts                   = true,                                 -- displays the loadout tab on the right side
        bDev                        = true,                                 -- displays the dev tab on the right side
        favorites =
        {
            bStartExpanded          = true,                                 -- if enabled, 'favorites' cat will start expanded in f4 menu
        },
        unavail =
        {
            bShow                   = true,                                 -- if enabled, jobs that the player CANNOT become will show in the f4
            bFade_box               = true,                                 -- if enabled, jobs a player cannot become will be faded
            bShowCustoms            = true,                                 -- if enabled, custom jobs that players cannot become will still display ( helps promote VIP jobs for others to see )
        },
        clrs =
        {

            bCatColors              = false,                                -- if enabled, any categories with a custom color defined in darkrp will display that color instead of the specified arivia color

            /*
            *   tab to far left that displays items in the category
            */

            tab =
            {
                btn_mat             = Color( 255, 255, 255, 255 ),          -- mat clr for job tab on left ( icon )
                btn_box_n           = Color( 46, 77, 115, 255 ),            -- btn clr for job tab on left normally
                btn_box_h           = Color( 48, 48, 48, 255 ),             -- btn clr for job tab on left when hovered
                btn_box_s           = Color( 48, 48, 48, 255 ),             -- btn clr for job tab on left when selected
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr for job tab on left normally
                btn_txt_h           = Color( 255, 255, 255, 255 ),          -- txt clr for job tab on left hovered
            },

            /*
            *   all items placed in list associated to tab category clicked on
            */

            list =
            {
                btn_box_n           = Color( 38, 39, 45, 255 ),             -- box clr when normal mode
                btn_box_h           = Color( 50, 56, 67, 255 ),             -- box clr when hovered
                btn_box_u           = Color( 40, 41, 47, 255 ),             -- box clr when unavailable
                btn_box_uc          = Color( 40, 41, 47, 255 ),             -- box clr when unavailable custom
                btn_box_t           = Color( 0, 0, 0, 0 ),                  -- box clr for outline
                btn_box_ol_n        = Color( 0, 0, 0, 0 ),                  -- box clr for overlay. useful for darkening/lightening a box color
                btn_box_ol_u        = Color( 0, 0, 0, 100 ),                -- box clr for overlay when unavailable
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr when allowed job
                btn_txt_h           = Color( 255, 255, 255, 200 ),          -- txt clr when hovered
                btn_txt_u           = Color( 255, 255, 255, 25 ),           -- txt clr when unavailable
                btn_sub_n           = Color( 255, 255, 255, 100 ),          -- txt sub clr when allowed job
                btn_sub_h           = Color( 255, 255, 255, 200 ),          -- txt sub clr when hovered
                btn_sub_u           = Color( 255, 255, 255, 25 ),           -- txt sub clr when unavailable
                btn_cir_n           = Color( 255, 255, 255, 5 ),            -- circle clr when allowed job
                btn_cir_h           = Color( 255, 255, 255, 5 ),            -- circle clr when hovered
                btn_cir_u           = Color( 255, 255, 255, 5 ),            -- circle clr when unavailable
                btn_lvl_1           = Color( 255, 255, 255, 120 ),          -- txt color for top line within circle for level ( text: Level )
                btn_lvl_2           = Color( 255, 255, 255, 120 ),          -- txt color for bottom line within circle for level ( text: level required )
                btn_gra_n           = Color( 17, 47, 61, 0 ),               -- gradient clr for each job listed normally
                btn_gra_u           = Color( 100, 39, 38, 255 ),            -- gradient clr for each job listed when unavailable
                btn_gra_c           = Color( 84, 29, 69, 255 ),             -- gradient clr for each job listed when custom and unavailable
                btn_gra_j           = Color( 25, 60, 95, 255 ),             -- gradient clr for job that is players current
                btn_mdl_box         = Color( 255, 255, 255, 1 ),            -- list: mdl background color
                btn_fav_off         = Color( 255, 255, 255, 15 ),           -- list: favorites > off
                btn_fav_on          = Color( 158, 164, 66, 255 ),           -- list: favorites > on

                cat_header_box      = Color( 34, 82, 106, 0 ),              -- list: header category > box color
                cat_header_txt      = Color( 255, 255, 255, 255 ),          -- list: header category > txt color
                cat_header_gra      = Color( 46, 77, 115, 255 ),            -- list: header category > gradient color
                cat_header_fav      = Color( 50, 112, 55 ),                 -- list: category > header color for favorites box
                cat_body_box        = Color( 0, 0, 0, 65 ),                 -- list: category body color
            },
        },
        misc =
        {
            sel =
            {
                gradient =
                {
                    bEnabled        = true,
                    bUseJobColor    = true,
                    jobColorAlpha   = 20,
                    overrideColor   = Color( 10, 10, 10, 255 )
                }
            },
        },
    }

/*
*   tabs > entities
*
*   >   bEnabled
*       determines if a tab is visible at all within the interface
*
*   >   name
*       name of the tab displayed on the left side of the interface
*
*   >   desc
*       description of the tab displayed on the left side of the interface
*       under the tab name
*
*   >   icon
*       material that displays to the left of a tab's name and description
*
*   >   unavail
*       various settings that allow you to determine if items show or not
*       if they are unavailable to a player
*
*       >   bShow
*           if enabled; items will show even if a player cannot buy the
*           item or become the job
*
*       >   bShowCustoms
*           if enabled, custom items will display for all players, even if
*           the player cannot ever buy that item ( useful for advertising donator items )
*/

    cfg.tabs.entities =
    {
        bEnabled                    = true,
        id                          = 'ents',
        name                        = 'Entities & Ammo',
        desc                        = 'Items for use in-world',
        icon                        = 'tab_store_ents',
        pnl                         = 'arivia.pnl.tab.ents',
        bDev                        = true,                                 -- displays the dev tab on the right side
        unavail =
        {
            bShow                   = false,                                -- if enabled, items player CANNOT buy will show in the f4
            bFade_box               = true,                                 -- if enabled, items player CANNOT buy will be faded
            bShowCustoms            = false,                                -- if enabled, custom items that players cannot buy will still display ( helps promote VIP items for others to see )
        },
        clrs =
        {

            bCatColors              = false,                                -- if enabled, any categories with a custom color defined in darkrp will display that color instead of the specified arivia color

            /*
            *   tab to far left that displays items in the category
            */

            tab =
            {
                btn_mat             = Color( 255, 255, 255, 255 ),          -- mat clr for ent tab on left ( icon )
                btn_box_n           = Color( 72, 106, 72, 190 ),            -- btn clr for ent tab on left normally
                btn_box_h           = Color( 48, 48, 48, 255 ),             -- btn clr for ent tab on left when hovered
                btn_box_s           = Color( 48, 48, 48, 255 ),             -- btn clr for ent tab on left when selected
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr for ent tab on left normally
                btn_txt_h           = Color( 255, 255, 255, 255 ),          -- txt clr for ent tab on left hovered
            },

            /*
            *   all items placed in list associated to tab category clicked on
            */

            list =
            {
                btn_box_n           = Color( 38, 39, 45, 255 ),             -- box clr when normal mode
                btn_box_h           = Color( 50, 56, 67, 255 ),             -- box clr when hovered
                btn_box_u           = Color( 40, 41, 47, 255 ),             -- box clr when unavailable
                btn_box_uc          = Color( 40, 41, 47, 255 ),             -- box clr when unavailable custom
                btn_box_t           = Color( 0, 0, 0, 0 ),                  -- box clr for outline
                btn_box_ol_n        = Color( 0, 0, 0, 0 ),                  -- box clr for overlay. useful for darkening/lightening a box color
                btn_box_ol_u        = Color( 0, 0, 0, 100 ),                -- box clr for overlay when unavailable
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr when allowed to buy
                btn_txt_h           = Color( 255, 255, 255, 200 ),          -- txt clr when hovered
                btn_txt_u           = Color( 255, 255, 255, 25 ),           -- txt clr when unavailable
                btn_sub_n           = Color( 255, 255, 255, 100 ),          -- txt sub clr when allowed to buy
                btn_sub_h           = Color( 255, 255, 255, 200 ),          -- txt sub clr when hovered
                btn_sub_u           = Color( 255, 255, 255, 25 ),           -- txt sub clr when unavailable
                btn_cir_n           = Color( 255, 255, 255, 5 ),            -- circle clr when allowed to buy
                btn_cir_h           = Color( 255, 255, 255, 5 ),            -- circle clr when hovered
                btn_cir_u           = Color( 255, 255, 255, 5 ),            -- circle clr when unavailable
                btn_lvl_1           = Color( 255, 255, 255, 120 ),          -- txt color for top line within circle for level ( text: Level )
                btn_lvl_2           = Color( 255, 255, 255, 120 ),          -- txt color for bottom line within circle for level ( text: level required )
                btn_gra_n           = Color( 17, 47, 61, 0 ),               -- gradient clr for each item listed normally
                btn_gra_u           = Color( 100, 39, 38, 255 ),            -- gradient clr for each item listed when unavailable
                btn_gra_c           = Color( 84, 29, 69, 255 ),             -- gradient clr for each item listed when custom and unavailable
                btn_mdl_box         = Color( 255, 255, 255, 1 ),            -- list: mdl background color
                cat_header_box      = Color( 34, 82, 106, 0 ),              -- list: header category > box color
                cat_header_txt      = Color( 255, 255, 255, 255 ),          -- list: header category > txt color
                cat_header_gra      = Color( 73, 103, 54, 255 ),            -- list: header category > gradient color
                cat_body_box        = Color( 0, 0, 0, 65 ),                 -- list: category body color
            },
        },
        misc =
        {
            sel =
            {
                gradient =
                {
                    bEnabled        = true,
                    alpha           = 50,                                   -- alpha amount for selection gradient ( right )
                },
            },
        },
    }

/*
*   tabs > weapons
*
*   >   bEnabled
*       determines if a tab is visible at all within the interface
*
*   >   name
*       name of the tab displayed on the left side of the interface
*
*   >   desc
*       description of the tab displayed on the left side of the interface
*       under the tab name
*
*   >   icon
*       material that displays to the left of a tab's name and description
*
*   >   unavail
*       various settings that allow you to determine if items show or not
*       if they are unavailable to a player
*
*       >   bShow
*           if enabled; items will show even if a player cannot buy the
*           item or become the job
*
*       >   bShowCustoms
*           if enabled, custom items will display for all players, even if
*           the player cannot ever buy that item ( useful for advertising donator items )
*/

    cfg.tabs.weapons =
    {
        bEnabled                    = true,
        id                          = 'weps',
        name                        = 'Weapons',
        desc                        = 'Your second amendment',
        icon                        = 'tab_store_weps',
        pnl                         = 'arivia.pnl.tab.weps',
        bDev                        = true,                                 -- displays the dev tab on the right side
        unavail =
        {
            bShow                   = false,                                -- if enabled, items player CANNOT buy will show in the f4
            bFade_box               = true,                                 -- if enabled, items player CANNOT buy will be faded
            bShowCustoms            = false,                                -- if enabled, custom items that players cannot buy will still display ( helps promote VIP items for others to see )
        },
        clrs =
        {

            bCatColors              = false,                                -- if enabled, any categories with a custom color defined in darkrp will display that color instead of the specified arivia color

            /*
            *   tab to far left that displays items in the category
            */

            tab =
            {
                btn_mat             = Color( 255, 255, 255, 255 ),          -- mat clr for wep tab on left ( icon )
                btn_box_n           = Color( 138, 58, 59, 255 ),            -- btn clr for wep tab on left normally
                btn_box_h           = Color( 48, 48, 48, 255 ),             -- btn clr for wep tab on left when hovered
                btn_box_s           = Color( 48, 48, 48, 255 ),             -- btn clr for wep tab on left when selected
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr for wep tab on left normally
                btn_txt_h           = Color( 255, 255, 255, 255 ),          -- txt clr for wep tab on left hovered
            },

            /*
            *   all items placed in list associated to tab category clicked on
            */

            list =
            {
                btn_box_n           = Color( 38, 39, 45, 255 ),             -- box clr when normal mode
                btn_box_h           = Color( 50, 56, 67, 255 ),             -- box clr when hovered
                btn_box_u           = Color( 40, 41, 47, 255 ),             -- box clr when unavailable
                btn_box_uc          = Color( 40, 41, 47, 255 ),             -- box clr when unavailable custom
                btn_box_t           = Color( 0, 0, 0, 0 ),                  -- box clr for outline
                btn_box_ol_n        = Color( 0, 0, 0, 0 ),                  -- box clr for overlay. useful for darkening/lightening a box color
                btn_box_ol_u        = Color( 0, 0, 0, 100 ),                -- box clr for overlay when unavailable
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr when allowed to buy
                btn_txt_h           = Color( 255, 255, 255, 200 ),          -- txt clr when hovered
                btn_txt_u           = Color( 255, 255, 255, 25 ),           -- txt clr when unavailable
                btn_sub_n           = Color( 255, 255, 255, 100 ),          -- txt sub clr when allowed to buy
                btn_sub_h           = Color( 255, 255, 255, 200 ),          -- txt sub clr when hovered
                btn_sub_u           = Color( 255, 255, 255, 25 ),           -- txt sub clr when unavailable
                btn_cir_n           = Color( 255, 255, 255, 5 ),            -- circle clr when allowed to buy
                btn_cir_h           = Color( 255, 255, 255, 5 ),            -- circle clr when hovered
                btn_cir_u           = Color( 255, 255, 255, 5 ),            -- circle clr when unavailable
                btn_lvl_1           = Color( 255, 255, 255, 120 ),          -- txt color for top line within circle for level ( text: Level )
                btn_lvl_2           = Color( 255, 255, 255, 120 ),          -- txt color for bottom line within circle for level ( text: level required )
                btn_gra_n           = Color( 17, 47, 61, 0 ),               -- gradient clr for each item listed normally
                btn_gra_u           = Color( 100, 39, 38, 255 ),            -- gradient clr for each item listed when unavailable
                btn_gra_c           = Color( 84, 29, 69, 255 ),             -- gradient clr for each item listed when custom and unavailable
                btn_mdl_box         = Color( 255, 255, 255, 1 ),            -- list: mdl background color
                cat_header_box      = Color( 34, 82, 106, 0 ),              -- list: header category > box color
                cat_header_txt      = Color( 255, 255, 255, 255 ),          -- list: header category > txt color
                cat_header_gra      = Color( 138, 58, 59, 255 ),            -- list: header category > gradient color
                cat_body_box        = Color( 0, 0, 0, 65 ),                 -- list: category body color
            },
        },
        misc =
        {
            sel =
            {
                gradient =
                {
                    bEnabled        = true,
                    alpha           = 50,                                   -- alpha amount for selection gradient ( right )
                },
            },
        },
    }

/*
*   tabs > shipments
*
*   >   bEnabled
*       determines if a tab is visible at all within the interface
*
*   >   name
*       name of the tab displayed on the left side of the interface
*
*   >   desc
*       description of the tab displayed on the left side of the interface
*       under the tab name
*
*   >   icon
*       material that displays to the left of a tab's name and description
*
*   >   unavail
*       various settings that allow you to determine if items show or not
*       if they are unavailable to a player
*
*       >   bShow
*           if enabled; items will show even if a player cannot buy the
*           item or become the job
*
*       >   bShowCustoms
*           if enabled, custom items will display for all players, even if
*           the player cannot ever buy that item ( useful for advertising donator items )
*/

    cfg.tabs.shipments =
    {
        bEnabled                    = true,
        id                          = 'ship',
        name                        = 'Shipments',
        desc                        = 'Extra things to help out',
        icon                        = 'tab_store_ship',
        pnl                         = 'arivia.pnl.tab.ship',
        bDev                        = true,                                 -- displays the dev tab on the right side
        unavail =
        {
            bShow                   = false,                                -- if enabled, items player CANNOT buy will show in the f4
            bFade_box               = true,                                 -- if enabled, items player CANNOT buy will be faded
            bShowCustoms            = false,                                -- if enabled, custom items that players cannot buy will still display ( helps promote VIP items for others to see )
        },
        clrs =
        {

            bCatColors              = false,                                -- if enabled, any categories with a custom color defined in darkrp will display that color instead of the specified arivia color

            /*
            *   tab to far left that displays items in the category
            */

            tab =
            {
                btn_mat             = Color( 255, 255, 255, 255 ),          -- mat clr for ship tab on left ( icon )
                btn_box_n           = Color( 204, 85, 0, 255 ),            -- btn clr for ship tab on left normally
                btn_box_h           = Color( 48, 48, 48, 255 ),             -- btn clr for ship tab on left when hovered
                btn_box_s           = Color( 48, 48, 48, 255 ),             -- btn clr for ship tab on left when selected
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr for ship tab on left normally
                btn_txt_h           = Color( 255, 255, 255, 255 ),          -- txt clr for ship tab on left hovered
            },

            /*
            *   all items placed in list associated to tab category clicked on
            */

            list =
            {
                btn_box_n           = Color( 38, 39, 45, 255 ),             -- box clr when normal mode
                btn_box_h           = Color( 50, 56, 67, 255 ),             -- box clr when hovered
                btn_box_u           = Color( 40, 41, 47, 255 ),             -- box clr when unavailable
                btn_box_uc          = Color( 40, 41, 47, 255 ),             -- box clr when unavailable custom
                btn_box_t           = Color( 0, 0, 0, 0 ),                  -- box clr for outline
                btn_box_ol_n        = Color( 0, 0, 0, 0 ),                  -- box clr for overlay. useful for darkening/lightening a box color
                btn_box_ol_u        = Color( 0, 0, 0, 100 ),                -- box clr for overlay when unavailable
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr when allowed to buy
                btn_txt_h           = Color( 255, 255, 255, 200 ),          -- txt clr when hovered
                btn_txt_u           = Color( 255, 255, 255, 25 ),           -- txt clr when unavailable
                btn_sub_n           = Color( 255, 255, 255, 100 ),          -- txt sub clr when allowed to buy
                btn_sub_h           = Color( 255, 255, 255, 200 ),          -- txt sub clr when hovered
                btn_sub_u           = Color( 255, 255, 255, 25 ),           -- txt sub clr when unavailable
                btn_cir_n           = Color( 255, 255, 255, 5 ),            -- circle clr when allowed to buy
                btn_cir_h           = Color( 255, 255, 255, 5 ),            -- circle clr when hovered
                btn_cir_u           = Color( 255, 255, 255, 5 ),            -- circle clr when unavailable
                btn_lvl_1           = Color( 255, 255, 255, 120 ),          -- txt color for top line within circle for level ( text: Level )
                btn_lvl_2           = Color( 255, 255, 255, 120 ),          -- txt color for bottom line within circle for level ( text: level required )
                btn_gra_n           = Color( 204, 85, 0, 0 ),               -- gradient clr for each item listed normally
                btn_gra_u           = Color( 100, 39, 38, 255 ),            -- gradient clr for each item listed when unavailable
                btn_gra_c           = Color( 84, 29, 69, 120 ),             -- gradient clr for each item listed when custom and unavailable
                btn_mdl_box         = Color( 255, 255, 255, 1 ),            -- list: mdl background color
                cat_header_box      = Color( 204, 85, 0, 0 ),              -- list: header category > box color
                cat_header_txt      = Color( 255, 255, 255, 255 ),          -- list: header category > txt color
                cat_header_gra      = Color(204, 85, 0, 255 ),            -- list: header category > gradient color
                cat_body_box        = Color( 0, 0, 0, 65 ),                 -- list: category body color
            },
        },
        misc =
        {
            sel =
            {
                gradient =
                {
                    bEnabled        = true,
                    alpha           = 50,                                   -- alpha amount for selection gradient ( right )
                },
            },
        },
    }

/*
*   tabs > ammo
*
*   >   bEnabled
*       determines if a tab is visible at all within the interface
*
*   >   name
*       name of the tab displayed on the left side of the interface
*
*   >   desc
*       description of the tab displayed on the left side of the interface
*       under the tab name
*
*   >   icon
*       material that displays to the left of a tab's name and description
*
*   >   unavail
*       various settings that allow you to determine if items show or not
*       if they are unavailable to a player
*
*       >   bShow
*           if enabled; items will show even if a player cannot buy the
*           item or become the job
*
*       >   bShowCustoms
*           if enabled, custom items will display for all players, even if
*           the player cannot ever buy that item ( useful for advertising donator items )
*/

    cfg.tabs.ammo =
    {
        bEnabled                    = false,
        id                          = 'ammo',
        name                        = 'Ammo',
        desc                        = 'Keeping your guns ready',
        icon                        = 'tab_store_ammo',
        pnl                         = 'arivia.pnl.tab.ammo',
        bDev                        = true,                                 -- displays the dev tab on the right side
        unavail =
        {
            bShow                   = true,                                 -- if enabled, items player CANNOT buy will show in the f4
            bFade_box               = true,                                 -- if enabled, items player CANNOT buy will be faded
            bShowCustoms            = true,                                 -- if enabled, custom items that players cannot buy will still display ( helps promote VIP items for others to see )
        },
        clrs =
        {

            bCatColors              = false,                                -- if enabled, any categories with a custom color defined in darkrp will display that color instead of the specified arivia color

            /*
            *   tab to far left that displays items in the category
            */

            tab =
            {
                btn_mat             = Color( 255, 255, 255, 255 ),          -- mat clr for ammo tab on left ( icon )
                btn_box_n           = Color( 101, 55, 81, 255 ),            -- btn clr for ammo tab on left normally
                btn_box_h           = Color( 48, 48, 48, 255 ),             -- btn clr for ammo tab on left when hovered
                btn_box_s           = Color( 48, 48, 48, 255 ),             -- btn clr for ammo tab on left when selected
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr for ammo tab on left normally
                btn_txt_h           = Color( 255, 255, 255, 255 ),          -- txt clr for ammo tab on left hovered
            },

            /*
            *   all items placed in list associated to tab category clicked on
            */

            list =
            {
                btn_box_n           = Color( 38, 39, 45, 255 ),             -- box clr when normal mode
                btn_box_h           = Color( 50, 56, 67, 255 ),             -- box clr when hovered
                btn_box_u           = Color( 40, 41, 47, 255 ),             -- box clr when unavailable
                btn_box_uc          = Color( 40, 41, 47, 255 ),             -- box clr when unavailable custom
                btn_box_t           = Color( 0, 0, 0, 0 ),                  -- box clr for outline
                btn_box_ol_n        = Color( 0, 0, 0, 0 ),                  -- box clr for overlay. useful for darkening/lightening a box color
                btn_box_ol_u        = Color( 0, 0, 0, 100 ),                -- box clr for overlay when unavailable
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr when allowed to buy
                btn_txt_h           = Color( 255, 255, 255, 200 ),          -- txt clr when hovered
                btn_txt_u           = Color( 255, 255, 255, 25 ),           -- txt clr when unavailable
                btn_sub_n           = Color( 255, 255, 255, 100 ),          -- txt sub clr when allowed to buy
                btn_sub_h           = Color( 255, 255, 255, 200 ),          -- txt sub clr when hovered
                btn_sub_u           = Color( 255, 255, 255, 25 ),           -- txt sub clr when unavailable
                btn_cir_n           = Color( 255, 255, 255, 5 ),            -- circle clr when allowed to buy
                btn_cir_h           = Color( 255, 255, 255, 5 ),            -- circle clr when hovered
                btn_cir_u           = Color( 255, 255, 255, 5 ),            -- circle clr when unavailable
                btn_lvl_1           = Color( 255, 255, 255, 120 ),          -- txt color for top line within circle for level ( text: Level )
                btn_lvl_2           = Color( 255, 255, 255, 120 ),          -- txt color for bottom line within circle for level ( text: level required )
                btn_gra_n           = Color( 17, 47, 61, 0 ),               -- gradient clr for each item listed normally
                btn_gra_u           = Color( 100, 39, 38, 255 ),            -- gradient clr for each item listed when unavailable
                btn_gra_c           = Color( 84, 29, 69, 255 ),             -- gradient clr for each item listed when custom and unavailable
                btn_mdl_box         = Color( 255, 255, 255, 1 ),            -- list: mdl background color
                cat_header_box      = Color( 34, 82, 106, 0 ),              -- list: header category > box color
                cat_header_txt      = Color( 255, 255, 255, 255 ),          -- list: header category > txt color
                cat_header_gra      = Color( 101, 55, 81, 255 ),            -- list: header category > gradient color
                cat_body_box        = Color( 0, 0, 0, 65 ),                 -- list: category body color
            },
        },
        misc =
        {
            sel =
            {
                gradient =
                {
                    bEnabled        = true,
                    alpha           = 50,                                   -- alpha amount for selection gradient ( right )
                },
            },
        },
    }

/*
*   tabs > food
*
*   >   bEnabled
*       determines if a tab is visible at all within the interface
*
*   >   name
*       name of the tab displayed on the left side of the interface
*
*   >   desc
*       description of the tab displayed on the left side of the interface
*       under the tab name
*
*   >   icon
*       material that displays to the left of a tab's name and description
*
*   >   bOtherAtEnd
*       because food categories are coded different; enabling this will force
*       the category "Other" to display at the END of the list.
*
*   >   unavail
*       various settings that allow you to determine if items show or not
*       if they are unavailable to a player
*
*       >   bShow
*           if enabled; items will show even if a player cannot buy the
*           item or become the job
*
*       >   bShowCustoms
*           if enabled, custom items will display for all players, even if
*           the player cannot ever buy that item ( useful for advertising donator items )
*/

    cfg.tabs.food =
    {
        bEnabled                    = true,
        id                          = 'food',
        name                        = 'Food',
        desc                        = 'Yummy for the tummy',
        icon                        = 'tab_store_food',
        pnl                         = 'arivia.pnl.tab.food',
        bDev                        = true,                                 -- displays the dev tab on the right side
        unavail =
        {
            bShow                   = true,                                -- if enabled, items player CANNOT buy will show in the f4
            bFade_box               = true,                                 -- if enabled, items player CANNOT buy will be faded
            bShowCustoms            = true,                                 -- if enabled, custom items that players cannot buy will still display ( helps promote VIP items for others to see )
        },
        clrs =
        {

            bCatColors              = true,                                -- if enabled, any categories with a custom color defined in darkrp will display that color instead of the specified arivia color

            /*
            *   tab to far left that displays items in the category
            */

            tab =
            {
                btn_mat             = Color( 255, 255, 255, 255 ),          -- mat clr for food tab on left ( icon )
                btn_box_n           = Color( 32, 111, 116, 255 ),           -- btn clr for food tab on left normally
                btn_box_h           = Color( 48, 48, 48, 255 ),             -- btn clr for food tab on left when hovered
                btn_box_s           = Color( 48, 48, 48, 255 ),             -- btn clr for food tab on left when selected
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr for food tab on left normally
                btn_txt_h           = Color( 255, 255, 255, 255 ),          -- txt clr for food tab on left hovered
            },

            /*
            *   all items placed in list associated to tab category clicked on
            */

            list =
            {
                btn_box_n           = Color( 38, 39, 45, 255 ),             -- box clr when normal mode
                btn_box_h           = Color( 50, 56, 67, 255 ),             -- box clr when hovered
                btn_box_u           = Color( 40, 41, 47, 255 ),             -- box clr when unavailable
                btn_box_uc          = Color( 40, 41, 47, 255 ),             -- box clr when unavailable custom
                btn_box_t           = Color( 0, 0, 0, 0 ),                  -- box clr for outline
                btn_box_ol_n        = Color( 0, 0, 0, 0 ),                  -- box clr for overlay. useful for darkening/lightening a box color
                btn_box_ol_u        = Color( 0, 0, 0, 100 ),                -- box clr for overlay when unavailable
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr when allowed to buy
                btn_txt_h           = Color( 255, 255, 255, 200 ),          -- txt clr when hovered
                btn_txt_u           = Color( 255, 255, 255, 25 ),           -- txt clr when unavailable
                btn_sub_n           = Color( 255, 255, 255, 100 ),          -- txt sub clr when allowed to buy
                btn_sub_h           = Color( 255, 255, 255, 200 ),          -- txt sub clr when hovered
                btn_sub_u           = Color( 255, 255, 255, 25 ),           -- txt sub clr when unavailable
                btn_cir_n           = Color( 255, 255, 255, 5 ),            -- circle clr when allowed to buy
                btn_cir_h           = Color( 255, 255, 255, 5 ),            -- circle clr when hovered
                btn_cir_u           = Color( 255, 255, 255, 5 ),            -- circle clr when unavailable
                btn_lvl_1           = Color( 255, 255, 255, 120 ),          -- txt color for top line within circle for level ( text: Level )
                btn_lvl_2           = Color( 255, 255, 255, 120 ),          -- txt color for bottom line within circle for level ( text: level required )
                btn_gra_n           = Color( 17, 47, 61, 0 ),               -- gradient clr for each item listed normally
                btn_gra_u           = Color( 100, 39, 38, 255 ),            -- gradient clr for each item listed when unavailable
                btn_gra_c           = Color( 84, 29, 69, 255 ),             -- gradient clr for each item listed when custom and unavailable
                btn_mdl_box         = Color( 255, 255, 255, 1 ),            -- list: mdl background color
                cat_header_box      = Color( 34, 82, 106, 0 ),              -- list: header category > box color
                cat_header_txt      = Color( 255, 255, 255, 255 ),          -- list: header category > txt color
                cat_header_gra      = Color( 32, 111, 116, 255 ),           -- list: header category > gradient color
                cat_body_box        = Color( 0, 0, 0, 65 ),                 -- list: category body color
            },
        },
        misc =
        {
            sel =
            {
                gradient =
                {
                    bEnabled        = true,
                    alpha           = 50,                                   -- alpha amount for selection gradient ( right )
                },
            },
        },
    }

/*
*   tabs > vehicles
*
*   >   bEnabled
*       determines if a tab is visible at all within the interface
*
*   >   name
*       name of the tab displayed on the left side of the interface
*
*   >   desc
*       description of the tab displayed on the left side of the interface
*       under the tab name
*
*   >   icon
*       material that displays to the left of a tab's name and description
*
*   >   unavail
*       various settings that allow you to determine if items show or not
*       if they are unavailable to a player
*
*       >   bShow
*           if enabled; items will show even if a player cannot buy the
*           item or become the job
*
*       >   bShowCustoms
*           if enabled, custom items will display for all players, even if
*           the player cannot ever buy that item ( useful for advertising donator items )
*/

    cfg.tabs.vehicles =
    {
        bEnabled                    = true,
        id                          = 'vehc',
        name                        = 'Vehicles',
        desc                        = 'Getting your permit',
        icon                        = 'tab_store_vehc',
        pnl                         = 'arivia.pnl.tab.vehc',
        bDev                        = true,                                 -- displays the dev tab on the right side
        unavail =
        {
            bShow                   = true,                                -- if enabled, items player CANNOT buy will show in the f4
            bFade_box               = true,                                 -- if enabled, items player CANNOT buy will be faded
            bShowCustoms            = true,                                 -- if enabled, custom items that players cannot buy will still display ( helps promote VIP items for others to see )
        },
        clrs =
        {

            bCatColors              = false,                                -- if enabled, any categories with a custom color defined in darkrp will display that color instead of the specified arivia color

            /*
            *   tab to far left that displays items in the category
            */

            tab =
            {
                btn_mat             = Color( 255, 255, 255, 255 ),          -- mat clr for veh tab on left ( icon )
                btn_box_n           = Color( 145, 119, 68, 255 ),           -- btn clr for veh tab on left normally
                btn_box_h           = Color( 48, 48, 48, 255 ),             -- btn clr for veh tab on left when hovered
                btn_box_s           = Color( 48, 48, 48, 255 ),             -- btn clr for veh tab on left when selected
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr for veh tab on left normally
                btn_txt_h           = Color( 255, 255, 255, 255 ),          -- txt clr for veh tab on left hovered
            },

            /*
            *   all items placed in list associated to tab category clicked on
            */

            list =
            {
                btn_box_n           = Color( 38, 39, 45, 255 ),             -- box clr when normal mode
                btn_box_h           = Color( 50, 56, 67, 255 ),             -- box clr when hovered
                btn_box_u           = Color( 40, 41, 47, 255 ),             -- box clr when unavailable
                btn_box_uc          = Color( 40, 41, 47, 255 ),             -- box clr when unavailable custom
                btn_box_t           = Color( 0, 0, 0, 0 ),                  -- box clr for outline
                btn_box_ol_n        = Color( 0, 0, 0, 0 ),                  -- box clr for overlay. useful for darkening/lightening a box color
                btn_box_ol_u        = Color( 0, 0, 0, 100 ),                -- box clr for overlay when unavailable
                btn_txt_n           = Color( 255, 255, 255, 255 ),          -- txt clr when allowed to buy
                btn_txt_h           = Color( 255, 255, 255, 200 ),          -- txt clr when hovered
                btn_txt_u           = Color( 255, 255, 255, 25 ),           -- txt clr when unavailable
                btn_sub_n           = Color( 255, 255, 255, 100 ),          -- txt sub clr when allowed to buy
                btn_sub_h           = Color( 255, 255, 255, 200 ),          -- txt sub clr when hovered
                btn_sub_u           = Color( 255, 255, 255, 25 ),           -- txt sub clr when unavailable
                btn_cir_n           = Color( 255, 255, 255, 5 ),            -- circle clr when allowed to buy
                btn_cir_h           = Color( 255, 255, 255, 5 ),            -- circle clr when hovered
                btn_cir_u           = Color( 255, 255, 255, 5 ),            -- circle clr when unavailable
                btn_lvl_1           = Color( 255, 255, 255, 120 ),          -- txt color for top line within circle for level ( text: Level )
                btn_lvl_2           = Color( 255, 255, 255, 120 ),          -- txt color for bottom line within circle for level ( text: level required )
                btn_gra_n           = Color( 17, 47, 61, 0 ),               -- gradient clr for each item listed normally
                btn_gra_u           = Color( 100, 39, 38, 255 ),            -- gradient clr for each item listed when unavailable
                btn_gra_c           = Color( 84, 29, 69, 255 ),             -- gradient clr for each item listed when custom and unavailable
                btn_mdl_box         = Color( 255, 255, 255, 1 ),            -- list: mdl background color
                cat_header_box      = Color( 34, 82, 106, 0 ),              -- list: header category > box color
                cat_header_txt      = Color( 255, 255, 255, 255 ),          -- list: header category > txt color
                cat_header_gra      = Color( 145, 119, 68, 255 ),           -- list: header category > gradient color
                cat_body_box        = Color( 0, 0, 0, 65 ),                 -- list: category body color
            },
        },
        misc =
        {
            sel =
            {
                gradient =
                {
                    bEnabled        = true,
                    alpha           = 50,                                   -- alpha amount for selection gradient ( right )
                },
            },
        },
    }