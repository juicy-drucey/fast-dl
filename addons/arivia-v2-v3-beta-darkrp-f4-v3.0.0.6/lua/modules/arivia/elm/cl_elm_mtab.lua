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
*	localized mat func
*/

local function mat( id )
    return mats:call( mod, id )
end

/*
*	panel
*/

local PANEL = { }

/*
*   AccessorFunc
*/

AccessorFunc( PANEL, 'navText',     'Text',     FORCE_STRING )
AccessorFunc( PANEL, 'navTip',      'Tip',      FORCE_STRING )
AccessorFunc( PANEL, 'navMat',      'Mat',      FORCE_STRING )
AccessorFunc( PANEL, 'navMatSel',   'MatSel',   FORCE_STRING )

/*
*	Init
*/

function PANEL:Init( )

    /*
    *	localized player
    */

    local pl                        = LocalPlayer( )
    local abs                       = math.abs
    local clp                       = math.Clamp
    local sin                       = math.sin
    local cal                       = ColorAlpha

    /*
    *	parent
    */

    self                            = ui.get( self                          )
    :fill                           ( 'm', 0                                )
    :setup                          (                                       )
    :nodraw                         (                                       )

    /*
    *	btn > nav
    */

    self.sub                        = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :fill                           ( 'm', 0, 0, 1, 0                       )
    :text                           ( self:GetText( )                       )
    :tip                            ( self:GetTip( )                        )
    :anim_click_ol                  ( Color( 255, 255, 255, 5 ), 0.4, 1, self.cf_d.bDisableAnim )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            design.box( 0, 0, w, h, self.clr_box_h )
                                        end

                                        self.clr_box_s      = self.cf_tabs_clr_box_s
                                        self.clr_ico_n      = self.cf_tabs_clr_ico_n

                                        if s.selected then
                                            local clr_a     = abs( sin( CurTime( ) * 4 ) * 255 )
                                            clr_a	        = clp( clr_a, 150, 255 )

                                            self.clr_ico_n  = cal( self.cf_tabs_clr_ico_s, clr_a )

                                            design.box( 0, 0, w, h, self.clr_box_s )
                                        end

                                        local m_ico_sel     = ( not helper.str:isempty( self:GetMatSel( ) ) and self:GetMatSel( ) ) or self:GetMat( )
                                        local m_ico         = ( s.selected and m_ico_sel ) or self:GetMat( )

                                        design.imat( ( w / 2 ) - ( self.ico_sz / 2 ), ( h / 2 ) - ( self.ico_sz / 2 ), self.ico_sz, self.ico_sz, mat( m_ico ), self.clr_ico_n )
                                    end )

                                    :oc( function( s )
                                        /*
                                        *	clear nav tabs selection
                                        */

                                        for b in helper.get.data( mod.tabs.n ) do
                                            b.selected = false
                                        end

                                        /*
                                        *	clear mini tabs selection
                                        */

                                        for b in helper.get.data( mod.tabs.m ) do
                                            b.selected = false
                                        end

                                        /*
                                        *	click action
                                        */

                                        local action = self:GetAction( )
                                        if not isfunction( action ) then return end

                                        action( )

                                        /*
                                        *	set selected
                                        */

                                        s.selected = true

                                        mod.tabs.n[ 1 ].selected = true
                                    end )

    /*
    *	register nav tab to ply
    */

    table.insert( mod.tabs.m, self.sub )

    /*
    *	set first nav tab selected
    */

    mod.tabs.m[ 1 ].selected = true

end

/*
*	think
*/

function PANEL:Think( )

    /*
    *	bIsPopulated
    */

    if not self.bIsPopulated then
        self.sub                    = ui.get( self.sub                      )
        :tip                        ( self:GetTip( )                        )
    end

end

/*
*	action > get
*
*   @return : func
*/

function PANEL:GetAction( )
    return self.action
end

/*
*	action > set
*
*   @param  : func fn
*/

function PANEL:SetAction( fn )
    self.action = fn
end

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
    self.cf_d                       = cfg.dev

    /*
    *   declare > general
    */

    self.bIsPopulated               = false
    self.ico_sz                     = 20

end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Colorize( )

    /*
    *   declare > colors
    */

    self.cf_tabs_clr_ico_s          = self.cf_u.left.clrs.tabs_ico_s
    self.cf_tabs_clr_ico_n          = self.cf_u.left.clrs.tabs_ico_n
    self.cf_tabs_clr_box_s          = self.cf_u.left.clrs.tabs_box_s
    self.clr_box_h                  = Color( 0, 0, 0, 100 )

end

/*
*	register
*/

ui:create( mod, 'elm_mtab', PANEL, 'pnl' )