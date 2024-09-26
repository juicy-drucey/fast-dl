/*
*   @package        : rcore
*   @module         : arivia
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2015 - 2021
*   @website        : https://rlib.io
*   @docs           : https://docs.rlib.io
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
local storage               = base.s
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
*	getparent
*
*	@return	: pnl
*/

function mod.ui:getparent( )
    local pnl_root = ui:call( '$pnl_root', mod )
    return ui:ok( pnl_root ) and pnl_root or nil
end

/*
*   ui > initialize
*
*   @param  : bool bAutoOpen
*/

function mod.ui:Initialize( bAutoOpen )

    /*
    *   setup > cvars
    *
    *   only needs ran once
    */

    mod.action:Setup( )

    /*
    *   pnl > root
    */

    local pnl_root          = ui:call( '$pnl_root', mod )
                            if ui:visible( pnl_root ) then return end

    /*
    *   pnl > root > create
    *
    *   runs only if root pnl does not exist yet
    */

    mod.ui:Root( )

    /*
    *   autoclose
    *
    *   provides for a 'precaching' type feature.
    *   auto-opens interface and then closes it
    */

    if bAutoOpen then
        timex.simple( 'arivia_cl_init_precache_autoclose', 3, function( )
            ui:unstage( '$pnl_root', mod )
        end )
    end
end

/*
*   ui > rehash
*
*   @param  : bool bForce
*/

function mod.ui:Rehash( bForce )
    mod.ui:Close( bForce )
    if timex.exists( 'arivia_cl_ui_rehash' ) then return end
    timex.create( 'arivia_cl_ui_rehash', 1, 1, function( )
        mod.ui:Bypass( )
    end )
end

/*
*   ui > clear contents
*/

function mod.ui:ClearContents( )
    local p =
    {
        '$pnl_about',
        '$pnl_web',
        '$pnl_ws',
        '$pnl_rules',
        '$pnl_staff',
        '$pnl_settings',
        '$tab_store',
        '$tab_store_nores',
    }

    for v in helper.get.data( p ) do
        ui:unstage( v, mod )
    end
end

/*
*   ui > HideMenus
*
*   hides all sidebars
*
*       >   network
*       >   actions
*       >   store
*/

function mod.ui:HideMenus( )
    ui:unstage( '$mnu_net',     mod     )
    ui:unstage( '$mnu_acts',    mod     )
    ui:unstage( '$mnu_store',   mod     )
end

/*
*   ui > update staff
*/

function mod.ui:UpdateStaff( )

    /*
    *   dispatch > existing pnl
    */

    ui:dispatch( '$pnl_staff', mod )

    /*
    *   get > parent pnl
    */

    local par               = ui:call( '$pnl_content', mod )
                            if not ui:ok( par ) then return end

    /*
    *   pnl > staff
    */

    local content           = ui.rlib( mod, 'pnl_staff', par        )
    :fill                   ( 'm', 0                                )
    :register               ( '$pnl_staff', mod                     )
    :hide                   (                                       )
end

/*
*   UpdateSettings
*
*   updates and loads the settings pnl
*/

function mod.ui:UpdateSettings( )

    /*
    *   dispatch > existing pnl
    */

    ui:dispatch( '$pnl_settings', mod )

    /*
    *   get > parent
    */

    local par                       = ui:call( '$pnl_content', mod )
                                    if not ui:ok( par ) then return end

    /*
    *   pnl > load settings content
    */

    local content                   = ui.rlib( mod, 'pnl_settings', par     )
    :fill                           ( 'm', 0                                )
    :register                       ( '$pnl_settings', mod                  )
    :hide                           (                                       )

end

/*
*   ui > bypass
*
*   used by the script to auto open the interface.
*   should not be called for manual use.
*/

function mod.ui:Bypass( )
    local pnl_root          = ui:call( '$pnl_root', mod )
                            if ui:visible( pnl_root ) then return end
    mod.ui:Open( )
end

/*
*   ui > open
*/

function mod.ui:Open( )

    local pnl_root          = ui:call( '$pnl_root', mod )
                            if not ui:ok( pnl_root ) then
                                mod.loadtime = os.clock( )
                                mod.ui:Root( )
                                return
                            end

    /*
    *   stage root pnl if already exists
    */

    ui:stage( '$pnl_root', mod )
end

/*
*   ui > close
*
*   @param  : bool bForce
*/

function mod.ui:Close( bForce )
    if bForce or cfg.dev.regeneration then
        ui:dispatch( '$pnl_root', mod )
    else
        ui:unstage( '$pnl_root', mod )
    end
end

/*
*   ui > toggle
*/

function mod.ui:Toggle( )
    if not helper.ok.ply( LocalPlayer( ) ) then return end
    local pl = LocalPlayer( )

    /*
    *   check > deny blocked players
    */

    if isfunction( pl.GetBlocked ) and pl:GetBlocked( ) then return end

    /*
    *   toggle flip-flop
    */

    local pnl_root  = ui:call( '$pnl_root', mod )
    if not ui:visible( pnl_root ) then
        mod.ui:Open( )
    else
        mod.ui:Close( )
    end
end

/*
*   ui > workshop
*/

function mod.ui:Workshop( )

    /*
    *   clear existing contents
    */

    mod.ui:ClearContents( )

    /*
    *   get parent pnl
    */

    local par               = ui:call( '$pnl_content', mod )
                            if not ui:ok( par ) then return end

    /*
    *   new workshop pnl
    */

    local pnl_ws            = ui.rlib( mod, 'pnl_ws', par           )
    :register               ( '$pnl_ws', mod                        )
end

/*
*   ui > get > state
*
*   @return : bool
*/

function mod.ui:GetState( )
    local pnl_leftbar       = ui:load( '$pnl_left', mod )
    local bVisible          = ui:ok( pnl_leftbar ) and ui:visible( '$pnl_left', mod ) and true or false

    return bVisible
end

/*
*   ui > set > state
*
*   @param  : pnl s
*   @param  : pnl pnl
*/

function mod.ui:SetState( s, pnl )

    local bVisible          = self:GetState( )

    local stage             = bVisible and '$btn_toggle' or '$pnl_left'
    local unstage           = bVisible and '$pnl_left' or '$btn_toggle'

    ui:stage                ( stage,    mod )
    ui:unstage              ( unstage,  mod )

    s:tooltip               ( bVisible and ln( 'tt_toggle_show' ) or ln( 'tt_toggle_hide' ) )
    cvar:SetBool            ( 'arivia_ui_maximized', bVisible and true or false )

    pnl:InvalidateChildren( )

end

/*
*   disconnect > initialize
*/

function mod.dc:Initialize( )
    ui:dispatch( '$diag_dcserv', mod )

    local diag_dc                   = ui.rlib( mod, 'diag_dcserv'           )
    :register                       ( '$diag_dcserv', mod                   )
end