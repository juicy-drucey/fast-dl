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
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return rlib.get:pref( str, state )
end

/*
*	localized glua
*/

local max                   = math.max
local abs                   = math.abs
local vec                   = Vector

/*
*   panel
*/

local PANEL                 = { }

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
    *   parent
    */

    self.Mdl                        = ui.new( self.elm, self                )
    :norotate                       (                                       )
    :onmouse                        (                                       )
end

/*
*   Attach
*
*   @param  : str model
*   @param  : bool bManual
*   @param  : int sz_offset
*   @param  : int fov
*/

function PANEL:Attach( model, bManual, sz_offset, fov )
    if not isstring( model ) then return end

    local mdl                       = self:GetModelPanel( )
    mdl:SetModel                    ( model )
                                    if not IsValid( mdl.Entity ) then return end

    if not bManual then
        local bone                  = mdl.Entity:LookupBone( 'ValveBiped.Bip01_Head1' )
                                    if not bone then return end

        local eyepos 			    = mdl.Entity:GetBonePosition( mdl.Entity:LookupBone( 'ValveBiped.Bip01_Head1' ) ) + vec( 0, 0, 2 )
        mdl:SetLookAt			    ( eyepos )
        mdl:SetCamPos			    ( eyepos + vec( select( 2, mdl.Entity:GetRenderBounds( ) ).x, 0, 0 ) )
        mdl.Entity:SetEyeTarget	    ( mdl:GetCamPos( ) )
    else
        local mn, mx                = mdl.Entity:GetRenderBounds( )
        local sz                    = isnumber( sz_offset ) and sz_offset or 0
        sz                          = max( sz, abs( mn.x ) + abs( mx.x ) )
        sz                          = max( sz, abs( mn.y ) + abs( mx.y ) )
        sz                          = max( sz, abs( mn.z ) + abs( mx.z ) )

        fov                         = isnumber( fov ) and fov or 70

        mdl                         = ui.get( mdl                           )
        :fov                        ( fov                                   )
        :look                       ( ( mn + mx ) / 2                       )
        :cam                        ( vec( sz, sz, sz )                     )
    end
end

/*
*   AttachControl
*
*   attempts to determine head ValveBiped Bone and
*   sets campos, eyepos based on head location automagically.
*
*   allows for manual FOV manipulation due to some models not working
*   correctly.
*
*   @param  : str model
*   @param  : int fov
*   @param  : int z
*/

function PANEL:AttachControl( model, fov, z )
    if not isstring( model ) then return end

    local mdl                       = self:GetModelPanel( )
    mdl:SetModel                    ( model )
                                    if not IsValid( mdl.Entity ) then return end

    local bone                      = mdl.Entity:LookupBone( 'ValveBiped.Bip01_Head1' )
                                    if not bone then return end

    fov                             = isnumber( fov ) and fov or 70
    z                               = isnumber( z ) and z or 0
    local eyes 			            = mdl.Entity:GetBonePosition( mdl.Entity:LookupBone( 'ValveBiped.Bip01_Head1' ) ) + vec( 0, 0, 2 )

    mdl                             = ui.get( mdl               )
    :fov                            ( fov                       )
    :look                           ( eyes + vec( 0, 1, z )     )
    :cam                            ( eyes + vec( select( 2, mdl.Entity:GetRenderBounds( ) ).x, 1, 0 ) )

    mdl.Entity:SetEyeTarget	        ( mdl:GetCamPos( ) )
end

/*
*   AttachManual
*
*   manually adjust model
*
*   @param  : str model
*   @param  : int fov
*   @param  : vec cam
*   @param  : vec look
*/

function PANEL:AttachManual( model, fov, cam, look )
    if not isstring( model ) then return end

    local mdl           = self:GetModelPanel( )
    mdl:SetModel        ( model )
                        if not IsValid( mdl.Entity ) then return end

    fov                 = isnumber( fov ) and fov or 70
    cam                 = isvector( cam ) and cam or Vector( 0, 0, 0 )
    look                = isvector( look ) and look or Vector( 0, 0, 0 )

    mdl                 = ui.get( mdl               )
    :fov                ( fov                       )
    :cam                ( cam                       )
    :look               ( look                      )

