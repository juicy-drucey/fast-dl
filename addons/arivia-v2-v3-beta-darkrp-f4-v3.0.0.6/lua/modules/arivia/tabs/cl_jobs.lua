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
*	localized mat func
*/

local function mat( id )
    return mats:call( mod, id )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return base.get:pref( str, state )
end

/*
*	localized > lib
*/

local level                 = mod.plugins.level
local prestige              = mod.plugins.prestige
local handle                = mod.handle

/*
*	declare > fonts
*/

local fo_sel_name           = pref( 'sel_name' )
local fo_sel_sub            = pref( 'sel_sub' )
local fo_sel_skin           = pref( 'sel_skins_i' )
local fo_sel_arrow          = pref( 'sel_arrow' )
local fo_sel_btn_utf8       = pref( 'sel_btn_act_ico' )
local fo_sel_btn_action     = pref( 'sel_btn_act_txt' )

/*
*	panel
*/

local PANEL = { }

/*
*	Init
*/

function PANEL:Init( )

    /*
    *	validate pl
    */

    if not helper.ok.ply( LocalPlayer( ) ) then return end
    local pl = LocalPlayer( )

    /*
    *	parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :nodraw                         (                                       )
    :fill                           ( 'm', 0                                )

    /*
    *	scroll
    */

    self.scr                        = ui.new( 'rlib.elm.sp.v2', self        )
    :fill                           ( 'm', 5                                )
    :param                          ( 'SetSBMLeft', 7                       )
    :param                          ( 'SetbElastic', true                   )
    :param                          ( 'SetAlwaysVisible', true              )
    :paramv                         ( 'SetVMargin', 0, 0, 5, 0              )

    /*
    *	sel > parent
    */

    self.sel                        = ui.new( 'pnl', self                   )
    :right                          ( 'm', 0                                )
    :wide                           ( self.cf_sz_w - 10                     )

                                    :draw( function( s, w, h )
                                        design.rbox( 0, 0, 0, w, h, cfg.ui.right.clrs.panel )

                                        if self.cf_i.misc.sel.gradient.bEnabled then
                                            local grad_clr      = self.cf_i.misc.sel.gradient.bUseJobColor and self.job.color or self.cf_i.misc.sel.gradient.overrideColor
                                            local grad_a        = self.cf_i.misc.sel.gradient.bUseJobColor and self.cf_i.misc.sel.gradient.jobColorAlpha or self.cf_i.misc.sel.gradient.overrideColor.a

                                            design.imat( 0, 0, w, 200, self.gra_mat_d, ColorAlpha( grad_clr, grad_a ) )
                                            if self.cf_g.sel.bBlur then
                                                design.blur_trim( s, 4 )
                                            end
                                        end

                                        design.box( 0, 0, 1, h, self.clr_sep )
                                    end )

    /*
    *	sel > name
    */

    self.sel.name                   = ui.new( 'lbl', self.sel               )
    :top                            ( 'm', 0                                )
    :notext                         (                                       )
    :font                           ( fo_sel_name                           )
    :align                          ( 5                                     )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        if not self.job then return end
                                        draw.SimpleText( helper.str:truncate( self.job.name, 26 ), fo_sel_name, w / 2, 20, self.cf_u.main.clrs.dt_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > salary
    */

    self.sel.sal                    = ui.new( 'pnl', self.sel               )
    :top                            ( 'm', 0, 0, 0, 5                       )
    :align                          ( 5                                     )
    :tall                           ( 20                                    )

                                    :draw( function( s, w, h )
                                        local sz_sal_w, sz_salary_h         = helper.str:len( self.job.pay, fo_sel_sub )
                                        sz_sal_w                            = sz_sal_w + 20
                                        s:SetTall                           ( sz_salary_h )

                                        design.rbox( 5, ( w / 2 ) - ( sz_sal_w / 2 ), 0, sz_sal_w, h, self.cf_u.main.clrs.box_accent )
                                        draw.SimpleText( self.job.pay, fo_sel_sub, w / 2, h / 2, self.cf_u.main.clrs.dt_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > model > defaults
    */

    local m_sel_src                 = istable( self.job.model ) and self.job.model[ 1 ] or self.job.model
    local m_sel_fov                 = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].fov ) or 30
    local m_sel_cam                 = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].cam ) or Vector( 187, 7, 60 )
    local m_sel_look                = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].look ) or Vector( 0, 0, 58 )

    local m_sel_sz                  = ui:SmartScaleH( true, cfg.ui.right.sizes.mdl_h )
    local m_sel_w                   = self.sel:GetWide( ) / 2
    local m_sel_h                   = self:GetTall( ) + m_sel_sz

    /*
    *	sel > model > ct
    */

    self.sel.mdl                    = ui.new( 'mdl', self.sel               )
    :top                            ( 'm', 0                                )
    :size                           ( m_sel_w, m_sel_h                      )
    :fov                            ( m_sel_fov                             )
    :cam                            ( m_sel_cam                             )
    :look                           ( m_sel_look                            )
    :norotate                       (                                       )
    :light                          (                                       )
    :mdl                            ( m_sel_src                             )
    :savedraw                       (                                       )

                                    :draw( function( s, w, h )
                                        s.OldPaint( s, w, h )
                                        if self.sel.skins < 2 then return end

                                        design.box( 0, 0, w, 24, self.cf_g.sel.clrs.box_skin_p )
                                        draw.SimpleText( ln( 'sel_skins_i', self.job.key, self.sel.skins ), fo_sel_skin, w / 2, 12, self.cf_g.sel.clrs.txt_skin_i, 1, 1)
                                    end )

    /*
    *	sel > model viewer
    */

    self.sel.btn                    = ui.new( 'btn', self.sel.mdl           )
    :bsetup                         (                                       )
    :fill                           ( 'm', 0                                )
    :tip                            ( ln( 'sel_tip_mview_preview' )         )

                                    :oc( function( s )
                                        if ui:registered( '$pnl_mdlv', mod ) then
                                            ui:dispatch( '$pnl_mdlv', mod )
                                            return
                                        end

                                        local pnl_mdlv          = ui.rlib( mod, 'pnl_mviewer'       )
                                        :param                  ( 'SetMDL', istable( self.job.model ) and self.job.model[ 1 ] or self.job.model )
                                        :param                  ( 'SetIsPly', 1                     )
                                        :register               ( '$pnl_mdlv', mod                  )
                                    end )

    /*
    *	sel > btn > edit tip
    */

    self.sel.b_tip_edit             = ui.new( 'btn', self.sel.mdl           )
    :bsetup                         (                                       )
    :sz                             ( 28                                    )
    :pos                            ( 10, self.sel.mdl:GetTall( ) - 28 - 10 )
    :tip                            ( ln( 'sel_tip_edit_mdl' )              )

                                    :oc( function( s )
                                        local id_file   = ln( 'sel_tip_edit_file' )
                                        local data      = { Color( 255, 255, 255, 255 ), ln( 'sel_tip_edit_text' ), Color( 31, 133, 222, 255 ), id_file }

                                        design:rbubble( data, 10 )
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, self.cf_g.sel.clrs.indic_box )

                                        local a	        = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                        a		        = math.Clamp( a, s.hover and 100 or 255, 255 )
                                        local clr_ico   = self.cf_g.sel.clrs.indic_ico_edit

                                        draw.SimpleText( '', pref( 'g_ico_hint' ), w / 2, h / 2 + 1, Color( clr_ico.r, clr_ico.g, clr_ico.b, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > btn > skin > prev
    */

    self.sel.b_skin_prev            = ui.new( 'btn', self.sel               )
    :bsetup                         (                                       )
    :size                           ( 20                                    )
    :pos                            ( 10, 10                                )
    :notext                         (                                       )
    :hide                           (                                       )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )

                                    :draw( function( s, w, h )
                                        local clr_text  = ( s.hover and self.cf_g.sel.clrs.btn_skin_h ) or self.cf_g.sel.clrs.btn_skin_n
                                        clr_text        = ( self.job.key <= 1 and self.cf_g.sel.clrs.btn_skin_u ) or clr_text

                                        draw.SimpleText( helper.get:utf8( 'arrow_l' ), fo_sel_arrow, w / 2, h / 2, clr_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        self.job.key = self.job.key - 1
                                        if self.job.key < 1 then self.job.key = 1 end

                                        self.sel.mdl:SetModel( self.job.model[ self.job.key ] )
                                        self.sel.mdl:InvalidateLayout( )

                                        if self.job.key == 1 then
                                            ui:hide( s )
                                        end
                                    end )

    /*
    *	sel > btn > skin > next
    */

    self.sel.b_skin_next            = ui.new( 'btn', self.sel               )
    :bsetup                         (                                       )
    :size                           ( 20                                    )
    :pos                            ( self.sel:GetWide( ) - 30, 10          )
    :notext                         (                                       )
    :hide                           (                                       )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )

                                    :draw( function( s, w, h )
                                        local clr_text      = ( s.hover and self.cf_g.sel.clrs.btn_skin_h ) or self.cf_g.sel.clrs.btn_skin_n
                                        clr_text            = ( self.job.key == self.sel.skins and self.cf_g.sel.clrs.btn_skin_u ) or clr_text

                                        draw.SimpleText( helper.get:utf8( 'arrow_r' ), fo_sel_arrow, w / 2, h / 2, clr_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        if self.job.key == #self.job.model then return end
                                        self.sel.skins      = istable( self.job.model ) and table.Count( self.job.model ) or 0
                                        self.job.key        = self.job.key + 1

                                        self.sel.mdl:SetModel( self.job.model[ self.job.key ] )
                                        self.sel.mdl:InvalidateLayout( )

                                        ui:show( s )

                                        if self.job.key > 1 then
                                            ui:show( self.sel.b_skin_prev )
                                        end
                                    end )

    /*
    *	sel > mdlv > indicator
    */

    self.sel.indic                  = ui.new( 'pnl', self.sel.mdl, 1        )
    :bottom                         ( 'm', 9, 0, 0, 7                       )
    :tall                           ( 28                                    )

    /*
    *	sel > tabs > ct
    */

    self.sel.ct                     = ui.new( 'pnl', self.sel, 1            )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 35                                    )

    /*
    *	sel > footer
    */

    self.sel.ftr                    = ui.new( 'pnl', self.sel, 1            )
    :bottom                         ( 'm', 0                                )
    :tall                           ( 45                                    )

    /*
    *	sel > notice > pnl > admin override
    */

    self.sel.no_pnl_admor           = ui.new( 'pnl', self.sel               )
    :bottom                         ( 'm', 0, 0, 0, 1                       )
    :tall                           ( 28                                    )
    :hide                           (                                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_g.sel.clrs.amsg.admin_ovr_box )
                                    end )

    /*
    *	sel > notice > lbl > admin override
    */

    self.sel.no_lbl_admor           = ui.new( 'lbl', self.sel.no_pnl_admor, 1 )
    :fill                           ( 'm', 0                                )
    :text                           ( ln( 'sel_notice_admin_or' )           )
    :tall                           ( 28                                    )
    :font                           ( pref( 'sel_notice' )                  )
    :align                          ( 5                                     )
    :alignright                     ( 0                                     )
    :clr                            ( self.cf_g.sel.clrs.amsg.admin_ovr_txt )

    /*
    *	sel > notice > pnl > admin only
    */

    self.sel.no_pnl_admonly         = ui.new( 'pnl', self.sel               )
    :bottom                         ( 'm', 0, 0, 0, 1                       )
    :tall                           ( 28                                    )
    :hide                           (                                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_g.sel.clrs.amsg.admin_only_box )
                                    end )

    /*
    *	sel > notice > lbl > admin only
    */

    self.sel.no_lbl_admonly         = ui.new( 'lbl', self.sel.no_pnl_admonly, 1 )
    :fill                           ( 'm', 0                                )
    :text                           ( ln( 'sel_notice_admin_only' )         )
    :tall                           ( 28                                    )
    :font                           ( pref( 'sel_notice' )                  )
    :align                          ( 5                                     )
    :alignright                     ( 0                                     )
    :clr                            ( self.cf_g.sel.clrs.amsg.admin_only_txt )

    /*
    *	sel > notice > pnl > custom
    */

    self.sel.no_pnl_cus             = ui.new( 'pnl', self.sel               )
    :bottom                         ( 'm', 0, 0, 0, 1                       )
    :tall                           ( 28                                    )
    :hide                           (                                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.job.err_clr or self.cf_g.sel.clrs.amsg.cus_box )
                                    end )

    /*
    *	sel > notice > lbl > custom
    */

    self.sel.no_lbl_cus             = ui.new( 'lbl', self.sel.no_pnl_cus, 1 )
    :fill                           ( 'm', 0                                )
    :text                           ( ''                                    )
    :tall                           ( 28                                    )
    :font                           ( pref( 'sel_notice' )                  )
    :align                          ( 5                                     )
    :clr                            ( self.cf_g.sel.clrs.amsg.cus_txt       )
    :alignright                     ( 0                                     )

    /*
    *	sel > btn > buy
    */

    self.sel.b_buy                  = ui.new( 'btn', self.sel.ftr           )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :fill                           ( 'm', 2, 0, 0, 1                       )
    :tip                            ( ln( 'sel_btn_job_start_tip' )         )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )
    :tall                           ( 30                                    )

                                    :pl( function( s )
                                        s.Text = self.job.vote and self.l_sel_btn_vote:upper( ) or self.l_sel_btn_start:upper( )
                                        s.DoClick = function( )
                                            DarkRP.setPreferredJobModel( self.job.team, self.sel.mdl:GetModel( ) )
                                            self:GetAction( self.job )
                                            DarkRP.closeF4Menu( )
                                        end

                                        if not mod.jobs:bCanSwitch( self.job, true ) then
                                            s.DoClick = function( )
                                                if cvar:GetInt( 'arivia_popup_enabled', 0 ) == 1 and self.job.err then
                                                    local reason = self.job.err or nil
                                                    design:bubble( reason, 5 )
                                                end
                                            end
                                        end
                                    end )

                                    :draw( function( s, w, h )
                                        local clr_btn       = self.job.vote and self.cf_g.sel.clrs.btn_act_vote or self.cf_g.sel.clrs.btn_act_allowed
                                        local ico_btn       = self.job.vote and self.cf_g.sel.ico_vote or self.cf_g.sel.ico_job

                                        /*
                                        *	check > job unavailable
                                        */

                                        if not mod.jobs:bCanSwitch( self.job ) then
                                            clr_btn         = self.cf_g.sel.clrs.btn_act_unavail
                                            ico_btn         = self.cf_g.sel.ico_unavail
                                            self.status     = ( not ( pl:IsAdmin( ) or pl:IsSuperAdmin( ) ) and self.job.admin == 1 ) and ln( 'sel_notice_admin_only' ) .. ' - ' .. ln( 'sel_notice_admin_only' ) or ln( 'sel_btn_job_restricted_txt' )
                                            self.utf8       = 9938
                                        end

                                        design.box( 0, 0, w, h, clr_btn )
                                        design.box( 0, 0, w, h / 2, self.cf_g.sel.clrs.btn_act_s )

                                        if s.hover then
                                            design.box( 0, 0, w, h, self.cf_g.sel.clrs.btn_act_h )
                                        end

                                        local sz_btext_w = helper.str:len( self.status, fo_sel_btn_action )

                                        if self.cf_g.sel.bShowIcon then
                                            draw.SimpleText( ico_btn, fo_sel_btn_utf8, w / 2 - ( sz_btext_w / 2 ) - 10, h / 2, self.cf_g.sel.clrs.btn_act_ico, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        end
                                        draw.SimpleText( self.status, fo_sel_btn_action, w / 2 - ( sz_btext_w / 2 ) + 10, h / 2, self.cf_g.sel.clrs.btn_act_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > btn > mviewer
    */

    self.sel.b_mview                = ui.new( 'btn', self.sel.ftr           )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :right                          ( 'm', 0, 0, 0, 0                       )
    :tip                            ( ln( 'sel_tip_mview_preview' )         )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )
    :wide                           ( 45                                    )
    :setupanim                      ( 'OnHoverFill', 7, rlib.i.OnHover      )

                                    :oc( function( s )
                                        if ui:registered( '$pnl_mdlv', mod ) then
                                            ui:dispatch( '$pnl_mdlv', mod )
                                            return
                                        end

                                        local pnl_mdlv          = ui.rlib( mod, 'pnl_mviewer'       )
                                        :param                  ( 'SetMDL', istable( self.job.model ) and self.job.model[ 1 ] or self.job.model )
                                        :param                  ( 'SetIsPly', 1                     )
                                        :register               ( '$pnl_mdlv', mod                  )
                                    end )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_g.sel.clrs.btn_mdl_n )
                                        design.box( 0, 0, w, h / 2, self.cf_g.sel.clrs.btn_mdl_s )
                                        design.box( 0, 0, 1, h, self.clr_sep )

                                        if s.hover then
                                            self:HoverFill( s, w, h, self.cf_g.sel.clrs.btn_mdl_h )
                                        end

                                        design.imat( ( w / 2 ) - ( 24 / 2 ), ( h / 2 ) - ( 24 / 2 ), 24, 24, self.m_prev, self.cf_g.sel.clrs.ico_mdlv_n )
                                    end )

    /*
    *	sel > btn > layout
    */

    self.sel.mdl.PerformLayout = function( s )
        ui:hide( self.sel.b_skin_next )
        ui:hide( self.sel.b_skin_prev )

        self.sel.skins = istable( self.job.model ) and table.Count( self.job.model ) or 0

        if ( istable( self.job.model ) ) and ( #self.job.model ~= 1 ) then
            ui:show( self.sel.b_skin_next )
            ui:show( self.sel.b_skin_prev )
        end
    end

    /*
    *	cats > sort
    */

    local cats = table.Copy( self.srctbl )
    table.sort( cats, function( a, b )
        local aso = a.raw_id or a.sortOrder or 100
        local bso = b.raw_id or b.sortOrder or 100

        return aso < bso or aso == bso and a.name < b.name
    end )

    self:AddSlot( cats )

end

/*
*	AddSlot
*/

function PANEL:AddSlot( cats )

    /*
    *	cats > favorites
    */

    local nObj_f                    = ( self.cf_i.bAllowFavs and #mod.favs.jobs > 0 and self:CreateCat( ln( 'mem_cat_favs' ) ) ) or nil

    /*
    *	cats > loop
    */

    for cat in helper.get.data( cats ) do

        -- if i_cats > 0 then continue end

        /*
        *	cats > count jobs
        */

        local i_jobs                = #cat.members
                                    if not cat.members or i_jobs < 1 then continue end

        /*
        *	cats > cansee
        */

        if ( cat.canSee and not cat.canSee( LocalPlayer( ) ) ) then continue end

        /*
        *	cats > check jobs
        */

        local jobs = cat.members
        table.sort( jobs, function( a, b )
            local aso = a.raw_id or a.sortOrder or 100
            local bso = b.raw_id or b.sortOrder or 100

            return aso < bso or aso == bso and a.name < b.name
        end )


        local i_err = 0
        for v in helper.get.data( jobs ) do
            local bCanJoin, bShow   = mod.jobs:bCanSwitch( v )

            if v.team ~= mod.jobs.current then
                if not bCanJoin and not bShow then
                    i_err = i_err + 1
                end
            else
                if not self.cf_i.bShowCurrJob and #RPExtraTeams > 1 then i_err = i_err + 1 end
            end

            --if self.cf_i.bFavsOnce and table.HasValue( mod.favs.jobs, v.command ) and cat.name:lower( ) == ln( 'mem_cat_favs' ):lower( ) then i_err = i_err + 1 end
        end

        /*
        *	cats > skip loading entire cat if errors greater than jobs in cat
        */

        if i_err >= i_jobs then continue end

        /*
        *	cats > create new
        */

        local cat_data              = { cat.name, cat.tip }
        local nObj_n                = cat.name and self:CreateCat( cat_data ) or self:CreateCat( ln( 'mem_cat_other' ) )

        /*
        *	jobs > loop
        */

        for v in helper.get.data( jobs ) do

            -- if i_mems < 1 then continue end

            /*
            *	members > check > allowjoin
            */

            local   bCanJoin,
                    bShow,
                    err,
                    bCustom         = mod.jobs:bCanSwitch( v )
                                    if not bCanJoin and not bShow then continue end

            /*
            *	jobs > hide current player job
            */

            if v.team == mod.jobs.current then
                if self.cf_i.bShowCurrJob or #RPExtraTeams < 2 then
                    v.bCurrJob          = true
                    self.job.bCurrJob   = true
                else
                    continue
                end
            end

            /*
            *	jobs > categpry > normal
            */

            if ( not self.cf_i.bFavsOnce ) or ( self.cf_i.bFavsOnce and not table.HasValue( mod.favs.jobs, v.command ) ) then
                local b_slot_n      = ( nObj_n and self:CreateSlot( v, nObj_n ) ) or false

                /*
                *	jobs > categpry > normal > object
                */


                nObj_n.list:Add     ( b_slot_n )
                nObj_n:AddSlot      ( b_slot_n )
            end

            /*
            *	jobs > categpry
            *
            *   hide category if cat contains no children slots
            *   this is the only way to do it without looping through the table and losing performance
            */

            local i_slots           = table.Count( nObj_n.list:GetChildren( ) )
                                    if nObj_n and i_slots < 1 then nObj_n:Hide( ) end
                                    if nObj_n and i_slots > 0 then nObj_n:Show( ) end

            /*
            *	favorites
            */

            if not table.HasValue( mod.favs.jobs, v.command ) then continue end

            /*
            *	declare > misc
            */

            local clrs              = self.cf_i.clrs
            local d_clr_box         = ( not bCanJoin and clrs.list.btn_box_u ) or clrs.list.btn_box_n

            /*
            *	jobs > btn > list > layer 1
            */

            local b_slot            = ui.new( 'btn'                         )
            :sz                     ( self.cf_sz_slot_n, 60                 )
            :notext                 (  ''                                   )

                                    :draw( function( s, w, h )
                                        local clr_box       = ( bCustom and clrs.list.btn_box_uc ) or d_clr_box
                                        design.box          ( 0, 0, w, h, clr_box )
                                    end )

                                    :logic( function( s )
                                        local bVisible = not cvar:GetBool( 'arivia_ui_maximized' )
                                        s:SetWide( bVisible and self.cf_sz_slot_n or self.cf_sz_slot_x )

                                        if ui:visible( nObj_f ) then
                                            nObj_f:InvalidateLayout( )
                                            if nObj_f.list then
                                                nObj_f.list:InvalidateChildren( )
                                            end
                                        end

                                        storage:Set( mod, 'bMaximized', not bVisible )
                                    end )

                                    nObj_f.list:Add         ( b_slot )
                                    nObj_f:AddSlot          ( b_slot )

            /*
            *	jobs > btn > list > layer 2
            */

            local slot              = ui.rlib( mod, 'slot', b_slot          )
            :bsetup                 (                                       )
            :param                  ( 'SetJob', v                           )
            :param                  ( 'SetPar', self                        )
            :param                  ( 'SetW', self.cf_sz_slot_n             )
            :fill                   ( 'm', 0                                )
            :notext                 (                                       )
            :savedraw               (                                       )
            :tip                    ( v.tip or nil                          )
            :setupanim              ( 'OnHoverFade', 4, rlib.i.OnHover      )

            /*
            *	jobs > model > container
            */

            local ct_mdl            = ui.new( 'pnl', slot                   )
            :left                   ( 'm', 0                                )
            :wide                   ( self.cf_g.slot.mdl_size               )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_i.clrs.list.btn_mdl_box )
                                        design.box( w - 1, 0, 1, h, self.clr_sep )
                                    end )

            /*
            *	jobs > model
            */

            local pl_mdl            = ui.rlib( mod, 'elm_mdl', ct_mdl       )
            :fill                   ( 'm', 0                                )

                                    pl_mdl:MdlThink( function( s )
                                        if not ui:ok( self ) then return end
                                        if not bCanJoin and self.cf_g.slot.mdl_unavail_bFade then
                                            s:SetAlpha( self.cf_g.slot.mdl_unavail_fade )
                                        else
                                            s:SetAlpha( 255 )
                                        end
                                    end )

            /*
            *	jobs > model > btn ( switch )
            */

            local pl_qjoin          = ui.new( 'btn', pl_mdl                 )
            :bsetup                 (                                       )
            :fill                   ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            design.box( 0, 0, w, h, bCanJoin and self.cf_g.slot.qacts.clrs.bg_switch or self.cf_g.slot.qacts.clrs.bg_locked )

                                            local txt_buy   = ( self.cf_g.slot.qacts.bUseIcons and ( bCanJoin and '' or '' ) ) or ( bCanJoin and ln( 'mem_job_qbuy_switch' ) or ln( 'mem_ent_qbuy_lock' ) )
                                            local fnt_buy   = ( self.cf_g.slot.qacts.bUseIcons and 'slot_item_qbuy_ico' ) or 'slot_item_qbuy_txt'
                                            local clr_buy   = ( self.cf_g.slot.qacts.bUseIcons and ( bCanJoin and self.cf_g.slot.qacts.clrs.ico_buy or self.cf_g.slot.qacts.clrs.ico_lock ) ) or ( bCanJoin and self.cf_g.slot.qacts.clrs.txt_buy or self.cf_g.slot.qacts.clrs.txt_lock )
                                            local pos_buy   = ( self.cf_g.slot.qacts.bUseIcons and h / 2 - self.cf_g.slot.qacts.oset_ico_h ) or ( h / 2 - self.cf_g.slot.qacts.oset_txt_h )

                                            local a         = math.abs( math.sin( CurTime( ) * 4 ) * 255 )
                                            a               = math.Clamp( a, 100, 255 )

                                            draw.DrawText( txt_buy, pref( fnt_buy ), w / 2 - 1, pos_buy, ColorAlpha( clr_buy, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        end
                                    end )

                                    :oc( function( s )
                                        if not bCanJoin then return end
                                        local mdl = istable( v.model ) and v.model[ 1 ] or v.model
                                        DarkRP.setPreferredJobModel( v.team, mdl )
                                        self:GetAction( v )
                                        DarkRP.closeF4Menu( )
                                    end )

            /*
            *	jobs > model > attach
            */

            local mdl_src           = istable( v.model ) and v.model[ 1 ] or v.model
            local mdl_fov           = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].fov ) or false
            local mdl_cam           = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].cam ) or false
            local mdl_look          = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].look ) or false
            local mdl_oset          = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].oset ) or Vector( 0, 0, 0 )

                                    if mdl_cam and mdl_look then
                                        pl_mdl:AttachManual    ( mdl_src, mdl_fov, mdl_cam, mdl_look )
                                    else
                                        pl_mdl:AttachControl   ( mdl_src, mdl_fov, mdl_oset )
                                    end

                                    pl_mdl:SetPaintedOver( )

        end

    end

    /*
    *	cats > setup children
    */

    for v in helper.get.data( self.cats ) do
        v:SetupChildren( )
    end

    /*
    *	populate ( init load )
    */

    self:Populate( self.job )
