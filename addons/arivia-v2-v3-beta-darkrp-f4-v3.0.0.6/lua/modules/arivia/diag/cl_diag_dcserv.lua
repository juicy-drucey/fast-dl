/*
*   @package        : rcore
*   @module         : lunera
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
*   panel
*/

local PANEL = { }

/*
*   accessorfunc
*/

AccessorFunc( PANEL, 'm_bDraggable', 'Draggable', FORCE_BOOL )

/*
*   initialize
*/

function PANEL:Init( )

    /*
    *   parent pnl
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :padding                        ( 2, 34, 2, 3                           )
    :shadow                         ( true                                  )
    :sz                             ( self.w, self.h                        )
    :wmin                           ( self.w * 0.85                         )
    :hmin                           ( self.h * 0.85                         )
    :popup                          (                                       )
    :notitle                        (                                       )
    :canresize                      ( false                                 )
    :showclose                      ( false                                 )
    :scrlock                        ( true                                  )

    /*
    *   display parent
    */

    ui.anim_fadein                  ( self, 0.2, 0                          )

    /*
    *   titlebar
    *
    *   to overwrite existing properties from the skin; do not change this
    *   labels name to anything other than lblTitle otherwise it wont
    *   inherit position/size properties
    */

    self.lblTitle                   = ui.new( 'lbl', self                   )
    :notext                         (                                       )
    :font                           ( pref( 'diag_dc_hdr_name' )            )
    :clr                            ( self.cf_d.clrs.header_txt             )

                                    :draw( function( s, w, h )
                                        design.lng( pf, helper.get:utf8( 'title' ), 'diag_dc_hdr_icon', 0, 8, self.cf_d.clrs.header_ico, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        design.lng( pf, self:GetLabel( ), 'diag_dc_hdr_name', 25, h / 2, self.cf_d.clrs.header_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   close button
    *
    *   to overwrite existing properties from the skin; do not change this
    *   buttons name to anything other than btnClose otherwise it wont
    *   inherit position/size properties
    */

    self.btnClose                   = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :tooltip                        ( ln( 'tt_close_window' )               )

                                    :draw( function( s, w, h )
                                        local clr_txt = s.hover and self.cf_d.clrs.btn_exit_h or self.cf_d.clrs.btn_exit_n
                                        design.lng( pf, helper.get:utf8( 'close' ), 'diag_dc_hdr_exit', w / 2 - 5, h / 2 + 4, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        ui:destroy( self )
                                    end )

    /*
    *   pnl > sub
    */

    self.p_sub                      = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 10, 0                         )

    /*
    *   pnl > body
    */

    self.p_body                     = ui.new( 'pnl', self.p_sub, 1          )
    :fill                           ( 'm', 5                                )

    /*
    *   dtxt > connect desc
    */

    self.dt_desc                    = ui.new( 'dt', self.p_body             )
    :top                            ( 'p', 3                                )
    :tall                           ( 90                                    )
    :drawbg                         ( false                                 )
    :mline                          ( true                                  )
    :lbllock                        (                                       )
    :font                           ( pref( 'diag_dc_btn_desc' )            )
    :txt                            ( ln( 'diag_dc_btn_msg' )               )
    :drawentry                      ( self.cf_d.clrs.txt_default, self.cf_d.clrs.cur_default, self.cf_d.clrs.hli_default )

    /*
    *   pnl > btn > sub
    */

    self.p_btn_sub                  = ui.new( 'pnl', self.p_body            )
    :bottom                         ( 'p', 33, 3                            )
    :tall                           ( 33                                    )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.footer_box )
                                        design.lng( pf, utf8.char( 10045 ), 'diag_dc_ftr_icon', 3, h / 2 - 1, self.cf_d.clrs.ico_bullet, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   pnl > btn > sub > spacer
    */

    self.p_btn_sub_sp               = ui.new( 'pnl', self.p_btn_sub, 1      )
    :right                          ( 'p', 1                                )
    :wide                           ( 100                                   )

    /*
    *   dtxt > disconnect warning
    */

    self.dt_msg                     = ui.new( 'dt', self.p_btn_sub          )
    :fill                           ( 'p', 0                                )
    :drawbg                         ( false                                 )
    :mline                          ( false                                 )
    :lbllock                        (                                       )
    :txt                            ( self.ln_dt_def, self.cf_d.clrs.txt_default, pref( 'diag_dc_btn_msg' ) )

                                    :draw( function( s, w, h )
                                        s:SetCursorColor    ( self.cf_d.clrs.cur_default )
                                        s:SetHighlightColor ( self.cf_d.clrs.hli_default )

                                        local clr_txt = self.cf_d.clrs.txt_default
                                        if s:GetValue( ) == self.ln_dt_def then
                                            clr_txt = Color( 150, 150, 150, self.Alpha )
                                        end

                                        s:DrawTextEntryText( clr_txt, s:GetHighlightColor( ), s:GetCursorColor( ) )
                                    end )

                                    :focuschg( function( s, bFocus )
                                        local val = string.Trim( s:GetValue( ) )
                                        if bFocus then
                                            if val == self.ln_dt_def then
                                                s:SetText( '' )
                                            end
                                        else
                                            if val == '' or not val then
                                                s:SetText( self.ln_dt_def )
                                            end
                                        end
                                    end )

    /*
    *   btn > dc > stay on server
    */

    self.b_dc_act_stay              = ui.new( 'btn', self.p_btn_sub_sp      )
    :bsetup                         (                                       )
    :right                          ( 'm', 0                                )
    :notext                         (                                       )
    :wide                           ( 28                                    )
    :tip                            ( ln( 'diag_dc_btn_tip_stay' )          )
    :ocr                            ( self                                  )

                                    :draw( function( s, w, h )
                                        local clr_a     = math.abs( math.sin( CurTime( ) * 4 ) * 255 )
                                        clr_a	        = math.Clamp( clr_a, 100, 255 )

                                        local clr_box   = ColorAlpha( self.cf_d.clrs.opt_no_btn_n, clr_a )

                                        design.rbox( 6, 0, 0, w, h, clr_box )

                                        if s.hover then
                                            design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.opt_no_btn_h )
                                        end

                                        design.lng( pf, utf8.char( 10799 ), 'diag_dc_btn_x', w / 2, 6, self.cf_d.clrs.opt_ok_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                                        if self.conn_disabled then
                                            s:SetCursor( 'no' )
                                            design.rbox( 6, 0, 0, w, h, Color( 15, 15, 15, 100 ) )
                                        end
                                    end )

    /*
    *   btn > dc > leave server
    */

    self.b_dc_act_leave             = ui.new( 'btn', self.p_btn_sub_sp      )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 0, 5, 0                       )
    :notext                         (                                       )
    :wide                           ( 28                                    )
    :tip                            ( ln( 'diag_dc_btn_tip_leave' )         )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.opt_ok_btn_n )
                                        if s.hover then
                                            design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.opt_ok_btn_h )
                                        end
                                        design.lng( pf, helper.get:utf8( 'check' ), 'diag_dc_btn_confirm', w / 2, h / 2, self.cf_d.clrs.opt_no_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        base:log( 1, '\n\n---------------------------\n ' .. ln( 'diag_dc_con_resp_l1' ) .. '\n---------------------------\n\n' .. ln( 'diag_dc_con_resp_l2' ) .. '\n\n    ' .. game.GetIPAddress( ) .. '\n\n' )
                                        timex.simple( 0.1, function( )
                                            rcc.run.gmod( 'disconnect' )
                                        end )
                                    end )