end

/*
*   AttachEntity
*
*   @param  : str model
*   @param  : int fov
*   @param  : int, vec vect
*   @param  : int oset
*/

function PANEL:AttachEntity( model, fov, vect, oset )
    if not isstring( model ) then return end

    local mdl                       = self:GetModelPanel( )
    mdl:SetModel                    ( model )
                                    if not IsValid( mdl.Entity ) then return end

    local mn, mx                    = mdl.Entity:GetRenderBounds( )
    local sz                        = isnumber( oset ) and oset or 0
    sz                              = max( sz, abs( mn.x ) + abs( mx.x ) )
    sz                              = max( sz, abs( mn.y ) + abs( mx.y ) )
    sz                              = max( sz, abs( mn.z ) + abs( mx.z ) )

    fov                             = isnumber( fov ) and fov or 70
    local vect_chk                  = ( not isnumber( vect ) and not isvector( vect ) and 0 ) or vect
    local vect_look                 = ( ( mn + mx ) / 2 ) + ( isvector( vect_chk ) and vect_chk or isnumber( vect_chk ) and Vector( 0, 0, vect_chk ) )

    mdl                             = ui.get( mdl                       )
    :fov                            ( fov                               )
    :look                           ( vect_look                         )
    :cam                            ( vec( sz, sz, sz )                 )
end

/*
*   IsHovered
*
*   @param  : void
*   @return : int
*/

function PANEL:IsHovered( )
    local w, h = self:GetSize( )
    local x, y = self:CursorPos( )

    if x < 0 or y < 0 or x > w or y > h then return false end
    return ( x - w / 2 ) ^ 2 + ( y - h / 2 ) ^ 2 < ( w / 2 ) ^ 2
end

/*
*   PerformLayout
*
*   @param  : void
*   @return : void
*/

function PANEL:PerformLayout( )
    if not ui:ok( self ) or not ui:ok( self.Mdl ) then return end
    self.Mdl:SetSize( self:GetWide( ), self:GetTall( ) )
    if self.Disabled then
        self.Mdl:SetAlpha( 100 )
    end
end

/*
*   GetModelPanel
*
*   @param  : void
*   @return : mdl
*/

function PANEL:GetModelPanel( )
    return self.Mdl
end

/*
*   GetEntity
*/

function PANEL:GetEntity( )
    return self:GetModelPanel( ).Entity
end

/*
*   Model Think
*
*   @param  : func fn
*   @return : void
*/

function PANEL:MdlThink( fn )
    self.Mdl.Think = function( s )
        fn( s )
    end
end

/*
*   Toggle
*
*   @param  : bool b
*   @return : void
*/

function PANEL:Toggle( b )
    self.Disabled = b or false
end

/*
*   Disable
*
*   @param  : void
*   @return : void
*/

function PANEL:Disable( )
    self.Disabled = true
end

/*
*   Enable
*
*   @param  : void
*   @return : void
*/

function PANEL:Enable( )
    self.Disabled = false
end

/*
*   SetPaintedOver
*
*   @param  : void
*   @return : void
*/

function PANEL:SetPaintedOver( )
    local p_cache   = self.Paint
    local po_cache  = self.PaintOver

    self.Paint      = nil
    self.PaintOver  = function( s, w, h )
        p_cache     ( s, w, h )
        po_cache    ( s, w, h )
    end
end

/*
*   SetHoverTxt
*
*   sets text when hovered
*
*   @param  : str str
*/

function PANEL:SetHoverTxt( str )
    self.txt_h = isstring( str ) and str or ''
end

/*
*   GetClrTxtH
*
*   returns hover text
*
*   @return : str
*/