end

/*
*	CheckJobs
*
*   determines if there are enough jobs to show this tab.
*   hides tab if jobs < 1
*/

function PANEL:CheckJobs( )
    if not RPExtraTeams[ 1 ] or RPExtraTeams[ 1 ] == nil then
        self:Hide( )
        return
    end
end

/*
*	GetDefault
*
*   returns the default job if marked within the jobrelated file with the param
*   >   arivia_default = true
*
*   @return : tbl
*/

function PANEL:GetDefault( )
    local def
    for v in helper.get.data( RPExtraTeams ) do
        if not v.arivia_default then continue end
        def = v
    end

    return def or RPExtraTeams[ 1 ]
end

/*
*	Populate
*
*   @param  : ent v
*/

function PANEL:Populate( v )

    /*
    *	check > object
    */

    if not v then
        if cvar:GetBool( 'arivia_sa_debug' ) then
            base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_jobs' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        end
        return
    end

    /*
    *	declare > pl
    */

    local pl = LocalPlayer( )

    /*
    *	jobs > check
    */

    local   bCanJoin,
            bShow,
            err,
            bCustom                 = mod.jobs:bCanSwitch( v )

    /*
    *	clear notices
    */

    self:ClearNotices( )

    /*
    *	sel > setup
    */

    self.job                        = v
    self.job.key                    = 1
    self.job.pay                    = handle:GetSalary( v, true )
    self.job.err                    = isstring( err ) and err or istable( err ) and err[ 1 ] or nil
    self.job.err_clr                = istable( err ) and err[ 2 ]
    self.job.adminonly              = ( v.admin == 1 or tostring( v.admin ) == 'true' and true ) or false
    self.job.sadminonly             = ( v.superadmin == 1 or tostring( v.superadmin ) == 'true' and true ) or false
    self.job.bCanJoin               = bCanJoin
    self.job.loadout                = v.weapons or { }
    self.job.needJob                = ''
    self.job.needGrp                = ''
    self.status                     = ( self.job.vote and self.l_sel_btn_vote ) or self.l_sel_btn_start
    self.utf8                       = 9865

    /*
    *	sel > update model
    */

    local job_mdl                   = istable( self.job.model ) and self.job.model[ self.job.key ] or self.job.model
    self.sel.mdl:SetModel           ( job_mdl )

    /*
    *	sel > rehash
    */

    ui:rehash( self.sel.mdl     )
    ui:rehash( self.sel.b_buy   )

    /*
    *	sel > set skin
    */

    self.sel.skins                  = istable( self.job.model ) and table.Count( self.job.model ) or 0

    /*
    *	populate > needs group
    *
    *   displays any required groups that a player must be in order to switch
    *   to the next job
    */

    if handle:GetGroups( self.job ) then
        local bHasReq, lst          = handle:GetGroupsReq( self.job )
        if not bHasReq then
            local msg               = ln( 'sel_desc_grps_a', lst )
            self.job.needGrp        = msg
        end
    end

    /*
    *	populate > req job
    *
    *   displays any required jobs that a player must have in order to switch
    *   to the next job
    */

    if handle:GetJobs( self.job ) then
        local bHasReq, lst          = handle:GetJobsReq( self.job )
        if not bHasReq then
            self.job.needJob        = ln( 'sel_desc_jobs_need', lst )
        end
    end

    /*
    *	sel > desc
    */

    self.sel.desc                   = self:GetDesc( self.job )

    /*
    *	btn > tip
    */

    self.sel.b_buy:tip              ( not bCanJoin and ln( 'sel_btn_job_restricted_tip' ) or self.job.vote and ln( 'sel_btn_job_vote_tip' ) or ln( 'sel_btn_job_start_tip' ) )

    /*
    *	check > admin privledges
    *
    *       > admin_override
    *       > superadmin only
    *       > admin only
    */

    if pl:IsSuperAdmin( ) then
        if cfg.dev.admin_override then
            ui:show( self.sel.no_pnl_admor )
        end
        if self.job.sadminonly then
            ui:show( self.sel.no_pnl_admonly )
            self.sel.no_lbl_admonly:SetText( ln( 'sel_notice_sadmin_only' ) )
        elseif self.job.adminonly then
            ui:show( self.sel.no_pnl_admonly )
            self.sel.no_lbl_admonly:SetText( ln( 'sel_notice_admin_only' ) )
        end
    end

    /*
    *	check > test triggers
    */

    self:DebugNotices( )

    /*
    *	populate > err msg
    */

    if self.job.err and not ui:visible( self.sel.no_pnl_cus ) then
        ui:show( self.sel.no_pnl_cus )
        self.sel.no_lbl_cus:SetText( self.job.err )
    end

    /*
    *	make indicators
    */

    self:CreateIndicators( )

    /*
    *	make tabs
    */

    self:CreateTabs( )

