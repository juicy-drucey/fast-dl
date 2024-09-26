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
*   SETTINGS > UI
*/

    /*
    *   these are for general layout colorization
    *   if you are looking for colors related to tabs, buttons, etc; visit the correct
    *   config file for those:
    *
    *   >   sh_3_nav.lua
    *   >   sh_4_tabs.lua
    */

        cfg.ui =
        {

            /*
            *   main
            */

            main =
            {
                clrs =
                {
                    panel           = Color( 35, 35, 35, 255 ),                     -- the main interface color for center panel ( dark grey )
                    box_accent      = Color( 0, 0, 0, 150 ),                        -- accent color for various boxes
                    separator       = Color( 255, 255, 255, 5 ),                    -- seperator color which shows a faded white line between panels
                    ico_section     = Color( 198, 149, 44 ),                        -- ico color for each section title at the top
                    txt_section     = Color( 200, 200, 200, 200 ),                  -- txt color for each section
                    ico_accent      = Color( 255, 255, 255, 1 ),                    -- large icon at bottom right of 'network staff' page
                    dt_txt          = Color( 255, 255, 255, 255 ),                  -- text default color
                    dt_txt_accent   = Color( 255, 255, 255, 150 ),                  -- text default color ( secondary )
                    dt_cur          = Color( 200, 200, 200, 255 ),                  -- cursor default color
                    dt_hl           = Color( 25, 25, 25, 255 ),                     -- highlight default color
                    sbar_ol         = Color( 85, 85, 85, 0 ),                       -- scrollbar > outline
                    sbar_i          = Color( 109, 48, 48, 255 ),                    -- scrollbar > inner bar
                },
            },

            /*
            *   header
            *
            *   this panel displays the news ticker and the icons for exiting, etc.
            */

            header =
            {
                clrs =
                {
                    panel           = Color( 93, 42, 42, 255 ),                     -- header bar which contains news ticker and close button
                    icons           = Color( 255, 255, 255, 255 ),                  -- icons in top right ( exit, about, maximize )
                    txt             = Color( 255, 255, 255, 255 ),                  -- text color ( tips / ticker ) in header
                },
            },

            /*
            *   left
            *
            *   this section is what displays the buttons to choose between jobs, entities, etc.
            *   it also displays the four tabs at the top left which switches you between viewing
            *   jobs / network staff / website info, etc.
            */

            left =
            {
                clrs =
                {
                    panel           = Color( 30, 30, 30, 255 ),                     -- left side > main background
                    tabs_pnl_main   = Color( 125, 46, 47, 255 ),                    -- left side > top > tabs panel background
                    tabs_ico_s      = Color( 217, 164, 45, 255 ),                   -- left side > icon > selected
                    tabs_ico_n      = Color( 255, 255, 255, 255 ),                  -- left side > icon > normal
                    tabs_box_s      = Color( 40, 40, 40, 210 ),                     -- left side > box > selected
                },
            },

            /*
            *   right
            *
            *   this area is where the 'large' model will show when you click a job / item.
            *   it also shows the description of the job / item.
            */

            right =
            {
                sizes =
                {
                    mdl_h                   = { 110, 140, 140, 160, 160, 180, 230, 380 }    -- large model panel size ( right side )
                },
                clrs =
                {
                    panel                   = Color( 28, 28, 28, 255 ),                     -- right side panel
                    tab_bg                  = Color( 93, 37, 37, 255 ),                     -- tabs > background ( about, loadout, debug )
                    tab_marker              = Color( 25, 25, 25, 255 ),                     -- tabs > selected box
                    tab_txt_active          = Color( 255, 255, 255, 255 ),                  -- tabs > inactive text
                    tab_txt_inactive        = Color( 255, 255, 255, 240 ),                  -- tabs > inactive text
                },
                ico =
                {
                    edit                    = '',
                    nocook                  = '',
                    nojob                   = '',
                    noafford                = '',
                    vote                    = '',
                }
            },

        }

/*
*   SETTINGS :: DIALOGS
*/

    /*
    *	these settings handle the dialog boxes that appear when certain actions are triggered such as trying
    *   to close the motd without accepting the terms, or connecting to a different server (confirmation box)
    */

        cfg.dialogs =
        {
            clrs =
            {

                /*
                *	default values for boxes
                *   controls text, cursor, and text highlighted colors
                */

                txt_default         = Color( 255, 255, 255, 255 ),
                cur_default         = Color( 200, 200, 200, 255 ),
                hli_default         = Color( 25, 25, 25, 255 ),

                /*
                *	interface colors
                */

                body_box            = Color( 40, 40, 40, 255 ),
                shadow_box          = Color( 20, 20, 20, 150 ),
                header_box          = Color( 30, 30, 30, 255 ),
                header_txt          = Color( 237, 237, 237, 255 ),
                header_ico          = Color( 240, 72, 133, 255 ),
                footer_box          = Color( 30, 30, 30, 255 ),
                errors_box          = Color( 114, 44, 44, 255 ),
                errors_txt          = Color( 255, 255, 255, 255 ),
                icon_resize         = Color( 240, 72, 133, 255 ),
                icon_bullet         = Color( 240, 113, 113, 255 ),

                /*
                *	error / notices
                *   displays at the top of some boxes when things go wrong
                */

                msg_box             = Color( 114, 44, 44, 255 ),
                msg_txt             = Color( 255, 255, 255, 255 ),
                desc_txt            = Color( 255, 255, 255, 255 ),

                /*
                *	exit button
                */

                btn_exit_n          = Color( 237, 237, 237, 255 ),                  -- btn color > ( normal )
                btn_exit_h          = Color( 200, 55, 55, 255 ),                    -- btn color > ( hovered )

                /*
                *	icons
                */

                ico_resize          = Color( 240, 72, 133, 255 ),                   -- ico color for resizing windows in bottom left of panels
                ico_bullet          = Color( 240, 113, 113, 255 ),                  -- ico color for 'asterisk' icon at the bottom of confirm boxes

                /*
                *	options below control the 'OK' / Confirm buttons that display when confirmation boxes appear
                */

                opt_ok_btn_n        = Color( 60, 120, 62, 255 ),                    -- btn color > ( normal )
                opt_ok_btn_h        = Color( 15, 15, 15, 100 ),                     -- btn color > ( hovered )
                opt_ok_txt          = Color( 255, 255, 255, 255 ),                  -- txt color > ( checkmark )

                /*
                *	options below control the 'No' / Disconnect buttons that display when confirmation boxes appear
                */

                opt_no_btn_n        = Color( 200, 55, 55, 255 ),                    -- btn color > ( normal )
                opt_no_btn_h        = Color( 15, 15, 15, 100 ),                     -- btn color > ( hovered )
                opt_no_txt          = Color( 255, 255, 255, 255 ),                  -- txt color > ( checkmark )

                /*
                *	options below control the 'alt' / Copy to Clipboard buttons that display when confirmation boxes appear
                */

                opt_al_btn_n        = Color( 31, 133, 222, 255 ),                   -- btn color > ( normal )
                opt_al_btn_h        = Color( 15, 15, 15, 100 ),                     -- btn color > ( hovered )
                opt_al_txt          = Color( 255, 255, 255, 255 ),                  -- txt color > ( checkmark )
            }
        }
