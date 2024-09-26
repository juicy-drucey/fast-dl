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
local helper                = base.h
local access                = base.a
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
local handle                = mod.handle

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

    /*
    *	scroll
    */

    self.scr                        = ui.new( 'rlib.elm.sp.v2', self        )
    :fill                           (                                       )
    :param                          ( 'SetbElastic', true                   )
    :param                          ( 'SetAlwaysVisible', true              )

end

/*
*   GetAnimated
*/

function PANEL:GetAnimated( )
    return ( ( self.anim_mdl == 1 or tostring( self.anim_mdl ) == 'true' ) and true ) or false
end

/*
*   type > set
*/

function PANEL:SetType( tbl, bClear )
    if bClear then
        self.scr:Clear( )
    end

    /*
    *   declare > data table
    */

    local params                    = table.Copy( tbl )

    /*
    *   sort > data table
    */


    /*
    *   item > parent
    */

    self.sel                        = ui.new( 'pnl', self.scr, 1            )
    :fill                           ( 'm', 0, 0, 0, 0                       )

    /*
    *   item > loop
    */

    for k, v in helper.get.table( params, SortedPairs ) do

        /*
        *   item > loop > skips
        */

        if type( v ) == 'table' and not IsColor( v ) then continue end
        if k == 'key' or k == 'default' then continue end

        /*
        *   item > loop > translate functions
        */

        if ( k == 'customCheck' or k == 'CustomCheckFailMsg' ) and isfunction( v ) then
            v = 'yes'
        end

        if tostring( v ) == 'false' then v = ln( 'sel_tab_debug_item_false' ) end
        if tostring( v ) == 'true' then v = ln( 'sel_tab_debug_item_true' ) end

        /*
        *   val > PlayerSpawn
        */

        if ( k == 'PlayerSpawn' ) and isfunction( v ) then
            v = 'Exists'
        end

        /*
        *   val > getMax
        *
        *   >   remove newlines
        *   >   remove everything before colon in language str
        *   >   trim spaces
        */

        if ( k == 'pay' ) then
            local str   = v:gsub( '[\n\r]', '' )
            str         = str:gsub( ".*:", '' )
            str         = str:Trim( )
            v           = str
        end

        /*
        *   val > needJob
        *
        *   >   remove newlines
        *   >   remove everything before colon in language str
        *   >   trim spaces
        */

        if k == 'needJob' then
            local str   = v:gsub( '[\n\r]', '' )
            str         = str:gsub( ".*:", '' )
            str         = str:Trim( )

            if not helper.str:ok( str ) then
                str     = ln( 'sel_tab_debug_item_none' )
            end

            v           = str
        end

        /*
        *   val > needGrp
        *
        *   >   remove newlines
        *   >   remove everything before colon in language str
        *   >   trim spaces
        */

        if k == 'needGrp' then
            local str   = v:gsub( '[\n\r]', '' )
            str         = str:gsub( ".*:", '' )
            str         = str:Trim( )

            if not helper.str:ok( str ) then
                str     = ln( 'sel_tab_debug_item_none' )
            end

            v           = str
        end

        /*
        *   val > color
        */

        local bColor = false
        if ( k == 'color' ) or ( k == 'clr' ) then
            bColor = v
        end

        /*
        *   item > values
        */

        local key                   = helper.str:truncate( tostring( k ), 20 )
        local val                   = helper.str:truncate( tostring( v ), 36 )
        val                         = val:gsub( '\n', '' )
        val                         = val:gsub( '\r', '' )

        local clr_box_ol            = Color( 255, 255, 255, 10 )
        local clr_box               = ( isbool( bColor ) and Color( 0, 0, 0, 0 ) ) or bColor
        v                           = string.format( 'Color( %i, %i, %i, %i )', clr_box.r, clr_box.g, clr_box.b, clr_box.a )

        /*
        *   item > parent
        */

        local item                  = ui.new( 'btn', self.scr               )
        :bsetup                     (                                       )
        :top                        ( 'm', 0, 0, 0, 0                       )
        :tall                       ( 24                                    )
        :tip                        ( ln( 'sel_tab_debug_item_btn_copy' )   )
        :setupanim                  ( 'OnHoverFill', 7, rlib.i.OnHover      )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            self:HoverFill( s, w, h, Color( 35, 35, 35, 255 ) )
                                        end

                                        local pos_w = ( bColor and 55 ) or 25
                                        draw.SimpleText( key, pref( 'sel_debug_name' ), 10, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( val, pref( 'sel_debug_value' ), w - pos_w, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

                                    :orc( function( s )
                                        if not handle:GetAccessSAdmin( 'arivia_sa_tools' ) then return end
                                        SetClipboardText    ( v )
                                    end )

        /*
        *   item > spacer
        */

        local spcr                  = ui.new( 'btn', self.scr               )
        :bsetup                     (                                       )
        :top                        ( 'm', 0, 0, 0, 0                       )
        :tall                       ( 1                                     )
        :setupanim                  ( 'OnHoverFill', 7, rlib.i.OnHover      )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w - 10, h, self.clr_sep )
                                    end )

        /*
        *   item > rgba
        */

        local rgba                  = ui.new( 'btn', item                   )
        :bsetup                     (                                       )
        :right                      ( 'm', 3, 3, 22, 3                      )
        :wide                       ( 21                                    )
        :state                      ( bColor and true or false              )
        :tip                        ( ln( 'sel_tab_debug_item_btn_copyclr' ) )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, clr_box_ol )
                                        design.rbox( 5, 1, 1, w - 2, h - 2, bColor )
                                        if s.hover then
                                            design.rbox( 5, 1, 1, w - 2, h - 2, Color( 0, 0, 0, 100 ) )
                                        end
                                    end )

                                    :orc( function( s )
                                        if not handle:GetAccessSAdmin( 'arivia_sa_tools' ) then return end
                                        SetClipboardText    ( v )
                                    end )

    end

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
    design.box( x, y, fw - 10, fh, clr )
end

/*
*   paint
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
    *	declare > configs
    */

    self.cf_u                       = cfg.ui

    /*
    *	declare > plugins
    */

    self.bLevelEnabled              = level:bEnabled( )
    self.bPrestEnabled              = prestige:bEnabled( )
    self.anim_mdl                   = false

    /*
    *	declare > clrs
    */

    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_def_txt                = self.cf_u.main.clrs.dt_txt

end

/*
*   register
*/

ui:create( mod, 'elm_sel_tab_dev_jobs', PANEL, 'pnl' )