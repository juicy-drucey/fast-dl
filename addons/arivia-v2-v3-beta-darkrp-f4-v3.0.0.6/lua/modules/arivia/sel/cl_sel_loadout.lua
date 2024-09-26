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
*	localized
*/

local level                 = mod.plugins.level
local prestige              = mod.plugins.prestige

/*
*	panels
*/

local PANEL = { }

/*
*	init
*/

function PANEL:Init( )

    /*
    *	parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :nodraw                         (                                       )
    :margin                         ( 0                                     )

    /*
    *	scroll
    */

    self.scr                        = ui.new( 'rlib.elm.sp.v2', self        )
    :fill                           (                                       )
    :param                          ( 'SetbElastic', true                   )
    :param                          ( 'SetAlwaysVisible', true              )

end

/*
*   loadout > set
*
*   @param  : tbl tbl
*   @param  : bool bClear
*/

function PANEL:SetLoadout( tbl, bClear )
    bClear = helper:val2bool( bClear )

    /*
    *   scroll > clear
    */

    if bClear then
        self.scr:Clear( )
    end

    /*
    *   declare > loadout table
    */

    local loadout           = table.Copy( tbl )

    /*
    *   sort > reorangize table
    */

    local sorted            = { }
    local cfg_lst           = cfg.loadout.list
    for v in helper.get.data( loadout ) do
        local wep           = weapons.Get( v )
        local name          = cfg_lst[ v ] and cfg_lst[ v ].name or wep and helper.get.item_name( wep ) or v
        local desc          = cfg_lst[ v ] and cfg_lst[ v ].desc or ln( 'lo_desc_none' )
        local mdl           = cfg_lst[ v ] and cfg_lst[ v ].model or wep and helper.get.item_mdl( wep ) or 'error.mdl'
        local fov           = cfg_lst[ v ] and cfg_lst[ v ].fov or 40

        sorted[ #sorted + 1 ] = { name = name, desc = desc, mdl = mdl, fov = fov }
    end

    /*
    *   sort > loadout table
    */

    table.sort( sorted, function( a, b ) return a.name < b.name end )

    /*
    *   check loadout list
    */

    if #sorted < 1 then

        /*
        *   no loadout > pnl
        */

        self.noloadout              = ui.new( 'pnl', self.scr, 1            )
        :top                        ( 'm', 0                                )
        :tall                       ( 50                                    )

        /*
        *   no loadout > lbl
        */

        self.no_lo_msg              = ui.new( 'lbl', self.noloadout         )
        :fill                       ( 'm', 0, 0, 0, 0                       )
        :textadv                    ( self.clr_txt_noload, pref( 'sel_tab_lo_none' ), ln( 'lo_none' ) )
        :align                      ( 5                                     )

        return
    end

    /*
    *   loop > loadout table
    */

    for i, v in helper.get.sorted_k( sorted, ipairs ) do

        /*
        *   item > loadout > declare
        */

        local mdl                   = v.mdl
        local name                  = v.name
        local desc                  = v.desc
        local fov                   = v.fov

        /*
        *   item > loadout > ct
        */

        self.sel                    = ui.new( 'btn', self.scr               )
        :bsetup                     (                                       )
        :top                        ( 'm', 0, 0, 0, 1                       )
        :tall                       ( 45                                    )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w - 7, h, self.clr_box_n )
                                    end )

        /*
        *   item > loadout > left
        */

        self.sel.l                  = ui.new( self:GetAnimated( ) and 'mdl' or 'mdl_img', self.sel )
        :left                       ( 'm', 0, 0, 0, 0                       )
        :wide                       ( 45                                    )
        :mdl                        ( mdl                                   )
        :allowmouse                 ( true                                  )
        :mdl_auto                   (                                       )
        :norotate                   (                                       )
        :savedraw                   (                                       )

                                    :draw( function( s, w, h )
                                        if self:GetAnimated( ) then
                                            s.OldPaint( s, w, h )
                                        end
                                        design.box( 0, 0, w, h, self.clr_box_side )
                                    end )

        /*
        *   item > loadout > mdl
        */

        self.sel.mdl                = ui.new( 'mdl', self.sel.l             )
        :fill                       ( 'm', 6, 0, 0, 0                       )
        :mdl                        ( mdl                                   )
        :allowmouse                 ( true                                  )
        :mdl_auto                   ( fov                                   )
        :norotate                   (                                       )

        /*
        *   item > loadout > name
        */

        self.sel.desc               = ui.new( 'btn', self.sel, 1            )
        :bsetup                     (                                       )
        :fill                       ( 'm', 0, 0, 0, 0                       )
        :setupanim                  ( 'OnHoverFill', 7, rlib.i.OnHover      )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            self:HoverFill( s, w + 4, h, self.clr_box_h )
                                            draw.SimpleText( desc, pref( 'elm_lo_item_desc' ), 10, h / 2, self.clr_txt_desc, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        else
                                            draw.SimpleText( name, pref( 'elm_lo_item_name' ), 10, h / 2, self.clr_txt_desc, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        end
                                    end )

    end
end

/*
*   GetAnimated
*/

function PANEL:GetAnimated( )
    return ( ( self.anim_mdl == 1 or tostring( self.anim_mdl ) == 'true' ) and true ) or false
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
        design.box( 0, 0, w - 10, h, clr )
        return
    end

    local x, y, fw, fh = 0, 0, math.Round( w * s.OnHoverFill ), h
    design.box( x, y, fw - 10, fh, clr )
end

/*
*   _Declare
*/

function PANEL:_Declare( )

    /*
    *	declare > configs
    */

    self.cf_lo                      = cfg.loadout

    /*
    *	declare > plugins
    */

    self.bLevelEnabled              = level:bEnabled( )
    self.bPrestEnabled              = prestige:bEnabled( )
    self.anim_mdl                   = false

end

/*
*   _Colorize
*/

function PANEL:_Colorize( )
    self.clr_txt_desc               = self.cf_lo.general.clrs.txt_desc
    self.clr_txt_noload             = self.cf_lo.general.clrs.txt_noload
    self.clr_box_n                  = self.cf_lo.general.clrs.box_n
    self.clr_box_h                  = self.cf_lo.general.clrs.box_h
    self.clr_box_side               = self.cf_lo.general.clrs.box_side
end

/*
*   register
*/

ui:create( mod, 'elm_sel_tab_loadout', PANEL, 'pnl' )