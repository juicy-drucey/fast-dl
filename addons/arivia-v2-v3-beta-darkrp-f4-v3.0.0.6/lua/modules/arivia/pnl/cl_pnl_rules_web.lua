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
*   accessorfunc
*/

AccessorFunc( PANEL, 'itemName',     'MenuItem',     FORCE_STRING )

/*
*   initialize
*/

function PANEL:Init( )

    /*
    *   parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :nodraw                         (                                       )
    :fill                           (                                       )

    /*
    *   pnl > sub
    */

    self.sub                        = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 0, 0, 0                       )

    /*
    *   pnl > body
    */

    self.body                       = ui.new( 'pnl', self.sub, 1            )
    :fill                           ( 'm', 10, 10, 10, 5                    )

    /*
    *   pnl > body > sub
    */

    self.body_sub                   = ui.new( 'pnl', self.body, 1           )
    :fill                           ( 'm', 0                                )

    /*
    *   dhtml > window
    */

    self.dhtml                      = ui.new( 'dhtml', self.body_sub, 1     )
    :fill                           ( 'm', 0, 10, 0, 10                     )
    :url                            (                                       )
    :loader                         ( 160, Color( 177, 29, 86, 255 )        )

    /*
    *   header
    */

    self.header                     = ui.new( 'pnl', self.body_sub, 1       )
    :top                            (                                       )
    :tall                           ( 32                                    )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 255, 255, 255, 1 ))
                                    end )

    /*
    *   header
    */

    self.header_l                   = ui.new( 'pnl', self.header, 1         )
    :left                           (                                       )
    :margin                         ( 5, 6, 3, 6                            )
    :wide                           ( 22                                    )

    /*
    *   tip
    */

    self.b_tip                      = ui.new( 'btn', self.header_l          )
    :bsetup                         (                                       )
    :fill                           (                                       )
    :tip                            ( ln( 'ibws_tip_warning' )              )

                                    :oc( function( s )
                                        if ui:registered( '$diag_ibws_notice', mod ) then
                                            ui:dispatch( '$diag_ibws_notice', mod )
                                            return
                                        end

                                        local get_id            = self:GetLinkData( )
                                        local diag_ibws         = ui.rlib( mod, 'diag_ibws_notice'      )
                                        :param                  ( 'SetMenuItem',  get_id                )
                                        :register               ( '$diag_ibws_notice', mod              )
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, Color( 202, 202, 202, 255 ) )

                                        local a	        = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                        a		        = math.Clamp( a, s.hover and 100 or 255, 255 )
                                        local clr_ico   = Color( 0, 0, 0, 255 )

                                        draw.SimpleText( '', pref( 'ibws_diag_ico_hint' ), w / 2, h / 2, Color( clr_ico.r, clr_ico.g, clr_ico.b, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   dhtml > controls
    */

    self.ctrlbar                    = ui.new( 'ctrls', self.header          )
    :fill                           ( 'm', 0                                )
    :pos                            ( 0                                     )
    :html                           ( self.dhtml or ''                      )

    /*
    *   dhtml > attach window
    */

    local window                    = ui.get( self.dhtml                    )
    :below                          ( self.ctrlbar                          )

end

/*
*   GetLinkData
*/

function PANEL:GetLinkData( )
    local id        = self:GetMenuItem( )
                    if not id then return end

    for v in helper.get.data( cfg.nav.list ) do
        local name_static   = v.name:lower( )
        local name_dyn      = ln( name_static )

        if ( name_static ~= id ) and ( name_dyn ~= id ) then continue end

        return v.id
    end
end

/*
*   GetURL
*
*   @return : str
*/

function PANEL:GetURL( )
    return self.web_url
end

/*
*   SetWebURL
*
*   @param  : str str
*/

function PANEL:SetURL( str )
    self.web_url = str
    self.dhtml:OpenURL( str )
    self.ctrlbar.AddressBar:SetText( str )
end

/*
*   GetStandalone
*
*   @return : bool
*/

function PANEL:GetStandalone( )
    return self.bStandalone
end

/*
*   SetStandalone
*
*   @param  : bool b
*/

function PANEL:SetStandalone( b )
    self.bStandalone = helper:val2bool( b )
end

/*
*   GetLabel
*
*   @return : str
*/

function PANEL:GetLabel( )
    return isstring( self.label ) and self.label or ln( 'rules_sect_name' )
end

/*
*   SetLabel
*
*   @param  : str str
*/

function PANEL:SetLabel( str )
    self.label = str
end

/*
*   GetTextTitleColor
*
*   @return : str
*/

function PANEL:GetTextTitleColor( )
    return self.clr_name_txt or cfg.rules.clrs.name
end

/*
*   SetTextTitleColor
*
*   @param  : clr clr
*/

function PANEL:SetTextTitleColor( clr )
    self.clr_name_txt = clr
end

/*
*   destroy
*/

function PANEL:Destroy( )
    ui:destroy( self, true, true )
end

/*
*   Declarations
*/

function PANEL:_Declare( )
    self.cf_u                       = cfg.ui
    self.cf_n                       = cfg.nav
end

/*
*   _Colorize
*/

function PANEL:_Colorize( )
    self.clr_cur                    = self.cf_n.ibws.clrs.cur
    self.clr_hl                     = self.cf_n.ibws.clrs.highlight
    self.clr_box                    = self.cf_n.ibws.clrs.box
    self.clr_web_txt                = self.cf_n.ibws.clrs.txt
end

/*
*   create
*/

ui:create( mod, 'pnl_rules_web', PANEL, 'pnl' )