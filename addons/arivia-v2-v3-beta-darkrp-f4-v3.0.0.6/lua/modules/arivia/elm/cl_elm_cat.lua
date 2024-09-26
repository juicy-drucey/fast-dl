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
*	localized mat func
*/

local function mat( id )
    return mats:call( mod, id )
end

/*
*	localized funcs
*/

local handle                = mod.handle

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

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :tall                           ( 20                                    )

    /*
    *   btn > category > container
    */

    self.sub                        = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 32                                    )
    :notext                         (                                       )

                                    :oc( function( s )
                                        self:DoToggle( )
                                    end )

                                    :draw( function( s, w, h )
                                        local clr_box, clr_txt, clr_gra = self:GetHeaderBox( ), self:GetHeaderTxt( ), self:GetHeaderGra( )
                                        local clr_header    = s.hover and self.cf_clr_box_h or clr_box
                                        local clr_grad      = self:bFavorite( ) and self:GetHeaderFav( ) or clr_gra

                                        design.box( 0, 0, w, h - 3, clr_header )

                                        local w_sz, h_sz = w, h
                                        draw.TexturedQuad( { texture = surface.GetTextureID( self.m_grad_lf ), color = clr_grad, x = 3, y = 3 + h_sz * 0.00, w = w_sz, h = h_sz * 1 - 6 } )

                                        if self.cfg_cat_mat.enabled then
                                            design.imat( 0, 0, w, h * self.cfg_cat_mat.oset_h, self.m_hlines, self.cfg_cat_mat.clr )
                                        end

                                        draw.SimpleText( self.Title, pref( 'elm_cat_btn_name' ), 10, h / 2, clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   btn > expand
    */

    self.expand                     = ui.new( 'btn', self.sub               )
    :bsetup                         (                                       )
    :right                          ( 'm', 0                                )
    :size                           ( 22, 32                                )
    :notext                         (                                       )

                                    :draw( function( s, w, h )
                                        local pulse_a	    = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                        pulse_a			    = math.Clamp( pulse_a, 100, 255 )

                                        local clr_ico       = s.hover and Color( 222, 161, 31, pulse_a ) or not self.bToggled and Color( 137, 60, 60, 255 ) or Color( 83, 134, 207, 255 )
                                        draw.SimpleText( utf8.char( 9642 ), pref( 'elm_cat_btn_expand' ), w - 15, h / 2 - 1, clr_ico, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

                                    :logic( function( s )
                                        s:tip( self.bToggled and ln( 'tt_cats_collapse' ) or ln( 'tt_cats_expand' ) )
                                    end )

                                    :oc( function( s )
                                        self:DoToggle( )
                                    end )

    /*
    *   btn > tips
    */

    self.tips                       = ui.new( 'btn', self.sub               )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 0, 5, 0                       )
    :wide                           ( 27                                    )
    :notext                         (                                       )

                                    :draw( function( s, w, h )
                                        if not self:ShowSATips( ) then return end

                                        local pulse_a	    = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                        pulse_a			    = math.Clamp( pulse_a, 100, 255 )

                                        local clr_ico       = s.hover and Color( 222, 161, 31, pulse_a ) or Color( 255, 255, 255, 30 )

                                        design.imat( ( w / 2 ) - ( self.btn_tip_sz / 2 ), ( h / 2 ) - ( self.btn_tip_sz / 2 ), self.btn_tip_sz, self.btn_tip_sz, self.m_bell, clr_ico )
                                    end )

                                    :logic( function( s )
                                        s:tip( self:ShowSATips( ) and ln( 'tt_cats_admin_hotkeys' ) or nil )
                                    end )

                                    :oc( function( s )
                                        if not self:ShowSATips( ) then return end
                                        local tip = cfg.dev.sadmin_tips[ self.cat ]
                                        design:bubble( tip, 7 )
                                    end )

    /*
    *   timer > category expansion states
    */

    timex.simple( 'arivia_cl_cat_setup', 0.03, function( )
        if not ui:ok( self ) then return end

        if self.expanded == 0 or not self.expanded then
            self:ToggleClosed( )
        else
            self:ToggleOpened( )
        end

        local cat = self:GetCategoryID( )
        if mod.history.jobs:Registered( cat ) then
            local cat_state = mod.history.jobs:GetState( cat )
            if cat_state == '0' then
                self:ToggleClosed( )
            elseif cat_state == '1' then
                self:ToggleOpened( )
            end
        end

        self.bInitialized = true
    end )

end

/*
*   bFavorite
*
*   @return : bool
*/

function PANEL:bFavorite( )
    return ( self.Title:lower( ) == ln( 'mem_cat_favs' ):lower( ) and true ) or false
end

/*
*   show superadmin tips
*
*   determines if a player should see superadmin tips
*
*   @return : bool
*/

function PANEL:ShowSATips( )
    return self:GetTipCat( ) and handle:GetAccessSAdmin( 'arivia_sa_tools' ) and true or false
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h )
    design.box( 0, 0, w, h, self:GetBodyColor( ) )
end

/*
*   AddSlot
*
*   @param  : pnl pnl
*/

function PANEL:AddSlot( pnl )
    if not IsValid( pnl ) then return end
    table.insert( self.children, pnl )

    self.list:PerformLayout( )
end

/*
*   SetupChildren
*/

function PANEL:SetupChildren( )
    self:SetTall( 25 + self.list:GetTall( ) + self.oset_h )
end

/*
*   ToggleOpened
*/

function PANEL:ToggleOpened( )
    self.bToggled           = true
    local speed             = not self.bInitialized and 0 or cfg.dev.anim_cat_speed
    self:SizeTo             ( self:GetWide( ), 25 + self.list:GetTall( ) + self.oset_h, speed, 0.1 )
end

/*
*   ToggleClosed
*/

function PANEL:ToggleClosed( )
    self.bToggled           = false
    local speed             = not self.bInitialized and 0 or cfg.dev.anim_cat_speed
    self:SizeTo             ( self:GetWide( ), 31, speed, 0.1 )
end

/*
*   GetCategoryID
*
*   @return : str
*/

function PANEL:GetCategoryID( )
    local cat               = self.Title
    cat                     = helper.str:clean( cat )

    return cat
end

/*
*   DoToggle
*/

function PANEL:DoToggle( )
    local cat = self:GetCategoryID( )

    if self.bToggled then
        self:ToggleClosed( )
        mod.history.jobs:WriteExpanded( cat, self, '0' )
    else
        self:ToggleOpened( )
        mod.history.jobs:WriteExpanded( cat, self, '1' )
    end
end

/*
*   SetBodyColor
*
*   @param  : clr clr
*/

function PANEL:SetBodyColor( clr )
    self.clr_body = clr
end

/*
*   GetBodyColor
*
*   @return : clr
*/

function PANEL:GetBodyColor( )
    return self.clr_body or self.cf_clr_box_n
end

/*
*   SetHeaderBox
*
*   @param  : clr clr
*/

function PANEL:SetHeaderBox( clr )
    self.clr_cat_box = clr
end

/*
*   GetHeaderBox
*
*   @return : clr
*/

function PANEL:GetHeaderBox( )
    return IsColor( self.clr_cat_box ) and self.clr_cat_box or self.cf_clr_box_n
end

/*
*   SetHeaderTxt
*
*   @param  : clr clr
*/

function PANEL:SetHeaderTxt( clr )
    self.clr_cat_txt = clr
end

/*
*   GetHeaderTxt
*
*   @return : clr
*/

function PANEL:GetHeaderTxt( )
    return IsColor( self.clr_cat_txt ) and self.clr_cat_txt or self.cf_clr_txt
end

/*
*   SetHeaderGra
*
*   @param  : clr clr
*/

function PANEL:SetHeaderGra( clr )
    self.clr_cat_gra = clr
end

/*
*   GetHeaderGra
*
*   @return : clr
*/

function PANEL:GetHeaderGra( )
    return IsColor( self.clr_cat_gra ) and self.clr_cat_gra or self.cf_clr_gradient
end

/*
*   SetHeaderFav
*
*   @param  : clr clr
*/

function PANEL:SetHeaderFav( clr )
    self.clr_cat_fav = clr
end

/*
*   GetHeaderFav
*
*   @return : clr
*/

function PANEL:GetHeaderFav( )
    return IsColor( self.clr_cat_fav ) and self.clr_cat_fav or self.cf_clr_gradient
end

/*
*   HeaderTitle
*
*   @param  : str str
*/

function PANEL:HeaderTitle( str )
    self.Title = str
end

/*
*   SetExpanded
*
*   @param  : bool b
*/

function PANEL:SetExpanded( b )
    self.expanded = helper:val2bool( b )
end

/*
*   SetTipCat
*
*   @param  : str cat
*/

function PANEL:SetTipCat( cat )
    self.cat = cat
end

/*
*   GetTipCat
*
*   @return : str
*/

function PANEL:GetTipCat( )
    return self.cat
end

/*
*   SetTip
*
*   @param  : str cat
*/

function PANEL:SetTip( tip )
    self.tip = tip
end

/*
*   GetTip
*
*   @return : str
*/

function PANEL:GetTip( )
    return self.tip
end

/*
*   LoadTips
*
*   @return : str
*/

function PANEL:LoadTips( )
    if not ui:ok( self.sub ) then return end

    local tip       = self:GetTip( )
    local tip_data  = helper.str:ok( tip ) and tip or nil

    self.sub:tip( tip_data )
end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *   declare > colors
    */

    self.cf_clr_txt                 = Color( 255, 255, 255, 255 )           -- default ( not used unless missing )
    self.cf_clr_box_n               = Color( 15, 15, 15, 255 )              -- default ( not used unless missing )
    self.cf_clr_box_h               = Color( 5, 5, 5, 100 )                 -- default ( not used unless missing )
    self.cf_clr_gradient            = Color( 144, 49, 55, 255 )             -- default ( not used unless missing )
    self.cfg_cat_mat                = cfg.tabs.general.pattern.cats

    /*
    *   declare > general
    */

    self.children                   = { }
    self.cat                        = 'jobs'
    self.oset_h                     = 12
    self.bToggled                   = true
    self.bInitialized               = false
    self.btn_tip_sz                 = 14

    /*
    *   declare > materials
    */

    self.m_bell                     = mat( 'cat_tip_bell' )
    self.m_hlines                   = mat( self.cfg_cat_mat.material )
    self.m_grad_lf                  = helper._mat[ 'grad_l' ]

end

/*
*   _Colorize
*/

function PANEL:_Colorize( )

end

/*
*   _Call
*/

function PANEL:_Call( )

    /*
    *   delay > setup tips
    */

    timex.simple( 0.1, function( )
        if not ui:ok( self ) then return end
        self:LoadTips( )
    end )

end

/*
*   register
*/

ui:create( mod, 'category', PANEL, 'pnl' )