end

/*
*   GetLabel
*
*   @return : str
*/

function PANEL:GetLabel( )
    return helper.str:ok( self.label ) and self.label or ln( 'diag_dc_btn_title' )
end

/*
*   SetLabel
*
*   @param  : str title
*/

function PANEL:SetLabel( title )
    self.lblTitle:SetText( '' )
    self.label = title
end

/*
*   Think
*/

function PANEL:Think( )
    self.BaseClass.Think( self )

    self:MoveToFront( )

    local mousex        = math.Clamp( gui.MouseX( ), 1, ScrW( ) - 1 )
    local mousey        = math.Clamp( gui.MouseY( ), 1, ScrH( ) - 1 )

    if self.Dragging then
        local x         = mousex - self.Dragging[ 1 ]
        local y         = mousey - self.Dragging[ 2 ]

        if self:GetScreenLock( ) then
            x           = math.Clamp( x, 0, ScrW( ) - self:GetWide( ) )
            y           = math.Clamp( y, 0, ScrH( ) - self:GetTall( ) )
        end

        self:SetPos     ( x, y )
    end

    if self.Sizing then
        local x         = mousex - self.Sizing[ 1 ]
        local y         = mousey - self.Sizing[ 2 ]
        local px, py    = self:GetPos( )

        if ( x < self.m_iMinWidth ) then x = self.m_iMinWidth elseif ( x > ScrW( ) - px and self:GetScreenLock( ) ) then x = ScrW( ) - px end
        if ( y < self.m_iMinHeight ) then y = self.m_iMinHeight elseif ( y > ScrH( ) - py and self:GetScreenLock( ) ) then y = ScrH( ) - py end

        self:SetSize    ( x, y )
        self:SetCursor  ( 'sizenwse' )
        return
    end

    if ( self.Hovered and self.m_bSizable and mousex > ( self.x + self:GetWide( ) - 20 ) and mousey > ( self.y + self:GetTall( ) - 20 ) ) then
        self:SetCursor  ( 'sizenwse' )
        return
    end

    if ( self.Hovered and self:GetDraggable( ) and mousey < ( self.y + 24 ) ) then
        self:SetCursor  ( 'sizeall' )
        return
    end

    self:SetCursor      ( 'arrow' )

    if self.y < 0 then self:SetPos( self.x, 0 ) end

