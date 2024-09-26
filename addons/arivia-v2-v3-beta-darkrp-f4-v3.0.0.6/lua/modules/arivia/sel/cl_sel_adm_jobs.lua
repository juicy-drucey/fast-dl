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
*   Localized res func
*/

local function resources( t, ... )
    return base:resource( mod, t, ... )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return base.get:pref( str, state )
end

/*
*	localized
*/

local level                 = mod.plugins.level
local prestige              = mod.plugins.prestige
local handle                = mod.handle

/*
*	panels
*/

local PANEL = { }

/*
*	init
*/

function PANEL:Init( )

    /*
    *	parent
    */

    self                            = ui.get( self                          )
    :setup                          (                                       )
    :drawbg                         ( false                                 )
    :drawbg_on                      ( false                                 )
    :drawborder                     ( false                                 )
    :allowkeyboard                  ( true                                  )

    /*
    *	sub
    */

    self.sub                        = ui.new( 'pnl', self, 1                )
    :fill                           (                                       )

    /*
    *   search > box > parent
    */

    self.search                     = ui.new( 'pnl', self.sub               )
    :top                            ( 'm', 5                                )
    :tall                           ( 26                                    )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w - 2, h, Color( 35, 35, 35, 255 ) )
                                    end )

    /*
    *   search > box > dtxt
    */

    self.dval                       = ui.new( 'entry', self.search, 1       )
    :fill                           ( 'm', 5, 2, 2, 2                       )
    :font                           ( pref( 'sel_job_tab_adm_def' )         )
    :val                            ( ln( 'sel_tab_adm_search_def' )        )
    :drawentry                      ( Color( 200, 200, 200, 255 ), Color( 200, 200, 200, 255 ), Color( 200, 200, 200, 255 ) )

                                    :ogfo( function( s )
                                        if s:GetValue( ) == ln( 'sel_tab_adm_search_def' ) then
                                            s:SetValue( '' )
                                        end
                                    end )

                                    :ochg( function( s )
                                        self:Load( )
                                    end )

    /*
    *   search > box > clear button
    */

    self.b_clear                    = ui.new( 'btn', self.dval, 1           )
    :bsetup                         (                                       )
    :right                          ( 'm', 2, 2, 5, 2                       )
    :wide                           ( 20                                    )

                                    :oc( function( s )
                                        self.dval:SetValue( ln( 'sel_tab_adm_search_def' ) )
                                        self:ListPlayers( )
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 4, 0, 0, w, h, Color( 200, 50, 50, 255 ) )
                                        draw.SimpleText( 'x', pref( 'sel_job_tab_adm_src_btn' ), w / 2, h / 2 - 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *	sub
    */

    self.body                       = ui.new( 'pnl', self.sub, 1            )
    :fill                           (                                       )


    /*
    *	scroll
    */

    self.scr                        = ui.new( 'rlib.elm.sp.v2', self.body   )
    :fill                           (                                       )
    :param                          ( 'SetbElastic', true                   )
    :param                          ( 'SetAlwaysVisible', true              )

    /*
    *	Load
    */

    self:ListPlayers( )

end

/*
*	Load
*/

function PANEL:Load( )
    self.scr:Clear( )

    local txt = self.dval:GetValue( )

    for k, v in pairs( player.GetAll( ) ) do
        if txt and not string.match( v:Name( ):lower( ), txt:lower( ) ) then continue end
        self:AddPlayer( k, v )
    end
end

/*
*	Load
*/

function PANEL:ListPlayers( )
    self.scr:Clear( )

    timex.simple( 0.1, function( s )
        for k, v in pairs( player.GetAll( ) ) do
            self:AddPlayer( k, v )
        end
    end )
end

/*
*	AddPlayer
*
*   @param  : int k
*   @param  : ply v
*/

function PANEL:AddPlayer( k, v )

    local name	                    = helper.str:truncate( v:Name( ), 15 )
    local job	                    = helper.str:truncate( team.GetName( v:Team( ) ), 20 )
    local tip                       = ln( 'sel_tab_adm_srch_tip_sw', self.job.name )

    /*
    *	button
    */

    local ply                       = ui.new( 'btn', self.scr               )
    :bsetup                         (                                       )
    :top                            ( 'm', 5, 1, 5, 1                       )
    :tall                           ( 36                                    )
    :tip                            ( tip                                   )

                                    :logic( function( s )
                                        if not s.nthink then s.nthink = 0 return end
                                        if s.nthink > CurTime( ) then return end
                                        if not helper.ok.ply( v ) then return end

                                        job	        = helper.str:truncate( team.GetName( v:Team( ) ), 15 )

                                        s.nthink    = CurTime( ) + 1
                                    end )

                                    :draw( function( s, w, h )
                                        if not helper.ok.ply( v ) then return end

                                        local clr_bg = ( math.fmod( k, 2 ) == 0 and Color( 35, 35, 35, 255 ) ) or Color( 45, 45, 45, 255 )

                                        design.box( 0, 0, w, h, clr_bg )

                                        draw.SimpleText( name, pref( 'sel_job_tab_adm_src_name' ), 46, h / 2 - 1, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( job, pref( 'sel_job_tab_adm_src_name' ), w - 25, h / 2, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        if not ui:ok( mod.pnl.setjob ) then
                                            mod.pnl.setjob = ui.rlib( mod, 'diag_setjob' )
                                        end

                                        mod.pnl.setjob:SetJob               ( self.job, v   )
                                        mod.pnl.setjob:ActionShow           (               )

                                        /*
                                        *	sfx > open
                                        */

                                        local snd       = CreateSound( LocalPlayer( ), resources( 'snd', 'swipe_01' ) )
                                        snd:PlayEx      ( 0.1, 100 )
                                    end )

    /*
    *	left
    */

    local ct_l                      = ui.new( 'pnl', ply, 1                 )
    :left                           (                                       )
    :wide                           ( 38                                    )

    /*
    *	avatar
    */

    local av                        = ui.new( 'av', ct_l                    )
    :sz                             ( 32                                    )
    :left                           ( 'm', 3                                )
    :ply                            ( v, 32                                 )

end

/*
*   job > set
*
*   @param  : tbl job
*/

function PANEL:SetJob( job )
    self.job = job or { }
end

/*
*   paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h ) end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declare( )

    /*
    *	declare > configs
    */

    self.cf_u                       = cfg.ui

    /*
    *	declare > plugins
    */

    self.bLevelEnabled              = level:bEnabled( )
    self.bPrestEnabled              = prestige:bEnabled( )

end

/*
*   _Colorize
*/

function PANEL:_Colorize( )
    self.clr_def_txt                = self.cf_u.main.clrs.dt_txt
end

/*
*   register
*/

ui:create( mod, 'elm_sel_tab_adm_jobs', PANEL, 'pnl' )