end

/*
*	create indicators
*
*   the status indicators that appear toward the bottom of the
*   selection model viewer
*/

function PANEL:CreateIndicators( )

    /*
    *	destroy existing
    */

    ui:destroy( self.sel.b_vote )
    ui:destroy( self.sel.b_tip_edit )

    /*
    *	localized glua
    */

    local abs                       = math.abs
    local sin                       = math.sin
    local clp                       = math.Clamp

    /*
    *	localized colors
    */

    local clr_ico_vote              = self.cf_g.sel.clrs.indic_ico_vote
    local clr_ico_edit              = self.cf_g.sel.clrs.indic_ico_edit
    local clr_bubble                = Color( 31, 133, 222, 255 )

    /*
    *	sel > btn > requires vote
    */

    self.sel.b_vote                 = ui.new( 'btn', self.sel.indic         )
    :bsetup                         (                                       )
    :left                           ( 'm' , 0, 0, 4, 0                      )
    :sz                             ( 31                                    )
    :tip                            ( ln( 'sel_tip_indic_vote' )            )
    :enabled                        ( self.job.vote and true or false       )

                                    :logic( function( s )
                                        if s.disabled then
                                            ui:hide( s )
                                        end
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, self.cf_g.sel.clrs.indic_bor )
                                        design.rbox( 5, 1, 1, w - 2, h - 2, self.cf_g.sel.clrs.indic_box )

                                        local a	        = abs( sin( CurTime( ) * 5 ) * 255 )
                                        a		        = clp( a, s.hover and 100 or 255, 255 )

                                        draw.SimpleText( self.cf_u.right.ico.vote, pref( 'g_ico_hint' ), w / 2, h / 2, ColorAlpha( clr_ico_vote, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > btn > edit tip
    */

    self.sel.b_tip_edit             = ui.new( 'btn', self.sel.indic         )
    :bsetup                         (                                       )
    :left                           ( 'm'                                   )
    :sz                             ( 31                                    )
    :tip                            ( ln( 'sel_tip_edit_mdl' )              )
    :enabled                        ( handle:GetAccessSAdmin( 'arivia_sa_tools' ) and true or false )

                                    :logic( function( s )
                                        if s.disabled then
                                            ui:hide( s )
                                        end
                                    end )

                                    :oc( function( s )
                                        local id_file   = ln( 'sel_tip_edit_file' )
                                        local data      = { Color( 255, 255, 255, 255 ), ln( 'sel_tip_edit_text' ), clr_bubble, id_file }

                                        design:rbubble( data, 10 )
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, self.cf_g.sel.clrs.indic_bor )
                                        design.rbox( 5, 1, 1, w - 2, h - 2, self.cf_g.sel.clrs.indic_box )

                                        local a	        = abs( sin( CurTime( ) * 5 ) * 255 )
                                        a		        = clp( a, s.hover and 100 or 255, 255 )

                                        draw.SimpleText( self.cf_u.right.ico.edit, pref( 'g_ico_hint' ), w / 2, h / 2, ColorAlpha( clr_ico_edit, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

end

/*
*	CreateTabs
*/

function PANEL:CreateTabs( )

    if ui:ok( self.sel.tabs ) then
        ui:destroy( self.sel.tabs.about )
        ui:destroy( self.sel.tabs )
    end

    /*
    *	sel > tabs
    */

    self.sel.tabs                   = ui.new( 'rlib.ui.tab', self.sel.ct    )
    :fill                           ( 'p', 0, 0, 0, 0                       )
    :param                          ( 'SetMargin', 0                        )
    :param                          ( 'SetTabPadding', 20                   )
    :param                          ( 'SetClrMarker', self.cf_u.right.clrs.tab_marker )
    :param                          ( 'SetClrInactive', self.cf_u.right.clrs.tab_txt_inactive )
    :param                          ( 'SetClrActive', self.cf_u.right.clrs.tab_txt_active )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_u.right.clrs.tab_bg )
                                    end )

    /*
    *	sel > tabs > about > content
    */

    self.sel.tabs.about             = ui.new( 'pnl', self.sel, 1            )
    :fill                           ( 'm', 0                                )
    :padding                        ( 0                                     )

    /*
    *	sel > tabs > about > attach
    */

    self.sel.tabs:Attach            ( self.sel.tabs.about, 'm', 1, 0, 1, 0  )
    self.sel.tabs:SetbNoAnim        ( cfg.dev.bDisableAnim                  )
    self.sel.tabs:CreateTab         ( ln( 'sel_tab_name_about' ), 'rlib.ui.tab.data' )
    self.sel.tabs:SetActive         ( ln( 'sel_tab_name_about' )            )

    /*
    *	sel > tab > about
    */

    local tab_about_id              = ln( 'sel_tab_name_about'              )
    local tab_about                 = self.sel.tabs:GetTab( tab_about_id    )
    tab_about:Clear                 (                                       )
    tab_about:SetData               ( self.sel.desc, 'entry', self.cf_u.main.clrs.dt_txt )
    tab_about:SetAlwaysVisible      ( true                                  )

    /*
    *	sel > tab > loadout
    */

    if self.cf_i.bLoadouts then
        local tab_lo_id             = ln( 'sel_tab_name_loadout'            )
        local pnl_loadout           = ui:getpnl( 'elm_sel_tab_loadout', mod )
        self.sel.tabs:CreateTab     ( tab_lo_id, pnl_loadout                )

        local tab_lo                = self.sel.tabs:GetTab( tab_lo_id       )
        if tab_lo then
            tab_lo:SetLoadout       ( self.job.loadout, true                )
        end
    end

    /*
    *	sel > tab > admin
    */

    if access:strict( LocalPlayer( ), 'arivia_forceteams', mod ) then
        local tab_adm_id            = ln( 'sel_tab_name_admin'              )
        local pnl_adm               = ui:getpnl( 'elm_sel_tab_adm_jobs', mod )
        self.sel.tabs:CreateTab     ( tab_adm_id, pnl_adm                   )


        local tab_adm               = self.sel.tabs:GetTab( tab_adm_id      )
        if tab_adm then
            tab_adm:SetJob          ( self.job                              )
        end
    else
        local tab_adm_id            = ln( 'sel_tab_name_admin'              )
        self.sel.tabs:DispatchTab   ( tab_adm_id                            )
    end

    /*
    *	sel > tab > dev
    */

    if self.cf_i.bDev and handle:GetAccessSAdmin( 'arivia_sa_tools' ) then
        local tab_dev_id            = ln( 'sel_tab_name_dev'                )
        local pnl_dev               = ui:getpnl( 'elm_sel_tab_dev_jobs', mod )
        self.sel.tabs:CreateTab     ( tab_dev_id, pnl_dev                   )


        local tab_dev               = self.sel.tabs:GetTab( tab_dev_id      )
        if tab_dev then
            tab_dev:SetType         ( self.job, true                        )
        end
    else
        local tab_dev_id            = ln( 'sel_tab_name_dev'                )
        self.sel.tabs:DispatchTab   ( tab_dev_id                            )
    end

end

/*
*	pnl > create category
*
*   @param  : tbl, str data
*   @param  : bool bExpanded
*   @return : pnl
*/

function PANEL:CreateCat( data, bExpanded )

    /*
    *	calc top padding
    *
    *   first category should be at the very top
    *   with padding added to the ones under
    */

    local i_top                     = self.cats_i == 0 and 0 or 15

    /*
    *	categories > define
    */

    local clr_h_box                 = self.cf_i.clrs.list.cat_header_box
    local clr_h_txt                 = self.cf_i.clrs.list.cat_header_txt
    local clr_cat                   = self.cf_i.clrs.list.cat_header_gra
    local clr_fav                   = self.cf_i.clrs.list.cat_header_fav
    local clr_body                  = self.cf_i.clrs.list.cat_body_box

    /*
    *	categories > define
    */

    local name                      = istable( data ) and data[ 1 ] or isstring( data ) and data
    local tip                       = istable( data ) and data[ 2 ] or nil

    /*
    *	categories > loop and match names
    */

    for v in helper.get.data( self.cats ) do
        if v.Title == name then return v end
    end

    /*
    *	fetch jobs
    *
    *   determine if categories are marked to be expanded or closed
    *   with startExpanded param
    */

    for v in helper.get.data( self.srctbl ) do
        if name:lower( ) == v.name:lower( ) then
            bExpanded   = v.startExpanded and 1 or 0
            clr_cat     = self.cf_i.clrs.bCatColors and v.color or clr_cat
        end
    end

    if ( self.cf_i.favorites.bStartExpanded ) and ( helper.str:clean( name ) == helper.str:clean( ln( 'mem_cat_favs' ) ) ) then
        bExpanded = 1
    end

    /*
    *	category > container
    */

    local cat                       = ui.rlib( mod, 'category', self.scr    )
    :top                            ( 'm', 0, i_top, 0, 0                   )
    :param                          ( 'HeaderTitle', name                   )
    :param                          ( 'SetExpanded', bExpanded              )
    :param                          ( 'SetHeaderBox', clr_h_box             )
    :param                          ( 'SetHeaderTxt', clr_h_txt             )
    :param                          ( 'SetHeaderGra', clr_cat               )
    :param                          ( 'SetHeaderFav', clr_fav               )
    :param                          ( 'SetBodyColor', clr_body              )
    :param                          ( 'SetTip', tip                         )
    :param                          ( 'SetTipCat', 'jobs'                   )

                                    table.insert( self.cats, cat            )

                                    if self.cats_i ~= 0 then
                                        cat:SetTipCat( nil )
                                    end

    /*
    *	category > iconlayout
    */

    cat.list                        = ui.new( 'dico', cat, 1                )
    :left                           ( 'm', 3, 0, 0, 0                       )
    :lodir                          ( TOP                                   )
    :wide                           ( self.cf_sz_cat                        )
    :spacing                        ( 3, 3                                  )

    /*
    *	count pos
    */

    self.cats_i                     = self.cats_i + 1

    /*
    *	return
    */

    return cat
end

/*
*	CreateSlot
*
*   @param  : tbl v
*   @param  : tbl object
*
*   @return : pnl
*/

function PANEL:CreateSlot( v, object )

    /*
    *	validate data
    */

    if not v or not object then return end

    /*
    *	members > check > allowjoin
    */

    local   bCanJoin,
            bShow,
            err,
            bCustom                 = mod.jobs:bCanSwitch( v )

    /*
    *	declare > misc
    */

    local clrs                      = self.cf_i.clrs
    local d_clr_box                 = ( not bCanJoin and clrs.list.btn_box_u ) or clrs.list.btn_box_n

    /*
    *	jobs > btn > list > layer 1
    */

    local b_slot                    = ui.new( 'btn'                         )
    :bsetup                         (                                       )
    :sz                             ( self.cf_sz_slot_n, 60                 )
    :notext                         (                                       )

                                    :draw( function( s, w, h )
                                        local clr_box       = ( bCustom and clrs.list.btn_box_uc ) or d_clr_box
                                        design.box          ( 0, 0, w, h, clr_box )
                                    end )

                                    :logic( function( s )
                                        local bVisible = not cvar:GetBool( 'arivia_ui_maximized' )
                                        s:SetWide( bVisible and self.cf_sz_slot_n or self.cf_sz_slot_x )

                                        if ui:visible( object ) then
                                            object:InvalidateLayout( )
                                            if object.list then
                                                object.list:InvalidateChildren( )
                                            end
                                        end

                                        storage:Set( mod, 'bMaximized', not bVisible )
                                    end )

    /*
    *	jobs > btn > list > layer 2
    */

    local slot                      = ui.rlib( mod, 'slot', b_slot          )
    :bsetup                         (                                       )
    :param                          ( 'SetJob', v                           )
    :param                          ( 'SetPar', self                        )
    :param                          ( 'SetW', self.cf_sz_slot_n             )
    :fill                           ( 'm', 0                                )
    :notext                         (                                       )
    :savedraw                       (                                       )
    :tip                            ( v.tip or nil                          )
    :setupanim                      ( 'OnHoverFade', 4, rlib.i.OnHover      )

    /*
    *	jobs > model > container
    */

    local ct_mdl                    = ui.new( 'btn', slot                   )
    :bsetup                         (                                       )
    :left                           ( 'm'                                   )
    :wide                           ( self.cf_g.slot.mdl_size               )
    :notext                         (                                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_i.clrs.list.btn_mdl_box )
                                        design.box( w - 1, 0, 1, h, self.clr_sep )
                                    end )

    /*
    *	jobs > model
    */

    local pl_mdl                    = ui.rlib( mod, 'elm_mdl', ct_mdl       )
    :fill                           ( 'm', 0                                )

                                    pl_mdl:MdlThink( function( s )
                                        if not ui:ok( self ) then return end
                                        if not bCanJoin and self.cf_g.slot.mdl_unavail_bFade then
                                            s:SetAlpha( self.cf_g.slot.mdl_unavail_fade )
                                        else
                                            s:SetAlpha( 255 )
                                        end
                                    end )

    /*
    *	jobs > model > btn ( switch )
    */

    local pl_qjoin                  = ui.new( 'btn', pl_mdl                 )
    :bsetup                         (                                       )
    :fill                           ( FILL                                  )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            design.box( 0, 0, w, h, bCanJoin and self.cf_g.slot.qacts.clrs.bg_switch or self.cf_g.slot.qacts.clrs.bg_locked )

                                            local txt_buy   = ( self.cf_g.slot.qacts.bUseIcons and ( bCanJoin and '' or '' ) ) or ( bCanJoin and ln( 'mem_job_qbuy_switch' ) or ln( 'mem_ent_qbuy_lock' ) )
                                            local fnt_buy   = ( self.cf_g.slot.qacts.bUseIcons and 'slot_item_qbuy_ico' ) or 'slot_item_qbuy_txt'
                                            local clr_buy   = ( self.cf_g.slot.qacts.bUseIcons and ( bCanJoin and self.cf_g.slot.qacts.clrs.ico_buy or self.cf_g.slot.qacts.clrs.ico_lock ) ) or ( bCanJoin and self.cf_g.slot.qacts.clrs.txt_buy or self.cf_g.slot.qacts.clrs.txt_lock )
                                            local pos_buy   = ( self.cf_g.slot.qacts.bUseIcons and h / 2 - self.cf_g.slot.qacts.oset_ico_h ) or ( h / 2 - self.cf_g.slot.qacts.oset_txt_h )

                                            local a         = math.abs( math.sin( CurTime( ) * 4 ) * 255 )
                                            a               = math.Clamp( a, 100, 255 )

                                            draw.DrawText( txt_buy, pref( fnt_buy ), w / 2 - 1, pos_buy, Color( clr_buy.r, clr_buy.g, clr_buy.b, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        end
                                    end )

                                    :oc( function( s )
                                        if not bCanJoin then return end
                                        local mdl = istable( v.model ) and v.model[ 1 ] or v.model
                                        DarkRP.setPreferredJobModel( v.team, mdl )
                                        self:GetAction( v )
                                        DarkRP.closeF4Menu( )
                                    end )

    /*
    *	jobs > model > attach
    */

    local mdl_src                   = istable( v.model ) and v.model[ 1 ] or v.model
    local mdl_fov                   = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].fov ) or false
    local mdl_cam                   = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].cam ) or false
    local mdl_look                  = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].look ) or false
    local mdl_oset                  = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].oset ) or Vector( 0, 0, 0 )

                                    if mdl_cam and mdl_look then
                                        pl_mdl:AttachManual    ( mdl_src, mdl_fov, mdl_cam, mdl_look )
                                    else
                                        pl_mdl:AttachControl   ( mdl_src, mdl_fov, mdl_oset )
                                    end

                                    pl_mdl:SetPaintedOver( )

    /*
    *	return slot data
    */

    return b_slot

