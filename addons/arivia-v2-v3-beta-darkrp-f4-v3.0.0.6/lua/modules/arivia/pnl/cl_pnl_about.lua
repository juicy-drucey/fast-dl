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
local helper                = base.h
local storage               = base.s
local design                = base.d
local ui                    = base.i
local mats                  = base.m
local cvar                  = base.v

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   Localized translation func
*/

local function ln( ... )
    return base:translate( mod, ... )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return base.get:pref( str, state )
end

/*
*   panel
*/

local PANEL = { }

/*
*   initialize
*/

function PANEL:Init( )

    /*
    *   parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :fill                           (                                       )

    /*
    *   sub
    */

    self.ct_sub                     = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 10, 0                         )

    /*
    *   sub > body
    */

    self.ct_outter                  = ui.new( 'pnl', self.ct_sub, 1         )
    :fill                           ( 'm', 10, 5, 10, 5                     )

    /*
    *   about > container
    */

    self.ct_sec                     = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 20, 10, 20, 10                   )

    /*
    *   about > title
    */

    self.ct_header                  = ui.new( 'pnl', self.ct_sec, 1         )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'ab_sec_main_name' ), pref( 'ab_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   about > sep
    */

    self.ct_sep                     = ui.new( 'pnl', self.ct_sec, 1         )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   about > body
    */

    self.ct_body                    = ui.new( 'pnl', self.ct_sec, 1         )
    :fill                           ( 'm', 0, 0, 0, 0                       )

    /*
    *   about
    */

    self.dt_desc                    = ui.new( 'dt', self.ct_body            )
    :top                            ( 'm', 0                                )
    :tall                           ( 120                                   )
    :drawbg                         ( false                                 )
    :mline                          ( true                                  )
    :txt                            ( ln( 'ab_alpha_desc' )                 )
    :textclr                        ( self.clr_txt_acc                      )
    :font                           ( pref( 'ab_desc' )                     )
    :lbllock                        (                                       )

    /*
    *   about > contributions > title
    */

    self.ct_cont_hdr                = ui.new( 'pnl', self.ct_body           )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'ab_sec_contrib_name' ), pref( 'ab_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   about > contributions > sep
    */

    self.ct_cont_sep                = ui.new( 'pnl', self.ct_body           )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )


    /*
    *   about > contributions > count entries
    */

    local i                         = #cfg.dev.contribs or 0

    /*
    *   about > contributions > parent
    */

    self.ct_cont_lst                = ui.new( 'pnl', self.ct_body, 1        )
    :top                            (                                       )
    :tall                           ( i * 40 + 50                           )

    /*
    *   about > contributions > sort
    */

    local contribs = table.Copy( cfg.dev.contribs )
    table.sort( contribs, function( a, b )
        local aso = a.sort or 100
        local bso = b.sort or 100

        return aso < bso or aso == bso and a.name < b.name
    end )

    /*
    *   about > contributions > list
    */

    for v in helper.get.data( contribs ) do

        /*
        *   about > contributions > parent
        */

        self.ct_cont_sub            = ui.new( 'pnl', self.ct_cont_lst       )
        :top                        ( 'm', 0, 0, 0, 1                       )
        :tall                       ( 40                                    )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 0, 0, 0, 100 ) )
                                    end )

        /*
        *   about > contributions > col > name
        */

        self.ct_cont_name           = ui.new( 'pnl', self.ct_cont_sub       )
        :left                       (                                       )
        :wide                       ( 150                                   )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 0, 0, 0, 45 ) )
                                        draw.SimpleText( v.name, pref( 'ab_cont_name' ), 20, h / 2 - 2, Color( 31, 133, 222  ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *   about > contributions > col > reason
        */

        self.ct_cont_desc           = ui.new( 'pnl', self.ct_cont_sub       )
        :fill                       (                                       )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( v.desc, pref( 'ab_cont_desc' ), 35, h / 2 - 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *   about > contributions > col > action
        */

        self.ct_cont_act            = ui.new( 'pnl', self.ct_cont_sub, 1    )
        :right                      ( 'm', 6                                )
        :wide                       ( 100                                   )

        /*
        *   about > contributions > col > action
        */

        self.b_cont_act             = ui.new( 'btn', self.ct_cont_act       )
        :bsetup                     (                                       )
        :fill                       (                                       )
        :tip                        ( ln( 'ab_cont_btn_tip' )               )
        :anim_click_ol              ( Color( 255, 255, 255, 10 ), 0.4, 1, cfg.dev.bDisableAnim )


                                    :draw( function( s, w, h )
                                        design.rbox( 4, 0, 0, w, h, Color( 135, 42, 32, 255 ) )
                                        design.rbox( 4, 0, 0, w, h / 2, Color( 255, 255, 255, 3 ) )

                                        if s.hover then
                                            design.rbox( 4, 0, 0, w, h, Color( 0, 0, 0, 50 ) )
                                        end

                                        draw.SimpleText( ln( 'ab_cont_lst_btn' ), pref( 'ab_cont_btn' ), w / 2, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        gui.OpenURL( v.url )
                                    end )

    end

    /*
    *   about > owner
    */

    self.ct_ownr_hdr                = ui.new( 'pnl', self.ct_body, 1        )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'ab_sec_owner_name' ), pref( 'ab_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   about > sep
    */

    self.ct_ownr_sep                = ui.new( 'pnl', self.ct_body, 1        )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   manifest > license
    */

    self.ct_ownr_lic                = ui.new( 'pnl', self.ct_body, 1        )
    :top                            ( 'm', 0                                )
    :tall                           ( 100                                   )

    /*
    *   about > owner > parent
    */

    self.ct_ownr_sub                = ui.new( 'pnl', self.ct_ownr_lic, 1    )
    :top                            ( 'm', 5                                )
    :tall                           ( 40                                    )

    /*
    *   about > owner > parent > left
    */

    self.ct_ownr_l                  = ui.new( 'pnl', self.ct_ownr_sub, 1    )
    :left                           ( 'm', 5                                )
    :wide                           ( 150                                   )

    /*
    *   about > owner > parent > right
    */

    self.ct_ownr_r                  = ui.new( 'pnl', self.ct_ownr_sub, 1    )
    :fill                           ( 'm', 5                                )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 45, 45, 45, 255 ) )
                                    end )

    /*
    *   about > owner > parent > left > lbl
    */

    self.ct_ownr_lbl                = ui.new( 'pnl', self.ct_ownr_l, 1      )
    :fill                           ( 'm', 0, 0, 0, 0                       )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( ln( 'ab_lbl_lic_regto' ), pref( 'ab_dt_lic_regto' ), 0, h / 2, Color( 171, 88, 83, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   about > owner > value
    */

    self.dt_ownr                    = ui.new( 'dt', self.ct_ownr_r          )
    :fill                           ( 'm', 10, 0, 10, 0                     )
    :drawbg                         ( false                                 )
    :mline                          ( false                                 )
    :txt                            ( self.owner_id                         )
    :font                           ( pref( 'ab_dt_lic_val' )               )
    :textclr                        ( Color( 255, 255, 255, 100 )           )
    :lbllock                        (                                       )

    /*
    *   manifest > container
    */

    self.ct_r                       = ui.new( 'pnl', self, 1                )
    :right                          ( 'm', 0, 0, 0, 0                       )
    :wide                           ( 270                                   )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 28, 28, 28, 255 ) )
                                        design.box( 0, 0, 1, h, self.clr_sep )
                                    end )

    /*
    *   manifest > inner
    */

    self.ct_r_i                     = ui.new( 'pnl', self.ct_r, 1           )
    :fill                           ( 'm', 20, 10, 20, 10                   )

    /*
    *   manifest > title
    */

    self.ct_mf_hdr                  = ui.new( 'pnl', self.ct_r_i, 1         )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'ab_sec_mf_name' ), pref( 'ab_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   manifest > header
    */

    self.ct_mf_sep                  = ui.new( 'pnl', self.ct_r_i, 1         )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   manifest > list
    */

    self.ct_mf_lst                  = ui.new( 'pnl', self.ct_r_i, 1         )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 200                                   )

    /*
    *   manifest > data
    */

    local uptime                    = timex.secs.sh_cols_steps( CurTime( ) - rlib.sys.uptime )

    local mf_data =
    {
        { name = ln( 'ab_lbl_version' ),    value = rlib.get:ver2str_mf( mod ) },
        { name = ln( 'ab_lbl_build' ),      value = rlib.modules:build( mod ) },
        { name = ln( 'ab_lbl_released' ),   value = os.date( '%m.%d.%Y', mod.released ) },
        { name = ln( 'ab_lbl_author' ),     value = mod.author },
        { name = ln( 'ab_lbl_utime' ),      value = uptime },
        { name = ln( 'ab_lbl_dev_reg' ),    value = helper:bool2str( cfg.dev.regeneration, 'enabled', 'disabled' ) },
        { name = ln( 'ab_lbl_dev_debug' ),  value = helper:bool2str( cvar:GetBool( 'arivia_sa_debug' ), 'enabled', 'disabled' ) },
    }

    /*
    *   manifest > data > loop
    */

    local i = 0
    for k, v in helper.get.table( mf_data ) do

        /*
        *   manifest > parent
        */

        local mf_pnl                = ui.new( 'pnl', self.ct_mf_lst, 1      )
        :top                        ( 'm', 0                                )
        :tall                       ( 30                                    )

                                    :draw( function( s, w, h )
                                        design.line( 0, h - 1, w, h - 1, Color( 255, 255, 255, 3 ) )
                                    end )

        /*
        *   manifest > left
        */

        local lbl_l                 = ui.new( 'lbl', mf_pnl                 )
        :left                       ( 'm', 5, 0, 0, 0                       )
        :wide                       ( 120                                   )
        :txt                        ( v.name, Color( 31, 133, 222, 255 ), pref( 'ab_mf_item_name' ), true, 4 )

        /*
        *   manifest > right
        */

        local lbl_r                 = ui.new( 'lbl', mf_pnl                 )
        :fill                       ( 'm', 0, 0, 5, 0                       )
        :txt                        ( v.value, self.cf_u.main.clrs.dt_txt, pref( 'ab_mf_item_val' ), true, 6 )

        /*
        *   manifest > data > count
        */

        i = i + 1

    end

    /*
    *   manifest > parent : adjust height
    */

    self.ct_mf_lst:SetTall         ( ( i * 30 ) + 20                       )

    /*
    *   docs > spacer
    */

    self.ct_docs_spcr               = ui.new( 'pnl', self.ct_r_i, 1         )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 15                                    )

    /*
    *   docs > header
    */

    self.ct_docs_header             = ui.new( 'pnl', self.ct_r_i, 1         )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'g_sect_ico' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( ln( 'ab_sec_docs_name' ), pref( 'ab_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   docs > sep
    */

    self.ct_docs_sep                = ui.new( 'pnl', self.ct_r_i, 1         )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   load buttons
    */

    for k, v in pairs( self.docbtns ) do

        if not v.enabled then continue end

        local name                  = v.name or 'error'

        self.b_docs                 = ui.new( 'btn', self.ct_r_i            )
        :bsetup                     (                                       )
        :top                        ( 'm', 0, 0, 0, 1                       )
        :tall                       ( 32                                    )
        :notext                     (                                       )

                                    :oc( function( s )
                                        gui.OpenURL( v.url or '' )
                                    end )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.clr_web_btn_box )
                                        design.box( 0, 0, w, h / 2, Color( 255, 255, 255, 2 ) )

                                        if s.hover then
                                            design.box( 0, 0, w, h, Color( 0, 0, 0, 75 ) )
                                        end

                                        draw.SimpleText( name, pref( 'ab_web_btn' ), w / 2, h / 2, self.clr_web_btn_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )
    end

    /*
    *   display notice
    */

    self.dt_notice                  = ui.new( 'lbl', self.ct_r_i            )
    :bottom                         ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 18                                    )
    :text                           ( ln( 'ab_lbl_vis_sadmin' )             )
    :font                           ( pref( 'ab_dt_notice' )                )
    :textclr                        ( Color( 255, 255, 255, 100 )           )
    :align                          ( 5                                     )

    /*
    *   docs > sep
    */

    self.ct_notice_sep              = ui.new( 'pnl', self.ct_r_i, 1         )
    :bottom                         ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

