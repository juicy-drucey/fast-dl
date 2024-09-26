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
*   module data
*/

    MODULE                  = { }
    MODULE.calls            = { }
    MODULE.resources        = { }

    MODULE.enabled          = true
    MODULE.parent		    = arivia or { }
    MODULE.demo             = false
    MODULE.name             = 'Arivia'
    MODULE.id               = 'arivia'
    MODULE.author           = 'Richard'
    MODULE.desc             = 'F4 menu'
    MODULE.docs             = 'https://arivia.rlib.io'
    MODULE.url              = 'https://gmodstore.com/scripts/view/3eb6dfdf-ff22-4f7b-8018-c875f247cc66/'
    MODULE.icon             = 'https://cdn.rlib.io/gms/3eb6dfdf-ff22-4f7b-8018-c875f247cc66/env.png'
    MODULE.script_id	    = '3eb6dfdf-ff22-4f7b-8018-c875f247cc66'
    MODULE.owner		    = '76561199237832821'
    MODULE.build            = 2
    MODULE.version          = { 3, 0, 0, 6 }
    MODULE.libreq           = { 3, 2, 1, 0 }
    MODULE.released		    = 1616301871

/*
*   workshops
*/

    MODULE.fastdl 	        = true
    MODULE.precache         = true
    MODULE.bWorkshop 	    = true
    MODULE.workshop         = '2290446815'

/*
*   fonts
*/

    MODULE.fonts = { }

/*
*   translations
*/

    MODULE.language = { }

/*
*   mats > v1
*/

    MODULE.materials = { }

