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
*	localized > lib
*/

local level                 = mod.plugins.level
local prestige              = mod.plugins.prestige
local handle                = mod.handle

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
*	declare > fonts
*/

local fo_slot_l1            = pref( 'slot_item_name' )
local fo_slot_l2            = pref( 'slot_item_sub' )
local fo_slot_cir_v1        = pref( 'slot_item_cir_val1' )

/*
*   panel
*/

local PANEL = { }

/*
*   Init
*/

function PANEL:Init( )

    /*
    *   parent
    */

    timex.simple( 0.03, function( )
        if not ui:ok( self ) then return end
        self:Run( )
    end )

end

/*
*   Run
*
*   build interface
*/

function PANEL:Run( )

    /*
    *	parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :fill                           (                                       )

    /*
    *	CreateCircles
    */

    self:CreateCircles( )

    /*
    *	declare > misc
    */

    local clrs                      = self.cf_i.clrs
    local pattern_mat               = Material( self.cf_g.pattern.members.material )
    local pattern_clr               = self.cf_g.pattern.members.clr

    /*
    *   slot
    */

    local slot                      = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :fill                           ( 'm', 0, 0, 0, 0                       )
    :notext                         (                                       )
    :setupanim                      ( 'OnHoverFade', 4, rlib.i.OnHover      )

                                    /*
                                    *	update data
                                    */

                                    :logic( function( s )
                                        if not s.nthink then s.nthink = 0 return end
                                        if s.nthink > CurTime( ) then return end

                                        self:UpdateJob      ( )
                                        self:_Colorize      ( )

                                        s.slots             = handle:GetSlots( self.job, true, '/' )
                                        s.cir_l1_n          = ( self.bLevelEnabled and self.level and self.l_mem_lvl_name ) or self.l_job_slot_name
                                        s.cir_l2_n          = ( self.bLevelEnabled and self.level ) or s.slots

                                        s.cir_l1_h          = self.l_job_slot_name
                                        s.cir_l2_h          = s.slots

                                        s.nthink            = CurTime( ) + 5
                                    end )

                                    :oc( function( s )
                                        self:GetPar( ):Populate( self.job )
                                        handle.jsl:Rehash( )
                                        s.selected = true

                                        /*
                                        *	developer > copy job name to clipboard
                                        */

                                        if handle:GetAccessSAdmin( 'arivia_sa_tools' ) then
                                            SetClipboardText( self.job.name )
                                        end
                                    end )

                                    :draw( function( s, w, h )
                                        local clr_box       = ( self.bCustom and clrs.list.btn_box_uc ) or self.clr_box

                                        design.box          ( 0, 0, w, h, clr_box )
                                        design.obox_th      ( 0, 0, w, h, clrs.list.btn_box_t, 2 )
                                        design.box          ( 0, 0, w, h, self.clr_box_ol )

                                        if self.cf_g.pattern.members.enabled then
                                            design.imat( 0, 0, w, h * 2, pattern_mat, pattern_clr )
                                        end

                                        if s.hover then
                                            self:HoverFade( s, w, h, self.bCanJoin and self.clr_box_h or self.cf_g.slot.clrs.btn_box_h_nojoin )
                                        end

                                        /*
                                        *	declare > hover colors
                                        */

                                        local clr_gra       = ( self.bCustom and self.clr_gra_c ) or self.clr_gra
                                        clr_gra             = Color( clr_gra.r, clr_gra.g, clr_gra.b, self.cf_g.slot.box_unavail_fade_gra )

                                        /*
                                        *	draw > gradient
                                        */

                                        local w_sz          = w * self.gra_sz
                                        local pos_w         = ( self.gra_dir == 1 and 0 ) or ( w - w_sz )
                                        if self.bCustom or not self.bCanJoin then
                                            design.mat( pos_w, h * 0.00, w_sz + 5, h * 1, self.gra_ori, clr_gra )
                                        end

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
                                        *       > NORM      salary
                                        *       > HOVER     prestige
                                        *
                                        *   >   style b
                                        *       > NORM      prestige
                                        &       > HOVER     salary
                                        */

                                        local job_l2 = ( self.bPrestEnabled and ( ( not s.hover and self.prestige ) or self.salary ) ) or ( not self.bPrestEnabled and self.salary )
                                        if not self.cf_g.slot.styleB then
                                            job_l2 = ( self.bPrestEnabled and ( ( s.hover and self.prestige ) or self.salary ) ) or ( not self.bPrestEnabled and self.salary )
                                        end

                                        draw.DrawText( self.name, fo_slot_l1, 15, h / 2 - 20, ( s.hover and self.clr_txt_h ) or self.clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.DrawText( job_l2, fo_slot_l2, 15, h / 2 + 3, ( s.hover and self.clr_sub_h ) or self.clr_sub, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

                                        /*
                                        *	draw > circles
                                        *
                                        *   >   leveling NOT installed
                                        *       >   slots
                                        *
                                        *   >   leveling addon installed
                                        *       >   level           ( not hovered )
                                        *       >   slots           ( hovered )
                                        */

                                        local cir_fill_pos = not storage:Get( mod, 'bMaximized' ) and self.cir_fill_n or self.cir_fill_x
                                        local cir_line_pos = not storage:Get( mod, 'bMaximized' ) and self.cir_line_n or self.cir_line_x

                                        design.rcir.fill( cir_fill_pos, self.cf_g.slot.clrs.cir_inner )
                                        design.rcir.line( cir_line_pos, self.cir_mat, self.clr_cir_line or ( s.hover and self.clr_cir_h ) or self.clr_cir )

                                        /*
                                        *	draw > right side text
                                        */

                                        local cir_w     = w - 35
                                        local cir_l1    = tostring( ( not s.hover and s.cir_l1_n or s.cir_l1_h ) or '0' )
                                        local cir_l2    = tostring( ( not s.hover and s.cir_l2_n or s.cir_l2_h ) or '0' )
                                        local fnt_l2    = ( cir_l2 and cir_l2:len( ) > 3 and 'slot_item_cir_val2_sm' ) or 'slot_item_cir_val2'

                                        draw.DrawText( cir_l1, fo_slot_cir_v1, cir_w, ( 20 - 5 ) or 20, clrs.list.btn_lvl_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.DrawText( cir_l2, pref( fnt_l2 ), cir_w, ( 20 + 7 ) or 20, clrs.list.btn_lvl_2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                                        /*
                                        *	job > unavailable > alpha
                                        */

                                        if not self.bCanJoin and self.cf_g.slot.box_unavail_bFade then
                                            s.b_alpha = self.cf_g.slot.box_unavail_fade
                                        else
                                            s.b_alpha = 255
                                        end

                                    end )

    /*
    *	slot > favorite button
    */

    local b_fav                     = ui.new( 'btn', slot                   )
    :bsetup                         (                                       )
    :sz                             ( 36                                    )
    :pos                            ( self:GetW( ) - 100 - self.cf_g.slot.cir_size - 10, 10 )
    :tip                            ( ln( 'slot_jobs_btn_fav_add' )         )

                                    :logic( function( s )
                                        if not s.nthink then s.nthink = 0 return end
                                        if s.nthink > CurTime( ) then return end
                                        if not ui:ok( self ) or not ui:visible( s ) then return end

                                        local slot_sz = not storage:Get( mod, 'bMaximized' ) and  15 or -89
                                        s:SetPos( self:GetW( ) - 100 - self.cf_g.slot.cir_size - slot_sz, 17 )

                                        if ui:ok( self:GetPar( ) ) then
                                            s.GetFavorite = self:GetPar( ):GetFavorite( self.job )
                                        end

                                        if s.GetFavorite then
                                            s:tip( ln( 'slot_jobs_btn_fav_rem' ) )
                                        end

                                        s.nthink            = CurTime( ) + 0.1
                                    end )

                                    :draw( function( s, w, h )
                                        local ico_name  = s.GetFavorite and '' or s.hover and '' or ''
                                        local ico_clr   = s.GetFavorite and clrs.list.btn_fav_on or s.hover and clrs.list.btn_fav_off or clrs.list.btn_fav_off
                                        local ico_fnt   = s.GetFavorite and 'slot_item_btn_fav_on' or s.hover and 'slot_item_btn_fav_on' or 'slot_item_btn_fav_off'

                                        draw.DrawText( ico_name, pref( ico_fnt ), w / 2 - 1, 0, ico_clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        local db = mod.favs.jobs

                                        if table.HasValue( db, self.job.command ) then
                                            table.RemoveByValue( db, self.job.command )
                                        else
                                            table.insert( db, self.job.command )
                                        end

                                        local pnl_base      = ui:call( '$pnl_base', mod )
                                                            if ui:ok( '$pnl_base', mod ) then
                                                                pnl_base:RehashStoreContent( 'jobs' )
                                                            end
                                    end )

    /*
    *	register slot
    */

    handle.jsl:New( slot )

end

/*
*   UpdateJob
*/

function PANEL:UpdateJob( )
    self.bCanJoin,
    self.bShow,
    self.err,
    self.bCustom                    = mod.jobs:bCanSwitch( self.job )
end

/*
*   Rebuild
*
*   rebuild slot when data needs updated
*/

function PANEL:Rebuild( )
    self:_Declare   ( )
    self:_Colorize  ( )
end

/*
*   RehashSlot
*
*   rebuilds all slots
*/

function PANEL:RehashSlot( )
    for a, b in pairs( handle.jsl:Get( ) ) do
        if not ui:ok( b ) then continue end
        b:GetParent( ):Rebuild( )
    end
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
*   SetJob
*/

function PANEL:SetJob( v )
    self.job = v
end

/*
*   GetJob
*/

function PANEL:GetJob( )
    return self.job
end

/*
*   SetJob
*/

function PANEL:SetPar( v )
    self.par = v
end

/*
*   GetJob
*/

function PANEL:GetPar( )
    return self.par
end

/*
*   SetJob
*/

function PANEL:SetW( v )
    self.w = v
end

/*
*   GetJob
*/

function PANEL:GetW( )
    return self.w
end

/*
*   SetObject
*/

function PANEL:SetObject( pnl )
    self.obj = pnl
end

/*
*   GetObject
*/

function PANEL:GetObject( )
    return self.obj
end

/*
*   BuildIndex
*/

function PANEL:BuildIndex( v )
    self.index = v
end

/*
*   BuildIndex
*/

function PANEL:GetIndex( )
    return self.index or { }
end

/*
*	CreateCircles
*/

function PANEL:CreateCircles( )

    /*
    *	rcir > generate > material
    */

    self.cir_mat                    = Material( 'rlib/cir/cir_01.png', 'smooth' )

    /*
    *	rcir > generate > outline
    */

    self.cir_line_n                 = rcir.new( CIRCLE_LINE, self.cf_g.slot.cir_size, self:GetW( ) - 100, 60 / 2, self.cf_g.slot.cir_line )
    self.cir_line_n:SetAngles       ( 0, 360                                )
    self.cir_line_n:Scale           ( 0.5                                   )

    self.cir_line_x                 = rcir.new( CIRCLE_LINE, self.cf_g.slot.cir_size, self:GetW( ) + 4, 60 / 2, self.cf_g.slot.cir_line )
    self.cir_line_x:SetAngles       ( 0, 360                                )
    self.cir_line_x:Scale           ( 0.5                                   )

    /*
    *	rcir > generate > fill
    */

    self.cir_fill_n                 = rcir.new( CIRCLE_FILL, self.cf_g.slot.cir_size, self:GetW( ) - 100, 60 / 2 )
    self.cir_fill_n:SetAngles       ( 0, 360                                )
    self.cir_fill_n:Scale           ( 0.5                                   )

    self.cir_fill_x                 = rcir.new( CIRCLE_FILL, self.cf_g.slot.cir_size, self:GetW( ) + 4, 60 / 2 )
    self.cir_fill_x:SetAngles       ( 0, 360                                )
    self.cir_fill_x:Scale           ( 0.5                                   )

end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h ) end

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
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *	declare > main tab configs
    */

    self.cf_u                       = cfg.ui
    self.cf_g                       = cfg.tabs.general
    self.cf_i                       = cfg.tabs.jobs

    /*
    *	declare > plugins
    */

    self.bLevelEnabled              = level:bEnabled( )
    self.bPrestEnabled              = prestige:bEnabled( )

    /*
    *	declare > job
    */

    local v                         = self:GetJob( )

    /*
    *	declare > job parameters
    */

    self.bCanJoin,
    self.bShow,
    self.err,
    self.bCustom                    = mod.jobs:bCanSwitch( v )

    self.name                       = helper.str:truncate( v.name, 27 )
    self.salary                     = handle:GetSalary( v, true )
    self.level                      = level:Get( v )
    self.prestige                   = prestige:Get( v, true )

    /*
    *	declare > gradient
    */

    self.gra_mat_d                  = Material( helper._mat[ 'grad_down' ] )
    self.gra_sz, self.gra_dir       = self.cf_g.slot.grad_w or 1, self.cf_g.slot.grad_o
    self.gra_ori                    = self.gra_dir == 1 and helper._mat[ 'grad_l' ] or helper._mat[ 'grad_r' ]

    /*
    *	job > curr > gradient
    */

    if self.job.bCurrJob then
        self.gra_sz = 0.5
    end

end

/*
*   _Colorize
*/

function PANEL:_Colorize( )

    /*
    *	declare > job
    */

    local v                         = self:GetJob( )

    /*
    *	declare > misc
    */

    local clrs                      = self.cf_i.clrs.list

    self.clr_box_ol                 = ( not self.bCanJoin and clrs.btn_box_ol_u ) or clrs.btn_box_ol_n
    self.clr_box, self.clr_box_h    = ( not self.bCanJoin and clrs.btn_box_u ) or clrs.btn_box_n, clrs.btn_box_h
    self.clr_txt, self.clr_txt_h    = ( not self.bCanJoin and clrs.btn_txt_u ) or clrs.btn_txt_n, clrs.btn_txt_h
    self.clr_sub, self.clr_sub_h    = ( not self.bCanJoin and clrs.btn_sub_u ) or clrs.btn_sub_n, clrs.btn_sub_h
    self.clr_cir, self.clr_cir_h    = ( not self.bCanJoin and clrs.btn_cir_u ) or clrs.btn_cir_n, clrs.btn_cir_h
    self.clr_gra, self.clr_gra_c    = ( not self.bCanJoin and clrs.btn_gra_u ) or clrs.btn_gra_n, clrs.btn_gra_c
                                    if v.bCurrJob then
                                        self.clr_gra = clrs.btn_gra_j
                                    end

    self.clr_cir_line               = ColorAlpha( self.bCanJoin and ( handle:GetColor( v ) ) or self.cf_g.slot.clrs.cir_line_def, self.bCanJoin and self.cf_g.slot.cir_line_val_a or self.cf_g.slot.cir_line_def_a )

end

/*
*   _Call
*/

function PANEL:_Call( )

end

/*
*   register
*/

ui:create( mod, 'slot', PANEL, 'pnl' )