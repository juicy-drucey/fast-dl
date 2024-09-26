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
*   panel
*/

local PANEL = { }

/*
*   initialize
*/

function PANEL:Init( )

    /*
    *   parent pnl
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :fill                           ( 'm', 0                                )

end

/*
*   Run
*/

function PANEL:Run( )

    /*
    *   declare > player
    */

    local pl                        = LocalPlayer( )

    /*
    *   commands > inner
    */

    self.ct_sub                     = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 4, 8, 7, 10                      )

    /*
    *   commands > body
    */

    self.ct_body                    = ui.new( 'pnl', self.ct_sub, 1         )
    :fill                           ( 'm', 0, 0, 0, 0                       )

    /*
    *   commands > scroll panel
    */

    self.spnl                       = ui.new( 'spnl', self.ct_sub, 1        )
    :fill                           ( 'm', 0, 0                             )
    :padding                        ( 0                                     )

                                    self.spnl.VBar:CreateScrollbar( )

    /*
    *   commands > icon layout
    */

    self.dico                       = ui.new( 'dico', self.spnl, 1          )
    :fill                           ( 'm', 0, 0, 0, 0                       )
    :lodir                          ( FILL                                  )
    :spacing                        ( 0, 0                                  )

                                    :logic( function ( s )
                                        local x = self.spnl.VBar.Enabled and 10 or 0
                                        s:DockMargin( 0, 0, x, 0 )
                                    end )

    /*
    *	loop > cmds
    */

    local i_lst = 0
    for v in helper.get.data( cfg.actions.buttons ) do

        /*
        *	check > enabled
        */

        if not v.enabled then continue end

        /*
        *	check > condition
        */

        if v.condition and not cfg.dev.unlockall then
            local condition         = v.condition( pl )
                                    if not condition then continue end
        end

        /*
        *	loop > cmds > category
        */

        if v.bIsCategory then
            local clr_btn           = v.clrs.btn
            local clr_txt           = v.clrs.txt
            local name              = ln( v.name )
            local l, t, r, b        = v.sizes.pl, v.sizes.pt, v.sizes.pr, v.sizes.pb

            local cat               = ui.add( 'pnl', self.dico              )
            :tall                   ( 25                                    )
            :top                    ( 'm', l, t, r, b                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, clr_btn )
                                        draw.SimpleText( name, pref( 'cmds_list_sep' ), 30, h / 2, clr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

            continue
        end

        /*
        *	loop > cmds > separator
        */

        if v.bIsSep then
            if i_lst == 0 then continue end

            local sep               = ui.add( 'pnl', self.dico              )
            :nodraw                 (                                       )
            :tall                   ( v.sizes.h                             )
            :top                    ( 'm', 0                                )

            continue
        end

        /*
        *	loop > cmds > item > btn
        */

        local clr_btn_n, clr_btn_h  = v.clrs.btn_n, v.clrs.btn_h
        local clr_ico               = v.clrs.ico_n or Color( 182, 59, 75, 255 )

        local b_cmd                 = ui.new( 'btn', self.dico              )
        :bsetup                     (                                       )
        :top                        ( 'm', 0, 1, 0, 0                       )
        :tip                        ( ln( v.tip )                           )
        :tall                       ( 28                                    )
        :setupanim                  ( 'OnHoverFill', 7, rlib.i.OnHover      )
        :anim_click_ol              ( Color( 255, 255, 255, 5 ), 0.4, 1, cfg.dev.bDisableAnim )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, clr_btn_n )
                                        if s.hover then
                                            self:HoverFill( s, w, h, clr_btn_h )
                                        end
                                    end )

                                    :oc( function( s )
                                        ui:dispatch( '$pnl_confirm', mod )

                                        if not pl:Alive( ) then
                                            design:bubble( ln( 'cmds_err_noalive' ), 5 )
                                            return
                                        end

                                        local args = v.args and table.Count( v.args ) or 0
                                        if args == 0 then

                                            if not isfunction( v.action ) then
                                                design:bubble( ln( 'cmds_err_noaction' ), 5 )
                                                return
                                            end

                                            local action = v.action( pl )

                                            ui:unstage( '$pnl_root', mod )

                                            if cvar:GetInt( 'arivia_cmds_aclose', 0 ) == 1 then
                                                DarkRP.closeF4Menu( )
                                            end
                                        else
                                            local confirm                   = ui.rlib( mod, 'diag_args'         )
                                            :lbl                            ( ln( v.name )                      )
                                            :param                          ( 'SetCommand', v                   )
                                            :register                       ( '$pnl_confirm', mod               )
                                        end
                                    end )

        /*
        *	loop > cmds > item > ico
        */

        local ico                   = ui.new( 'pnl', b_cmd                  )
        :left                       ( 'm', 0, 0, 5, 0                       )
        :wide                       ( 20                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( '', pref( 'cmds_list_ico' ), w / 2, h / 2, clr_ico, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *	loop > cmds > item > lbl
        */

        local lbl                   = ui.new( 'lbl', b_cmd                  )
        :txt                        ( ln( v.name )                          )
        :fill                       ( 'm', 5, 2, 10, 2                      )
        :autosize                   (                                       )

        /*
        *	loop > cmds > count
        */

        i_lst                       = i_lst + 1

    end

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
*   @param  : clr clr
*/

function PANEL:SetCommand( cmd )
    self.cmd = cmd
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
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *	declare > main configs
    */

    self.cf_u                       = cfg.ui

    /*
    *   declare > colors
    */

    self.clr_def_txt                = self.cf_u.main.clrs.dt_txt
    self.clr_def_cur                = self.cf_u.main.clrs.dt_cur
    self.clr_def_hl                 = self.cf_u.main.clrs.dt_hl
    self.clr_sep                    = self.cf_u.main.clrs.separator
    self.clr_txt_sec                = self.cf_u.main.clrs.txt_section
    self.clr_ico_sec                = self.cf_u.main.clrs.ico_section
    self.clr_ico_acc                = self.cf_u.main.clrs.ico_accent

end

/*
*   _Call
*/

function PANEL:_Call( )
    timex.simple( 0.05, function( s )
        if not ui:ok( self ) then return end
        self:Run( )
    end )
end

/*
*   register
*/

ui:create( mod, 'pnl_actions', PANEL, 'pnl' )