end

/*
*	CreateFav
*
*   @param  : tbl v
*   @param  : tbl object
*
*   @return : pnl
*/

function PANEL:CreateFav( v, object )

    /*
    *	validate data
    */

    if not v or not object then return end

    /*
    *	members > check > allowjoin
    */

    local   bCanJoin,
            bShow,
            err,
            bCustom                 = mod.jobs:bCanSwitch( v )

    /*
    *	declare > misc
    */

    local clrs                      = self.cf_i.clrs
    local d_clr_box                 = ( not bCanJoin and clrs.list.btn_box_u ) or clrs.list.btn_box_n

    /*
    *	jobs > btn > list > layer 1
    */

    local b_slot                    = vgui.Create( 'DButton'                )
    b_slot:SetSize                  ( self.cf_sz_slot_n, 60                 )
    b_slot:SetText                  (  ''                                   )

                                    b_slot.Paint = function( s, w, h )
                                        local clr_box       = ( bCustom and clrs.list.btn_box_uc ) or d_clr_box
                                        design.box          ( 0, 0, w, h, clr_box )
                                    end

    /*
    *	return slot data
    */

    return b_slot

end

/*
*	GetFavorite
*
*   @param  : tbl v
*   @return : bool
*/

function PANEL:GetFavorite( v )
    local cmd   = v.command or v.cmd
                if not cmd then return end

    return ( istable( mod.favs.jobs ) and table.HasValue( mod.favs.jobs, cmd ) ) or false
