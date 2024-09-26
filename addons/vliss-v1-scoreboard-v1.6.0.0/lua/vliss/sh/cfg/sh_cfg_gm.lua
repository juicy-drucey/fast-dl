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
*   gamemode loader
*
*   this table contains the loader for which
*   features are enabled based on the gamemode you are running.
*
*   only edit this if you know what you're doing
*/

cfg.Gamemodes =
{

    /*
    *   sandbox
    */

    [ 'sandbox' ]           = { id = 'sb', name = 'Sandbox' },

    /*
    *   rp
    */

    [ 'darkrp' ]            = { id = 'rp', name = 'DarkRP' },
    [ 'dark_rp' ]           = { id = 'rp', name = 'RP Based' },
    [ 'starwarsrp' ]        = { id = 'rp', name = 'Starwars RP' },
    [ 'starwars)rp' ]       = { id = 'rp', name = 'Starwars RP' },
    [ 'hogwartsrp' ]        = { id = 'rp', name = 'Hogwarts RP' },
    [ 'hogwarts_rp' ]       = { id = 'rp', name = 'Hogwarts RP' },

    /*
    *   prophunt
    */

    [ 'prophunt' ]          = { id = 'ph', name = 'PropHunt', teams = { hunters = 1, props = 2, spec = 3 } },
    [ 'prop_hunt' ]         = { id = 'ph', name = 'PropHunt', teams = { hunters = 1, props = 2, spec = 3 } },
    [ 'prophunters' ]       = { id = 'ph', name = 'PropHunt', teams = { hunters = 2, props = 3, spec = 1 } },

    /*
    *   ttt
    */

    [ 'ttt' ]               = { id = 'ttt', name = 'Terror Town' },
    [ 'terror_town' ]       = { id = 'ttt', name = 'Terror Town' },
    [ 'terrortown' ]        = { id = 'ttt', name = 'Terror Town' },

    /*
    *   murder
    */

    [ 'mu' ]                = { id = 'mu', name = 'Murder' },
    [ 'murder' ]            = { id = 'mu', name = 'Murder' },

    /*
    *   deathrun
    */

    [ 'deathrun' ]          = { id = 'dr', name = 'Deathrun' },
    [ 'death_run' ]         = { id = 'dr', name = 'Deathrun' },

    /*
    *   deathrun
    */

    [ 'melonbomber' ]       = { id = 'mb', name = 'Melon Bomber' },

    /*
    *   zombie survival
    */

    [ 'zombiesurvival' ]    = { id = 'zs', name = 'Zombie Survival' },
    [ 'zombie' ]            = { id = 'zs', name = 'Zombie Survival' },
}