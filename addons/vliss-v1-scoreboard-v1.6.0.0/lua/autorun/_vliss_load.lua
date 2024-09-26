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

/*
*   loader > tables
*/

vliss                       = vliss or { }
vliss.mf                    = vliss.mf or { }

local base                  = vliss
local mf                    = base.mf

/*
*   loader > general
*/

mf.name                     = 'Vliss'
mf.folder                   = 'vliss'
mf.id                       = 'd4ee83d0-957c-475e-8ab1-f9e223981778'
mf.owner                    = '76561199237832821'
mf.author                   = 'Richard'
mf.build                    = '1.6.0'
mf.released                 = '1607514593'
mf.site                     = 'https://gmodstore.com/scripts/view/' .. mf.id .. '/'
mf.docs                     = 'https://vliss.rlib.io/'

/*
*   workshops
*
*   a list of steam workshop collection ids that are associated to this script. On server boot, these
*   workshops will be mounted to the server both server and client-side.
*/

    mf.workshops =
    {
        '2306283801'
    }

/*
*   fastdl
*
*   list of folders which will include materials, resources, sounds that will be included using
*   resource.AddFile
*/

    mf.fastdl =
    {
        'materials',
        'sound',
        'resource',
    }

/*
*    fonts
*
*    a list of the custom fonts used for this script. these will be used within the Resources section
*    in order to ensure the proper fonts are added to the server.
*
*    in most cases, this table will be empty unless content needs loaded here in special circumstances.
*    check each modules' manifest file for any custom content being loaded.
*
*    @ex    : font.ttf
*/

    mf.fonts =
    {
        'adventpro_light.ttf',
        'gsym_adv.ttf',
        'gsym_black.ttf',
        'gsym_light.ttf',
        'gsym_reg.ttf',
        'gsym_solid.ttf',
        'montserrat_black.ttf',
        'montserrat_bold.ttf',
        'montserrat_extrabold.ttf',
        'montserrat_extralight.ttf',
        'montserrat_light.ttf',
        'montserrat_medium.ttf',
        'montserrat_regular.ttf',
        'montserrat_thin.ttf',
        'oswald_light.ttf',
        'raleway_black.ttf',
        'raleway_bold.ttf',
        'raleway_extra_bold.ttf',
        'raleway_extra_light.ttf',
        'raleway_light.ttf',
        'raleway_medium.ttf',
        'raleway_regular.ttf',
        'raleway_semibold.ttf',
        'raleway_thin.ttf',
        'roboto_bk.ttf',
        'roboto_black.ttf',
        'roboto_bold.ttf',
        'roboto_bold_italic.ttf',
        'roboto_italic.ttf',
        'roboto_light.ttf',
        'roboto_lightitalic.ttf',
        'roboto_lt.ttf',
        'roboto_medium.ttf',
        'roboto_mediumitalic.ttf',
        'roboto_regular.ttf',
        'roboto_th.ttf',
        'roboto_thin.ttf',
        'roboto_thinitalic.ttf',
        'robotocondensed_bold.ttf',
        'robotocondensed_bolditalic.ttf',
        'robotocondensed_italic.ttf',
        'robotocondensed_light.ttf',
        'robotocondensed_lightitalic.ttf',
        'robotocondensed_regular.ttf',
        'tasmania_expandedlight.ttf',
        'tasmania_middle.ttf',
        'tasmania_regular.ttf',
        'teko_light.ttf',
        'titillium_web_light.ttf',
        'titillium_web_thin.ttf',
        'ubuntu_bold.ttf',
        'ubuntu_light.ttf',
        'ubuntu_medium.ttf',
        'ubuntu_regular.ttf',
    }

/*
*   loader > tables > general
*/

base.cfg                    = base.cfg or { }
base.cfg.general            = base.cfg.general or { }
base.cfg.perms              = base.cfg.perms or { }
base.cfg.groups             = base.cfg.groups or { }
base.cfg.spiffyav           = base.cfg.spiffyav or { }
base.cfg.staffcard          = base.cfg.staffcard or { }
base.cfg.slmenu             = base.cfg.slmenu or { }
base.cfg.widget             = base.cfg.widget or { }
base.cfg.acts               = base.cfg.acts or { }
base.cfg.dev                = base.cfg.dev or { }