/*
*   mats > v2
*/

    MODULE.mats =
    {
        [ 'nav_cats_buy_01' ]                   = { 'rlib/modules/arivia/v3/ico/general/box_01.png' },
        [ 'nav_cats_buy_02' ]                   = { 'rlib/modules/arivia/v3/ico/general/box_02.png' },
        [ 'nav_cats_buy_03' ]                   = { 'rlib/modules/arivia/v3/ico/general/buy_01.png' },
        [ 'nav_cats_actions_01' ]               = { 'rlib/modules/arivia/v3/ico/general/actions_01.png' },
        [ 'nav_cats_actions_02' ]               = { 'rlib/modules/arivia/v3/ico/general/actions_02.png' },
        [ 'nav_cats_actions_03' ]               = { 'rlib/modules/arivia/v3/ico/general/actions_03.png' },
        [ 'nav_cats_info_01' ]                  = { 'rlib/modules/arivia/v3/ico/general/info_01.png' },

        [ 'tab_mini_buy_01' ]                   = { 'rlib/modules/arivia/v3/ico/tabs/mini/buy_01.png' },
        [ 'tab_mini_act_01' ]                   = { 'rlib/modules/arivia/v3/ico/tabs/mini/act_01.png' },
        [ 'tab_mini_info_01' ]                  = { 'rlib/modules/arivia/v3/ico/tabs/mini/info_01.png' },
        [ 'tab_mini_settings_01' ]              = { 'rlib/modules/arivia/v3/ico/tabs/mini/settings_01.png' },

        [ 'gen_close_01' ]                      = { 'rlib/modules/arivia/v3/ico/general/close_01.png' },
        [ 'gen_close_02' ]                      = { 'rlib/modules/arivia/v3/ico/general/close_02.png' },
        [ 'gen_close_03' ]                      = { 'rlib/modules/arivia/v3/ico/general/close_03.png' },
        [ 'gen_connect_01' ]                    = { 'rlib/modules/arivia/v3/ico/general/connect_01.png' },
        [ 'gen_console_01' ]                    = { 'rlib/modules/arivia/v3/ico/general/console_01.png' },
        [ 'gen_console_02' ]                    = { 'rlib/modules/arivia/v3/ico/general/console_02.png' },
        [ 'gen_controller_01' ]                 = { 'rlib/modules/arivia/v3/ico/general/controller_01.png' },
        [ 'gen_disconnect_01' ]                 = { 'rlib/modules/arivia/v3/ico/general/disconnect_01.png' },
        [ 'gen_disconnect_02' ]                 = { 'rlib/modules/arivia/v3/ico/general/disconnect_02.png' },
        [ 'gen_discord_01' ]                    = { 'rlib/modules/arivia/v3/ico/general/discord_01.png' },
        [ 'gen_discord_02' ]                    = { 'rlib/modules/arivia/v3/ico/general/discord_02.png' },
        [ 'gen_donate_01' ]                     = { 'rlib/modules/arivia/v3/ico/general/donate_01.png' },
        [ 'gen_donate_02' ]                     = { 'rlib/modules/arivia/v3/ico/general/donate_02.png' },
        [ 'gen_forums_01' ]                     = { 'rlib/modules/arivia/v3/ico/general/forums_01.png' },
        [ 'gen_gmod_01' ]                       = { 'rlib/modules/arivia/v3/ico/general/gmod_01.png' },
        [ 'gen_gmod_02' ]                       = { 'rlib/modules/arivia/v3/ico/general/gmod_02.png' },
        [ 'gen_help_01' ]                       = { 'rlib/modules/arivia/v3/ico/general/help_01.png' },
        [ 'gen_main_01' ]                       = { 'rlib/modules/arivia/v3/ico/general/main_01.png' },
        [ 'gen_main_02' ]                       = { 'rlib/modules/arivia/v3/ico/general/main_02.png' },
        [ 'gen_resume_01' ]                     = { 'rlib/modules/arivia/v3/ico/general/resume_01.png' },
        [ 'gen_resume_02' ]                     = { 'rlib/modules/arivia/v3/ico/general/resume_02.png' },
        [ 'gen_rules_01' ]                      = { 'rlib/modules/arivia/v3/ico/general/rules_01.png' },
        [ 'gen_rules_02' ]                      = { 'rlib/modules/arivia/v3/ico/general/rules_02.png' },
        [ 'gen_rules_03' ]                      = { 'rlib/modules/arivia/v3/ico/general/rules_03.png' },
        [ 'gen_server_01' ]                     = { 'rlib/modules/arivia/v3/ico/general/server_01.png' },
        [ 'gen_settings_01' ]                   = { 'rlib/modules/arivia/v3/ico/general/settings_01.png' },
        [ 'gen_settings_02' ]                   = { 'rlib/modules/arivia/v3/ico/general/settings_02.png' },
        [ 'gen_staff_01' ]                      = { 'rlib/modules/arivia/v3/ico/general/staff_01.png' },
        [ 'gen_staff_02' ]                      = { 'rlib/modules/arivia/v3/ico/general/staff_02.png' },
        [ 'gen_steam_01' ]                      = { 'rlib/modules/arivia/v3/ico/general/steam_01.png' },
        [ 'gen_steam_02' ]                      = { 'rlib/modules/arivia/v3/ico/general/steam_02.png' },
        [ 'gen_twitch_01' ]                     = { 'rlib/modules/arivia/v3/ico/general/twitch_01.png' },
        [ 'gen_website_01' ]                    = { 'rlib/modules/arivia/v3/ico/general/website_01.png' },
        [ 'gen_website_02' ]                    = { 'rlib/modules/arivia/v3/ico/general/website_02.png' },
        [ 'gen_website_03' ]                    = { 'rlib/modules/arivia/v3/ico/general/website_03.png' },
        [ 'gen_workshop_01' ]                   = { 'rlib/modules/arivia/v3/ico/general/workshop_01.png' },

        [ 'tab_store_jobs' ]                    = { 'rlib/modules/arivia/v3/ico/tabs/store/jobs.png' },
        [ 'tab_store_ship' ]                    = { 'rlib/modules/arivia/v3/ico/tabs/store/shipments.png' },
        [ 'tab_store_ents' ]                    = { 'rlib/modules/arivia/v3/ico/tabs/store/entities.png' },
        [ 'tab_store_weps' ]                    = { 'rlib/modules/arivia/v3/ico/tabs/store/weapons.png' },
        [ 'tab_store_ammo' ]                    = { 'rlib/modules/arivia/v3/ico/tabs/store/ammo.png' },
        [ 'tab_store_food' ]                    = { 'rlib/modules/arivia/v3/ico/tabs/store/food.png' },
        [ 'tab_store_vehc' ]                    = { 'rlib/modules/arivia/v3/ico/tabs/store/vehicles.png' },

        [ 'mdlv_preview_01' ]                   = { 'rlib/modules/arivia/v3/ico/general/mviewer/preview_01.png' },
        [ 'mdlv_preview_02' ]                   = { 'rlib/modules/arivia/v3/ico/general/mviewer/preview_02.png' },

        [ 'pattern_hdiag' ]                     = { 'rlib/general/patterns/diag_w.png' },

        [ 'cat_tip_bell' ]                      = { 'rlib/modules/arivia/v3/ico/general/bell.png' },
    }