end

/*
*   OnMousePressed
*/

function PANEL:OnMousePressed( )
    if ( self.m_bSizable and gui.MouseX( ) > ( self.x + self:GetWide( ) - 20 ) and gui.MouseY( ) > ( self.y + self:GetTall( ) - 20 ) ) then
        self.Sizing =
        {
            gui.MouseX( ) - self:GetWide( ),
            gui.MouseY( ) - self:GetTall( )
        }
        self:MouseCapture( true )
        return
    end

    if ( self:GetDraggable( ) and gui.MouseY( ) < ( self.y + 24 ) ) then
        self.Dragging =
        {
            gui.MouseX( ) - self.x,
            gui.MouseY( ) - self.y
        }
        self:MouseCapture( true )
        return
    end
end

/*
*   OnMouseReleased
*/

function PANEL:OnMouseReleased( )
    self.Dragging = nil
    self.Sizing = nil
    self:MouseCapture( false )
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )
    local titlePush = 0
    self.BaseClass.PerformLayout( self )

    self.lblTitle:SetPos( 11 + titlePush, 7 )
    self.lblTitle:SetSize( self:GetWide( ) - 25 - titlePush, 20 )
end

/*
*   Paint
*/

function PANEL:Paint( w, h )
    design.rbox( 4, 0, 0, w, h, self.cf_d.clrs.shadow_box )
    design.rbox( 4, 2, 2, w - 4, h - 4, self.cf_d.clrs.body_box )
    design.rbox_adv( 4, 4, 4, w - 8, 34 - 8, self.cf_d.clrs.header_box, true, true, false, false )
end

/*
*   ActionHide
*/

function PANEL:ActionHide( )
    self.is_visible = false
    self:SetState( )
end

/*
*   ActionShow
*/

function PANEL:ActionShow( )
    self.is_visible = true
    self:SetState( )
    self:SetMouseInputEnabled( true )
    self:SetKeyboardInputEnabled( true )
end

/*
*   SetState
*/

function PANEL:SetState( )
    self.Alpha = self.is_visible and 255 or 0
    if IsValid( self.btnClose ) then self.btnClose:SetAlpha( self.Alpha ) end
end

/*
*   Destroy
*/

function PANEL:Destroy( )
    ui:destroy( self, true, true )
end

/*
*   SetVisible
*
*   @param  : bool bVisible
*/

function PANEL:SetVisible( bVisible )
    if bVisible then
        ui:show( self, true )
    else
        ui:hide( self, true )
    end
end

/*
*   _Declare
*/

function PANEL:_Declare( )

    /*
    *   declare > configs
    */

    self.cf_d                       = cfg.dialogs

    /*
    *   declare > sizing
    */

    self.w, self.h                  = 420, 185

    /*
    *   declare > misc
    */

    self.Alpha                      = 255
    self.is_visible                 = true
    self.allow_resize               = false
    self.conn_disabled              = false
    self.clipb_data                 = { }
    self.clipb_delay                = 0
    self.ln_dt_def                  = ln( 'diag_dc_btn_sub' )

end

/*
*   create
*/

ui:create( mod, 'diag_dcserv', PANEL )