base.cfg.bg                 = base.cfg.bg or { }
base.cfg.bg.static          = base.cfg.bg.static or { }
base.cfg.bg.live            = base.cfg.bg.live or { }
base.cfg.bg.filter          = base.cfg.bg.filter or { }

base.cfg.servers            = base.cfg.servers or { }
base.cfg.servers.general    = base.cfg.servers.general or { }
base.cfg.servers.list       = base.cfg.servers.list or { }

/*
*   loader > tables > general
*/

base._def                   = base._def or { }
base.core                   = base.core or { }
base.cmds                   = base.cmds or { }
base.lang                   = base.lang or { }
base.handle                 = base.handle or { }
base.handle.util            = base.handle.util or { }

/*
*   loader > tables > gamemodes
*/

base.sb                     = base.sb or { }
base.mu                     = base.mu or { }
base.ttt                    = base.ttt or { }
base.rp                     = base.rp or { }
base.ph                     = base.ph or { }
base.zs                     = base.zs or { }
base.dr                     = base.dr or { }
base.mb                     = base.mb or { }

/*
*   loader > tables > settings
*/

base.cfg.Menu               = base.cfg.Menu or { }
base.cfg.Column             = base.cfg.Column or { }
base.cfg.Columns            = base.cfg.Columns or { }
base.cfg.HomeTab            = base.cfg.HomeTab or { }
base.cfg.ActionsTab         = base.cfg.ActionsTab or { }
base.cfg.ControlsTab        = base.cfg.ControlsTab or { }

/*
*   loader > console > header
*/

local co_h =
{
    '\n\n',
    [[.................................................................... ]],
}

/*
*   loader > console > body
*/

local co_b =
{
    [[[title]........... ]] .. mf.name .. [[ ]],
    [[[build]........... v]] .. mf.build .. [[ ]],
    [[[released]........ ]] .. mf.released .. [[ ]],
    [[[author].......... ]] .. mf.author .. [[ ]],
    [[[website]......... ]] .. mf.site .. [[ ]],
    [[[docs]........... ]] .. mf.docs .. [[ ]],
    [[[owner]........... ]] .. mf.owner .. [[ ]],
}

/*
*   loader > console > footer
*/

local co_f =
{
    [[.................................................................... ]],
}

/*
*   loader > console > output
*/

for k, i in ipairs( co_h ) do
    MsgC( Color( 255, 255, 0 ), i .. '\n' )
end

for k, i in ipairs( co_b ) do
    MsgC( Color( 255, 255, 255 ), i .. '\n' )
end

for k, i in ipairs( co_f ) do
    MsgC( Color( 255, 255, 0 ), i .. '\n\n' )
end

/*
*   server
*/

