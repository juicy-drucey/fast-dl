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
local access                = base.a
local helper                = base.h
local design                = base.d
local ui                    = base.i
local mats                  = base.m
local cvar                  = base.v

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'arivia' )
local cfg               	= base.modules:cfg( mod )

/*
*   Localized translation func
*/

local function ln( ... )
    return base:translate( mod, ... )
end

/*
*	localized plugin
*/

local handle                = mod.handle

/*
*	HANDLE > GENERAL
*/

    /*
    *	handle > background color > get
    *
    *   @return : clr
    */

        function handle:GetBackgroundColor( )
            local bBgEnabled    = ( ( cfg.bg.static.enabled or cfg.bg.live.enabled ) and true ) or false
            local bg_clr        = ( bBgEnabled and cfg.bg.filter.enabled and cfg.bg.filter.clr ) or cfg.ui.main.clrs.panel

            return bg_clr
        end

    /*
    *	handle > tabs > width > set
    *
    *   @param  : int w
    */

        function handle:SetTabWidth( w )
            w = isnumber( w ) and w or tonumber( w )
            mod.tabs.w = w or 0
        end

    /*
    *	handle > tabs > width > get
    *
    *   @return : int
    */

        function handle:GetTabWidth( )
            return mod.tabs.w or 0
        end

    /*
    *	handle > get > description
    *
    *   returns the description for an item ( if provided by server owner )
    *
    *   @param  : ent item
    *   @return : str
    */

        function handle:GetDescription( item )
            if not item then return '' end

            /*
            *	developer > override job descriptions
            */

            local bDevDesc = item.name or item.id or false
            if bDevDesc and cfg.dev.descriptions[ helper.str:clean( bDevDesc ) ] then
                return cfg.dev.descriptions[ helper.str:clean( item.name or item.id ) ]
            end

            /*
            *	job / ent descriptions
            */

            local desc      = ( cfg.ent.bAllowCustomDesc and ( ( ( item.ent or item.entity ) and cfg.ent.desc[ helper.str:clean( item.ent or item.entity ) ] ) or ( item.name and ( cfg.ent.desc[ helper.str:clean( item.name ) ] or cfg.food.desc[ helper.str:clean( item.name ) ] ) or cfg.ent.desc[ item.name ] ) or ( item.ammoType and ( cfg.ent.desc[ helper.str:clean( item.ammoType ) ] ) or cfg.ent.desc[ item.ammoType ] ) ) ) or ( item.description or item.desc ) or ''
            desc            = string.TrimLeft( desc, ' ' )
            desc            = desc .. '\n\n'

            return desc
        end

    /*
    *	handle > get > vehicle speed
    *
    *   returns the vehicle speed rating
    *
    *   @param  : ent item
    *   @return : str
    */

        function handle:GetVehicleSpec( item )
            if not item then return '' end

            local speed     = ( ( item.ent or item.entity ) and cfg.ent.vehicles[ helper.str:clean( item.ent or item.entity ) ] ) or ( item.name and ( cfg.ent.vehicles[ helper.str:clean( item.name ) ] ) or cfg.ent.vehicles[ item.name ] ) or 3
            speed           = string.TrimLeft( speed, ' ' )

            return speed
        end

    /*
    *	handle > can buy food
    *
    *   returns if player can buy food
    *
    *   @param  : ent food
    *   @return : bool
    */

        function handle:CanBuyFood( food )
            if LocalPlayer( ):isCook( ) then return true end
            if food.requiresCook and not LocalPlayer( ):isCook( ) then return false end
            return false
        end

    /*
    *	handle > get > command
    *
    *   returns assigned item command
    *
    *   @param  : ent item
    *   @return : str
    */

        function handle:GetCommand( item )
            return item.command or item.cmd or ''
        end

    /*
    *	handle > get > cost
    *
    *   returns a formatted version of the item price
    *
    *   @param  : ent item
    *   @return : str
    */

        function handle:GetCost( price )
            price           = isnumber( price ) and price or 0
            local price_f   = string.Comma( price )

            return price_f ~= '0' and string.format( '%s%s', GAMEMODE.Config.currency, price_f ) or ln( 'handle_price_free' )
        end

    /*
    *	handle > get > cost diff
    *
    *   returns the price difference between what the player has in money, and the
    *   amount that the item costs
    *
    *   @param  : ent item
    *   @param  : bool bFormat
    *   @return : str
    */

        function handle:GetCostDiff( price, bNeg, bFormat )
            price           = isnumber( price ) and price or 0
            local diff      = math.floor( price ) >= 0 and ( LocalPlayer( ):getmoney( ) or 0 ) - math.floor( price )
            diff            = not bNeg and math.abs( diff ) or diff
            diff            = tostring( diff )
            diff            = string.Comma( diff )

            return not bFormat and diff or string.format( '%s%s', GAMEMODE.Config.currency, diff )
        end

    /*
    *	handle > get > cost progress
    *
    *   compares the total cost of item to the player's current funds and displays
    *   how much remains.
    *
    *   @ex     : $500 / $1,200
    *
    *   @param  : ent item
    *   @param  : bool bFormat
    *   @return : str
    */

        function handle:GetCostProg( price, bFormat )
            price           = isnumber( price ) and price or 0
            local total     = math.floor( price )
            total           = math.abs( total )
            total           = tostring( total )
            total           = string.Comma( total )

            local total_r   = not bFormat and total or string.format( '%s%s', GAMEMODE.Config.currency, total )

            local curr      = LocalPlayer( ):getmoney( ) or 0
            curr            = tostring( curr )
            curr            = string.Comma( curr )

            local curr_f    = not bFormat and curr or string.format( '%s%s', GAMEMODE.Config.currency, curr )

            return string.format( '%s / %s', curr_f, total_r )
        end

    /*
    *	handle > get > salary
    *
    *   returns a formatted version of the job salary
    *
    *   >   bPrefix
    *       enabled     : $0,000 / hr
    *       disabled    : $0,000
    *
    *   @param  : ent item
    *   @param  : bool bPrefix
    *   @return : str
    */

        function handle:GetSalary( item, bPrefix )
            local sal       = item.salary or 0
            local sal_f     = string.Comma( tostring( sal ) )
            local sal_v     = sal_f:lower( )

            if sal_v == 'none' or sal_v == '0' then
                return ln( 'handle_salary_none' )
            end

            local lang_sal = ln( 'handle_salary_name' )
            return sal_f ~= '0' and ( bPrefix and string.format( '%s: %s%s / hr', lang_sal, GAMEMODE.Config.currency, sal_f ) or string.format( '%s%s', GAMEMODE.Config.currency, sal_f ) )
        end

    /*
    *	handle > get > slots
    *
    *   returns a formatted version of the job slots open / max
    *
    *   >   bFormat
    *           enabled     : 1/5
    *           disabled    : 5
    *
    *   @param  : ent item
    *   @param  : bool bFormat
    *   @param  : str sep
    *   @return : str
    */

        function handle:GetSlots( item, bFormat, sep )
            local max       = item.max or 0
            local curr      = table.Count( team.GetPlayers( item.team ) )
            sep             = isstring( sep ) and sep or '-'

            if not max or ( tostring( max ) == '0' ) then
                return ln( 'handle_unlim_i' )
            end

            return not bFormat and max or string.format( '%s%s%s', curr, sep, max )
        end

    /*
    *	handle > get > group
    *
    *   returns require groups for an item or other job
    *
    *   @param  : ent item
    *   @return : str
    */

        function handle:GetGroups( item )
            return item.NeedGroup or item.NeedGroups or item.groups or nil
        end

    /*
    *	handle > get > group
    *
    *   returns require jobs for an item or other job
    *
    *   @param  : ent item
    *   @return : str
    */

        function handle:GetJobs( item )
            return item.NeedToChangeFrom or item.NeedJob or item.jobs or item.allowed or nil
        end

    /*
    *	handle > get > job groups
    *
    *   gets a list of groups that a job may require and checks to see if the player is in
    *   one of the required groups
    *
    *   @note   : does NOT show in description if player meets requirement
    *
    *   @param  : tbl job
    *   @return : bool, str
    */

        function handle:GetGroupsReq( job )

            local pl_group  = LocalPlayer( ):GetUserGroup( )
            local param     = handle:GetGroups( job )

            if ( istable( param ) and not table.HasValue( param, pl_group ) or ( not istable( param ) and param ~= pl_group ) ) then

                /*
                *	populate > req job
                *
                *   displays any required jobs that a player must have in order to switch
                *   to the next job
                */

                local lst = ''
                if param then
                    if istable( param ) then
                        local j_req, i = '', 0
                        for l, m in pairs( param ) do
                            if i == 0 then
                                j_req = m
                            else
                                j_req = j_req .. ', ' .. m
                            end

                            i = i + 1
                        end
                        lst = j_req
                    else
                        lst = param
                    end
                end

                return false, lst
            end

            return true
        end

    /*
    *	handle > get > job requirements
    *
    *   gets a list of jobs that a job requires and checks to see if the player is in
    *   one of the required jobs
    *
    *   @note   : does NOT show in description if player meets requirement
    *
    *   @param  : tbl job
    *   @return : bool, str
    */

        function handle:GetJobsReq( job )

            local pl_team   = LocalPlayer( ):Team( )
            local param     = handle:GetJobs( job )

            if ( istable( param ) and not table.HasValue( param, pl_team ) or ( not istable( param ) and param ~= pl_team ) ) then

                /*
                *	populate > req job
                *
                *   displays any required jobs that a player must have in order to switch
                *   to the next job
                */

                local lst = ''
                if param then
                    if istable( param ) then
                        local j_req, i = '', 0
                        for l, m in pairs( param ) do
                            if i == 0 then
                                j_req = team.GetName( m )
                            else
                                j_req = j_req .. ', ' .. team.GetName( m )
                            end

                            i = i + 1
                        end
                        lst = j_req
                    else
                        lst = team.GetName( param )
                    end
                end

                return false, lst
            end

            return true
        end

    /*
    *	handle > get > color
    *
    *   returns item color
    *
    *   @param  : tbl item
    *   @return : clr
    */

        function handle:GetColor( item )
            return ( item and ( item.clr or item.color or item.Color ) or Color( 150, 150, 150, 200 ) )
        end

    /*
    *	handle > get > access > tips ( super admin )
    *
    *   returns if ply has access to particular features that are marked as ( admin only )
    *
    *   @param  : str cv
    *   @return : bool
    */

        function handle:GetAccessSAdmin( cv )
            cv          = isstring( cv ) and cv or tostring( cv )
                        if not cv then return false end

            return ( cvar:GetInt( cv, 0 ) == 1 and access:strict( LocalPlayer( ), 'rlib_root' ) and true ) or false
        end

