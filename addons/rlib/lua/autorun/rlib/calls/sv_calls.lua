/*
    @library        : rlib
    @docs           : https://docs.rlib.io

    IF YOU HAVE NOT DIRECTLY RECEIVED THESE FILES FROM THE DEVELOPER, PLEASE CONTACT THE DEVELOPER
    LISTED ABOVE.

    THE WORK (AS DEFINED BELOW) IS PROVIDED UNDER THE TERMS OF THIS CREATIVE COMMONS PUBLIC LICENSE
    ('CCPL' OR 'LICENSE'). THE WORK IS PROTECTED BY COPYRIGHT AND/OR OTHER APPLICABLE LAW. ANY USE OF
    THE WORK OTHER THAN AS AUTHORIZED UNDER THIS LICENSE OR COPYRIGHT LAW IS PROHIBITED.

    BY EXERCISING ANY RIGHTS TO THE WORK PROVIDED HERE, YOU ACCEPT AND AGREE TO BE BOUND BY THE TERMS
    OF THIS LICENSE. TO THE EXTENT THIS LICENSE MAY BE CONSIDERED TO BE A CONTRACT, THE LICENSOR GRANTS
    YOU THE RIGHTS CONTAINED HERE IN CONSIDERATION OF YOUR ACCEPTANCE OF SUCH TERMS AND CONDITIONS.

    UNLESS OTHERWISE MUTUALLY AGREED TO BY THE PARTIES IN WRITING, LICENSOR OFFERS THE WORK AS-IS AND
    ONLY TO THE EXTENT OF ANY RIGHTS HELD IN THE LICENSED WORK BY THE LICENSOR. THE LICENSOR MAKES NO
    REPRESENTATIONS OR WARRANTIES OF ANY KIND CONCERNING THE WORK, EXPRESS, IMPLIED, STATUTORY OR
    OTHERWISE, INCLUDING, WITHOUT LIMITATION, WARRANTIES OF TITLE, MARKETABILITY, MERCHANTIBILITY,
    FITNESS FOR A PARTICULAR PURPOSE, NONINFRINGEMENT, OR THE ABSENCE OF LATENT OR OTHER DEFECTS, ACCURACY,
    OR THE PRESENCE OF ABSENCE OF ERRORS, WHETHER OR NOT DISCOVERABLE. SOME JURISDICTIONS DO NOT ALLOW THE
    EXCLUSION OF IMPLIED WARRANTIES, SO SUCH EXCLUSION MAY NOT APPLY TO YOU.
*/

/*
    library > routes
*/

local base                  = rlib
local helper                = base.h

/*
    library > localize
*/

local mf                    = base.manifest
local pf                    = mf.prefix

/*
    language
*/

local function ln( ... )
    return base:lang( ... )
end

/*
*   simplifiy funcs
*/

local function log( ... ) base:log( ... ) end

/*
*   calls > catalog
*
*   loads library calls catalog
*
*   :   (bool) bPrefix
*       true adds lib prefix at front of all network entries
*       'rlib.network_string_id'
*
*   :   (str) affix
*       bPrefix must be true, determines what prefix to add to
*       the front of a netnw string. if none provided, lib prefix
*       will be used
*
*   @param  : bool bPrefix
*   @param  : str affix
*/

function base.calls:Catalog( bPrefix, affix )
    for v in helper.get.data( base._rcalls[ 'net' ] ) do
        local aff       = isstring( affix ) and affix or mf.prefix
        local id        = bPrefix and tostring( aff .. v[ 1 ] ) or tostring( v[ 1 ] )

        local nid       = GetGlobalString( ('rlib_sess'), 0 )
        local i         = string.format( '%s', id )

        util.AddNetworkString( i )
        base:log( RLIB_LOG_RNET, ln( 'rnet_added', i ) )
    end
end