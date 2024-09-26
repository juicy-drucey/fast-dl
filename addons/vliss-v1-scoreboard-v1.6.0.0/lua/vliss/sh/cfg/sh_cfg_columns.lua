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
*   tables
*/

local base                  = vliss
local cfg                   = base.cfg
local handle                = base.handle
cfg.Columns                 = { }

/*
*   columns > general
*/

    cfg.Column.bKillSkull           = true      -- Enabled the skull to the right of a player who has died. False to disable.
    cfg.Column.PingEnabled          = true      -- Disable ping for players?
    cfg.Column.PingHeight           = 1
    cfg.Column.RefreshTime          = 1         -- How often (in seconds) the players columns should refresh.

/*
*   columns > sorting
*
*   the function below will determine how players are sorted by default.
*   players can click on a column in order to try other sorting otpions
*   IE: deaths, kills, etc.
*
*   to change sorting; you must edit the function. here is a list of options:
*
*       : Deaths( )                 : sort by deaths
*       : Frags( )                  : sort by kills
*       : Health( )                 : sort by HP
*       : Nick( )                   : sort by name
*       : GetUserGroup( )           : sort by user group
*       : getDarkRPVar( 'level' )   : sort by user level
*       : getDarkRPVar( 'lvl' )     : sort by user level ( alternative )
*       : GetUTime( )               : sort by playtime
*
*       >                           : Descending    ( highest to lowest )
*       <                           : Ascending     ( lowest to highest )
*/

    cfg.Column.DefaultOrder = function( a, b )
        return a:Nick( ) < b:Nick( )
    end

