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
local mf                    = base.mf
local cfg                   = base.cfg
local core                  = base.core

-----------------------------------------------------------------
--  Server Listings
-----------------------------------------------------------------

    cfg.servers.general =
    {
        enabled                     = true,
        icons_text                  = true,
        icons_only                  = false,
        clrs =
        {
            pnl_main                = Color( 21, 21, 21, 255 ),
            pnl_diag_fade           = Color( 15, 15, 15, 230 ),
            pnl_diag_main           = Color( 37, 37, 37, 255 ),
            btn_diag_box_ok         = Color( 64, 105, 126, 190 ),
            btn_diag_box_no         = Color( 124, 51, 50, 190 ),
            btn_diag_txt_ok         = Color( 255, 255, 255, 255 ),
            btn_diag_txt_no         = Color( 255, 255, 255, 255 ),
            btn_list_box_n          = Color( 15, 15, 15, 0 ),
            btn_list_box_h          = Color( 255, 255, 255, 255 ),
            btn_list_txt_n          = Color( 255, 255, 255, 255 ),
            btn_list_txt_h          = Color( 0, 0, 0, 255 ),
        }
    }

    cfg.servers.list =
    {
        {
            hostname                    = 'EXAMPLE SERVER',
            icon                        = 'vliss/vliss_btn_server.png',
            ip                          = '127.0.0.1:27015'
        },
        {
            hostname                    = 'EXAMPLE SERVER 2',
            icon                        = 'vliss/vliss_btn_server.png',
            ip                          = '127.0.0.1:27015'
        }
    }