end

/*
*	GetFavorites
*
*   @return : tbk
*/

function PANEL:GetFavorites( )
    return istable( mod.favs.jobs ) and mod.favs.jobs or { }
end

/*
*	GetDesc
*
*   formats and returns description.
*   also attaches additional info on to the end of desc
*
*   @param  : tbl item
*/

function PANEL:GetDesc( item )
    local desc                      = handle:GetDescription( item )

    local bEmpty                    = helper.str:isempty( desc )
    desc                            = ( not bEmpty and desc ) or ''

    if item.needGrp then
        desc                        = desc .. item.needGrp .. '\n\n'
    end

    if item.needJob then
        desc                        = desc .. item.needJob .. '\n\n'
    end

    self.sel.desc                   = desc

    return self.sel.desc
end

/*
*	GetAction
*
*   action executed when player clicks 'become job' button
*
*   @param  : tbl item
*/

function PANEL:GetAction( item )
    if not item then return end
    rcc.run.gmod( 'darkrp', ( item.vote and 'vote' or '' ) .. item.command )
end

/*
*   animation > HoverFill
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
*   animation > HoverFade
*
*   animation for fading effect
*
*   @param  : pnl s
*   @param  : int w
*   @param  : int h
*   @param  : clr clr
*/

function PANEL:HoverFade( s, w, h, clr )
    if cfg.dev.bDisableAnim then
        design.box( 0, 0, w, h, clr )
        return
    end

    local da = ColorAlpha( clr, clr.a * s.OnHoverFade )
    design.box( 0, 0, w, h, da )
