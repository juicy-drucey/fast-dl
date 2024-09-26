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
*   COMMANDS > BUTTONS
*
*   >   enabled
*       if command is enabled for players to use
*
*   >   bIsCategory
*       determines if entry is only a category
*
*   >   bIsSep
*       determines if entry is only a spacer
*       ( provides padding between sets of commands )
*
*   >   name
*       text to display for command button
*
*   >   sizes
*       allows you to adjust the padding of an item
*
*       >   pl      : left
*       >   pr      : right
*       >   pt      : top
*       >   pb      : bottom
*
*   >   tip
*       helpful text to display when button is hovered
*
*   >   clrs
*       list of colors used for button
*
*   >   args
*       if command requires additional input from player
*
*   >   condition
*       requirements a player must have before seeing command
*       ( restricting by job, etc )
*
*   >   action
*       what is executed when command button is pressed
*/

    cfg.actions.buttons =
    {

        /*
        *   civil protection > category
        */

            {
                enabled                 = true,
                bIsCategory             = true,
                name                    = 'cmds_cat_civil_proct',
                sizes =
                {
                    pl                  = 0,
                    pt                  = 0,
                    pr                  = 0,
                    pb                  = 5
                },
                clrs =
                {
                    btn                 = Color( 105, 35, 86, 0 ),
                    txt                 = Color( 255, 255, 255, 255 ),
                },
                condition = function( pl )
                    if pl:isCP( ) then return true end
                end
            },

        /*
        *   civil protection > warrant > new
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_swarrant_btn',
                tip                     = 'cmds_act_swarrant_tip',
                clrs =
                {
                    btn_n               = Color( 79, 35, 67, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Player Name',
                        default         = '',
                    },
                    {
                        name            = 'Reason',
                        default         = 'None',
                        bChange         = true,
                    }
                },
                condition = function( pl )
                    if pl:isCP( ) then return true end
                end,
                action = function( pl, data )
                    local targ      = data[ 1 ]
                    local reason    = data[ 2 ]
                    rcc.run.gmod( 'darkrp', 'warrant', targ, reason )
                end,
            },

        /*
        *   civil protection > warrant > remove
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_rwarrant_btn',
                tip                     = 'cmds_act_rwarrant_tip',
                clrs =
                {
                    btn_n               = Color( 79, 35, 67, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Player Name',
                        default         = '',
                    },
                },
                condition = function( pl )
                    if pl:isCP( ) then return true end
                end,
                action = function( pl, data )
                    local targ      = data[ 1 ]
                    rcc.run.gmod( 'darkrp', 'unWarrant', targ )
                end,
            },

        /*
        *   civil protection > warrant > player
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_plwanted_btn',
                tip                     = 'cmds_act_plwanted_tip',
                clrs =
                {
                    btn_n               = Color( 79, 35, 67, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Player Name',
                        default         = '',
                        type            = 'str',
                    },
                    {
                        name            = 'Reason',
                        default         = 'None',
                        type            = 'str',
                        bChange         = true,
                    },
                    {
                        name            = 'Duration',
                        default         = '60',
                        type            = 'int',
                    }
                },
                condition = function( pl )
                    if pl:isCP( ) then return true end
                end,
                action = function( pl, data )
                    local targ      = data[ 1 ]
                    local reason    = data[ 2 ]
                    local dur       = data[ 3 ]
                    rcc.run.gmod( 'darkrp', 'wanted', targ, reason, dur )
                end,
            },

        /*
        *   civil protection > warrant > remove player
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_plrwanted_btn',
                tip                     = 'cmds_act_plrwanted_tip',
                clrs =
                {
                    btn_n               = Color( 79, 35, 67, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Player Name',
                        default         = '',
                        type            = 'str',
                    },
                },
                condition = function( pl )
                    if pl:isCP( ) then return true end
                end,
                action = function( pl, data )
                    local targ      = data[ 1 ]
                    rcc.run.gmod( 'darkrp', 'unwanted', targ )
                end,
            },

        /*
        *   mayor > spacer
        */

            {
                enabled                 = true,
                bIsSep                  = true,
                sizes =
                {
                    h                   = 15,
                },
            },

        /*
        *   mayor > category
        */

            {
                enabled                 = true,
                bIsCategory             = true,
                name                    = 'Mayor',
                sizes =
                {
                    pl                  = 0,
                    pt                  = 0,
                    pr                  = 0,
                    pb                  = 5
                },
                clrs =
                {
                    btn                 = Color( 48, 61, 103, 0 ),
                    txt                 = Color( 255, 255, 255, 255 ),
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end
            },

        /*
        *   mayor > actions
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_broadcast_btn',
                tip                     = 'cmds_act_broadcast_tip',
                clrs =
                {
                    btn_n               = Color( 80, 43, 37, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Message',
                        default         = '',
                        type            = 'str',
                    },
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end,
                action = function( pl, data )
                    local msg = data[ 1 ]
                    local cmd = string.format( '/broadcast %s', tostring( msg ) )
                    rcc.run.gmod( 'say', cmd )
                end,
            },

        /*
        *   mayor > lottery
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_lottery_btn',
                tip                     = 'cmds_act_lottery_tip',
                clrs =
                {
                    btn_n               = Color( 80, 43, 37, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Amount',
                        default         = '30',
                        type            = 'int',
                    },
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end,
                action = function( pl, data )
                    local amt = data[ 1 ]
                    local cmd = string.format( '/lottery %s', tostring( amt ) )
                    rcc.run.gmod( 'say', cmd )
                end,
            },

        /*
        *   mayor > lockdown > start
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_nlockdown_btn',
                tip                     = 'cmds_act_nlockdown_tip',
                clrs =
                {
                    btn_n               = Color( 80, 43, 37, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end,
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'lockdown' )
                end,
            },

        /*
        *   mayor > lockdown > stop
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_slockdown_btn',
                tip                     = 'cmds_act_slockdown_tip',
                clrs =
                {
                    btn_n               = Color( 80, 43, 37, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end,
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'unlockdown' )
                end,
            },

        /*
        *   mayor > law > add
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_nlaw_btn',
                tip                     = 'cmds_act_nlaw_tip',
                clrs =
                {
                    btn_n               = Color( 80, 43, 37, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Law',
                        default         = 'Law here',
                        type            = 'str',
                        bChange         = true,
                    },
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end,
                action = function( pl, data )
                    local msg = data[ 1 ]
                    rcc.run.gmod( 'darkrp', 'addlaw', msg )
                end,
            },

        /*
        *   mayor > law > remove
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_rlaw_btn',
                tip                     = 'cmds_act_rlaw_tip',
                clrs =
                {
                    btn_n               = Color( 80, 43, 37, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                args =
                {
                    {
                        name            = 'Law #',
                        default         = 1,
                        type            = 'int',
                    },
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end,
                action = function( pl, data )
                    local rule_id = data[ 1 ] or 0
                    rcc.run.gmod( 'darkrp', 'removelaw', rule_id )
                end,
            },

        /*
        *   mayor > lawboard > place
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_plawboard_btn',
                tip                     = 'cmds_act_plawboard_tip',
                clrs =
                {
                    btn_n               = Color( 80, 43, 37, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 255, 255, 255, 255 ),
                },
                condition = function( pl )
                    if pl:isMayor( ) then return true end
                end,
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'placelaws' )
                end,
            },

        /*
        *   general > spacer
        */

            {
                enabled                 = true,
                bIsSep                  = true,
                sizes =
                {
                    h                   = 15,
                },
            },

        /*
        *   general > category
        */

            {
                enabled                 = true,
                bIsCategory             = true,
                name                    = 'cmds_cat_general',
                sizes =
                {
                    pl                  = 0,
                    pt                  = 0,
                    pr                  = 0,
                    pb                  = 5
                },
                clrs =
                {
                    btn                 = Color( 57, 65, 92, 0 ),
                    txt                 = Color( 255, 255, 255, 255 ),
                },
            },

        /*
        *   general > actions
        */

            {
                enabled                 = true,
                name                    = 'cmds_act_dropweapon_btn',
                tip                     = 'cmds_act_dropweapon_tip',
                clrs =
                {
                    btn_n               = Color( 42, 42, 42, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 182, 59, 75, 255 ),
                },
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'drop' )
                end
            },

            {
                enabled                 = true,
                name                    = 'cmds_act_dropmoney_btn',
                tip                     = 'cmds_act_dropmoney_tip',
                clrs =
                {
                    btn_n               = Color( 42, 42, 42, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 182, 59, 75, 255 ),
                },
                args =
                {
                    {
                        name            = 'Amount',
                        default         = 0,
                        type            = 'int',
                        bChange         = true,
                    },
                },
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'dropmoney', data[ 1 ] )
                end,
            },

            {
                enabled                 = true,
                name                    = 'cmds_act_givemoney_btn',
                tip                     = 'cmds_act_givemoney_tip',
                clrs =
                {
                    btn_n               = Color( 42, 42, 42, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 182, 59, 75, 255 ),
                },
                args =
                {
                    {
                        name            = 'Amount',
                        default         = 0,
                        type            = 'int',
                        bChange         = true,
                    },
                },
                action = function( pl, data )
                    local cmd = string.format( '/give %s', tostring( data[ 1 ] ) )
                    rcc.run.gmod( 'say', cmd )
                end,
            },

            {
                enabled                 = true,
                name                    = 'cmds_act_nshipment_btn',
                tip                     = 'cmds_act_nshipment_tip',
                clrs =
                {
                    btn_n               = Color( 42, 42, 42, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 182, 59, 75, 255 ),
                },
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'makeshipment' )
                end,
            },

            {
                enabled                 = true,
                name                    = 'cmds_act_selldoors_btn',
                tip                     = 'cmds_act_selldoors_tip',
                clrs =
                {
                    btn_n               = Color( 42, 42, 42, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 182, 59, 75, 255 ),
                },
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'unownalldoors' )
                end,
            },

            {
                enabled                 = true,
                name                    = 'cmds_act_reqgunlic_btn',
                tip                     = 'cmds_act_reqgunlic_tip',
                clrs =
                {
                    btn_n               = Color( 42, 42, 42, 255 ),
                    btn_h               = Color( 255, 255, 255, 5 ),
                    txt_n               = Color( 255, 255, 255, 255 ),
                    txt_h               = Color( 255, 255, 255, 255 ),
                    ico_n               = Color( 182, 59, 75, 255 ),
                },
                action = function( pl, data )
                    rcc.run.gmod( 'darkrp', 'requestlicense' )
                end,
            },
    }