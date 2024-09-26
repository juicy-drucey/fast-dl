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

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   SETTINGS > SERVERS
*/

    /*
    *	servers > general
    *
    *   settings related to overall servers feature
    *
    *   >   enabled         : true      > servers will be listed within script
    *                       : false     > no server selection interface will show
    *
    *   >   type            : [ 1 ]     > Menu will display TEXT + ICONS
    *                         [ 2 ]     > Menu will display ICONS ONLY
    *                         [ 3 ]     > Menu will display TEXT ONLY
    *
    *   >   validation      : true      > server ip will be validated and warn if invalid ip provided
    *                       : false     > server ip will NOT be validated and allow you to input anything
    *                                     ( use this if using a DNS instead of IP )
    *
    *                         to ensure the proper data is given for a server's ip address, this
    *                         feature will check to see if you gave a valid ip for your server and warn you
    *                         if you didnt.
    *
    *                         set this to FALSE if you are going to use a DNS for players to connect with:
    *                         @example:   yourserver.yourdomain.com
    */

        cfg.servers =
        {
            enabled                 = true,
            type                    = 1,
            validation              = true,
            clrs =
            {
                parent              = Color( 5, 5, 5, 100 ),
                primary             = Color( 255, 255, 255, 2 ),
                secondary           = Color( 255, 136, 0, 255 ),
                text_name           = Color( 255, 255, 255, 255 ),
                text_list           = Color( 255, 255, 255, 255 ),
                text_confirm        = Color( 255, 255, 255, 255 ),
                ico_n               = Color( 168, 70, 70, 255 ),
                ico_h               = Color( 255, 255, 255, 255 ),
                txt_n               = Color( 255, 255, 255, 255 ),
                txt_h               = Color( 255, 255, 255, 255 ),
                btn_n               = Color( 15, 15, 15, 0 ),
                btn_h               = Color( 168, 70, 70, 255 ),
                uline               = Color( 255, 255, 255, 255 ),
            }
        }

    /*
    *	servers > list
    *
    *	list of servers that a player can pick from in a list within the motd.
    *
    *   >   enabled         : true      > server will be displayed in list for players to connec to
    *                       : false     > server will NOT be displayed
    *
    *   >   hostname        : name of your server
    *
    *   >   desc            : tooltip that will appear when mouse is hovered over the server button
    *
    *   >   mat             : direct material path to an icon you have uploaded to a workshop
    *
    *   >   rmat            : rlib specific registered material
    *
    *   >   ip              : address that player will connect to when button clicked
    */

        cfg.servers.list =
        {
            {
                enabled         = true,
                hostname        = 'DarkRP',
                desc            = 'Visit our DarkRP server',
                mat             = 'rlib/modules/lunera/v3/connect.png',
                rmat            = 'gen_connect_01',
                ip              = '192.168.0.2:27015'
            },
            {
                enabled         = true,
                hostname        = 'Sandbox',
                desc            = 'Visit our Sandbox server',
                mat             = 'rlib/modules/lunera/v3/connect.png',
                rmat            = 'gen_connect_01',
                ip              = 'server.ipaddress:27015'
            }
        }