/*
*   permissions
*/

    MODULE.permissions =
    {
        [ 'index' ] =
        {
            category                = 'RLib » Arivia',
            module                  = 'Arivia',
        },
        [ 'arivia_forceteams' ] =
        {
            id                      = 'arivia_forceteams',
            svg_id                  = 'Arivia » Force Teams',
            desc                    = 'Allows staff member to force team on player.',
            usrlvl                  = 'superadmin',
        },
    }

/*
*   storage > sh
*/

    MODULE.storage =
    {
        dc                  = { },
        slots =
        {
            jobs            = { },
            ents            = { },
        },
        tabs =
        {
            cur             = nil,
            dir             = { },
            m               = { },
            n               = { },
            w               = 0,
        },
        plugins =
        {
            level           = { },
            prestige        = { },
        },
        precache            = { },
        binds =
        {
            chat            = { },
            console         = { },
        },
        history =
        {
            exp             = { },
            jobs            = { },
        },
        favs =
        {
            jobs            = { },
        },
        jobs =
        {
            src             = { },
            current         = 1
        },
        ammo =
        {
            src             = { },
        },
        weps =
        {
            src             = { },
            i               = 0,
        },
        ship =
        {
            src             = { },
        },
        ents =
        {
            src             = { },
        },
        vehc =
        {
            src             = { },
        },
        food =
        {
            src             = { },
        },
        ticker              = { },
        handle =
        {
            tab             = { },
            jsl             = { },
            ent             = { },
        },
        rules               = { },
        web                 = { },
        commands            = { },
        settings =
        {
            general         = { },
            precache        = { },
            anim            = { },
            ugroups         = { },
            web             = { },
            tabs            = { },
            ticker          = { },
            loadout         = { },
            jobs            = { },
            ammo            = { },
            gun             = { },
            shipment        = { },
            ent             = { },
            vehicle         = { },
            food            = { },
            staff           = { },
            models =
            {
                slot        = { },
                sel         = { },
            },
            rules           = { },
            actions         = { },
            plugins =
            {
                level       = { },
                prestige    = { },
            },
            ui =
            {
                sizes       = { },
                clrs =
                {
                    pnl     = { },
                    sbar    = { },
                    btn     = { },
                    text    = { },
                },
            },
            dev =
            {
                cvar        = { },
                cvarlst     = { },
            },
        }
    }

/*
*   storage > sv
*/

    MODULE.storage_sv = { }

/*
*   storage > cl
*/

    MODULE.storage_cl = { }

/*
*   datafolder
*/

    MODULE.datafolder = { }

/*
*   calls > net
*/

    MODULE.calls.net =
    {
        [ 'arivia_sv_pl_setup' ]                            = { 'arivia.sv.pl.setup' },
        [ 'arivia_sv_all_data_rehash' ]                     = { 'arivia.sv.all.data.rehash' },
    }

