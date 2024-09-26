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
*   localized glua
*/

local sf                    = string.format

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
    return rlib.get:pref( str, state )
end

/*
*   interface settings storage
*/

local cvar_lst =
{
    { id = 'arivia_mdlv_banim',         name = 'Rotate Animation',  desc = 'enable/disable model rotating',     type = 'checkbox',  default = 0,    values = { } },
    { id = 'arivia_mdlv_fov',           name = 'Field of View',     desc = 'Field of view',                     type = 'slider',    default = 100,  values = { },   min = 0,        max = 180 },
    { id = 'arivia_mdlv_campos_x',      name = 'campos x',          desc = 'Camera pos x',                      type = 'slider',    default = 100,  values = { },   min = -1000,    max = 1000 },
    { id = 'arivia_mdlv_campos_y',      name = 'campos y',          desc = 'Camera pos y',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'arivia_mdlv_campos_z',      name = 'campos z',          desc = 'Camera pos z',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'arivia_mdlv_lookat_x',      name = 'lookat x',          desc = 'Lookat pos x',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'arivia_mdlv_lookat_y',      name = 'lookat y',          desc = 'Lookat pos y',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'arivia_mdlv_lookat_z',      name = 'lookat z',          desc = 'Lookat pos z',                      type = 'slider',    default = 5,    values = { },   min = -1000,    max = 1000 },
}

/*
*   cycle setup convars
*/

local function setup_convars( )
    for k, v in pairs( cvar_lst ) do
        cvar:Setup( v.type, v.id, v.default, v.values )
    end
