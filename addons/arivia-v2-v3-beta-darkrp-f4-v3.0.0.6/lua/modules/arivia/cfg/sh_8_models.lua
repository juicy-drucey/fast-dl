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
*   SETTINGS > MODELS
*/

    /*
    *   model > selection > manual
    *
    *   right side model displayed when item / job selected.
    *
    *   allows you to specify exactly how a model appears.
    *   you need to provide the fov, cam, and look parameters.
    *
    *   you can find these by opening the f4, selecting a job, and clicking
    *   the model to the right side. it will open a model viewer.
    *   use the sliders to adjust the position, and then copy those values
    *   into the table below with the path of the model
    *
    *   @param  : fov
    *             adjust field of view
    *
    *   @param  : cam ( coming soon )
    *             camera vector( x, y, z )
    *
    *   @param  : look ( coming soon )
    *             lookat vector( x, y, z )
    *
    *   @param  : speed
    *             how fast a model will rotate
    *               > default           : 40
    *               > stop rotation     : 0
    *
    *   @param  : oset
    *             offset vector( x, y, z )
    *             does not set the specific vector you provide; offsets based on the original position + offset
    */

        cfg.models.sel.man =
        {

            /*
            [ 'example/path/modelname.mdl' ] =
            {
                fov     = 10,
                cam     = Vector( 250, 13, 111 ),
                look    = Vector( 0, 0, 56 ),
                speed   = 60,
                note    = 'An example',
            },

            [ 'example/path/example_2.mdl' ] =
            {
                fov     = 15,
                note    = 'An example',
            },
            */

            [ 'models/props_lab/crematorcase.mdl' ] =
            {
                fov     = 115,
                note    = 'Drug lab',
            },

            [ 'models/props_c17/TrapPropeller_Engine.mdl' ] =
            {
                fov     = 100,
                note    = 'Gun lab',
            },

            [ 'models/weapons/w_smg_mac10.mdl' ] =
            {
                oset    = Vector( 0, 0, 1 ),
                note    = 'Mac 10',
            }

        }

    /*
    *   model > slot > manual
    *
    *   model that appears to the left of each listed item / job ( middle of interface )
    *
    *   allows you to specify exactly how a model appears.
    *   you need to provide the fov, cam, and look parameters.
    *
    *   you can find these by opening the f4, selecting a job, and clicking
    *   the model to the right side. it will open a model viewer.
    *   use the sliders to adjust the position, and then copy those values
    *   into the table below with the path of the model
    *
    *   @param  : fov
    *             adjust field of view
    *
    *   @param  : cam
    *             camera vector( x, y, z )
    *
    *   @param  : look
    *             lookat vector( x, y, z )
    *
    *   @param  : oset
    *             offset vector( x, y, z )
    *             does not set the specific vector you provide; offsets based on the original position + offset
    */

        cfg.models.slot.man =
        {

            /*
            [ 'example/path/modelname.mdl' ] =
            {
                fov     = 10,
                cam     = Vector( 250, 13, 111 ),
                look    = Vector( 0, 0, 56 ),
                oset    = Vector( 0, 5, 0 ),
                note    = 'An example',
            },

            [ 'example/path/example_2.mdl' ] =
            {
                fov     = 15,
                note    = 'An example',
            },
            */

        }