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
*   declare > default table
*
*   do not modify
*/

    cfg.ent.desc            = { }
    cfg.ent.vehicles        = { }

/*
*   SETTINGS > ENTITIES > DESCRIPTIONS
*/

    /*
    *   entities > custom descriptions > enable
    *
    *   if enabled; this allows you to setup custom descriptions for each entity
    *   that will display within the F4 menu.
    *
    *   if disabled; you will need to setup a description within the darkrp config
    *   for each entity with an example such as:
    *
    *       ent     = 'money_printer',
    *       model   = 'models/props_c17/consolebox01a.mdl',
    *       price   = 1000,
    *       desc    = 'This is a printer'
    *
    *   if NO description is provided either by using the method below, nor in the
    *   darkrp entities file; nothing at all will display below the entity.
    */

        cfg.ent.bAllowCustomDesc = true

    /*
    *   entities > custom descriptions
    *
    *   cfg.ent.bAllowCustomDesc MUST be enabled in order to use anything below
    *
    *   this is a list of custom descriptions you want to setup for each entity.
    *   you can add a new entity by finding the entity name of it within garrys mod.
    *
    *   make all characters lowercase, and replace spaces with underscores
    *
    *   as a superadmin; you can get the call name by hovering the item within the F4 menu and pressing
    *   MIDDLE MOUSE button ( if superadmin tools enabled in F4 menu settings )
    */

        cfg.ent.desc[ 'weapon_ak472' ]          = 'A very powerful Russian made 7.62×39mm assault rifle'
        cfg.ent.desc[ 'weapon_deagle2' ]        = 'A semi-automatic handgun notable for chambering the largest centerfire cartridge of any magazine fed, self loading pistol. It has a relatively unique design with a triangular barrel and large muzzle.'
        cfg.ent.desc[ 'money_printer' ]         = 'This is a money printer'

    /*
    *   entities > ammo
    *
    *   to set custom ammo descriptions; use the value you'd use for ammoType
    *
    *   @ex : ammoType = 'pistol'
    *
    *   you can get the call name by opening the f4 menu, clicking the ammo tab, and pressing
    *   MIDDLE MOUSE button ( if superadmin tools enabled in F4 menu settings ) on the ammo you wish to modify.
    *   this will copy the name to your clipboard which can be pasted here.
    *
    */

        cfg.ent.desc[ 'pistol' ]                    = 'Ammunition for a pistol.'
        cfg.ent.desc[ 'smg1' ]                      = 'Ammunition for a rifle or SMG.'
        cfg.ent.desc[ 'buckshot' ]                  = 'Ammunition for a shotgun.'
        cfg.ent.desc[ 'ar2' ]                       = 'Ammunition for an AR.'

    /*
    *   entities > entities
    */

        cfg.ent.desc[ 'money_printer' ]             = 'Allows money to be printed'
        cfg.ent.desc[ 'darkrp_tip_jar' ]            = 'Always remember to donate generously.'

    /*
    *   entities > vehicles
    */

        cfg.ent.desc[ 'airboat' ]                   = 'It may not look pretty; but you\'ll get from point A to B.'

/*
*   SETTINGS > ENTITIES > VEHICLES
*
*   the vehicles tab includes a special parameter which displays in the circle to the
*   right of each vehicle in the list.
*
*   because vehicles in darkrp dont have anything "special" to report info on,
*   a custom value has been added.
*
*   these settings regulate that
*/

    /*
    *   entities > vehicles > special param > enable
    *
    *   you can either use it for your own purpose, or disable it completely depending on
    *   your needs.
    */

        cfg.ent.vehicles.bCustomValEnabled      = true

    /*
    *   entities > vehicles > special param > name
    *
    *   if you have enabled cfg.ent.vehicles.bCustomValEnabled, then
    *   this value will determine the "name" of the custom value.
    */

        cfg.ent.vehicles.name                   = 'Speed'

    /*
    *   entities > vehicles > special param > list
    *
    *   this is for the custom vehicle param.
    *   by default; we use 'speed' as a special.
    *
    *   it accepts all strings, but we use a number rating for this.
    *   1 being the SLOWEST and 5 being the FASTEST
    *
    *   you can change this label to be whatever.
    */

        cfg.ent.vehicles[ 'airboat' ]           = '3'