end
setup_convars( )

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
    :shadow                         ( true                                  )
    :sz                             ( self.ui_w, self.ui_h                  )
    :wmin                           ( self.ui_w / 2                         )
    :hmin                           ( self.ui_h / 2                         )
    :padding                        ( 0, 34, 0, 0                           )
    :popup                          (                                       )
    :notitle                        (                                       )
    :canresize                      ( true                                  )
    :canclose                       ( false                                 )
    :scrlock                        ( true                                  )
    :appear                         ( 5, 0.2                                )

    /*
    *   titlebar
    */

    self.lblTitle                   = ui.new( 'lbl', self                   )
    :notext                         (                                       )
    :font                           ( pref( 'mdlv_name' )                  )
    :clr                            ( Color( 255, 255, 255, 255 )           )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( utf8.char( 9930 ), pref( 'mdlv_icon' ), 0, 8, Color( 240, 72, 133, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self:GetLabel( ), pref( 'mdlv_name' ), 25, h / 2, Color( 237, 237, 237, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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
    :tooltip                        ( ln( 'tooltip_close' )                 )
    :ocr                            ( self                                  )

                                    :draw( function( s, w, h )
                                        local a	        = math.abs( math.sin( CurTime( ) * 3 ) * 255 )
                                        a			    = math.Clamp( a, 15, 255 )
                                        local clr_txt   = s.hover and Color( 255, 255, 255, a ) or Color( 255, 255, 255, 255 )
                                        draw.SimpleText( helper.get:utf8( 'close' ), pref( 'mdlv_exit' ), w / 2 - 5, h / 2 + 4, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   loader
    */

    timex.simple( 0.2, function( )
        self.mdl_default = self.mdl
        self:Content( )
    end )

end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    self.bInitialized = true
end

/*
*   Content
*/

function PANEL:Content( )

    self:Cvars( )

    /*
    *   sub pnl
    */

    self.ct_sub                     = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0                                )

    /*
    *   dmodel
    */

    self.mdl_elm                    = ui.new( 'mdl', self.ct_sub            )
    :fill                           ( 'm', 0                                )
    :mdl                            ( self.mdl                              )
    :light                          ( Color( 255, 255, 255, 255 )           )

                                    :le( function( ent, s )
                                        if not cvar:GetBool( 'arivia_mdlv_banim' ) then
                                            s:SetAngles( Angle( 0, 0, 0 ) )
                                            return
                                        end

                                        if ( self.mdl_elm.bAnimated ) then
                                            self.mdl_elm:RunAnimation( )
                                        end

                                        s:SetAngles( Angle( 0, RealTime( ) * 10 % 360, 0 ) )
                                    end )

                                    :logic( function( s )
                                        s:SetFOV        ( cvar:GetInt( 'arivia_mdlv_fov' ) )
                                        s:SetCamPos     ( Vector( cvar:GetInt( 'arivia_mdlv_campos_x' ), cvar:GetInt( 'arivia_mdlv_campos_y' ), cvar:GetInt( 'arivia_mdlv_campos_z' ) ) )
                                        s:SetLookAt     ( Vector( cvar:GetInt( 'arivia_mdlv_lookat_x' ), cvar:GetInt( 'arivia_mdlv_lookat_y' ), cvar:GetInt( 'arivia_mdlv_lookat_z' ) ) )
                                    end )

                                    :po( function( s, w, h )
                                        local pos_x, pos_y, pos_z       = cvar:GetInt( 'arivia_mdlv_campos_x' ), cvar:GetInt( 'arivia_mdlv_campos_y' ), cvar:GetInt( 'arivia_mdlv_campos_z' )
                                        local look_x, look_y, look_z    = cvar:GetInt( 'arivia_mdlv_lookat_x' ), cvar:GetInt( 'arivia_mdlv_lookat_y' ), cvar:GetInt( 'arivia_mdlv_lookat_z' )
                                        local fov, bAnim                = cvar:GetInt( 'arivia_mdlv_fov' ), cvar:GetBool( 'arivia_mdlv_banim' ) and 'ON' or 'OFF'
                                        local bValidOnly                = self.bIsValidOnly and 'ON' or 'OFF'
                                        local y_pos                     = 10

                                        local clr_label                 = Color( 200, 200, 200, 255 )
                                        local clr_value                 = Color( 93, 180, 255, 255 )

                                        local w_sz, h_sz                = w, h
                                        draw.TexturedQuad { texture = surface.GetTextureID( helper._mat[ 'grad_up' ] ), color = Color( 0, 0, 0, 200 ), x = 0, y = h_sz - 100, w = w_sz, h = 100 }

                                        -- stats > top left > labels
                                        draw.SimpleText( 'cam', pref( 'mdlv_minfo' ), 85, y_pos + 10, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( 'lookat', pref( 'mdlv_minfo' ), 85, y_pos + 30, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( 'fov', pref( 'mdlv_minfo' ), 85, y_pos + 50, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )

                                        -- stats > top left > values
                                        draw.SimpleText( sf( '%sx %sy %sz', pos_x, pos_y, pos_z ), pref( 'mdlv_minfo' ), 110, y_pos + 10, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%sx %sy %sz', look_x, look_y, look_z ), pref( 'mdlv_minfo' ), 110, y_pos + 30, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%s', fov ), pref( 'mdlv_minfo' ), 110, y_pos + 50, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

                                        -- stats > top right > labels
                                        draw.SimpleText( 'Animations', pref( 'mdlv_minfo' ), w - 105, y_pos + 10, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( 'Show valid only', pref( 'mdlv_minfo' ), w - 105, y_pos + 30, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )

                                        -- stats > top right > values
                                        draw.SimpleText( sf( '%s', bAnim ), pref( 'mdlv_minfo' ), w - 55, y_pos + 10, clr_value, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%s', bValidOnly ), pref( 'mdlv_minfo' ), w - 55, y_pos + 30, clr_value, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   controls pnl
    */

    self.p_ctrls                    = ui.new( 'pnl', self, 1                )
    :bottom                         ( 'm', 8, 8, 8, 0                       )
    :tall                           ( self.ui_h * 0.33                      )

    /*
    *   btm block
    */

    self.b_copy                     = ui.new( 'btn', self.p_ctrls           )
    :bsetup                         (                                       )
    :top                            ( 'm', 22, 0, 25, 10                    )
    :tall                           ( 30                                    )
    :tip                            ( ln( 'mdlv_btn_copytoclip' )           )

                                    :draw( function( s, w, h )
                                        local btn_txt   = s.hover and ln( 'mdlv_btn_copy' ) or ln( 'mdlv_btn_path' )
                                        local btn_clr   = s.hover and Color( 156, 4, 81, 255 ) or Color( 31, 133, 222, 255 )

                                        design.rbox_adv( 4, 2, 2, w - 4, h - 4, Color( 25, 25, 25, 255 ), true, false, true, false )
                                        design.rbox_adv( 4, 2, 2, 50, h - 4, btn_clr, true, false, true, false )

                                        local getmodel  = self.mdl_elm:GetModel( ) and tostring( self.mdl_elm:GetModel( ) ) or ''
                                        self.mdl_path   = ( self.bIsValidOnly and util.IsValidModel( getmodel ) and getmodel ) or ( not self.bIsValidOnly and getmodel ) or getmodel or 'invalid model path'

                                        draw.SimpleText( btn_txt, pref( 'mdlv_minfo' ), 53 / 2, h / 2 - 1, clr_label, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%s', self.mdl_path ), pref( 'mdlv_minfo' ), 60, h / 2, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        SetClipboardText( self.mdl_path )
                                        self.clipb_delay = CurTime( ) + 0.5
                                    end )

    /*
    *   scroll pnl
    */

    self.dsp                        = ui.new( 'rlib.elm.sp.v2', self.p_ctrls, 1 )
    :fill                           ( 'm', 5                                )
    :param                          ( 'SetbKonsole', false                  )
    :param                          ( 'SetbElastic', true                   )

    /*
    *   cvar > loop
    */

    for k, v in helper.get.table( cvar_lst, pairs ) do

        /*
        *   cvar > declarations
        */

        local class 	            = v.type
        local cv		            = GetConVar( v.id )

        /*
        *   cvar > parent
        */

        self.ct_parent              = ui.new( 'pnl', self.dsp, 1            )
        :top                        ( 'm', 5, 2, 20, 2                      )

        /*
        *   type > slider
        */

        if class == 'slider' then
            self:ElmSlider( v, cv )
        end

        /*
        *   type > chkbox
        */

        if class == 'checkbox' then
            self:ElmCheckbox( v, cv )
        end

        /*
        *   spacer
        */

        self.spcr                   = ui.new( 'pnl', self.dsp               )
        :top                        ( 'm', 0                                )
        :tall                       ( 1                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.cf_clr_spcr )
                                    end )

    end

end

/*
*   elm > slider
*
*   @param  : tbl v
*   @param  : cvar cv
*/

function PANEL:ElmSlider( v, cv )

    /*
    *   slider > container > main
    */

    self.ct_slid            = ui.new( 'pnl', self.ct_parent, 1      )
    :fill                   ( 'm', 0, 0, 0, 0                       )

    /*
    *   slider > lbl
    */

    self.l_name             = ui.new( 'btn', self.ct_slid           )
    :bsetup                 (                                       )
    :left                   ( 'm', 15, 0, 0, 0                      )
    :font                   ( pref( 'mdlv_control' )                )
    :clr                    ( Color( 255, 255, 255, 255 )           )
    :text                   ( v.desc                                )
    :autosize               (                                       )

                            :draw( function( s, w, h )
                                s:SetTextColor( s.hover and self.cf_clr_txt_h or self.cf_clr_txt_n )
                            end )

    /*
    *   slider > right > container
    */

    self.ct_r               = ui.new( 'pnl', self.ct_slid, 1        )
    :fill                   ( 'm', 5, 3, 20, 0                      )
    :wide                   ( 300                                   )

    /*
    *   slider > right > elm
    */

    self.elm                = ui.new( 'rlib.ui.slider', self.ct_r   )
    :right                  ( 'm', 0, 0, 0, 0                       )
    :wide                   ( 300                                   )
    :min                    ( v.min                                 )
    :max                    ( v.max                                 )
    :value                  ( cv:GetFloat( )                        )
    :param                  ( 'SetKnobColor', Color( 51, 169, 74 )  )
    :cvar                   ( cv                                    )

                            :ovc( function( s )
                                cv:SetInt( s:GetValue( ) )
                            end )

end

/*
*   elm > checkbox
*
*   @param  : tbl v
*   @param  : cvar cv
*/

function PANEL:ElmCheckbox( v, cv )

    /*
    *   chkbox > container > main
    */

    self.ct_cbox            = ui.new( 'pnl', self.ct_parent, 1      )
    :fill                   ( 'm', 0, 0, 0, 5                       )

    /*
    *   chkbox > lbl
    */

    self.l_name             = ui.new( 'btn', self.ct_cbox           )
    :bsetup                 (                                       )
    :left                   ( 'm', 15, 0, 0, 0                      )
    :font                   ( pref( 'mdlv_control' )                )
    :clr                    ( Color( 255, 255, 255, 255 )           )
    :text                   ( v.name                                )
    :autosize               (                                       )

                            :draw( function( s, w, h )
                                s:SetTextColor( s.hover and self.cf_clr_txt_h or self.cf_clr_txt_n )
                            end )

    /*
    *   chkbox > container > right
    */

    self.ct_r               = ui.new( 'pnl', self.ct_cbox, 1        )
    :fill                   ( 'm', 5, 0, 20, 0                      )
    :autosize               (                                       )

    /*
    *   chkbox > element
    */

    self.elm                = ui.new( 'rlib.ui.toggle', self.ct_r   )
    :right                  ( 'm', 0                                )
    :var                    ( 'enabled', cv:GetBool( ) or false     )

                            :ooc( function( s )
                                cv:SetBool( s.enabled )
                            end )

end

/*
*   Think
*/

function PANEL:Think( )
    self.BaseClass.Think( self )
    self:MoveToFront( )

    local mousex = math.Clamp( gui.MouseX( ), 1, ScrW( ) - 1 )
    local mousey = math.Clamp( gui.MouseY( ), 1, ScrH( ) - 1 )

    if self.Dragging then
        local x = mousex - self.Dragging[ 1 ]
        local y = mousey - self.Dragging[ 2 ]

        if self:GetScreenLock( ) then
            x = math.Clamp( x, 0, ScrW( ) - self:GetWide( ) )
            y = math.Clamp( y, 0, ScrH( ) - self:GetTall( ) )
        end

        self:SetPos( x, y )
    end

    if self.Sizing then
        local x = mousex - self.Sizing[ 1 ]
        local y = mousey - self.Sizing[ 2 ]
        local px, py = self:GetPos( )

        if ( x < self.m_iMinWidth ) then x = self.m_iMinWidth elseif ( x > ScrW( ) - px and self:GetScreenLock( ) ) then x = ScrW( ) - px end
        if ( y < self.m_iMinHeight ) then y = self.m_iMinHeight elseif ( y > ScrH( ) - py and self:GetScreenLock( ) ) then y = ScrH( ) - py end

        self:SetSize( x, y )
        self:SetCursor( 'sizenwse' )
        return
    end

    if ( self.Hovered and self.m_bSizable and mousex > ( self.x + self:GetWide( ) - 20 ) and mousey > ( self.y + self:GetTall( ) - 20 ) ) then
        self:SetCursor( 'sizenwse' )
        return
    end

    if ( self.Hovered and self:GetDraggable( ) and mousey < ( self.y + 24 ) ) then
        self:SetCursor( 'sizeall' )
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

    /*
    *   initialize only
    */

    if not self.bInitialized then
        if not ui:ok( self ) then return end
        self:FirstRun( )
    end

    local titlePush = 0
    self.BaseClass.PerformLayout( self )

    self.lblTitle:SetPos( 11 + titlePush, 7 )
    self.lblTitle:SetSize( self:GetWide( ) - 2 - titlePush, 20 )
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h )
    design.rbox( 4, 0, 0, w, h, Color( 35, 35, 35, 255 ) )
    design.rbox_adv( 0, 0, 0, w, 34, Color( 93, 37, 37, 255 ), true, true, false, false )
    design.box( 0, 33, w, 1, self.clr_sep )

    local remains       = math.Round( self.clipb_delay - CurTime( ) ) or 0
    local limit         = math.Clamp( remains, 0, 5 )

    if limit == 1 and #self.clipb_data == 0 then
        timex.simple( 'rlib_lo_mviewer_copy_anim', 0.1, function( )
            if #self.clipb_data == 0 then
                local pos_x, pos_y  = self.b_copy:LocalToScreen( )
                local exp           = CurTime( ) + ( self._anim_scrtxt or 2 )

                pos_x = pos_x + 50
                pos_y = pos_y - 20

                table.insert( self.clipb_data, { pos = pos_x, x = pos_x, y = pos_y, expires = exp } )
            end
        end )
    end

    -- resizing arrow
    draw.SimpleText( utf8.char( 9698 ), pref( 'mdlv_resizer' ), w - 3, h - 7, Color( 240, 72, 133, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    draw.SimpleText( utf8.char( 9698 ), pref( 'mdlv_resizer' ), w - 5, h - 9, Color( 40, 40, 40, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
end

/*
*   ActionHide
*/

function PANEL:ActionHide( )
    self:SetMouseInputEnabled( false )
    self:SetKeyboardInputEnabled( false )
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
    return ( helper.str:ok( self.label ) and self.label ) or ln( 'mdlv_name' )
end

/*
*   SetLabel
*
*   @param  : str str
*/

function PANEL:SetLabel( str )
    self.lblTitle:SetText( '' )
    self.label = str
end

/*
*   GetRequireValidation
*/

function PANEL:GetbValidOnly( )
    return self.bIsValidOnly
end

/*
*   SetLabel
*
*   @param  : bool b
*/

function PANEL:bValidOnly( b )
    self.bIsValidOnly = helper:val2bool( b )
end

/*
*   model > get
*
*   @return : str
*/

function PANEL:GetMDL( )
    return self.mdl
end

/*
*   model > set
*
*   @param  : str mdl
*/

function PANEL:SetMDL( mdl )
    self.mdl = mdl
end

/*
*   is player > get
*
*   @return : int
*/

function PANEL:GetIsPly( )
    return self.bIsPlyMdl == 1 and true or false
end

/*
*   is player > set
*
*   @param  : bool b
*/

function PANEL:SetIsPly( int )
    self.bIsPlyMdl = int or 0
end

/*
*   is vehicle > get
*
*   @return : int
*/

function PANEL:GetIsVehicle( )
    return self.bIsVeh == 1 and true or false
end

/*
*   is vehicle > set
*
*   @param  : bool b
*/

function PANEL:SetIsVehicle( int )
    self.bIsVeh = int or 0
end

/*
*   Cvars
*/

function PANEL:Cvars( )

    /*
    *   cvars > set
    */

    cvar:SetInt( 'arivia_mdlv_fov',                 self:GetIsVehicle( )    and     95      or self:GetIsPly( ) and 45 or 14 )
    cvar:SetInt( 'arivia_mdlv_campos_x',            self:GetIsPly( )        and     250     or -27 )
    cvar:SetInt( 'arivia_mdlv_campos_y',            self:GetIsPly( )        and     13      or -233 )
    cvar:SetInt( 'arivia_mdlv_campos_z',            self:GetIsPly( )        and     47      or 27 )
    cvar:SetInt( 'arivia_mdlv_lookat_x',            self:GetIsPly( )        and     -207    or 0 )
    cvar:SetInt( 'arivia_mdlv_lookat_y',            self:GetIsPly( )        and     -13     or 0 )
    cvar:SetInt( 'arivia_mdlv_lookat_z',            self:GetIsVehicle( )    and     40      or self:GetIsPly( ) and 47 or 5 )

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

    self.cf_m                       = cfg.ui.main
    self.cf_d                       = cfg.dev

    /*
    *   declare > sizing
    */

    self.sc_w, self.sc_h            = ui:scalesimple( 0.85, 0.85, 0.90 ), ui:scalesimple( 0.85, 0.85, 0.90 )
    self.ui_w, self.ui_h            = self.sc_w * self.cf_d.mdlv.ui.width, self.sc_h * self.cf_d.mdlv.ui.height

    /*
    *   declare > clipboard btn
    */

    self.clipb_data                 = { }
    self.clipb_delay                = 0
    self._anim_scrtxt               = design.anim_scrolltext( ln( 'mdlv_copied_to_clipboard' ), 'rlib_lo_mviewer_overlay_copy', self.clipb_data, pref( 'mdlv_copyclip' ), Color( 255, 255, 255, 255 ), 0.5, 2 )

    /*
    *   bIsValidOnly
    *
    *   utilizes util.IsValidModel
    *
    *   if turned on, however this is extremely unreliable for detecting a valid model due to the
    *   restrictions it has. it is recommended to keep this off unless you need to see if the game sees
    *   a particular model as valid
    *
    *   A model is considered invalid in following cases:
    *       : Starts with a space or maps
    *       : Doesn't start with /models/
    *       : On server: If the model isn't precached, if the model file doesn't exist on the disk
    *       : If precache failed
    *       : Model is the error model
    *       : Contains any of the following:
    *           - _gestures
    *           - _animations
    *           - _postures
    *           - _gst
    *           - _pst
    *           - _shd
    *           - _ss
    *           - _anm
    *           - .bsp
    *           - cs_fix
    */

    self.bIsValidOnly               = false

    /*
    *   declarations > mdl
    */

    self.mdl_path                   = 'none'

end

/*
*	_Colorize
*/

function PANEL:_Colorize( )
    self.clr_sep                    = self.cf_m.clrs.separator
    self.cf_clr_spcr                = self.cf_m.clrs.separator
    self.cf_clr_txt_n               = self.cf_m.clrs.dt_txt
    self.cf_clr_txt_h               = Color( 31, 133, 222, 255 )
end

/*
*	register
*/

ui:create( mod, 'pnl_mviewer', PANEL, 'frame' )