if SERVER then

    local dir_base      = mf.folder .. '/'
    local files, dirs   = file.Find( dir_base .. '*', 'LUA' )

    for k, v in pairs( files ) do
        include( dir_base .. v )
    end

    /*
    *   recursive autoloader :: serverside client
    */

    local function inc_sv( dir_recur, id, term )
        for _, File in SortedPairs( file.Find( dir_recur .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
            if id == 1 or id == 2 then include( dir_recur .. '/' .. File ) end
            if id == 2 or id == 3 then AddCSLuaFile( dir_recur .. '/' .. File ) end
        end
        local file_sub, dir_sub = file.Find( dir_recur .. '/' .. '*', 'LUA' )
        for l, m in pairs( dir_sub ) do
            for _, FileSub in SortedPairs( file.Find( dir_recur .. '/' .. m .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
                if id == 1 or id == 2 then include( dir_recur .. '/' .. m .. '/' .. FileSub ) end
                if id == 2 or id == 3 then AddCSLuaFile( dir_recur .. '/' .. m .. '/' .. FileSub ) end
            end
        end
    end

    for _, dir in SortedPairs( dirs, true ) do
        if dir == '.' or dir == '..' then continue end
        if dir == 'modules' then continue end

        local dir_recur = dir_base .. dir
        inc_sv( dir_recur, 1, 'sv'  )
        inc_sv( dir_recur, 2, 'sh'  )
        inc_sv( dir_recur, 3, 'cl'  )
        inc_sv( dir_recur, 3, 'i'   )
    end

end

/*
*   client
*/

    if CLIENT then
        local dir_base      = mf.folder .. '/'
        local _, dirs       = file.Find( dir_base .. '*', 'LUA' )

        local function inc_cl( dir_recur, id, term )
            for _, File in SortedPairs( file.Find( dir_recur .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
                include( dir_recur .. '/' .. File )
            end
            local file_sub, dir_sub = file.Find( dir_recur .. '/' .. '*', 'LUA' )
            for l, m in pairs( dir_sub ) do
                for _, FileSub in SortedPairs( file.Find( dir_recur .. '/' .. m .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
                    include( dir_recur  .. '/' .. m .. '/' .. FileSub )
                end
            end
        end

        for _, dir in SortedPairs( dirs, true ) do
            if dir == '.' or dir == '..' then continue end
            if dir == 'modules' then continue end

            local dir_recur = dir_base .. dir
            inc_cl( dir_recur, 2, 'sh'  )
            inc_cl( dir_recur, 3, 'cl'  )
            inc_cl( dir_recur, 3, 'i'   )
        end
    end

/*
*   loader > workshop / fastdl
*/

    if SERVER and istable( mf.fonts ) then
        local fonts = mf.fonts
        if #fonts > 0 then
            for _, f in pairs( fonts ) do
                local src = string.format( 'resource/fonts/%s', f )
                resource.AddSingleFile( src )
                vliss:log( VLISS_LOG_FONT, '+ %s » [ %s ]', 'font', src )
            end
        end
    end

/*
*   fastdl
*
*   determines if the script should handle content related to the script via Steam Workshop or FastDL.
*/

    if SERVER and base.cfg.dev.bFastDL then
        local path_base = mf.folder or ''

        for k, v in pairs( mf.fastdl ) do
            local r_path = v .. '/' .. path_base
            if v == 'resource' then
                r_path = v .. '/fonts'
            end

            local r_files, r_dirs = file.Find( r_path .. '/*', 'GAME' )

            for _, File in SortedPairs( r_files ) do
                local r_dir_inc = r_path .. '/' .. File
                resource.AddFile( r_dir_inc )
                vliss:log( RLIB_LOG_FASTDL, '+ %s', r_dir_inc )
            end

            for _, d in pairs( r_dirs ) do
                local r_subpath = r_path .. '/' .. d
                local r_subfiles, r_subdirs = file.Find( r_subpath .. '/*', 'GAME' )
                for _, subfile in SortedPairs( r_subfiles ) do
                    local r_path_subinc = r_subpath .. '/' .. subfile
                    resource.AddFile( r_path_subinc )
                    vliss:log( RLIB_LOG_FASTDL, '+ %s', r_path_subinc )
                end
            end
        end
    end

/*
*   loader > workshop
*/

    if base.cfg.dev.bWorkshopEnabled then
        local ws_val = mf.workshops
        if ws_val then
            local src   = istable( ws_val ) and ws_val
                        if not istable( src ) then
                            src             = { }
                            local ws_chk    = ws_val
                                            if vliss.handle:isempty( ws_chk ) then return end

                            table.insert( src, ws_chk )
                        end

            for l, m in pairs( src ) do
                if SERVER then
                    resource.AddWorkshop( m )
                    vliss:log( RLIB_LOG_WS, '+ [ %s ]', m )
                elseif CLIENT then
                    steamworks.FileInfo( m, function( res )
                        if res and res.id then
                            steamworks.DownloadUGC( tostring( res.id ), function( name, f )
                                game.MountGMA( name or '' )
                                local size = res.size / 1024
                                vliss:log( RLIB_LOG_WS, '+ [ %s ] » %i KB', res.title, math.Round( size ) )
                            end )
                        end
                    end )
                end
            end
        end
    end