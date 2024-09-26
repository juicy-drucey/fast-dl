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

    cfg.food.desc           = { }
    cfg.food.categories     = { }

/*
*   SETTINGS > FOOD > CATEGORIES
*/

    /*
    *   food > categories
    *
    *   darkrp gives you the ability to create categories for entities, shipments, etc.
    *   however, has no support for custom categories for food that can be controlled.
    *   this table allows you to define categories for food.
    *
    *   to assign a category to a particular food item; edit the darkrp file ( sh_init.lua )
    *   and add the category:
    *
    *   category must be registered in this table otherwise the food category will start
    *   collapsed. cat must have startExpanded = true
    *
    *   @params :
    *       >   name                name of the category
    *       >   startExpanded       if category will be opened or closed when food tab clicked
    *       >   sortOrder           where in the list the cat will display ( 1 = top )
    *       >   tip                 tip to display when mouse hovers over cat tab
    *       >   color               color of category
    *
    *   if you set a custom color for each category, ensure:
    *       open    > lua\modules\arivia\cfg\sh_4_tabs.lua
    *       find    > cfg.tabs.food
    *       set     > bCatColors = true
    */

        cfg.food.categories =
        {
            [ 'other' ] =
            {
                name                = 'Other',
                startExpanded       = true,
                sortOrder           = 1,
                tip                 = 'General food items',
            },
        }

    /*
    *   entities > food
    */

        cfg.food.desc[ 'banana' ]               = 'This is a banana. Oh how wonderful it is.'
        cfg.food.desc[ 'bunch_of_bananas' ]     = 'This is a bundle of bananas straight from Africa - ensuring you get the best in quality.'
        cfg.food.desc[ 'melon' ]                = 'A giant melon, who doesn\'t like melons?'
        cfg.food.desc[ 'glass_bottle' ]         = 'The same bottle you use at a bar fight - now gives energy.'
        cfg.food.desc[ 'pop_can' ]              = 'High in sugar, this is sure to give you an energetic jolt.'
        cfg.food.desc[ 'plastic_bottle' ]       = 'This plastic bottle is full of... well... a liquid.'
        cfg.food.desc[ 'milk' ]                 = 'It\'s only three days past expired -- still healthy for you.'
        cfg.food.desc[ 'bottle_1' ]             = 'A nice beverage from the tropics. It contains cherries, oranges, and some type of vodka.'
        cfg.food.desc[ 'bottle_2' ]             = 'A strange bottle that was located next to a bum.'
        cfg.food.desc[ 'bottle_3' ]             = 'It smells cheap, but it will still keep you hydrated.'
        cfg.food.desc[ 'orange' ]               = 'A ripe firm orange.'