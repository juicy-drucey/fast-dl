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
    *   sub
    */

    self.p_sub                      = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0, 10, 0                         )

    /*
    *   sub > body
    */

    self.ct_body                    = ui.new( 'pnl', self.p_sub, 1          )
    :fill                           ( 'm', 10, 5, 10, 5                     )

    /*
    *   stats > container
    */

    self.ct_section                 = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 20, 10, 20, 10                   )

    /*
    *   stats > name
    */

    self.ct_name                    = ui.new( 'pnl', self.ct_section, 1     )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 36                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'rules_sect_icon' ), 0, h / 2, self.clr_ico_sec, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self:GetLabel( ), pref( 'rules_sect_name' ), 35, h / 2, self:GetTextTitleColor( ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   stats > header
    */

    self.ct_header                  = ui.new( 'pnl', self.ct_section, 1     )
    :top                            ( 'm', 0, 5, 0, 5                       )
    :tall                           ( 5                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, 1, self.clr_sep )
                                    end )

    /*
    *   stats > body
    */

    self.ct_body                    = ui.new( 'pnl', self.ct_section, 1     )
    :fill                           ( 'm', 0, 0, 0, 0                       )

    /*
    *   sub > body > dt > body > rules
    */

    self.dt_rules                   = ui.new( 'rlib.elm.text', self.ct_body )
    :fill                           ( 'p', 0, 10, 3, 3                      )
    :param                          ( 'SetData', self:GetRules( )           )
    :param                          ( 'SetOffsetTall', 50                   )

    /*
    *   sub > desc > container
    */

    self.ct_desc                    = ui.new( 'pnl', self, 1                )
    :right                          ( 'm', 0, 0, 0, 0                       )
    :wide                           ( 270                                   )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 28, 28, 28, 255 ) )
                                        design.box( 0, 0, 1, h, self.clr_sep )
                                    end )

    /*
    *   sub > desc > container
    */

    self.ct_desc_i                  = ui.new( 'pnl', self.ct_desc, 1        )
    :fill                           ( 'm', 20                               )

    /*
    *   sub > desc > lbl
    */

    self.lb_desc                    = ui.new( 'lbl', self.ct_desc_i, 1      )
    :top                            ( 'm', 0, 0, 0, 20                      )
    :text                           ( ln( 'rules_site_desc' )               )
    :font                           ( pref( 'rules_btn_web_desc' )          )
    :wrap                           ( true                                  )
    :autoverticle                   ( true                                  )
    :tall                           ( 150                                   )

    /*
    *   btn > website
    */

    self.sub                        = ui.new( 'btn', self.ct_desc_i         )
    :bsetup                         (                                       )
    :top                            ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 32                                    )
    :notext                         (                                       )

                                    :oc( function( s )
                                        gui.OpenURL( cfg.nav.btn.rules_url or ln( 'rules_site_btn_url' ) )
                                    end )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.clr_box )
                                        design.box( 0, 0, w, h / 2, Color( 255, 255, 255, 2 ) )

                                        if s.hover then
                                            design.box( 0, 0, w, h, Color( 0, 0, 0, 75 ) )
                                        end

                                        draw.SimpleText( ln( 'rules_site_btn' ), pref( 'rules_btn_web' ), w / 2, h / 2, self.clr_web_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    if ui:ok( self.dt_rules ) then
        self.dt_rules:SetData( self:GetRules( ) )
    end

    self.bInitialized = true
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )

    /*
    *   initialize only
    */

    if not self.bInitialized then
        self:FirstRun( )
    end
end

/*
*   GetRules
*
*   @return : str
*/

function PANEL:GetRules( )
    return self.rules
end

/*
*   SetRules
*
*   @param  : str str
*/

function PANEL:SetRules( str )
    self.rules = str
    self.dt_rules:SetText( str )
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
    return self.clr_name_txt or self.clr_txt_sec
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
*   Destroy
*/

function PANEL:Destroy( )
    ui:destroy( self, true, true )
end

/*
*   Declarations
*/

function PANEL:_Declare( )
    self.cf_u                       = cfg.ui
end

/*
*   Colorize
*/

function PANEL:_Colorize( )
    self.clr_def_txt                = self.cf_u.main.clrs.dt_txt
    self.clr_def_cur                = self.cf_u.main.clrs.dt_cur
    self.clr_def_hl                 = self.cf_u.main.clrs.dt_hl
    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_txt_sec                = self.cf_u.main.clrs.txt_section
    self.clr_ico_sec                = self.cf_u.main.clrs.ico_section
    self.clr_ico_acc                = self.cf_u.main.clrs.ico_accent
    self.clr_box                    = cfg.rules.clrs.btn_web_box
    self.clr_web_txt                = cfg.rules.clrs.btn_web_txt
end

/*
*   create
*/

ui:create( mod, 'pnl_rules', PANEL, 'pnl' )