end

/*
*   GetWebsites
*
*   populate workshops
*/

function PANEL:GetWebsites( )

    self.docbtns =
    {
        {
            enabled         = true,
            name            = ln( 'ab_docs_btn_main_name' ),
            url             = ln( 'ab_docs_btn_main_url' ),
        },
        {
            enabled         = true,
            name            = ln( 'ab_docs_btn_fsum_name' ),
            url             = ln( 'ab_docs_btn_fsum_url' ),
        },
        {
            enabled         = true,
            name            = ln( 'ab_docs_btn_ws_name' ),
            url             = ln( 'ab_docs_btn_ws_url', storage:Get( mod, 'workshop' ) or '' ),
        },
    }

end

/*
*   HoverFill
*
*   animation to make buttons appear as if they are being filled
*   with color when player hovers over
*
*   @param  : pnl s
*   @param  : int w
*   @param  : int h
*   @param  : clr clr
*/

function PANEL:HoverFill( s, w, h, clr )
    if cfg.dev.bDisableAnim then
        design.box( 0, 0, w, h, clr )
        return
    end

    local x, y, fw, fh = 0, 0, math.Round( w * s.OnHoverFill ), h
    design.box( x, y, fw, fh, clr )
end

/*
*   GetLabel
*
*   @return : str
*/

