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
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return rlib.get:pref( str, state )
end

/*
*   meta :: pnl
*/

local pmeta = FindMetaTable( 'Panel' )

/*
*   meta :: CreateScrollbar
*/

function pmeta:CreateScrollbar( )
    self.Paint              = function( s, w, h ) end
    self:SetWide            ( 7                         )

    self.btnUp              = ui.get( self.btnUp, 1     )
    :tall                   ( 1                         )

    self.btnDown            = ui.get( self.btnDown, 1   )

    self.btnGrip.Paint      = function( s, w, h )
        design.rbox( 4, 2, 2, w - 4, h - 4, cfg.ui.main.clrs.sbar_i )
    end
end

/*
*   PANEL
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

    /*
    *   sbar :: btn :: up
    */

    self.btnUp                      = ui.new( 'btn', self                   )
    :notext                         (                                       )

                                    :oc( function( s )
                                        s:GetParent( ):AddScroll( -1 )
                                    end )

                                    :draw( function( s, w, h )
                                        derma.SkinHook( 'Paint', 'ButtonUp', s, w, h )
                                    end )

    /*
    *   sbar :: btn :: down
    */

    self.btnDown                    = ui.new( 'btn', self                   )
    :notext                         (                                       )

                                    :oc( function( s )
                                        s:GetParent( ):AddScroll( 1 )
                                    end )

                                    :draw( function( s, w, h )
                                        derma.SkinHook( 'Paint', 'ButtonDown', s, w, h )
                                    end )

    /*
    *   sbar :: btn :: grip
    */

    self.btnGrip                    = ui.new( 'grip', self                  )
    :sz                             ( 15                                    )

end

/*
*   SetEnabled
*/

function PANEL:SetEnabled( b )
    if not b then
        self.Offset         = 0
        self:SetScroll      ( 0 )
        self.HasChanged     = true
    end

    self:SetMouseInputEnabled( helper:val2bool( b ) )
    self:SetVisible( helper:val2bool( b ) )

    if ( self.Enabled ~= b ) then
        self.Content:InvalidateLayout( )
        if ( self.Content.OnScrollbarAppear ) then
            self.Content:OnScrollbarAppear( )
        end
    end

    self.Enabled = b
end

/*
*   Value
*/

function PANEL:Value( )
    return self.Pos
end

/*
*   BarScale
*/

function PANEL:BarScale( )
    if ( self.BarSize == 0 ) then return 1 end
    return self.BarSize / ( self.CanvasSize + self.BarSize )
end

/*
*   SetUp
*/

function PANEL:SetUp( bar_sz, can_sz )
    self.BarSize            = bar_sz
    self.CanvasSize         = math.max( can_sz - bar_sz, 1 )
    self:SetEnabled         ( can_sz > bar_sz )
    self:InvalidateLayout   ( )
end

/*
*   OnMouseWheeled
*/

function PANEL:OnMouseWheeled( dlta )
    if not self:IsVisible( ) then return false end
    return self:AddScroll( dlta * -2 )
end

/*
*   AddScroll
*/

function PANEL:AddScroll( dlta )
    local OldScroll         = self:GetScroll( )
    dlta                    = dlta * 25

    self:SetScroll          ( self:GetScroll( ) + dlta )

    return OldScroll ~= self:GetScroll( )
end

/*
*   SetScroll
*/

function PANEL:SetScroll( scrll )
    if not self.Enabled then self.Scroll = 0 return end
    self.Scroll = math.Clamp( scrll, 0, self.CanvasSize )
    self:InvalidateLayout( )

    local func = self.Content.OnVScroll
    if ( func ) then
        func( self.Content, self:GetOffset( ) )
    else
        self.Content:InvalidateLayout( )
    end
end

/*
*   AnimateTo
*/

function PANEL:AnimateTo( scrll, length, delay, ease )
    local anim              = self:NewAnimation( length, delay, ease )
    anim.StartPos           = self.Scroll
    anim.TargetPos          = scrll

    anim.Think = function( anim, pnl, fraction )
        pnl:SetScroll( Lerp( fraction, anim.StartPos, anim.TargetPos ) )
    end
end

/*
*   GetScroll
*
*   @return : pnl
*/

function PANEL:GetScroll( )
    if not self.Enabled then self.Scroll = 0 end
    return self.Scroll
end

/*
*   GetOffset
*
*   @return : int
*/

function PANEL:GetOffset( )
    if not self.Enabled then return 0 end
    return self.Scroll * -1
end

/*
*   Think
*/

function PANEL:Think( ) end

/*
*   Paint
*/

function PANEL:Paint( w, h )
    derma.SkinHook( 'Paint', 'VScrollBar', self, w, h )
    return true
end

/*
*   OnMousePressed
*/

function PANEL:OnMousePressed( )
    local x, y              = self:CursorPos( )
    local pg_sz             = self.BarSize

    if ( y > self.btnGrip.y ) then
        self:SetScroll      ( self:GetScroll( ) + pg_sz )
    else
        self:SetScroll      ( self:GetScroll( ) - pg_sz )
    end
end

/*
*   OnMouseReleased
*/

function PANEL:OnMouseReleased( )
    self.Dragging           = false
    self.DraggingCanvas     = nil
    self:MouseCapture       ( false )
    self.btnGrip.Depressed  = false
end

/*
*   OnCursorMoved
*/

function PANEL:OnCursorMoved( x, y )
    if not self.Enabled then return end
    if not self.Dragging then return end

    local x                 = 0
    local y                 = gui.MouseY( )
    local x, y              = self:ScreenToLocal( x, y )
    y                       = y - self.btnUp:GetTall( )
    y                       = y - self.HoldPos

    local trk_sz            = self:GetTall( ) - self:GetWide( ) * 2 - self.btnGrip:GetTall( )
    y                       = y / trk_sz

    self:SetScroll          ( y * self.CanvasSize )
end

/*
*   Grip
*/

function PANEL:Grip( )
    if not self.Enabled then return end
    if self.BarSize == 0 then return end

    self:MouseCapture       ( true )
    self.Dragging           = true

    local x, y              = 0, gui.MouseY( )
    local x, y              = self.btnGrip:ScreenToLocal( x, y )

    self.HoldPos            = y
    self.btnGrip.Depressed  = true
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )
    local w                 = self:GetWide( )
    local scr_sz            = self:GetScroll( ) / self.CanvasSize
    local bar_sz            = math.max( self:BarScale( ) * ( self:GetTall( ) ), 10 )
    local trk_sz            = self:GetTall( ) - ( w * 2 ) - bar_sz
    trk_sz                  = trk_sz + 1
    scr_sz                  = scr_sz * trk_sz

    self.btnGrip:SetPos     ( 0, w + scr_sz     )
    self.btnGrip:SetSize    ( w, bar_sz         )

    self.btnUp:SetPos       ( 0, 0, w, w        )
    self.btnUp:SetSize      ( w, w              )

    self.btnDown:SetPos     ( 0, self:GetTall( ) - w, w, w )
    self.btnDown:SetSize    ( w, w              )
end

/*
*   _Declare
*/

function PANEL:_Declare( )

    self.Offset                     = 0
    self.Scroll                     = 0
    self.CanvasSize                 = 1
    self.BarSize                    = 1

end

/*
*   register
*/

ui:create( mod, 'elm_sbar', PANEL, 'pnl' )