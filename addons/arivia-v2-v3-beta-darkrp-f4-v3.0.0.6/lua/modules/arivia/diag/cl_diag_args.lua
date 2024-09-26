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
*   initialize
*/

function PANEL:Init( )

    /*
    *   parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :shadow                         ( true                                  )
    :sz                             ( self.w, self.h                        )
    :wmin                           ( self.w * 0.85                         )
    :hmin                           ( self.h * 0.85                         )
    :padding                        ( 0, 34, 0, 0                           )
    :popup                          (                                       )
    :notitle                        (                                       )
    :canresize                      ( false                                 )
    :canclose                       ( false                                 )
    :scrlock                        ( true                                  )
    :appear                         ( 5, 0.2                                )

    /*
    *   titlebar
    *
    *   to overwrite existing properties from the skin; do not change this
    *   labels name to anything other than lblTitle otherwise it wont
    *   inherit position/size properties
    */

    self.lblTitle                   = ui.new( 'lbl', self                   )
    :notext                         (                                       )
    :font                           ( pref( 'cmds_args_hdr_name' )          )
    :clr                            ( cfg.dialogs.clrs.header_txt           )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( helper.get:utf8( 'title' ), pref( 'cmds_args_hdr_icon' ), 0, 8, cfg.dialogs.clrs.header_ico, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self:GetLabel( ), pref( 'cmds_args_hdr_name' ), 25, h / 2, cfg.dialogs.clrs.header_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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
    :ocr                            ( self                                  )

                                    :draw( function( s, w, h )
                                        local clr_txt = s.hover and cfg.dialogs.clrs.btn_exit_h or cfg.dialogs.clrs.btn_exit_n
                                        draw.SimpleText( helper.get:utf8( 'close' ), pref( 'cmds_args_hdr_exit' ), w / 2 - 6, h / 2 + 4, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   load
    */

    timex.simple( 0.1, function( s )
        if not ui:ok( self ) then return end
        self:Run( )
    end )

end

/*
*   Run
*/

function PANEL:Run( )

    /*
    *   pnl > sub
    */

    self.p_sub                      = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 10, 0                         )

    /*
    *   pnl > body
    */

    self.p_body                     = ui.new( 'pnl', self.p_sub, 1          )
    :fill                           ( 'm', 10, 5, 10, 5                     )

    /*
    *   args > define
    */

    local args                      = self.cmd and self.cmd.args or { }

    /*
    *   args > loop
    */

    local i_args = 0
    for k, v in pairs( args ) do

        /*
        *   args > define
        */

        local arg_name              = v.name or 'No name'
        local arg_default           = not isstring( v.default ) and tostring( v.default ) or v.default
        local arg_bChange           = ( tostring( v.bChange ) == 'true' or v.bChange == 1 and true ) or false

        /*
        *   args > parent container
        */

        local ct_arg                = ui.new( 'pnl', self.p_body, 1         )
        :top                        ( 'm', 4, 0, 0, 2                       )
        :tall                       ( 28                                    )

        /*
        *   args > name ( left )
        */

        local lbl_arg_name          = ui.new( 'lbl', ct_arg                 )
        :left                       ( 'm', 0, 0, 0, 0                       )
        :textadv                    ( Color( 255, 255, 255, 255 ), pref( 'cmds_args_arg_name' ), '' )
        :wide                       ( 100                                   )
        :align                      ( 6                                     )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( arg_name, pref( 'cmds_args_arg_name' ), w - 5, h / 2, cfg.dialogs.clrs.icon_bullet, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *   args > name ( left )
        */

        local lbl_spcr              = ui.new( 'lbl', ct_arg                 )
        :left                       ( 'm', 0, 0, 0, 0                       )
        :textadv                    ( Color( 255, 255, 255, 255 ), pref( 'cmds_args_arg_name' ), '' )
        :wide                       ( 15                                    )
        :align                      ( 6                                     )

        /*
        *   args > value ( right ) > container
        */

        local ct_arg_value          = ui.new( 'pnl', ct_arg                 )
        :fill                       ( 'm', 0, 0, 0, 0                       )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 30, 30, 30, 255 ) )
                                    end )

        /*
        *   args > value ( right ) > dt
        */

        local dt_arg_value          = ui.new( 'entry', ct_arg_value         )
        :fill                       ( 'm', 5, 0, 5, 0                       )
        :multiline                  ( false                                 )
        :drawbg                     ( false                                 )
        :enabled                    ( true                                  )
        :vsbar                      ( false                                 )
        :textadv                    ( Color( 255, 255, 255, 255 ), pref( 'cmds_args_arg_value' ), arg_default )

        /*
        *   args > register
        */

        table.insert( self.args, k, { name = arg_name, val = dt_arg_value, type = v.type, default = arg_default, bChange = arg_bChange } )

        /*
        *   args > count
        */

        i_args = i_args + 1

    end

    /*
    *   footer > container
    */

    self.ct_footer                  = ui.new( 'pnl', self.p_body            )
    :bottom                         ( 'p', 30, 3                            )
    :tall                           ( 32                                    )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 30, 30, 30, 255 ) )
                                        draw.SimpleText( helper.get:utf8( 'dtxt' ), pref( 'cmds_args_info_icon' ), 4, 15, cfg.dialogs.clrs.icon_bullet, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   footer > container > spacer
    */

    self.ct_footer_sp               = ui.new( 'pnl', self.ct_footer, 1      )
    :right                          ( 'm', 0                                )
    :sz                             ( 100, 18                               )

    /*
    *   footer > dt > confirm msg
    */

    local dt_default                = ln( 'cmds_args_diag_conf_dt' )

    self.dt_footer                  = ui.new( 'dt', self.ct_footer          )
    :fill                           ( 'p', 0                                )
    :drawbg                         ( false                                 )
    :mline                          ( false                                 )
    :lbllock                        (                                       )
    :txt                            ( dt_default, clr_text, pref( 'cmds_args_info_text' ) )

                                    :draw( function( s, w, h )
                                        s:SetCursorColor    ( clr_cur   )
                                        s:SetHighlightColor ( clr_hl    )

                                        local clr_txt = clr_text
                                        if s:GetValue( ) == dt_default then
                                            clr_txt = Color( 150, 150, 150, 255 )
                                        end

                                        s:DrawTextEntryText( clr_txt, s:GetHighlightColor( ), s:GetCursorColor( ) )
                                    end )

                                    :focuschg( function( s, bFocus )
                                        local value = string.Trim( s:GetValue( ) )
                                        if bFocus then
                                            if value == dt_default then
                                                s:SetText( '' )
                                            end
                                        else
                                            if ( value == '' or not value ) then
                                                s:SetText( dt_default )
                                            end
                                        end
                                    end )

    /*
    *   btn > confirm
    */

    self.b_confirm                  = ui.new( 'btn', self.ct_footer_sp      )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 0, 0, 0                       )
    :notext                         (                                       )
    :wide                           ( 28                                    )
    :tip                            ( ln( 'cmds_args_diag_conf_btn' )       )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 60, 120, 62, 255 ) )

                                        if s.hover then
                                            design.rbox( 6, 0, 0, w, h, Color( 15, 15, 15, 100 ) )
                                        end

                                        draw.SimpleText( helper.get:utf8( 'check' ), pref( 'cmds_args_btn_confirm' ), w / 2, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                                        if self.conn_disabled then
                                            s:SetCursor( 'no' )
                                            design.rbox( 6, 0, 0, w, h, Color( 15, 15, 15, 100 ) )
                                        end
                                    end )

                                    :oc( function( s )
                                        if not isfunction( self.cmd.action ) then
                                            design:bubble( ln( 'cmds_err_noaction' ), 5 )
                                            return
                                        end

                                        local data = { }
                                        for a, b in pairs( self.args ) do
                                            local val = b.val:GetValue( )

                                            if b.type == 'int' and not helper:bIsNum( val ) then
                                                design:bubble( ln( 'cmds_err_arg_isnum', b.name ), 5 )
                                                return
                                            end

                                            if b.bChange and helper.str:clean( val ) == helper.str:clean( b.default ) then
                                                design:bubble( ln( 'cmds_err_arg_isdef', b.name ), 5 )
                                                return
                                            end

                                            if not helper.str:ok( val ) then
                                                design:bubble( ln( 'cmds_err_arg_toofew', b.name ), 5 )
                                                return
                                            end

                                            table.insert( data, val )
                                        end

                                        local action = self.cmd.action( LocalPlayer( ), data )

                                        self:Destroy( )

                                        if cvar:GetInt( 'arivia_cmds_aclose', 0 ) == 1 then
                                            DarkRP.closeF4Menu( )
                                        end
                                    end )

    /*
    *   adjust height based on number of args associated to
    *   each command
    */

    self:SetTall( ( i_args * 32 ) + 34 + 32 + 20 + 15 )

