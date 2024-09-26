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
    :font                           ( pref( 'diag_setjob_label' )           )
    :clr                            ( self.cf_d.clrs.header_txt             )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( helper.get:utf8( 'title' ), pref( 'diag_setjob_icon' ), 0, 8, self.cf_d.clrs.header_ico, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self:GetLabel( ), pref( 'diag_setjob_label' ), 25, h / 2, self.cf_d.clrs.header_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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
    :ocfo                           ( self, 0.2                             )

                                    :draw( function( s, w, h )
                                        local clr_txt = s.hover and self.cf_d.clrs.btn_exit_h or self.cf_d.clrs.btn_exit_n
                                        draw.SimpleText( helper.get:utf8( 'close' ), pref( 'diag_setjob_exit' ), w / 2, h / 2 + 5, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   pnl > sub
    */

    self.p_sub                      = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 20, 0                         )

    /*
    *   pnl > error container
    */

    self.p_err_parent               = ui.new( 'pnl', self.p_sub, 1          )
    :top                            ( 'm', 4, 0, 4, 10                      )
    :hide                           (                                       )

    /*
    *   pnl > body
    */

    self.p_body                     = ui.new( 'pnl', self.p_sub, 1          )
    :fill                           ( 'm', 5, 0, 5, 0                       )

    /*
    *   pnl > bottom (footer)
    */

    self.p_btm                      = ui.new( 'pnl', self.p_sub, 1          )
    :bottom                         ( 'm', 10, 0, 10, 0                     )
    :tall                           ( 4                                     )

    /*
    *   pnl > error subcontainer
    */

    self.p_err_sub                  = ui.new( 'pnl', self.p_err_parent      )
    :fill                           ( 'm', 4, 0, 4, 0                       )
    :tall                           ( 20                                    )
    :rbox                           ( self.cf_d.clrs.errors_box, 4          )

    /*
    *   label > error msg
    */

    self.l_err                      = ui.new( 'lbl', self.p_err_sub         )
    :notext                         (                                       )
    :fill                           ( 'm', 3, 3, 0, 3                       )
    :txt                            ( '', self.cf_d.clrs.errors_txt, pref( 'diag_setjob_err' ), false, 5 )

    /*
    *   dtxt > desc
    */

    self.dt_desc                    = ui.new( 'dt', self.p_body             )
    :notext                         (                                       )
    :top                            ( 'p', 3                                )
    :tall                           ( 90                                    )
    :drawbg                         ( false                                 )
    :mline                          ( true                                  )
    :lbllock                        (                                       )
    :font                           ( pref( 'diag_setjob_desc' )            )
    :drawentry                      ( self.cf_d.clrs.txt_default, self.cf_d.clrs.cur_default, self.cf_d.clrs.hli_default )

    /*
    *   footer > main
    */

    self.ct_footer                  = ui.new( 'pnl', self.p_body            )
    :bottom                         ( 'p', 30, 3                            )
    :tall                           ( 32                                    )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.footer_box )
                                        draw.SimpleText( helper.get:utf8( 'dtxt' ), pref( 'diag_setjob_ftr_icon' ), 4, 15, self.cf_d.clrs.icon_bullet, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   footer > spacer
    */

    self.ct_footer_sp               = ui.new( 'pnl', self.ct_footer, 1      )
    :right                          ( 'm', 0                                )
    :sz                             ( 100, 18                               )

    /*
    *   footer > dtxt
    */

    self.dt_footer                  = ui.new( 'dt', self.ct_footer          )
    :fill                           ( 'p', 0                                )
    :drawbg                         ( false                                 )
    :mline                          ( false                                 )
    :lbllock                        (                                       )
    :txt                            ( self.dt_default, self.cf_d.clrs.txt_default, pref( 'diag_setjob_ftr_text' ) )

    /*
    *   footer > btn > deny
    */

    self.b_deny                     = ui.new( 'btn', self.ct_footer_sp      )
    :bsetup                         (                                       )
    :right                          ( 'm', 0                                )
    :notext                         (                                       )
    :wide                           ( 28                                    )
    :tip                            ( ln( 'diag_setjob_btn_no' )            )
    :ocfo                           ( self, 0.2                             )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.opt_no_btn_n )
                                        if s.hover then
                                            design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.opt_no_btn_h )
                                        end
                                        draw.SimpleText( helper.get:utf8( 'x' ), pref( 'diag_setjob_btn_n' ), w / 2 - 1, 6, self.cf_d.clrs.opt_no_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   footer > btn > agree
    */

    self.b_agree                    = ui.new( 'btn', self.ct_footer_sp      )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 0, 5, 0                       )
    :notext                         (                                       )
    :wide                           ( 28                                    )
    :tip                            ( ln( 'diag_setjob_btn_yes' )           )

                                    :draw( function( s, w, h )
                                        local a         = math.abs( math.sin( CurTime( ) * 4 ) * 255 )
                                        a	            = math.Clamp( a, 100, 255 )

                                        local clr_box   = ColorAlpha( self.cf_d.clrs.opt_ok_btn_n, a )

                                        design.rbox( 6, 0, 0, w, h, clr_box )

                                        if s.hover then
                                            design.rbox( 6, 0, 0, w, h, self.cf_d.clrs.opt_ok_btn_h )
                                        end

                                        draw.SimpleText( helper.get:utf8( 'check' ), pref( 'diag_setjob_btn_y' ), w / 2, h / 2, self.cf_d.clrs.opt_ok_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        local cmd = ( self.job and ( self.job.cmd or self.job.command ) ) or 'citizen'
                                        rcc.run.rlib( 'arivia_setjob_cmd', self.ply:Name( ), cmd )

                                        self:Destroy( )
                                    end )

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

    self:SetCursor( 'arrow' )

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
    self.Dragging   = nil
    self.Sizing     = nil
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
*   ActionShow
*/

function PANEL:ActionShow( )
    self:SetMouseInputEnabled( true )
    self:SetKeyboardInputEnabled( true )
end

/*
*   GetLabel
*
*   @return : str
*/

function PANEL:GetLabel( )
    return ( helper.str:ok( self.label ) and self.label ) or ln( 'diag_setjob_name' )
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
*   SetJob
*
*   @param str str
*/

function PANEL:SetJob( job, pl )
    self.job = job
    self.ply = pl
    self.dt_desc:SetText( ln( 'diag_setjob_conf', pl:palias( ), job.label ) )
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

function PANEL:SetVisible( b )
    if b then
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

end

/*
*   _Lang
*/

function PANEL:_Lang( )
    self.dt_default                 = ln( 'diag_setjob_footer' )
end

/*
*   create
*/

ui:create( mod, 'diag_setjob', PANEL )