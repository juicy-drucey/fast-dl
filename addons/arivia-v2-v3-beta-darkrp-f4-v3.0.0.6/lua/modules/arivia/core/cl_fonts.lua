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
local access                = rlib.a
local helper                = base.h
local font                  = base.f

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   misc localization
*/

local _f                    = font.new

/*
*   fonts > primary
*/

local function fonts_register( pl )

    /*
    *	perm > reload
    */

        if ( ( helper.ok.ply( pl ) or base.con:Is( pl ) ) and not access:allow_throwExcept( pl, 'rlib_root' ) ) then return end

    /*
    *	general
    */

        _f( pf, 'g_nw_name',                    'Segoe UI Light', 40, 100 )
        _f( pf, 'g_pl_name',                    'Open Sans', 24, 400 )
        _f( pf, 'g_pl_salary',                  'Open Sans', 18, 400 )
        _f( pf, 'g_ticker_text',                'Segoe UI Light', 19, 300, true )
        _f( pf, 'g_hdr_exit',                   'Roboto', 50, 800 )
        _f( pf, 'g_sect_ico',                   'GSym Solid', 21, 800, false, true )
        _f( pf, 'g_ico_rehash',                 'GSym Solid', 19, 800, false, true )
        _f( pf, 'g_ico_about',                  'GSym Solid', 19, 800, false, true )
        _f( pf, 'g_ico_vis',                    'GSym Solid', 19, 800, false, true )
        _f( pf, 'g_ico_steam',                  'GSym Black', 19, 800, false, true )
        _f( pf, 'g_pnl_icon_lg',                'GSym Solid', 300, 800, false, true )
        _f( pf, 'g_pnl_ext_tabs',               'GSym Solid', 24, 800, false, true )
        _f( pf, 'g_ico_hint',                   'GSym Solid', 18, 800, false, true )

    /*
    *	about > manifest
    */

        _f( pf, 'ab_name',                      'Segoe UI Light', 32, 100 )
        _f( pf, 'ab_desc',                      'Segoe UI Light', 21, 200 )
        _f( pf, 'ab_dt_thx_icon',               'GSym Solid', 21, 800, false, true )
        _f( pf, 'ab_dt_thx_name',               'Open Sans', 21, 600 )
        _f( pf, 'ab_dt_lic_regto',              'Segoe UI Light', 27, 400 )
        _f( pf, 'ab_dt_lic_val',                'Segoe UI Light', 26, 200 )
        _f( pf, 'ab_cont_name',                 'Segoe UI Light', 18, 400 )
        _f( pf, 'ab_cont_desc',                 'Segoe UI Light', 18, 400 )
        _f( pf, 'ab_cont_btn',                  'Segoe UI Light', 18, 600 )
        _f( pf, 'ab_mf_item_name',              'Roboto Light', 16, 400 )
        _f( pf, 'ab_mf_item_val',               'Roboto Light', 16, 400 )
        _f( pf, 'ab_dt_notice',                 'Segoe UI Light', 19, 200 )
        _f( pf, 'ab_web_btn',                   'Roboto', 16, 400 )

    /*
    *	item > nav > buttons
    */

        _f( pf, 'nav_button_name',              'Oswald Light', 25, 400 )
        _f( pf, 'nav_button_desc',              'Oswald Light', 16, 300 )

    /*
    *	item > selection
    */

        _f( pf, 'sel_name',                     'Segoe UI Light', 26, 100 )
        _f( pf, 'sel_sub',                      'Segoe UI Light', 19, 100 )
        _f( pf, 'sel_desc',                     'Segoe UI Light', 20, 100 )
        _f( pf, 'sel_arrow',                    'Roboto', 34, 100 )
        _f( pf, 'sel_skins_i',                  'Segoe UI Light', 20, 300 )
        _f( pf, 'sel_notice',                   'Segoe UI Light', 20, 100 )
        _f( pf, 'sel_notice_indc',              'Segoe UI Light', 18, 100 )
        _f( pf, 'sel_notice_ico',               'GSym Solid', 17, 100, false, true )
        _f( pf, 'sel_btn_act_txt',              'Segoe UI Light', 26, 100 )
        _f( pf, 'sel_btn_act_ico',              'GSym Solid', 23, 100, false, true )
        _f( pf, 'sel_tab_item',                 'Oswald Light', 25, 400 )
        _f( pf, 'sel_tab_lo_none',              'Segoe UI Light', 26, 100 )
        _f( pf, 'sel_tab_info_desc',            'Segoe UI Light', 16, 400 )
        _f( pf, 'sel_debug_name',               'Segoe UI Light', 16, 400 )
        _f( pf, 'sel_debug_value',              'Segoe UI Light', 16, 100 )
        _f( pf, 'sel_job_req',                  'Segoe UI Light', 17, 400 )

    /*
    *	item > selection > tab > admin > search
    */

        _f( pf, 'sel_job_tab_adm_def',          'Roboto', 16, 400 )
        _f( pf, 'sel_job_tab_adm_sel_usr',      'Roboto', 16, 400 )
        _f( pf, 'sel_job_tab_adm_src_name',     'Roboto Light', 16, 400 )
        _f( pf, 'sel_job_tab_adm_src_btn',      'Roboto Light', 18, 200 )

    /*
    *	item > slots
    */

        _f( pf, 'slot_item_name',               'Segoe UI Light', 22, 300, true )
        _f( pf, 'slot_item_sub',                'Segoe UI Light', 19, 400, true )
        _f( pf, 'slot_item_cir_val1',           'Segoe UI Light', 14, 400, true )
        _f( pf, 'slot_item_cir_val2',           'Segoe UI', 21, 300, true )
        _f( pf, 'slot_item_cir_val2_sm',        'Segoe UI', 18, 300, true )
        _f( pf, 'slot_item_qbuy_txt',           'Segoe UI Light', 22, 600, true )
        _f( pf, 'slot_item_qbuy_ico',           'GSym Solid', 32, 800, false, true )
        _f( pf, 'slot_item_mdl_h_locked',       'Segoe UI Light', 16, 600, true )
        _f( pf, 'slot_item_btn_fav_on',         'GSym Solid', 26, 100, false, true )
        _f( pf, 'slot_item_btn_fav_off',        'GSym Regular', 26, 100, false, true )
        _f( pf, 'slot_item_btn_nfo_n',          'GSym Light', 26, 400, false, true )
        _f( pf, 'slot_item_btn_nfo_h',          'GSym Solid', 26, 100, false, true )
        _f( pf, 'slot_results_none_ico',        'GSym Solid', 90, 800, false, true )
        _f( pf, 'slot_results_none_404',        'Segoe UI', 72, 800, false )
        _f( pf, 'slot_results_none_msg',        'Segoe UI Light', 32, 100, false )

    /*
    *	element > category
    */

        _f( pf, 'elm_cat_btn_expand',           'Roboto', 30, 800, false )
        _f( pf, 'elm_cat_btn_name',             'Oswald Light', 25, 400, false )
        _f( pf, 'elm_lo_item_name',             'Montserrat Thin', 25, 400, false )
        _f( pf, 'elm_lo_item_desc',             'Montserrat Thin', 19, 100, false )

    /*
    *	element > mdl
    */

        _f( pf, 'elm_mdl_txt_hover',            'Segoe UI Light', ScreenScale( 10 ), 300, true )
        _f( pf, 'elm_mdl_txt_disabled',         'Open Sans', 100, 300, true )

    /*
    *	staff > card
    */

        _f( pf, 'staff_sect_name',              'Segoe UI Light', 32, 100 )
        _f( pf, 'staff_card_pl_name',           'Montserrat Thin', 22, 300 )
        _f( pf, 'staff_card_pl_rank',           'Montserrat Thin', 20, 300 )

    /*
    *   rules
    */

        _f( pf, 'rules_sect_name',              'Segoe UI Light', 32, 100 )
        _f( pf, 'rules_sect_icon',              'GSym Solid', 21, 800, false, true )
        _f( pf, 'rules_exit',                   'Roboto', 24, 800 )
        _f( pf, 'rules_resizer',                'Roboto Light', 24, 100 )
        _f( pf, 'rules_btn_web',                'Roboto', 16, 400 )
        _f( pf, 'rules_btn_web_desc',           'Montserrat Light', 18, 100 )
        _f( pf, 'rules_text',                   'Roboto Light', 16, 400 )

    /*
    *   commands
    */

        _f( pf, 'settings_sect_name',           'Segoe UI Light', 32, 100 )
        _f( pf, 'settings_msg',                 'Segoe UI Light', 32, 100 )
        _f( pf, 'settings_fps_sub',             'Segoe UI Light', 26, 100 )
        _f( pf, 'settings_fps_chart_legend',    'Segoe UI Light', 16, 400 )
        _f( pf, 'settings_fps_chart_value',     'Segoe UI', 22, 200 )

    /*
    *   commands
    */

        _f( pf, 'ws_name',                      'Segoe UI Light', 32, 100 )
        _f( pf, 'ws_sub',                       'Segoe UI Light', 18, 100 )
        _f( pf, 'ws_sect_ico',                  'GSym Black', 22, 100, false, true )
        _f( pf, 'ws_sect_desc',                 'Montserrat Light', 18, 100 )
        _f( pf, 'ws_card_ico',                  'GSym Black', 38, 100, false, true )
        _f( pf, 'ws_card_name',                 'Montserrat', 19, 300 )
        _f( pf, 'ws_card_id',                   'Montserrat Thin', 17, 300 )

    /*
    *   commands
    */

        _f( pf, 'cmds_list_ico',                'GSym Solid', 20, 800, false, true )
        _f( pf, 'cmds_list_sep',                'Segoe UI Light', 20, 100 )
        _f( pf, 'cmds_args_hdr_icon',           'Roboto Light', 24, 100 )
        _f( pf, 'cmds_args_hdr_name',           'Roboto Light', 16, 600 )
        _f( pf, 'cmds_args_hdr_exit',           'Roboto', 40, 800 )
        _f( pf, 'cmds_args_hdr_desc',           'Roboto Light', 16, 400 )
        _f( pf, 'cmds_args_info_text',          'Roboto Light', 16, 400 )
        _f( pf, 'cmds_args_info_icon',          'Roboto Light', 31, 100 )
        _f( pf, 'cmds_args_arg_name',           'Roboto', 15, 400 )
        _f( pf, 'cmds_args_arg_value',          'Roboto', 15, 100 )
        _f( pf, 'cmds_args_btn_confirm',        'Roboto', 18, 800 )

    /*
    *    mviewer
    */

        _f( pf, 'mdlv_exit',                    'Roboto', 50, 800 )
        _f( pf, 'mdlv_resizer',                 'Roboto Light', 24, 100 )
        _f( pf, 'mdlv_icon',                    'Roboto Light', 24, 100 )
        _f( pf, 'mdlv_name',                    'Roboto Light', 44, 100 )
        _f( pf, 'mdlv_name',                    'Roboto Light', 16, 600, true )
        _f( pf, 'mdlv_clear',                   'Roboto', 20, 800 )
        _f( pf, 'mdlv_enter',                   'Roboto', 20, 800 )
        _f( pf, 'mdlv_control',                 'Roboto Condensed', 16, 200 )
        _f( pf, 'mdlv_searchbox',               'Roboto Light', 18, 100 )
        _f( pf, 'mdlv_minfo',                   'Roboto Light', 16, 400 )
        _f( pf, 'mdlv_copyclip',                'Roboto Light', 14, 100, true )

    /*
    *   servers
    */

        _f( pf, 'servers_button_name',          'Oswald Light', 25, 400 )

    /*
    *   switch server dialog
    */

        _f( pf, 'cwserv_hdr_icon',              'Roboto Light', 24, 100 )
        _f( pf, 'cwserv_hdr_name',              'Roboto Light', 16, 600 )
        _f( pf, 'cwserv_hdr_exit',              'Roboto', 40, 800 )
        _f( pf, 'cwserv_btn_clr',               'Roboto', 41, 800 )
        _f( pf, 'cwserv_btn_copy',              'Roboto', 18, 800 )
        _f( pf, 'cwserv_btn_confirm',           'Roboto', 18, 800 )
        _f( pf, 'cwserv_err',                   'Roboto', 14, 800 )
        _f( pf, 'cwserv_desc',                  'Roboto Light', 16, 400 )
        _f( pf, 'cwserv_info',                  'Roboto Light', 16, 400 )
        _f( pf, 'cwserv_info_icon',             'Roboto Light', 31, 100 )
        _f( pf, 'cwserv_copyclip',              'Roboto Light', 14, 100, true )

    /*
    *   cvar settings
    */

        _f( pf, 'cvar_cbox_label',              'Roboto', 13, 400 )
        _f( pf, 'cvar_status_msg',              'Roboto Light', 19, 400 )

    /*
    *   ibws > diag
    */

        _f( pf, 'ibws_diag_hdr_icon',           'Roboto Light', 24, 100 )
        _f( pf, 'ibws_diag_hdr_name',           'Roboto Light', 16, 600 )
        _f( pf, 'ibws_diag_hdr_exit',           'Roboto', 40, 800 )
        _f( pf, 'ibws_diag_desc',               'Roboto Light', 16, 400 )
        _f( pf, 'ibws_diag_txt_ack',            'Roboto Light', 16, 400 )
        _f( pf, 'ibws_diag_btn_ack',            'Roboto', 18, 800 )
        _f( pf, 'ibws_diag_ico_hint',           'GSym Solid', 14, 800, false, true )
        _f( pf, 'ibws_diag_ftr_icon',           'Roboto Light', 31, 100 )

    /*
    *   diag > disconnect
    */

        _f( pf, 'diag_dc_hdr_icon',             'Roboto Light', 24, 100 )
        _f( pf, 'diag_dc_hdr_name',             'Roboto Light', 16, 600 )
        _f( pf, 'diag_dc_hdr_exit',             'Roboto', 40, 800 )
        _f( pf, 'diag_dc_btn_msg',              'Roboto Light', 20, 400 )
        _f( pf, 'diag_dc_btn_desc',             'Roboto Light', 18, 400 )
        _f( pf, 'diag_dc_ftr_icon',             'Roboto Light', 34, 100 )
        _f( pf, 'diag_dc_btn_x',                'Roboto', 38, 800 )
        _f( pf, 'diag_dc_btn_confirm',          'Roboto', 16, 100 )

    /*
    *   diag > set job
    */

        _f( pf, 'diag_setjob_label',            'Roboto Light', 16, 600 )
        _f( pf, 'diag_setjob_icon',             'Roboto Light', 24, 100 )
        _f( pf, 'diag_setjob_exit',             'Roboto', 30, 800 )
        _f( pf, 'diag_setjob_err',              'Roboto', 14, 800 )
        _f( pf, 'diag_setjob_desc',             'Roboto Light', 16, 400 )
        _f( pf, 'diag_setjob_ftr_icon',         'Roboto Light', 31, 100 )
        _f( pf, 'diag_setjob_ftr_text',         'Roboto Light', 16, 400 )
        _f( pf, 'diag_setjob_btn_n',            'Roboto', 41, 800 )
        _f( pf, 'diag_setjob_btn_y',            'Roboto', 18, 800 )

    /*
    *   concommand > reload
    */

        if helper.ok.ply( pl ) or base.con:Is( pl ) then
            base:log( 4, '[ %s ] reloaded fonts', mod.name )
            if not base.con.Is( pl ) then
                base.msg:target( pl, mod.name, 'reloaded fonts' )
            end
        end

end
rhook.new.rlib( 'arivia_fonts_register', fonts_register )
rcc.new.rlib( 'arivia_fonts_reload', fonts_register )

/*
*   fonts > rnet > reload
*/

local function fonts_rnet_reload( data )
    fonts_register( LocalPlayer( ) )
end
rnet.call( 'arivia_fonts_reload', fonts_rnet_reload )