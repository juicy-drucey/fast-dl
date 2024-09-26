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

local function lang( ... )
    return base:translate( mod, ... )
end

/*
*	localized mat func
*/

local function mat( id )
    return mats:call( mod, id )
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
*   Init
*/

function PANEL:Init( )

    /*
    *   parent pnl
    */

    self:Dock                       ( FILL                                  )
    self:DockPadding                ( 0, 0, 0, 0                            )

    /*
    *   loop server list
    */

    local i = 1
    for v in helper.get.data( cfg.servers.list ) do

        if not v.enabled then continue end

        local sizex                 = helper.str:len( v.hostname:upper( ), pref( 'servers_button_name' ) )
        local i_pad                 = 50

        local b_server              = ui.new( 'btn', self                   )
        :bsetup                     (                                       )
        :left                       ( 'm', 0, 1, 2, 1                       )
        :notext                     (                                       )
        :sz                         ( sizex + i_pad, 60                     )
        :tip                        ( v.desc or nil                         )
        :anim_click_ol              ( Color( 255, 255, 255, 15 )            )
        :SetupAnim                  ( 'OnHoverFill', 5, function( s ) return s:IsHovered( ) end )

                                    if ( v.rmat or v.mat ) and ( cfg.servers.type == 1 ) then
                                        mat_id = v.rmat and mat( v.rmat ) or Material( v.mat )
                                        b_server:SetSize( b_server:GetWide( ) + 32, b_server:GetTall( ) )
                                    elseif ( v.rmat or v.mat ) and ( cfg.servers.type == 2 ) then
                                        mat_id = v.rmat and mat( v.rmat ) or Material( v.mat )
                                        b_server:SetSize( 64, b_server:GetTall( ) )
                                    elseif ( v.rmat or v.mat ) and ( cfg.servers.type == 3 ) then
                                        b_server:SetSize( b_server:GetWide( ) + 10, b_server:GetTall( ) )
                                    end

        local pnl_serv              = ui.get( b_server )

                                    :draw( function( s, w, h )
                                        s.OnHoverFill   = not s.OnHoverFill and 5 or s.OnHoverFill

                                        local clr_box   = s.hover and cfg.servers.clrs.btn_h or cfg.servers.clrs.btn_n
                                        local clr_text  = s.hover and cfg.servers.clrs.txt_h or cfg.servers.clrs.txt_n
                                        local clr_icon  = s.hover and cfg.servers.clrs.ico_h or cfg.servers.clrs.ico_n

                                        local prog      = math.Round( h * s.OnHoverFill )
                                        x, y, fw, fh    = 0, h - prog, w, prog

                                        design.box( 0, 0, w, h, cfg.servers.clrs.primary )
                                        design.box( x, y, fw, fh, clr_box )

                                        if ( cfg.servers.type == 1 and mat_id ) then
                                            design.imat( i_pad / 2 - 7, ( h / 2 ) - ( 32 / 2 ), 32, 32, mat_id, clr_icon )
                                            draw.SimpleText( v.hostname:upper( ), pref( 'servers_button_name' ), w / 2 + 15 + 5, h / 2, clr_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        elseif ( cfg.servers.type == 2 and mat_id ) then
                                            design.imat( 17, 14, 32, 32, mat_id, clr_icon )
                                        else
                                            draw.SimpleText( v.hostname:upper( ), pref( 'servers_button_name' ), w / 2, h / 2, clr_text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        end

                                        if s.hover then
                                            local clr_anim          = cfg.dev.bDisableAnim and cfg.servers.clrs.uline or Color( 0, 0, 0, 0 )
                                            if not cfg.dev.bDisableAnim then
                                                local calc_pulse    = math.abs( math.sin( CurTime( ) * 4 ) * 255 )
                                                calc_pulse          = math.Clamp( calc_pulse, 150, 230 )
                                                clr_anim            = Color( calc_pulse, calc_pulse, calc_pulse, calc_pulse )
                                            end

                                            design.box( 0, h - 3, w, 3, clr_anim )

                                            /*
                                            *	sfx > open
                                            */

                                            if not s.bSndHover and cfg.general.sounds_enabled then
                                                local snd       = CreateSound( LocalPlayer( ), resources( 'snd', 'mouseover_01' ) )
                                                snd:PlayEx      ( 0.1, 100 )
                                                s.bSndHover     = true
                                            end
                                        end
                                    end )

                                    :oc( function( s )
                                        if not ui:ok( mod.pnl.cwserv ) then
                                            mod.pnl.cwserv = ui.rlib( mod, 'diag_cwserv' )
                                        end

                                        mod.pnl.cwserv:SetServerName        ( v.hostname    )
                                        mod.pnl.cwserv:SetServerIp          ( v.ip          )
                                        mod.pnl.cwserv:ActionShow           (               )

                                        /*
                                        *	sfx > open
                                        */

                                        local snd       = CreateSound( LocalPlayer( ), resources( 'snd', 'swipe_01' ) )
                                        snd:PlayEx      ( 0.1, 100 )
                                    end )

                                    :logic( function( s )

                                        /*
                                        *	sfx > open
                                        */

                                        if s.hover then
                                            if not s.bSndHover and cfg.general.sounds_enabled then
                                                local snd       = CreateSound( LocalPlayer( ), resources( 'snd', 'mouseover_01' ) )
                                                snd:PlayEx      ( 0.1, 100 )
                                                s.bSndHover     = true
                                            end
                                        else
                                            s.bSndHover     = false
                                        end

                                    end )

        i = i + 1

    end

end

/*
*   Think
*/

function PANEL:Think( )
    if not ui:ok( self ) then return end
    self:MoveToFront( )
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h ) end

/*
*   Destroy
*/

function PANEL:Destroy( )
    ui:destroy( self, true, true )
end

/*
*   create
*/

ui:create( mod, 'pnl_servers', PANEL, 'pnl' )