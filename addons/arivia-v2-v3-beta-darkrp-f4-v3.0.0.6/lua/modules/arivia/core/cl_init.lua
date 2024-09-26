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
*	localized plugin
*/

local handle                = mod.handle

/*
*	pl > onchangeteam
*
*   called when pl changes teams
*/

local function pl_onchangeteam( pl, old, new )

    /*
    *	declare > new job
    */

    mod.jobs.current = new

    /*
    *	slots > rehash
    *
    *   refreshes data slots
    */

    timex.simple( 0.1, function( )
        local pnl_base      = ui:call( '$pnl_base', mod )
                            if ui:ok( '$pnl_base', mod ) then
                                handle.tab:Reset( )
                                pnl_base:RehashStore( )
                            end
    end )

    /*
    *	notifications
    */

    if cfg.general.switch_notify then
        local pl_team       = team.GetName( new )
        local data          = { Color( 255, 255, 255, 255 ), 'You are now a ', Color( 31, 133, 222, 255 ), pl_team }

        design:rbubble( data, 10 )
    end
end
rhook.new.gmod( 'OnPlayerChangedTeam', 'arivia_cl_pl_teamchange', pl_onchangeteam )

/*
*	rnet > data > update
*
*   forces ui data to rehash for everyone after a
*   player switches teams
*/

local function rnet_data_update( data )

    /*
    *	refresh all slot data
    */

    /*
    local pnl_root          = ui:call( '$pnl_root', mod )
                            if ui:ok( pnl_root ) then
                                handle.jsl:Rehash( )
                            end
    */

    /*
    *	used to refresh content
    *   not needed if developer mode on
    *
    *   clears all registered directory tabs
    *   reloads all item tabs ( jobs, ents, etc )
    */

    /*
    timex.simple( 0.1, function( )
        local pnl_base      = ui:call( '$pnl_base', mod )
                            if ui:ok( '$pnl_base', mod ) then
                                handle.tab:Reset( )
                                pnl_base:RehashStore( )
                            end
    end )
    */

end
rnet.call( 'arivia_sv_all_data_rehash', rnet_data_update )

/*
*	interface > think
*/

local function th_initialize( )
    if not helper.ok.ply( LocalPlayer( ) ) then return end
    local pl = LocalPlayer( )

    if isfunction( pl.GetBlocked ) and pl:GetBlocked( ) then return end

    if mod.bInitialized then return end
end
rhook.new.gmod( 'Think', 'arivia_cl_init_precache', th_initialize )

/*
*	init_post_ent
*/

local function ipe( )

    /*
    *	register fonts
    */

    rhook.run.rlib( 'arivia_fonts_register' )

    /*
    *	assign route > DarkRP
    */

    DarkRP.openF4Menu               = mod.ui.Open
    DarkRP.closeF4Menu              = mod.ui.Close
    DarkRP.toggleF4Menu             = mod.ui.Toggle

    /*
    *   bind > ShowSpare2
    */

    GAMEMODE.ShowSpare2             = DarkRP.toggleF4Menu
end
rhook.new.gmod( 'InitPostEntity', 'arivia_cl_ipe', ipe )

/*
*	gm_onreload
*/

local function gm_onreload( )

    /*
    *	destroy parent pnl
    */

    ui:dispatch( '$pnl_root', mod )

    /*
    *	initpostent
    */

    ipe( )

    /*
    *   lua refresh
    */

    if cfg.dev.regeneration then
        print( ln( 'dev_luaref' ) )
    end
end
rhook.new.gmod( 'OnReloaded', 'arivia_cl_gm_onreload', gm_onreload )