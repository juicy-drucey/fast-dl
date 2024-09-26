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

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   register net libraries
*/

local function rnet_register( pl )

    /*
    *	permission :: rnet refresh
    */

    if ( ( helper.ok.ply( pl ) or base.con:Is( pl ) ) and not access:allow_throwExcept( pl, 'rlib_root' ) ) then return end

    /*
    *   rnet > initialize
    */

    rnet.new        ( 'arivia_sv_pl_setup'          )
    rnet.run        (                               )

    /*
    *   rnet > liko_ui_init
    *
    *   opens the mod main interface
    */

    rnet.new		( 'arivia_sv_all_data_rehash'   )
    rnet.run	    (                               )

    /*
    *   concommand :: reload
    */

    if helper.ok.ply( pl ) or base.con:Is( pl ) then
        base:log( 4, '[ %s ] reloaded rnet', mod.name )
        if not base.con.Is( pl ) then
            base.msg:target( pl, mod.name, 'reloaded rnet' )
        end
    end

end
rhook.new.rlib( 'arivia_rnet_register', rnet_register )
rcc.new.rlib( 'arivia_rnet_reload', rnet_register )