end

/*
*   SetState
*
*   sets interface state
*/

function PANEL:SetState( )
    local bStateMax         = cvar:GetBool( 'arivia_ui_maximized' ) and true or false

    timex.simple( 0.1, function( )
        if bStateMax then
            ui:unstage      ( '$pnl_left',   mod )
            ui:stage        ( '$btn_toggle', mod )
        else
            ui:stage        ( '$pnl_left',   mod )
            ui:unstage      ( '$btn_toggle', mod )
        end
    end )
end

/*
*	clear notices
*
*   clears all notices on the player's interface
*   located to bottom right in the selection panel
*/

function PANEL:ClearNotices( )
    ui:hide( self.sel.no_pnl_cus        )
    ui:hide( self.sel.no_pnl_admonly    )
    ui:hide( self.sel.no_pnl_admor      )
end

/*
*   DebugNotices
*/

function PANEL:DebugNotices( )
    if not self.bDebugNotices then return end

    ui:show( self.sel.no_pnl_admor )
    ui:show( self.sel.no_pnl_admonly )

    self.sel.no_lbl_admor:SetText( ln( 'sel_notice_sadmin_only' ) )
    self.sel.no_lbl_admonly:SetText( ln( 'sel_notice_admin_only' ) )
end

/*
*   SetupRawID
*
*   adds an additional data field to the original darkrp jobs
*   table for the position of the item in the table
*
*   raw_id is numerical value ( key position ) for table item
*/

