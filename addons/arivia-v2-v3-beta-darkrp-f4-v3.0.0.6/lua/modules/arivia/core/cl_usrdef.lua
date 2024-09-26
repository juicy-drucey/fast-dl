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
*	usrdef > setup
*
*	setup clientside params for a player
*
*   @param  : tbl data
*/

function mod.usrdef:Setup( )

    local bHasRan = false

    local function setup( )
        if bHasRan then return end

        local pl                = LocalPlayer( )
        pl.rlib                 = pl.rlib or { }                -- parent
        pl.rlib.arivia          = pl.rlib.arivia or { }         -- subparent
        pl.rlib.arivia.res_w    = ScrW( )                       -- stored screen resolution ( w )
        pl.rlib.arivia.res_h    = ScrH( )                       -- stored screen resolution ( h )

        bHasRan                 = true

        rhook.drop.gmod( 'Think', 'arivia_cl_usrdef_setup_th' )
    end
    rhook.new.gmod( 'Think', 'arivia_cl_usrdef_setup_th', setup )

end

/*
*   usrdef > setup
*
*   set a client-side convar which determines the default cfg.
*
*   @param  : str hash
*/

function mod.action:Setup( )
    local pl_teamid         = mod.jobs and mod.jobs.current or GAMEMODE.DefaultTeam
    local job_mdl           = RPExtraTeams[ pl_teamid ]
    job_mdl                 = istable( job_mdl.model ) and job_mdl.model[ 1 ] or job_mdl.model

    /*
    *   cvar > create
    */

    cvar:CreateClient( 'arivia_mview_path', job_mdl, true, false, 'arivia :: mdlv :: default mdl path' )
    cvar:CreateClient( 'arivia_ui_maximized', '0', true, false, 'arivia :: interface maximized' )

    /*
    *   cvar > set
    */

    cvar:SetStr( 'arivia_mview_path', job_mdl )

    /*
    *   default team
    */

    mod.jobs.current                = GAMEMODE.DefaultTeam

end