function PANEL:GetHoverTxt( )
    return isstring( self.txt_h ) and self.txt_h or ''
end

/*
*   SetClrBoxH
*
*   sets box hover color
*
*   @param  : clr clr
*/

function PANEL:SetClrBoxH( clr )
    self.clr_box_h = IsColor( clr ) and clr or Color( 0, 0, 0, 240 )
end

/*
*   GetClrBoxH
*
*   returns box hover color
*
*   @return : clr
*/

function PANEL:GetClrBoxH( )
    return IsColor( self.clr_box_h ) and self.clr_box_h or Color( 0, 0, 0, 240 )
end

/*
*   SetClrBoxH
*
*   sets box hover color
*
*   @param  : clr clr
*/

function PANEL:SetClrTxtH( clr )
    self.clr_txt_h = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
end

/*
*   GetClrBoxH
*
*   returns box hover color
*
*   @return : clr
*/

function PANEL:GetClrTxtH( )
    return IsColor( self.clr_txt_h ) and self.clr_txt_h or Color( 255, 255, 255, 255 )
end

/*
*   SetbCanJoin
*
*   specify if model associated to job that can be joined by player
*
*   @param  : bool b
*/

function PANEL:SetbCanJoin( b )
    self.bCanJoin = helper:val2bool( b )
end

/*
*   GetbCanJoin
*
*   returns if model associated to job that can be joined by player
*
*   @return : bool
*/

function PANEL:GetbCanJoin( )
    return self.bCanJoin or false
end

/*
*   SetbUseModelImg
*
*   specify if element should display a model or model img
*
*   @param  : bool b
*/

function PANEL:SetbUseModelImg( b )
    self.bModelImg = helper:val2bool( b )
end

/*
*   GetbUseModelImg
*
*   returns if element should display a model or model img
*
*   @return : bool
*/

function PANEL:GetbUseModelImg( )
    return self.bModelImg or false
end

/*
*   PaintOver
*
*   @param  : int w
*   @param  : int h
*   @return : void
*/

function PANEL:PaintOver( w, h )
    if not self.Disabled then return end

    local alpha = self.Alpha * 200
    draw.SimpleText( helper.get:utf8( 'x' ), pref( 'elm_mdl_txt_disabled' ), w / 2, h / 2 - 15, Color( 184, 104, 103, alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*   @return : void
*/

function PANEL:Paint( w, h )
    self.Alpha = Lerp( FrameTime( ) * 10, self.Alpha, self:IsHovered( ) and 1 or 0 )

    if self.Alpha >= 0 then
        local txt       = self:GetHoverTxt( )
        local alpha     = self.Alpha * 200
        if helper.str:ok( txt ) then
            local clr_box = self:GetClrBoxH( )
            design.rbox( 2, 2, 2, w - 4, h - 4, ColorAlpha( clr_box, alpha ) )
            if not self.Disabled then
                draw.SimpleText( txt, pref( 'elm_mdl_txt_hover' ), w / 2, h / 2, ColorAlpha( self:GetClrTxtH( ), alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end
        end
    end
end

/*
*   norotate > set
*
*   sets the model ro rotate
*
*   @param  : int speed [ optional ]
*/

function PANEL:AllowRotate( speed )
    speed                   = isnumber( speed ) and speed or 10

    local mdl               = ui.get( self.Mdl      )

    mdl.LayoutEntity = function( s, ent )
        if s.bAnimated then s:RunAnimation( ) end
        ent:SetAngles( Angle( 0, RealTime( ) * speed % 360, 0 ) )
    end
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

    self.cfg_cat_mat                = cfg.tabs.general

    /*
    *   declare > parent element
    */

    self.elm                        = cvar:GetInt( 'arivia_mdls_3d', 1 ) == 1 and 'mdl' or 'mdl_img'

    /*
    *   declare > general
    */

    self.Alpha                      = 0

end

/*
*   register
*/

ui:create( mod, 'elm_mdl', PANEL, 'pnl' )