function PANEL:SetupRawID( )
    if not self.cf_i.bRawData then return end

    for k, v in ipairs( self.srctbl ) do
        for a, b in ipairs( v.members ) do
            local cmd   = b.command
            local res   = self:GetRawID( cmd )
            b.raw_id    = res
        end
    end
end

/*
*   GetRawID
*
*   find the position key for an rp job based on the
*   command specified
*
*   @param  : name
*/

function PANEL:GetRawID( name )
    name        = isstring( name ) and name:lower( )
    local res   = false
    for k, v in ipairs( RPExtraTeams ) do
        if v.command ~= name then continue end

        res = k
    end

    return res
end

/*
*	_Lang
*/

function PANEL:_Lang( )
    self.l_job_slot_name            = ln( 'mem_jobs_slots_name' )
    self.l_mem_lvl_name             = ln( 'mem_lvl_name' )
    self.l_sel_btn_vote             = ln( 'sel_btn_job_vote_txt' )
    self.l_sel_btn_start            = ln( 'sel_btn_job_start_txt' )
end

/*
*   Declarations
*/

function PANEL:_Declare( )

    /*
    *	declare > main tab configs
    */

    self.cf_u                       = cfg.ui
    self.cf_g                       = cfg.tabs.general
    self.cf_i                       = cfg.tabs.jobs

    /*
    *	declare > sizes
    */

    self.sz_w                       = handle:GetTabWidth( )
    self.cf_sz_w                    = math.Round( self.sz_w * 0.33 )
    self.cf_sz_cat                  = math.Round( self.sz_w - self.sz_w / 3 + 5 + cfg.general.panels.left_w )
    self.cf_sz_slot_n               = self.cf_sz_w - 3
    self.cf_sz_slot_x               = self.cf_sz_w + ( cfg.general.panels.left_w / 2 ) - 3

    /*
    *	declare > gradient
    */

    self.gra_mat_d                  = Material( helper._mat[ 'grad_down' ] )

    /*
    *	declare > misc
    */

    self.pnl_left                   = ui:load( '$pnl_left', mod )

    /*
    *	assign job id
    */

    self.job = self:GetDefault( )
    if ( #RPExtraTeams > 1 ) and ( self.job.name == team.GetName( mod.jobs.current ) ) then
        self.job = RPExtraTeams[ 2 ]
    end

    /*
    *	declare > general
    */

    self.srctbl                     = DarkRP.getCategories( ).jobs
    self.job.key                    = 1
    self.cats                       = { }
    self.cats_i                     = 0
    self.status                     = ln( 'sel_btn_act_err' )
    self.m_prev                     = mat( 'mdlv_preview_02' )
    self.bDebugNotices              = false

    /*
    *	declare > selection
    */

    self.sel                        = { }
    self.sel.skins                  = 0

end

/*
*	_Call
*/

function PANEL:_Call( )
    self:SetState       ( )
    self:SetupRawID     ( )
    self:CheckJobs      ( )
    handle.jsl:Clear    ( )
end

/*
*	_Colorize
*/

function PANEL:_Colorize( )

    self.clr_sep            = self.cf_u.main.clrs.separator
    self.clr_def_txt        = self.cf_u.main.clrs.dt_txt

end

/*
*	register
*/

ui:create( mod, 'pnl_tab_jobs', PANEL, 'pnl' )