/*
*   columns > list
*
*   the table below lists every column.
*   some of them are for different gamemodes; so read carefully before you edit.
*/

    cfg.Columns =
    {

    /*
    *   column > voice
    */

        {
            enabled                 = true,
            sort                    = 1,
            name                    = 'Voice',
            width                   = 50,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:GetUserGroup( ) < b:GetUserGroup( )
                                    end,
            bIsMute                 = function( pl )
                                        return true
                                    end,
            func                    = function( pl )
                                        if not pl:IsMuted( ) then
                                            return '       '
                                        else
                                            return '       '
                                        end
                                    end,
            condition               = function( pl )
                                        return true
                                    end,
        },

    /*
    *   column > rank
    *
    *   @gamemode   : all
    */

    {
        enabled                 = true,
        sort                    = 2,
        name                    = 'Rank',
        rset                    = 9,
        width                   = 100,
        clr_txt_title           = Color( 255, 255, 255, 255 ),
        clr_txt_res             = Color( 255, 255, 255, 255 ),
        sortvar                 = function( a, b )
                                    local a1 = handle:GroupTitle( a )
                                    local b1 = handle:GroupTitle( b )
                                    return a1 < b1
                                end,
        func                    = function( pl )
                                    return handle:GroupTitle( pl )
                                end,
        condition               = function( pl )
                                    if not base.dr.Enabled then return true end
                                    return false
                                end,
    },


    /*
    *   column > rank
    *
    *   @gamemode   : all
    */

        {
            enabled                 = true,
            sort                    = 3,
            name                    = 'Props',
            width                   = 80,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:GetCount( 'props' ) > b:GetCount( 'props' )
                                    end,
            func                    = function( pl )
                                        if not CLIENT then return end
                                        local i_props           = pl:GetCount( 'props' ) or 0

                                        return i_props
                                    end,
            condition               = function( pl )
                                        if base.sb.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > kills / deaths mixed
    *
    *   @gamemode   : all
    */

        {
            enabled                 = true,
            sort                    = 4,
            name                    = 'K/D',
            width                   = 80,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:Frags( ) > b:Frags( )
                                    end,
            func                    = function( pl )
                                        local kills     = pl:Frags( ) or 0
                                        local deaths    = pl:Deaths( ) or 0
                                        return string.format( '%s:%s', kills, deaths )
                                    end,
            condition               = function( pl )
                                        if not base.dr.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > kills
    *
    *   @gamemode   : all
    */

        {
            enabled                 = false,
            sort                    = 4,
            name                    = 'Kills',
            width                   = 80,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:Frags( ) > b:Frags( )
                                    end,
            func                    = function( pl ) return pl:Frags( ) end,
            condition               = function( pl )
                                        if not base.dr.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > deaths
    *
    *   @gamemode   : all
    */

        {
            enabled                 = false,
            sort                    = 5,
            name                    = 'Deaths',
            width                   = 60,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:Deaths( ) > b:Deaths( )
                                    end,
            func                    = function( pl )
                                        return pl:Deaths( )
                                    end,
            condition               = function( pl )
                                        if not base.dr.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > money
    *
    *   @gamemode   : darkrp ( and derived )
    */

        {
            enabled                 = true,
            sort                    = 6,
            name                    = 'Money',
            width                   = 120,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return team.GetName( a:Team( ) ) < team.GetName( b:Team( ) )
                                    end,
            func                    = function( pl )
                                        local money = pl:getDarkRPVar( 'money' ) or 0
                                        return DarkRP.formatMoney( money )
                                    end,
            condition               = function( pl )
                                        if base.rp.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > job
    *
    *   @gamemode   : darkrp ( and derived )
    */

        {
            enabled                 = true,
            sort                    = 7,
            rset                    = 15,
            name                    = 'Job',
            width                   = 220,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b ) return team.GetName( a:Team( ) ) > team.GetName( b:Team( ) ) end,
            func                    = function( pl ) return team.GetName( pl:Team( ) ):upper( ) end,
            specialColor            = function( pl ) return team.GetColor( pl:Team( ) ) end,
            condition               = function( pl )
                                        if base.rp.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > level
    *
    *   @gamemode   : darkrp ( and derived )
    */

        {
            enabled                 = true,
            sort                    = 8,
            name                    = 'Level',
            width                   = 80,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return ( a:getDarkRPVar( 'level' ) or a:getDarkRPVar( 'lvl' ) )  > ( b:getDarkRPVar( 'level' ) or b:getDarkRPVar( 'lvl' ) )
                                    end,
            func                    = function( pl )
                                        local pl_lvl = pl:getDarkRPVar( 'level' ) or pl:getDarkRPVar( 'lvl' ) or 1
                                        if LevelSystemConfiguration or DARKRP_LVL_SYSTEM then
                                            return pl_lvl
                                        end
                                        return 0
                                    end,
            condition               = function( pl )
                                        if LevelSystemConfiguration or DARKRP_LVL_SYSTEM then return true end
                                        return false
                                    end,
        },

    /*
    *   column > prestige
    *
    *   @gamemode   : darkrp ( and derived )
    */

        {
            enabled                 = true,
            sort                    = 9,
            name                    = 'Prestige',
            width                   = 80,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:getDarkRPVar( 'prestige' ) > b:getDarkRPVar( 'prestige' )
                                    end,
            func                    = function( pl )
                                        return pl:getDarkRPVar( 'prestige' ) or 0
                                    end,
            condition               = function( pl )
                                        if LevelSystemPrestigeConfiguration then return true end
                                        return false
                                    end,
        },

    /*
    *   column > score
    *
    *   @gamemode   : ttt
    */

        {
            enabled                 = true,
            sort                    = 10,
            name                    = 'Score',
            width                   = 80,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:Frags( ) > b:Frags( )
                                    end,
            func                    = function( pl )
                                        return pl:Frags( )
                                    end,
            condition               = function( pl )
                                        if base.ttt.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > karma
    *
    *   @gamemode   : ttt
    */

        {
            enabled                 = true,
            sort                    = 11,
            name                    = 'Karma',
            width                   = 70,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:GetBaseKarma( ) < b:GetBaseKarma( )
                                    end,
            func                    = function( pl )
                                        return math.Round( pl:GetBaseKarma( ) )
                                    end,
            condition               = function( pl )
                                        if base.ttt.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > score
    *
    *   @gamemode   : melon-bomber
    */

        {
            enabled                 = true,
            sort                    = 12,
            name                    = 'Score',
            width                   = 80,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return a:GetScore( ) < b:GetScore( )
                                    end,
            func                    = function( pl )
                                        return ( '|' ):rep( math.min( 10, pl:GetScore( ) ) ) .. ' ' .. pl:GetScore( )
                                    end,
            condition               = function( pl )
                                        if base.mb.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > playtime
    *
    *   @gamemode   : all
    */

        {
            enabled                 = true,
            sort                    = 13,
            name                    = 'Playtime (Hrs)',
            width                   = 90,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                    end,
            func                    = function( pl )
                                        return math.floor( ( pl:GetUTime( ) + CurTime( ) - pl:GetUTimeStart( ) ) / 60 / 60 )
                                    end,
            condition               = function( pl )
                                        if Utime and not base.dr.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > ptag
    *
    *   @gamemode   : ttt
    */

        {
            enabled                 = true,
            sort                    = 14,
            name                    = '',
            width                   = 100,
            clr_txt_title           = Color( 255, 255, 255, 255 ),
            clr_txt_res             = Color( 255, 255, 255, 255 ),
            sortvar                 = function( a, b )
                                        return ScoreGroup( a ) < ScoreGroup( b )
                                    end,
            func                    = function( pl )
                                        local ptag              = pl.sb_tag
                                        local GetTranslation    = LANG.GetTranslation
                                        if ScoreGroup( pl ) ~= GROUP_TERROR then
                                            ptag = nil
                                        end
                                        return ptag and GetTranslation(ptag.txt) or ''
                                    end,
            condition               = function( pl )
                                        if base.ttt.Enabled then return true end
                                        return false
                                    end,
        },

    /*
    *   column > level
    *
    *   @gamemode   : all
    */

        {
            enabled                     = true,
            sort                        = 100,
            name                        = '',
            width                       = 80,
            clr_txt_title               = Color( 255, 255, 255, 255 ),
            clr_txt_res                 = Color( 255, 255, 255, 255 ),
            bIsDeath                    = function( pl )
                                            return true
                                        end,
            sortvar                     = function( a, b )
                                            return a:GetBaseKarma( ) < b:GetBaseKarma( )
                                        end,
            func                        = function( pl )
                                            if not pl:Alive( ) then
                                                return '          '
                                            else
                                                return ' '
                                            end
                                        end,
            condition                   = function( pl )
                                            return true
                                        end,
        },

    }