/*
*   calls > hooks
*/

    MODULE.calls.hooks =
    {
        [ 'arivia_fonts_register' ]                         = { 'arivia.fonts.register' },
        [ 'arivia_rnet_register' ]                          = { 'arivia.rnet.register' },
        [ 'arivia_sv_pl_auth' ]                             = { 'arivia.sv.pl.auth' },
        [ 'arivia_cl_init' ]                                = { 'arivia.cl.init' },
        [ 'arivia_cl_ipe' ]                                 = { 'arivia.cl.ipe' },
        [ 'arivia_cl_init_precache' ]                       = { 'arivia.cl.init.precache' },
        [ 'arivia_cl_pl_teamchange' ]                       = { 'arivia.cl.pl.teamchange' },
        [ 'arivia_cl_usrdef_setup_th' ]                     = { 'arivia.cl.usrdef.setup.th' },
        [ 'arivia_sv_pl_changedteam' ]                      = { 'arivia.sv.pl.changedteam' },
        [ 'arivia_sh_precache' ]                            = { 'arivia.sh.precache' },
        [ 'arivia_ol_copy_clipb' ]                          = { 'arivia.ol.copy.clipb' },
        [ 'arivia_ps_toggle' ]                              = { 'arivia.ps.toggle' },
    }

/*
*   calls > commands
*/

    MODULE.calls.commands =
    {
        [ 'arivia_toggle_m0' ] =
        {
            id                      = 'arivia',
            desc                    = 'opens f4',
            scope                   = 3
        },
        [ 'arivia_toggle_m1' ] =
        {
            id                      = 'buymenu',
            desc                    = 'opens f4',
            scope                   = 3
        },
        [ 'arivia_ui_rehash' ] =
        {
            id                      = 'arivia.ui.rehash',
            desc                    = 'completely destroys all pnls and re-creates them',
            scope                   = 3
        },
        [ 'arivia_ui_pnls' ] =
        {
            id                      = 'arivia.ui.pnls',
            desc                    = 'returns list of all registered pnls',
            scope                   = 3
        },
        [ 'arivia_ui_loadstore' ] =
        {
            id                      = 'arivia.ui.loadstore',
            desc                    = 'forces store data to rehash',
            scope                   = 3
        },
        [ 'arivia_rnet_reload' ] =
        {
            id                      = 'arivia.rnet.reload',
            desc                    = 'reloads module rnet module',
            is_hidden               = true,
            scope                   = 1,
        },
        [ 'arivia_fonts_reload' ] =
        {
            id                      = 'arivia.fonts.reload',
            desc                    = 'reloads all fonts',
            is_hidden               = true,
            scope                   = 2,
        },
        [ 'arivia_setjob' ] =
        {
            id                      = 'arivia.setjob',
            desc                    = 'forces player to new job',
            is_hidden               = true,
            scope                   = 2,
        },
        [ 'arivia_setjob_cmd' ] =
        {
            id                      = 'arivia.setjob.cmd',
            desc                    = 'forces player to new job based on job command',
            is_hidden               = true,
            scope                   = 2,
        },
        [ 'arivia_getjob' ] =
        {
            id                      = 'arivia.getjob',
            desc                    = 'returns player job',
            is_hidden               = true,
            scope                   = 2,
        },
        [ 'arivia_listjobs' ] =
        {
            id                      = 'arivia.listjobs',
            desc                    = 'returns list of jobs on server',
            is_hidden               = true,
            scope                   = 2,
        },
    }

/*
*   calls > timers
*/

    MODULE.calls.timers =
    {
        [ 'arivia_sv_pl_auth' ]                             = { 'arivia.sv.pl.auth' },
        [ 'arivia_cl_init_precache_autoclose' ]             = { 'arivia.cl.init.precache.autoclose' },
        [ 'arivia_cl_ui_rehash' ]                           = { 'arivia.cl.ui.rehash' },
        [ 'arivia_cl_ticker' ]                              = { 'arivia.cl.ticker' },
        [ 'arivia_cl_cat_setup' ]                           = { 'arivia.cl.cat.setup' },
        [ 'arivia_cl_copy_anim' ]                           = { 'arivia.cl.copy.anim' },
    }

/*
*   resources > particles
*/

    MODULE.resources.ptc =
    {

    }

