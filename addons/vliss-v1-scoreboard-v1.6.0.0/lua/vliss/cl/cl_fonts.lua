/*
*   @package        : rcore
*   @module         : vliss
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2016 - 2020
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

local base                  = vliss
local cfg                   = base.cfg

/*
*   misc localization
*/

local _f = surface.CreateFont

/*
*   general
*/

    _f( 'vliss_g_header',                       { size = 30, weight = 400, antialias = true, shadow = true, font = 'Advent Pro Light' } )

/*
*   sb
*/

    _f( 'vliss_sb_team_join',                   { size = 22, weight = 400, antialias = true, shadow = false, font = 'Tasmania' } )
    _f( 'vliss_sb_team_name',                   { size = 22, weight = 100, antialias = true, shadow = false, font = 'Tasmania' } )
    _f( 'vliss_sb_pl_name_real',                { size = 18, weight = 300, antialias = true, shadow = false, font = 'Tasmania' } )
    _f( 'vliss_sb_pl_ratio',                    { size = 26, weight = 100, antialias = true, shadow = false, font = 'Tasmania Middle' } )
    _f( 'vliss_sb_pl_name_fake',                { size = 22, weight = 200, antialias = true, shadow = false, font = 'Tasmania Middle' } )
    _f( 'vliss_sb_column_title_name',           { size = 16, weight = 400, antialias = true, shadow = false, font = 'Oort Light' } )
    _f( 'vliss_sb_column_title_data',           { size = 16, weight = 400, antialias = true, shadow = false, font = 'Oort Light' } )
    _f( 'vliss_sb_column_ply',                  { size = 19, weight = 100, antialias = true, shadow = false, font = 'Rlib Sans Light' } )

/*
*   slmenu
*/

    _f( 'vliss_slmenu_pl_name',                 { size = 23, weight = 100, antialias = true, shadow = false, font = 'Europa Light' } )
    _f( 'vliss_slmenu_pl_money',                { size = 19, weight = 100, antialias = true, shadow = false, font = 'Tasmania' } )

/*
*   server swutch
*/

    _f( 'vliss_cwserv_hdr_icon',                { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( 'vliss_cwserv_hdr_title',               { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( 'vliss_cwserv_hdr_exit',                { size = 24, weight = 800, antialias = true, font = 'Roboto' } )
    _f( 'vliss_cwserv_btn_clr',                 { size = 41, weight = 800, antialias = true, font = 'Roboto' } )
    _f( 'vliss_cwserv_btn_copy',                { size = 18, weight = 800, antialias = true, font = 'Roboto' } )
    _f( 'vliss_cwserv_btn_confirm',             { size = 18, weight = 800, antialias = true, font = 'Roboto' } )
    _f( 'vliss_cwserv_err',                     { size = 14, weight = 800, antialias = true, font = 'Roboto' } )
    _f( 'vliss_cwserv_name',                    { size = 26, weight = 100, antialias = true, font = 'Roboto Condensed' } )
    _f( 'vliss_cwserv_desc',                    { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( 'vliss_cwserv_info_icon',               { size = 31, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( 'vliss_cwserv_copyclip',                { size = 14, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )


-----------------------------------------------------------------
-- [ FONTS ]
-----------------------------------------------------------------

surface.CreateFont("VlissFontCloseGUI", {
    size = 14,
    weight = 700,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontBrowserTitle", {
    size = 26,
    weight = 100,
    antialias = true,
    shadow = false,
    font = "Teko Light"
})

surface.CreateFont("VlissFontNetworkName", {
    size = 34,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Advent Pro Light"
})

surface.CreateFont("VlissFontOnlineStaff", {
    size = 34,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Advent Pro Light"
})

surface.CreateFont("VlissFontServerInfo", {
    size = 22,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontServerStaffCount", {
    size = 22,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontPlayerName", {
    size = 22,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontStandardText", {
    size = 16,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})


surface.CreateFont("VlissFontSandboxItemLabel", {
    size = 11,
    weight = 500,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontSandboxItemAmt", {
    size = 12,
    weight = 200,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontControlKey", {
    size = 46,
    weight = 200,
    antialias = true,
    shadow = true,
    font = "Teko Light"
})

surface.CreateFont("VlissFontControlDesc", {
    size = 22,
    weight = 200,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontCardPlayerName", {
    size = 26,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontCardSteamID", {
    size = 18,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontCardRank", {
    size = 22,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontPlayername", {
    size = 22,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontRPMoney", {
    size = 34,
    weight = 200,
    antialias = true,
    shadow = false,
    font = "Teko Light"
})

surface.CreateFont("VlissFontSteamID", {
    size = 26,
    weight = 100,
    antialias = true,
    shadow = false,
    font = "Teko Light"
})

surface.CreateFont("VlissFontClock", {
    size = 34,
    weight = 100,
    antialias = true,
    shadow = false,
    font = "Teko Light"
})

surface.CreateFont("VlissFontMenuItem", {
    size = 25,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontButtonItem", {
    size = 18,
    weight = 200,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissFontMenuSubinfo", {
    size = 16,
    weight = 300,
    antialias = true,
    shadow = false,
    font = "Oswald Light"
})

surface.CreateFont("VlissAboutText", {
    size = 28,
    weight = 100,
    antialias = true,
    shadow = false,
    font = "Teko Light"
})

surface.CreateFont("VlissAboutUpdateText", {
    size = 16,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissAboutUpdateResultText", {
    size = 14,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontStandardAbout", {
    size = 15,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontAboutSInfo", {
    size = 15,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontAboutUpdateText", {
    size = 40,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Teko Light"
})

surface.CreateFont("VlissFontConfirmTitle", {
    size = 32,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Teko Light"
})

surface.CreateFont("VlissFontConfirmText", {
    size = 14,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontConfirmBText", {
    size = 26,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontConfirmButton", {
    size = 14,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontPHSpecTitle", {
    size = 14,
    weight = 500,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontPHSpecList", {
    size = 14,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})

surface.CreateFont("VlissFontTTTRemaining", {
    size = 14,
    weight = 400,
    antialias = true,
    shadow = false,
    font = "Roboto"
})