function PANEL:GetLabel( )
    return isstring( self.label ) and self.label or ln( 'ab_sec_main_name' )
end

/*
*   SetLabel
*
*   @param  : str str
*/

function PANEL:SetLabel( str )
    self.label = str
end

/*
*   GetTextTitleColor
*
*   @return : str
*/

function PANEL:GetTextTitleColor( )
    return self.clr_name_txt or self.clr_txt_sec
end

/*
*   SetTextTitleColor
*
*   @param  : clr clr
*/

function PANEL:SetTextTitleColor( clr )
    self.clr_name_txt = clr
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h ) end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *	declare > main configs
    */

    self.cf_u                       = cfg.ui

    /*
    *   declare > colors
    */

    self.clr_txt_acc                = self.cf_u.main.clrs.dt_txt
    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_ico_sec                = self.cf_u.main.clrs.ico_section
    self.clr_txt_sec                = self.cf_u.main.clrs.txt_section
    self.clr_ico_acc                = self.cf_u.main.clrs.ico_accent
    self.clr_web_btn_txt            = Color( 255, 255, 255, 255 )
    self.clr_web_btn_box            = Color( 184, 23, 72, 255 )

    /*
    *   declare > general
    */

    self.owner_id                   = mod.owner or ln( 'ab_unregistered' )

    /*
    *   get website buttons
    */

    self:GetWebsites( )
end

/*
*   register
*/

ui:create( mod, 'pnl_about', PANEL, 'pnl' )