/*
*   resources > sounds
*/

    MODULE.resources.snd =
    {

    }

/*
*   resources > models
*/

    MODULE.resources.mdl = { }

/*
*   resources > panels
*/

    MODULE.resources.pnl =
    {
        [ 'pnl_ticker' ]                = { 'arivia.pnl.ticker' },
        [ 'pnl_settings' ]              = { 'arivia.pnl.settings' },
        [ 'pnl_actions' ]               = { 'arivia.pnl.actions' },
        [ 'pnl_staff' ]                 = { 'arivia.pnl.staff' },
        [ 'pnl_rules' ]                 = { 'arivia.pnl.rules' },
        [ 'pnl_rules_web' ]             = { 'arivia.pnl.rules.web' },
        [ 'pnl_ibws' ]                  = { 'arivia.pnl.ibws' },
        [ 'pnl_about' ]                 = { 'arivia.pnl.about' },
        [ 'pnl_ws' ]                    = { 'arivia.pnl.workshop' },
        [ 'pnl_bg' ]                    = { 'arivia.pnl.bg' },
        [ 'pnl_tab_jobs' ]              = { 'arivia.pnl.tab.jobs' },
        [ 'pnl_tab_ents' ]              = { 'arivia.pnl.tab.ents' },
        [ 'pnl_tab_ammo' ]              = { 'arivia.pnl.tab.ammo' },
        [ 'pnl_tab_weps' ]              = { 'arivia.pnl.tab.weps' },
        [ 'pnl_tab_ship' ]              = { 'arivia.pnl.tab.ship' },
        [ 'pnl_tab_food' ]              = { 'arivia.pnl.tab.food' },
        [ 'pnl_tab_vehc' ]              = { 'arivia.pnl.tab.vehc' },
        [ 'pnl_mviewer' ]               = { 'arivia.pnl.mviewer' },
        [ 'pnl_servers' ]               = { 'arivia.pnl.servers' },
        [ 'diag_cwserv' ]               = { 'arivia.diag.cwserv' },
        [ 'diag_dcserv' ]               = { 'arivia.diag.dc.serv' },
        [ 'diag_setjob' ]               = { 'arivia.diag.setjob' },
        [ 'diag_args' ]                 = { 'arivia.diag.args' },
        [ 'diag_ibws_notice' ]          = { 'arivia.diag.ibws.notice' },
        [ 'category' ]                  = { 'arivia.pnl.category' },
        [ 'base' ]                      = { 'arivia.pnl.base' },
        [ 'elm_desc' ]                  = { 'arivia.elm.desc' },
        [ 'elm_mdl' ]                   = { 'arivia.elm.model' },
        [ 'elm_sbar' ]                  = { 'arivia.elm.scrollbar' },
        [ 'elm_slot' ]                  = { 'arivia.elm.slot' },
        [ 'elm_sel_tab_loadout' ]       = { 'arivia.elm.sel.tab.loadout' },
        [ 'elm_sel_tab_dev_jobs' ]      = { 'arivia.elm.sel.tab.dev.jobs' },
        [ 'elm_sel_tab_adm_jobs' ]      = { 'arivia.elm.sel.tab.adm.jobs' },
        [ 'elm_sel_tab_adm_jobs_pl' ]   = { 'arivia.elm.sel.tab.adm.jobs.pl' },
        [ 'elm_sel_tab_dev_item' ]      = { 'arivia.elm.sel.tab.dev.item' },
        [ 'nav_cats' ]                  = { 'arivia.pnl.nav.cats' },
    }

/*
*   doclick
*/

    MODULE.doclick = function( ) end

/*
*   dependencies
*/

    MODULE.dependencies =
    {

    }

  MODULE.resources.snd =
  {
    [ 'mouseover_01' ]     = { 'rlib/general/actions/mo_1.mp3' },
    [ 'mouseover_02' ]     = { 'rlib/general/actions/mo_2.mp3' },
    [ 'swipe_01' ]         = { 'rlib/general/actions/sw_1.mp3' },
  }