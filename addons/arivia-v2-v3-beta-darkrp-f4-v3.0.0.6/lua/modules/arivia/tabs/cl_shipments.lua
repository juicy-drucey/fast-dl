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
*   Localized res func
*/

local function resources( t, ... )
    return base:resource( mod, t, ... )
end

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
*	localized mat func
*/

local function mat( id )
    return mats:call( mod, id )
end

/*
*	localized
*/

local level                 = mod.plugins.level
local prestige              = mod.plugins.prestige
local handle                = mod.handle

/*
*	declare > fonts
*/

local fo_slot_cir_v1        = pref( 'slot_item_cir_val1' )

/*
*	pnl
*/

local PANEL = { }

/*
*	_Lang
*/

function PANEL:_Lang( )
    self.l_ent_amt_name     = ln( 'mem_amt_name' )
    self.l_ent_lvl_name     = ln( 'mem_lvl_name' )
end

/*
*	pnl > initialize
*/

function PANEL:Init( )

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
    *	cats > sort
    */

    local cats  = table.Copy( self.srctbl )
    table.sort( cats, function( a, b )
        local aso = a.sortOrder or 100
        local bso = b.sortOrder or 100

        return aso < bso or aso == bso and a.name < b.name
    end )

    /*
    *	declare > misc
    */

    local clrs                      = self.cf_i.clrs

    /*
    *	cats > loop
    */

    for cat in helper.get.data( cats ) do

        /*
        *	cats > count ents
        */

        local i_ents                = #cat.members
                                    if not cat.members or i_ents < 1 then continue end

        /*
        *	cats > cansee
        */

        if ( cat.canSee and not cat.canSee( LocalPlayer( ) ) ) then continue end

        /*
        *	cats > check ents
        */

        local i_err = 0
        for v in helper.get.data( cat.members ) do
            local bCanBuy, bShow    = mod.ship:bCanBuy( v )

            if not bCanBuy and not bShow then
                i_err = i_err + 1
            end
        end

        /*
        *	cats > skip loading entire cat if errors greater than jobs in cat
        */

        if i_err >= i_ents then continue end

        /*
        *	cats > create new
        */

        local cat_data              = { cat.name, cat.tip }
        local nObj_n                = ( cat.name and self:CreateCat( cat_data ) or nil ) or false

        /*
        *	members > loop
        */

        for v in helper.get.data( cat.members ) do

            /*
            *	members > check > allowbuy
            */

            local   bCanBuy,
                    bShow,
                    err,
                    bCustom,
                    price           = mod.ship:bCanBuy( v )
                                    if not bCanBuy and not bShow then continue end

            /*
            *	cats > alternative
            */

            if not nObj_n then
                cat_data            = { v.category, v.tip }
                nObj_n              = v.category and self:CreateCat( cat_data ) or self:CreateCat( ln( 'mem_cat_other' ) )
            end

            /*
            *	items > assign first
            */

            if not self.item then
                self.item = v
            end

            /*
            *	items > declare > misc
            */

            local ent_name                              = helper.str:truncate( v.name, 27 )
            local ent_level                             = level:Get( v )
            local ent_prestige                          = prestige:Get( v, true )
            local ent_price                             = handle:GetCost( price )
            local ent_max                               = ( v.amount and v.amount > 0 and v.amount ) or ( v.max and v.max > 0 and v.max ) or 0
            ent_max                                     = ent_max > 0 and ent_max or ln( 'handle_unlim_i' )

            /*
            *	items > declare > clr
            */

            local d_clr_box_t, d_clr_box_uc             = clrs.list.btn_box_t, clrs.list.btn_box_uc
            local d_clr_box_ol                          = ( not bCanBuy and clrs.list.btn_box_ol_u ) or clrs.list.btn_box_ol_n
            local d_clr_box, d_clr_box_h                = ( not bCanBuy and clrs.list.btn_box_u ) or clrs.list.btn_box_n, clrs.list.btn_box_h
            local d_clr_txt, d_clr_txt_h                = ( not bCanBuy and clrs.list.btn_txt_u ) or clrs.list.btn_txt_n, clrs.list.btn_txt_h
            local d_clr_sub, d_clr_sub_h                = ( not bCanBuy and clrs.list.btn_sub_u ) or clrs.list.btn_sub_n, clrs.list.btn_sub_h
            local d_clr_cir, d_clr_cir_h                = ( not bCanBuy and clrs.list.btn_cir_u ) or clrs.list.btn_cir_n, clrs.list.btn_cir_h
            local d_clr_gra, d_clr_gra_c                = ( not bCanBuy and clrs.list.btn_gra_u ) or clrs.list.btn_gra_n, clrs.list.btn_gra_c
            local m_clr_cir_line                        = ColorAlpha( bCanBuy and ( handle:GetColor( v ) ) or self.cf_g.slot.clrs.cir_line_def, bCanBuy and self.cf_g.slot.cir_line_val_a or self.cf_g.slot.cir_line_def_a )

            /*
            *	items > pattern
            */

            local pattern_mat                           = mat( self.cf_g.pattern.members.material )
            local pattern_clr                           = self.cf_g.pattern.members.clr

            /*
            *	items > btn > list > layer 1
            */

            local b_slot            = ui.new( 'btn'                         )
            :bsetup                 (                                       )
            :size                   ( self.cf_sz_slot_n, 60                 )
            :notext                 (                                       )
            :anim_click_ol          ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )
            :savedraw               (                                       )

                                    :draw( function( s, w, h )
                                        local clr_box       = ( bCustom and d_clr_box_uc ) or d_clr_box

                                        design.box          ( 0, 0, w, h, clr_box )
                                        design.obox_th      ( 0, 0, w, h, d_clr_box_t, 2 )
                                        design.box          ( 0, 0, w, h, d_clr_box_ol )

                                        if self.cf_g.pattern.members.enabled then
                                            design.imat( 0, 0, w, h * 2, pattern_mat, pattern_clr )
                                        end
                                    end )

                                    :logic( function( s )
                                        local bVisible = ui:ok( self.pnl_left ) and ui:visible( '$pnl_left', mod ) and true or false

                                        s:SetWide( bVisible and self.cf_sz_slot_n or self.cf_sz_slot_x )

                                        nObj_n.list:InvalidateChildren( )
                                        nObj_n:InvalidateLayout( )

                                        storage:Set( mod, 'bMaximized', not bVisible )
                                    end )

            /*
            *	items > btn > list > layer 2
            */

            local slot              = ui.new( 'btn', b_slot                 )
            :bsetup                 (                                       )
            :fill                   ( 'm', 0                                )
            :notext                 (                                       )
            :savedraw               (                                       )
            :tip                    ( v.tip or nil                          )
            :setupanim              ( 'OnHoverFade', 4, rlib.i.OnHover      )

                                    /*
                                    *	update data
                                    */

                                    :logic( function( s )
                                        if not s.nthink then s.nthink = 0 return end
                                        if s.nthink > CurTime( ) then return end

                                        s.amt               = ent_max
                                        s.cir_l1_n          = ( self.bLevelEnabled and ent_level and self.l_ent_lvl_name ) or self.l_ent_amt_name
                                        s.cir_l2_n          = ( self.bLevelEnabled and ent_level ) or s.amt

                                        s.cir_l1_h          = self.l_ent_amt_name
                                        s.cir_l2_h          = s.amt

                                        s.nthink            = CurTime( ) + 5
                                    end )

                                    :draw( function( s, w, h )

                                        if not s.b_alpha then s.b_alpha = 255 end

                                        /*
                                        *	hover fade
                                        */

                                        if s.hover then
                                            self:HoverFade( s, w, h, bCanBuy and d_clr_box_h or self.cf_g.slot.clrs.btn_box_h_nojoin )
                                        end

                                        /*
                                        *	declare > hover colors
                                        */

                                        local clr_txt       = ( s.hover and d_clr_txt_h ) or d_clr_txt
                                        local clr_sub       = ( s.hover and d_clr_sub_h ) or d_clr_sub
                                        local clr_cir       = ( s.hover and d_clr_cir_h ) or d_clr_cir
                                        local clr_gra       = ( bCustom and d_clr_gra_c ) or d_clr_gra
                                        clr_gra             = ColorAlpha( clr_gra, self.cf_g.slot.box_unavail_fade_gra )

                                        /*
                                        *	draw > gradient
                                        */

                                        local w_sz          = w * self.gra_sz
                                        local pos_w         = ( self.gra_dir == 1 and 0 ) or ( w - w_sz )

                                        design.mat( pos_w, h * 0.00, w_sz + 5, h * 1, self.gra_ori, clr_gra )

                                        /*
                                        *	selected
                                        */

                                        if s.selected then
                                            local a	        = math.abs( math.sin( CurTime( ) * 2 ) * 255 )
                                            a			    = math.Clamp( a, 5, 100 )
                                            design.box( 0, 0, w, h, ColorAlpha( self.cf_g.slot.clrs.bg_sel, a ) )
                                        end

                                        /*
                                        *	draw > info > line 1 / 2
                                        *
                                        *   >   style a
                                        *       > NORM      price
                                        *       > HOVER     prestige
                                        *
                                        *   >   style b
                                        *       > NORM      prestige
                                        &       > HOVER     price
                                        */

                                        local ent_l2 = ( self.bPrestEnabled and ( ( not s.hover and ent_prestige ) or ent_price ) ) or ( not self.bPrestEnabled and ent_price )
                                        if not self.cf_g.slot.styleB then
                                            ent_l2 = ( self.bPrestEnabled and ( ( s.hover and ent_prestige ) or ent_price ) ) or ( not self.bPrestEnabled and ent_price )
                                        end

                                        draw.DrawText( ent_name, pref( 'slot_item_name' ), self.cf_g.slot.txt_left_w, h / 2 - 20, ColorAlpha( clr_txt, s.b_alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.DrawText( ent_l2, pref( 'slot_item_sub' ), self.cf_g.slot.txt_left_w, h / 2 + 3, ColorAlpha( clr_sub, s.b_alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

                                        /*
                                        *	draw > circles
                                        *
                                        *   >   leveling NOT installed
                                        *       >   amount
                                        *
                                        *   >   leveling addon installed
                                        *       >   level           ( not hovered )
                                        *       >   amount          ( hovered )
                                        */

                                        local cir_fill_pos = not storage:Get( mod, 'bMaximized' ) and self.cir_fill_n or self.cir_fill_x
                                        local cir_line_pos = not storage:Get( mod, 'bMaximized' ) and self.cir_line_n or self.cir_line_x

                                        design.rcir.fill( cir_fill_pos, self.cf_g.slot.clrs.cir_inner )
                                        design.rcir.line( cir_line_pos, self.cir_mat, m_clr_cir_line or clr_cir )

                                        /*
                                        *	draw > right side text
                                        */

                                        local cir_w     = w - 35
                                        local cir_l1    = tostring( ( not s.hover and s.cir_l1_n or s.cir_l1_h ) or '0' )
                                        local cir_l2    = tostring( ( not s.hover and s.cir_l2_n or s.cir_l2_h ) or '0' )
                                        local fnt_l2    = ( cir_l2 and cir_l2:len( ) > 3 and 'slot_item_cir_val2_sm' ) or 'slot_item_cir_val2'

                                        draw.DrawText( cir_l1, fo_slot_cir_v1, cir_w, ( self.cir_pos_h - 5 ) or 20, clrs.list.btn_lvl_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.DrawText( cir_l2, pref( fnt_l2 ), cir_w, ( self.cir_pos_h + 7 ) or 20, clrs.list.btn_lvl_2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                                        /*
                                        *	ent > unavailable > alpha
                                        */

                                        s.b_alpha = ( not bCanBuy and self.cf_g.slot.box_unavail_bFade and self.cf_g.slot.box_unavail_fade ) or 255
                                    end )

                                    :oc( function( s )
                                        self:Populate( v )
                                        self.sel:InvalidateLayout( true )

                                        for sl in helper.get.data( self.slots ) do
                                            sl.selected = false
                                        end

                                        s.selected = true

                                        /*
                                        *	developer > copy item name to clipboard
                                        */

                                        if handle:GetAccessSAdmin( 'arivia_sa_tools' ) then
                                            SetClipboardText    ( v.name )
                                        end
                                    end )

                                    /*
                                    *	developer > middle click
                                    */

                                    :omc( function( s )
                                        if handle:GetAccessSAdmin( 'arivia_sa_tools' ) then
                                            local name          = v.entity or v.ent or v.label or ''
                                            SetClipboardText    ( name )
                                        end
                                    end )

                                    /*
                                    *	developer > right click
                                    */

                                    :orc( function( s )
                                        if handle:GetAccessSAdmin( 'arivia_sa_tools' ) then
                                            local mdl_src       = istable( v.model ) and v.model[ 1 ] or v.model
                                            SetClipboardText    ( mdl_src )
                                        end
                                    end )

            /*
            *	items > model > container
            */

            local ct_mdl            = ui.new( 'pnl', slot                   )
            :left                   ( 'm', 0                                )
            :wide                   ( self.cf_g.slot.mdl_size               )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, clrs.list.btn_mdl_box )
                                        design.box( w - 1, 0, 1, h, self.clr_sep )
                                    end )

            /*
            *	items > model
            */

            local ent_mdl           = ui.rlib( mod, 'elm_mdl', ct_mdl       )
            :fill                   ( 'm', 0                                )

                                    :logic( function( s )
                                        s:SetHoverTxt       ( '' )
                                    end )

                                    ent_mdl:MdlThink( function( s )
                                        if not bCanBuy and self.cf_g.slot.mdl_unavail_bFade then
                                            s:SetAlpha( self.cf_g.slot.mdl_unavail_fade )
                                        else
                                            s:SetAlpha( 255 )
                                        end
                                    end )

            /*
            *	items > model > btn ( buy )
            */

            local b_buy             = ui.new( 'btn', ent_mdl                )
            :bsetup                 (                                       )
            :fill                   ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            design.box( 0, 0, w, h, bCanBuy and self.cf_g.slot.qacts.clrs.bg_buy or self.cf_g.slot.qacts.clrs.bg_locked )

                                            local txt_buy   = ( self.cf_g.slot.qacts.bUseIcons and ( bCanBuy and '' or '' ) ) or ( bCanBuy and ln( 'mem_ent_qbuy_buy' ) or ln( 'mem_ent_qbuy_lock' ) )
                                            local fnt_buy   = ( self.cf_g.slot.qacts.bUseIcons and 'slot_item_qbuy_ico' ) or 'slot_item_qbuy_txt'
                                            local clr_buy   = ( self.cf_g.slot.qacts.bUseIcons and ( bCanBuy and self.cf_g.slot.qacts.clrs.ico_buy or self.cf_g.slot.qacts.clrs.ico_lock ) ) or ( bCanBuy and self.cf_g.slot.qacts.clrs.txt_buy or self.cf_g.slot.qacts.clrs.txt_lock )
                                            local pos_buy   = ( self.cf_g.slot.qacts.bUseIcons and h / 2 - self.cf_g.slot.qacts.oset_ico_h ) or ( h / 2 - self.cf_g.slot.qacts.oset_txt_h )

                                            local a         = math.abs( math.sin( CurTime( ) * 4 ) * 255 )
                                            a               = math.Clamp( a, 100, 255 )

                                            draw.DrawText( txt_buy, pref( fnt_buy ), w / 2 - 1, pos_buy, ColorAlpha( clr_buy, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        end
                                    end )

                                    :oc( function( s )
                                        if not bCanBuy then return end
                                        self:GetAction( v )
                                        if cvar:GetInt( 'arivia_onbuy_aclose', 1 ) == 1 then
                                            DarkRP.closeF4Menu( )
                                        end
                                    end )

            /*
            *	items > model > attach
            */

            local mdl_src           = istable( v.model ) and v.model[ 1 ] or v.model
            local mdl_fov           = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].fov ) or 46
            local mdl_cam           = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].cam ) or false
            local mdl_look          = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].look ) or false
            local mdl_oset          = ( cfg.models.slot.man[ mdl_src ] and cfg.models.slot.man[ mdl_src ].oset ) or Vector( 0, 0, 0 )

                                    if mdl_cam and mdl_look then
                                        ent_mdl:AttachManual   ( mdl_src, mdl_fov, mdl_cam, mdl_look )
                                    else
                                        ent_mdl:AttachEntity   ( mdl_src, mdl_fov, mdl_oset )
                                    end

                                    ent_mdl:SetPaintedOver ( )

            /*
            *	items > assign / add category
            */

            nObj_n.list:Add         ( b_slot )
            nObj_n:AddSlot          ( b_slot )

            /*
            *	register slots
            */

            table.insert( self.slots, slot )

        end // cat.members

    end // cats

    /*
    *	sel > parent
    */

    self.sel                        = ui.new( 'pnl', self                   )
    :right                          ( 'm', 0                                )
    :wide                           ( self.cf_sz_w - 10                     )

                                    :draw( function( s, w, h )
                                        design.rbox( 0, 0, 0, w, h, cfg.ui.right.clrs.panel )

                                        if self.cf_i.misc.sel.gradient.bEnabled then
                                            local grad_clr      = clrs.tab.btn_box_n
                                            local grad_a        = self.gra_mat_a

                                            design.imat( 0, 0, w, 200, self.gra_mat_d, ColorAlpha( grad_clr, grad_a ) )
                                            if self.cf_g.sel.bBlur then
                                                design.blur_trim( s, 4 )
                                            end
                                        end

                                        design.box( 0, 0, 1, h, self.cf_u.main.clrs.separator )
                                    end )

    /*
    *	sel > name
    */

    self.sel.name                   = ui.new( 'lbl', self.sel               )
    :top                            ( 'm', 0                                )
    :notext                         (                                       )
    :font                           ( pref( 'sel_name' )                    )
    :align                          ( 5                                     )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        if not self.item then return end
                                        draw.SimpleText( helper.str:truncate( self.item.name, 26 ), pref( 'sel_name' ), w / 2, 20, self.cf_u.main.clrs.dt_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > cost
    */

    self.sel.cost                   = ui.new( 'pnl', self.sel               )
    :top                            ( 'm', 0, 0, 0, 5                       )
    :align                          ( 5                                     )
    :tall                           ( 20                                    )

                                    :draw( function( s, w, h )
                                        if not self.item then return end

                                        local cost                          = self.item.cost
                                        local sz_cost_w, sz_cost_h          = helper.str:len( cost, pref( 'sel_sub' ) )
                                        sz_cost_w                           = sz_cost_w + 20
                                        s:SetTall                           ( sz_cost_h )

                                        design.rbox( 5, ( w / 2 ) - ( sz_cost_w / 2 ), 0, sz_cost_w, h, self.cf_u.main.clrs.box_accent )
                                        draw.SimpleText( cost, pref( 'sel_sub' ), w / 2, h / 2, self.cf_u.main.clrs.dt_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > model > defaults
    */

    local m_sel_sz                  = ui:SmartScaleH( true, cfg.ui.right.sizes.mdl_h )
    local m_sel_w                   = self.sel:GetWide( ) / 2
    local m_sel_h                   = self:GetTall( ) + m_sel_sz

    /*
    *	sel > model > ct
    */

    self.sel.mdl                    = ui.rlib( mod, 'elm_mdl', self.sel     )
    :top                            ( 'm', 0                                )
    :size                           ( m_sel_w, m_sel_h                      )

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
                                        :param                  ( 'SetMDL', istable( self.item.model ) and self.item.model[ 1 ] or self.item.model )
                                        :register               ( '$pnl_mdlv', mod                  )
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

    self.sel.no_pnl_admor           = ui.new( 'pnl', self.sel, 1            )
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

    self.sel.no_pnl_admonly         = ui.new( 'pnl', self.sel, 1            )
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

    self.sel.no_pnl_cus             = ui.new( 'pnl', self.sel, 1            )
    :bottom                         ( 'm', 0, 0, 0, 1                       )
    :tall                           ( 28                                    )
    :hide                           (                                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_g.sel.clrs.amsg.cus_box )
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
    *	sel > btn > action
    */

    self.sel.b_buy                  = ui.new( 'btn', self.sel.ftr           )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :fill                           ( 'm', 2, 0, 0, 1                       )
    :tip                            ( ln( 'sel_btn_buy_buy_tip' )           )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )
    :tall                           ( 30                                    )

                                    :pl( function( s )
                                        if not self.item then return end
                                        if not self.item.bCanBuy then
                                            s.DoClick = function( )
                                                if cvar:GetInt( 'arivia_popup_enabled', 0 ) == 1 and self.item.err then
                                                    local reason = self.item.err or nil
                                                    design:bubble( reason, 5 )
                                                end
                                            end

                                            return
                                        end
                                        s.DoClick = function( )
                                            self:GetAction( self.item )
                                            if cvar:GetInt( 'arivia_onbuy_aclose', 1 ) == 1 then
                                                DarkRP.closeF4Menu( )
                                            end
                                        end
                                    end )

                                    :draw( function( s, w, h )
                                        local clr_btn   = self.cf_g.sel.clrs.btn_act_allowed
                                        local ico_btn   = self.cf_g.sel.ico_buy

                                        /*
                                        *	check > player level vs ent level
                                        */

                                        if not self.item or not self.item.bCanBuy then
                                            clr_btn     = self.cf_g.sel.clrs.btn_act_unavail
                                            ico_btn     = self.cf_g.sel.ico_unavail
                                            self.status = ln( 'sel_btn_buy_unavail_txt' )
                                        end

                                        design.box( 0, 0, w, h, clr_btn )
                                        design.box( 0, 0, w, h / 2, self.cf_g.sel.clrs.btn_act_s )

                                        if s.hover then
                                            design.box( 0, 0, w, h, self.cf_g.sel.clrs.btn_act_h )
                                        end

                                        local sz_btext_w = helper.str:len( self.status, pref( 'sel_btn_act_txt' ) )

                                        if self.cf_g.sel.bShowIcon then
                                            draw.SimpleText( ico_btn, pref( 'sel_btn_act_ico' ), w / 2 - ( sz_btext_w / 2 ) - 13, h / 2, self.cf_g.sel.clrs.btn_act_ico, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        end
                                        draw.SimpleText( self.status, pref( 'sel_btn_act_txt' ), w / 2 - ( sz_btext_w / 2 ) + 13, h / 2, self.cf_g.sel.clrs.btn_act_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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
                                        :param                  ( 'SetMDL', istable( self.item.model ) and self.item.model[ 1 ] or self.item.model )
                                        :register               ( '$pnl_mdlv', mod                  )
                                    end )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_g.sel.clrs.btn_mdl_n )
                                        design.box( 0, 0, w, h / 2, self.cf_g.sel.clrs.btn_mdl_s )
                                        design.box( 0, 0, 1, h, self.cf_u.main.clrs.separator )

                                        if s.hover then
                                            self:HoverFill( s, w, h, self.cf_g.sel.clrs.btn_mdl_h )
                                        end

                                        design.imat( ( w / 2 ) - ( 24 / 2 ), ( h / 2 ) - ( 24 / 2 ), 24, 24, self.m_prev, self.cf_g.sel.clrs.ico_mdlv_n )
                                    end )

    /*
    *	cats > setup children
    */

    for v in helper.get.data( self.cats ) do
        v:SetupChildren( )
    end

    /*
    *	populate ( init load )
    */

    self:Populate( self.item )

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
    :param                          ( 'SetBodyColor', clr_body              )
    :param                          ( 'SetTip', tip                         )
    :param                          ( 'SetTipCat', 'ship'                   )

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
*	populate
*
*   @para   : ent v
*/

function PANEL:Populate( v )

    /*
    *	check > object
    */

    if not v then
        if cvar:GetBool( 'arivia_sa_debug' ) then
            base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_ship' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        end
        return
    end

    /*
    *	declare > pl
    */

    local pl = LocalPlayer( )

    /*
    *	ent > allow buy
    */

    local   bCanBuy,
            bShow,
            err,
            bCustom,
            price                   = mod.ship:bCanBuy( v )

    /*
    *	clear notices
    */

    self:ClearNotices( )

    /*
    *	check > v
    */

    if not v then return end

    /*
    *	sel > setup
    */

    self.item                       = v
    self.item.key                   = 1
    self.item.cost                  = handle:GetCost( price )
    self.item.price                 = price
    self.item.err                   = isstring( err ) and err or istable( err ) and err[ 1 ] or nil
    self.item.err_clr               = istable( err ) and err[ 2 ]
    self.item.adminonly             = ( v.admin == 1 or tostring( v.admin ) == 'true' and true ) or false
    self.item.sadminonly            = ( v.superadmin == 1 or tostring( v.superadmin ) == 'true' and true ) or false
    self.item.bCanBuy               = bCanBuy
    self.item.needJob               = ''
    self.status                     = ln( 'sel_btn_buy_buy_txt', handle:GetCost( price ) )

    /*
    *	sel > update model
    */

    self.sel.mdl:SetModel           ( istable( self.item.model ) and self.item.model[ self.item.key ] or self.item.model )

    /*
    *	sel > rehash
    */

    ui:rehash( self.sel.mdl     )
    ui:rehash( self.sel.b_buy   )

    /*
    *	sel > model > defaults
    */

    local m_sel_src                 = istable( self.item.model ) and self.item.model[ 1 ] or self.item.model
    local m_sel_fov                 = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].fov ) or 80
    local m_sel_cam                 = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].cam ) or Vector( 0, 0, 0 )
    local m_sel_look                = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].look ) or Vector( 0, 0, 0 )
    local m_sel_speed               = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].speed ) or 40
    local mdl_oset                  = ( cfg.models.sel.man[ m_sel_src ] and cfg.models.sel.man[ m_sel_src ].oset ) or Vector( 0, 0, 0 )

    /*
    *	sel > model > ct
    */

    self.sel.mdl:AllowRotate        ( m_sel_speed )
    self.sel.mdl:AttachEntity       ( m_sel_src, m_sel_fov, mdl_oset )

    /*
    *	sel > set skin
    */

    self.sel.Skins                  = istable( self.item.model ) and table.Count( self.item.model ) or 0

    /*
    *	populate > req job
    *
    *   displays any required jobs that a player must have in order to
    *   buy this item
    */

    if handle:GetJobs( self.item ) then
        local bHasReq, lst          = handle:GetJobsReq( self.item )
        if not bHasReq then
            self.item.bNotJob       = true
            self.item.needJob       = ln( 'sel_desc_ents_need', lst )
        end
    end

    /*
    *	sel > desc
    */

    self.sel.desc                   = self:GetDesc( self.item )

    /*
    *	btn > tip
    */

    self.sel.b_buy:tip              ( bCanBuy and ln( 'sel_btn_buy_buy_tip' ) or ln( 'sel_btn_buy_unavail_tip' ) )

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
        if self.item.sadminonly then
            ui:show( self.sel.no_pnl_admonly )
            self.sel.no_lbl_admonly:SetText( ln( 'sel_notice_sadmin_only' ) )
        elseif self.item.adminonly then
            ui:show( self.sel.no_pnl_admonly )
            self.sel.no_lbl_admonly:SetText( ln( 'sel_notice_admin_only' ) )
        end
    end

    /*
    *	populate > err msg
    */

    if self.item.err and not ui:visible( self.sel.no_pnl_cus ) then
        ui:show( self.sel.no_pnl_cus )
        self.sel.no_lbl_cus:SetText( self.item.err )
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

    ui:destroy( self.sel.b_nojob )
    ui:destroy( self.sel.b_noafford )
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

    local clr_ico_nojob             = self.cf_g.sel.clrs.indic_ico_nojob
    local clr_ico_noafford          = self.cf_g.sel.clrs.indic_ico_noafford
    local clr_ico_edit              = self.cf_g.sel.clrs.indic_ico_edit
    local clr_bubble                = Color( 31, 133, 222, 255 )

    /*
    *	sel > btn > no job
    */

    self.sel.b_nojob                = ui.new( 'btn', self.sel.indic         )
    :bsetup                         (                                       )
    :left                           ( 'm' , 0, 0, 4, 0                      )
    :sz                             ( 31                                    )
    :tip                            ( ln( 'sel_tip_indic_nojob' )           )
    :enabled                        ( self.item.bNotJob and true or false   )

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

                                        draw.SimpleText( self.cf_u.right.ico.nojob, pref( 'g_ico_hint' ), w / 2, h / 2, ColorAlpha( clr_ico_nojob, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sel > btn > no afford
    */

    self.sel.b_noafford             = ui.new( 'btn', self.sel.indic         )
    :bsetup                         (                                       )
    :left                           ( 'm' , 0, 0, 4, 0                      )
    :sz                             ( 31                                    )
    :tip                            ( ln( 'sel_tip_indic_noafford' )        )
    :enabled                        ( not LocalPlayer( ):canAfford( self.item.price ) and true or false )

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

                                        draw.SimpleText( self.cf_u.right.ico.noafford, pref( 'g_ico_hint' ), w / 2, h / 2, ColorAlpha( clr_ico_noafford, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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
    *	sel > tab > dev
    */

    if self.cf_i.bDev and handle:GetAccessSAdmin( 'arivia_sa_tools' ) then
        local tab_dev_id            = ln( 'sel_tab_name_dev'                )
        local pnl_dev               = ui:getpnl( 'elm_sel_tab_dev_item', mod )
        self.sel.tabs:CreateTab     ( tab_dev_id, pnl_dev                   )


        local tab_dev               = self.sel.tabs:GetTab( tab_dev_id      )
        if tab_dev then
            tab_dev:SetType         ( self.item, true                       )
        end
    else
        local tab_dev_id            = ln( 'sel_tab_name_dev'                )
        self.sel.tabs:DispatchTab   ( tab_dev_id                            )
    end

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
    desc                            = ( not bEmpty and desc ) or ln( 'sel_desc_alt_item' )

    if item.needJob then
        desc                        = desc .. '\n\n' .. item.needJob .. '\n\n'
    end

    self.sel.desc                   = desc

    return self.sel.desc
end

/*
*	GetAction
*
*   @param  : tbl item
*/

function PANEL:GetAction( item )
    if not item then return end
    rcc.run.gmod( 'darkrp', 'buyshipment', item.name )
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
*   HoverFade
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
    local bStateMax     =  storage:Get( mod, 'bMaximized' ) and true or false
    if bStateMax then
        ui:unstage      ( '$pnl_left',   mod )
        ui:stage        ( '$btn_toggle', mod )
    else
        ui:stage        ( '$pnl_left',   mod )
        ui:unstage      ( '$btn_toggle', mod )
    end
end

/*
*	CreateCircles
*/

function PANEL:CreateCircles( )

    /*
    *	rcir > generate > outline
    */

    self.cir_line_n                 = rcir.new( CIRCLE_LINE, self.cf_g.slot.cir_size, self.cf_sz_slot_n - 35, 60 / 2, self.cf_g.slot.cir_line )
    self.cir_line_n:SetAngles       ( 0, 360                                )
    self.cir_line_n:Scale           ( 0.5                                   )

    self.cir_line_x                 = rcir.new( CIRCLE_LINE, self.cf_g.slot.cir_size, self.cf_sz_slot_x - 35, 60 / 2, self.cf_g.slot.cir_line )
    self.cir_line_x:SetAngles       ( 0, 360                                )
    self.cir_line_x:Scale           ( 0.5                                   )

    /*
    *	rcir > generate > fill
    */

    self.cir_fill_n                 = rcir.new( CIRCLE_FILL, self.cf_g.slot.cir_size, self.cf_sz_slot_n - 35, 60 / 2 )
    self.cir_fill_n:SetAngles       ( 0, 360                                )
    self.cir_fill_n:Scale           ( 0.5                                   )

    self.cir_fill_x                 = rcir.new( CIRCLE_FILL, self.cf_g.slot.cir_size, self.cf_sz_slot_x - 35, 60 / 2 )
    self.cir_fill_x:SetAngles       ( 0, 360                                )
    self.cir_fill_x:Scale           ( 0.5                                   )

end

/*
*	clear notices
*/

function PANEL:ClearNotices( )
    ui:hide( self.sel.no_pnl_cus        )
    ui:hide( self.sel.no_pnl_admonly    )
    ui:hide( self.sel.no_pnl_admor      )
end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *	declare > main tab configs
    */

    self.cf_u                       = cfg.ui
    self.cf_g                       = cfg.tabs.general
    self.cf_i                       = cfg.tabs.shipments

    /*
    *	declare > sizes
    */

    self.sz_w                       = handle:GetTabWidth( )
    self.cf_sz_w                    = math.Round( self.sz_w * 0.33 )
    self.cf_sz_cat                  = self.sz_w - self.sz_w / 3 + 5 + cfg.general.panels.left_w
    self.cf_sz_slot_n               = self.cf_sz_w - 3
    self.cf_sz_slot_x               = self.cf_sz_w + ( cfg.general.panels.left_w / 2 ) - 3

    /*
    *	declare > misc
    */

    self.pnl_left                   = ui:load( '$pnl_left', mod )

    /*
    *	declare > gradient
    */

    self.gra_mat_d                  = Material( helper._mat[ 'grad_down' ] )
    self.gra_mat_a                  = self.cf_i.misc.sel.gradient.alpha
    self.gra_sz, self.gra_dir       = self.cf_g.slot.grad_w or 1, self.cf_g.slot.grad_o
    self.gra_ori                    = self.gra_dir == 1 and helper._mat[ 'grad_l' ] or helper._mat[ 'grad_r' ]

    /*
    *	declare > general
    */

    self.srctbl                     = mod.ship.src
    self.item                       = nil
    self.cats                       = { }
    self.cats_i                     = 0
    self.status                     = ln( 'sel_btn_act_err' )
    self.m_prev                     = mat( 'mdlv_preview_02' )
    self.slots                      = { }

    /*
    *	declare > rcir
    */

    self.cir_mat                    = Material( 'rlib/cir/cir_01.png', 'smooth' )
    self.cir_pos_h                  = 20

    /*
    *	declare > plugins
    */

    self.bLevelEnabled              = level:bEnabled( )
    self.bPrestEnabled              = prestige:bEnabled( )

    /*
    *	set > state
    */

    self:SetState( )

end

/*
*	_Call
*/

function PANEL:_Call( )
    self:CreateCircles( )
end

/*
*	_Colorize
*/

function PANEL:_Colorize( )

    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_def_txt                = self.cf_u.main.clrs.dt_txt

end

/*
*	register
*/

ui:create( mod, 'pnl_tab_ship', PANEL, 'pnl' )