/*
*	HANDLE > TABS
*/

    /*
    *	handle > tabs > find by key
    *
    *   returns the table key for a tab registered on the player
    *
    *   @param  : pnl pnl
    *   @return : int
    */

        function handle.tab:FindByKey( pnl )
            return table.KeyFromValue( mod.tabs.dir, pnl )
        end

    /*
    *	handle > tabs > get by key
    *
    *   returns current player tab by table key
    *
    *   @param  : str id
    *   @return : pnl
    */

        function handle.tab:GetByKey( id )
            id = tostring( id )
            return mod.tabs.dir[ id ]
        end

    /*
    *	handle > tabs > get config id
    *
    *   must match the entries in lua\modules\arivia\cfg\sh_4_tabs.lua
    *
    *   @param  : str id
    *   @return : pnl
    */

        function handle.tab:GetConfig( id )
            id = tostring( id )

            local tabs =
            {
                jobs        = 'jobs',
                entities    = 'ents',
                weapons     = 'weps',
                ammo        = 'ammo',
                shipments   = 'ship',
                food        = 'food',
                vehicles    = 'vehc',
            }

            return cfg.tabs[ tabs[ id ] ]
        end

    /*
    *	handle > tabs > get list
    *
    *   returns list of player's stored tabs
    *
    *   @return : tbl
    */

        function handle.tab:GetList( )
            mod.tabs.dir = istable( mod.tabs.dir ) and mod.tabs.dir or { }
            return mod.tabs.dir
        end

    /*
    *	handle > tabs > reset list
    *
    *   resets the player's stored tab directory
    */

        function handle.tab:Reset( )
            mod.tabs.dir    = { }
            mod.tabs.first  = nil
        end

    /*
    *	handle > tabs > hide all
    *
    *   hides all player registered tab pnls
    *
    *   @return : tbl
    */

        function handle.tab:HideAll( )
            for k, tab in pairs( mod.tabs.dir ) do
                if not ui:ok( tab ) then continue end
                ui:hide( tab )
            end

            return mod.tabs.dir
        end

    /*
    *	handle > tabs > reg
    *
    *   registers new pnl in table
    *
    *   @param  : pnl pnl
    *   @param  : str id
    */

        function handle.tab:Register( pnl, id )
            if not ui:ok( pnl ) then return end
            mod.tabs.dir[ id ] = pnl
        end

    /*
    *	handle > tabs > current > set
    *
    *   returns current player tab by table key
    *
    *   @param  : str id
    */

        function handle.tab:CurSet( id )
            id = tostring( id )
            mod.tabs.cur = id
        end

    /*
    *	handle > tabs > current > set
    *
    *   returns current player tab by table key
    *
    *   @return : str
    */

        function handle.tab:CurGet( )
            local cur = mod.tabs.cur or mod.tabs.first or 'jobs'

            if not cfg.tabs.jobs.bEnabled and cur == 'jobs' then
                cur = 'ammo'
            end

            if not cfg.tabs.ammo.bEnabled and cur == 'ammo' then
                cur = 'ents'
            end

            return cur
        end

    /*
    *	handle > tabs > current > show
    *
    *   displays the last tab a player had open
    */

        function handle.tab:CurShow( )
            local ctab  = handle.tab:CurGet( )

            ui:stage    ( '$tab_store_nores', mod   )
            ui:stage    ( '$tab_store', mod         )

            local tab   = handle.tab:GetByKey( ctab )
            ui:show     ( tab                       )
        end

    /*
    *	handle > tabs > show > last opened
    *
    *   searches player's last opened tab and shows it
    *
    *   @param  : int id
    *   @return : void
    */

        function handle.tab:Show( id )
            handle.tab:HideAll( )

            ui:stage    ( '$tab_store', mod         )
            local tab   = handle.tab:GetByKey( id   )
            ui:show     ( tab                       )
        end

    /*
    *	handle > tabs > current > set + show
    *
    *   sets a player's current tab and then shows it
    *
    *   @param  : str id
    */

        function handle.tab:CurSetShow( id )
            id = tostring( id )
            mod.tabs.cur = id

            handle.tab:Show( id )
        end

/*
*	HANDLE > JOB SLOTS
*/

    /*
    *	handle > slots > jobs > new
    *
    *   clears the slot index
    */

        function handle.jsl:New( pnl )
            if not ui:ok( pnl ) then return end
            table.insert( mod.slots.jobs, pnl )
        end

    /*
    *	handle > slots > jobs > get
    *
    *   clears the slot index
    */

        function handle.jsl:Get( )
            mod.slots.jobs = istable( mod.slots.jobs ) and mod.slots.jobs or { }
            return mod.slots.jobs
        end

    /*
    *	handle > slots > jobs > rehash
    *
    *   clears the slot index
    */

        function handle.jsl:Rehash( )
            if not handle.jsl:Get( ) then return end
            for a, b in pairs( handle.jsl:Get( ) ) do
                if not ui:ok( b ) then continue end
                b:GetParent( ):RehashSlot( )
                b.selected = false
            end
        end

    /*
    *	handle > slots > clear
    *
    *   clears the slot index
    */

        function handle.jsl:Clear( )
            mod.slots.jobs = { }
        end