end

/*
*   Think
*/

function PANEL:Think( )
    self.BaseClass.Think( self )

    self:MoveToFront( )

    local mousex    = math.Clamp( gui.MouseX( ), 1, ScrW( ) - 1 )
    local mousey    = math.Clamp( gui.MouseY( ), 1, ScrH( ) - 1 )

    if self.Dragging then
        local x     = mousex - self.Dragging[ 1 ]
        local y     = mousey - self.Dragging[ 2 ]

        if self:GetScreenLock( ) then
            x       = math.Clamp( x, 0, ScrW( ) - self:GetWide( ) )
            y       = math.Clamp( y, 0, ScrH( ) - self:GetTall( ) )
        end

        self:SetPos( x, y )
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
    return ( isstring( self.label ) and self.label ~= '' and self.label ) or ln( 'cmds_args_name_def' )
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
*   GetCommand
*
*   @return : tbl
*/

function PANEL:GetCommand( )
    return self.cmd or { }
end

/*
*   SetCommand
*
*   @param  : tbl cmd
*/

function PANEL:SetCommand( cmd )
    self.cmd = cmd
end

/*
*   Destroy
*/

function PANEL:Destroy( )
    ui:destroy( self, true, true )
end

/*
*   Declarations
*/

function PANEL:_Declare( )

    /*
    *   declare > configs
    */

    self.cf_d                       = cfg.dialogs

    /*
    *   declare > general
    */

    self.w, self.h                  = 420, 185
    self.args                       = { }
end

/*
*   Colorize
*/

function PANEL:_Colorize( )
    self.clr_cur                    = Color( 200, 200, 200, 255 )
    self.clr_txt                    = Color( 255, 255, 255, 255 )
    self.clr_hl                     = Color( 25, 25, 25, 255 )
end

/*
*   register
*/

ui:create( mod, 'diag_args', PANEL )