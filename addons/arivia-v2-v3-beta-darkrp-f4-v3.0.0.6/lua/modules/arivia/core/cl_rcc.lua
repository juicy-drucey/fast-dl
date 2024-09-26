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
*   rcc > ui > toggle
*
*   determines if the parent pnl is valid or not and hides it
*   if parent pnl doesnt exist, will be created and shown
*
*   @param  : void
*   @return : void
*/

local function rcc_ui_toggle( )
    local pnl = mod.ui:getparent( )
    if not ui:ok( pnl ) then
        mod.ui:Initialize( )
        return
    end

    if ui:visible( pnl ) then
        if cfg.dev.regeneration then
            ui:dispatch( pnl )
        else
            ui:unstage( pnl )
        end
    else
        ui:stage( pnl )
    end
end
rcc.new.rlib( 'arivia_toggle_m0', rcc_ui_toggle )
rcc.new.rlib( 'arivia_toggle_m1', rcc_ui_toggle )

/*
*   rcc > ui > toggle
*
*   determines if the parent pnl is valid or not and hides it
*   if parent pnl doesnt exist, will be created and shown
*
*   @param  : void
*   @return : void
*/

local function rcc_ui_rehash( )
    local pnl = mod.ui:getparent( )
    if not ui:ok( pnl ) then
        mod.ui:Initialize( )
        return
    end

    if ui:visible( pnl ) then
        if cfg.dev.regeneration then
            ui:dispatch( pnl )
        else
            ui:unstage( pnl )
        end
    else
        ui:stage( pnl )
    end
end
rcc.new.rlib( 'arivia_ui_rehash', rcc_ui_rehash )

/*
*   rcc > ui > pnls
*
*   @param  : void
*   @return : void
*/

local function rcc_ui_pnls( )
    local src = base.modules:RegisteredPnls( mod )
    PrintTable( src )
end
rcc.new.rlib( 'arivia_ui_pnls', rcc_ui_pnls )

/*
*   rcc > ui > load store
*
*   @param  : void
*   @return : void
*/

local function rcc_ui_loadstore( )
    local pnl_root          = ui:call( '$pnl_root', mod )
    if ui:ok( pnl_root ) then
        handle.jsl:Rehash( )
    end

    timex.simple( 0.5, function( )
        local pnl_base      = ui:call( '$pnl_base', mod )
        pnl_base:RehashStore( )
    end )
end
rcc.new.rlib( 'arivia_ui_loadstore', rcc_ui_loadstore )