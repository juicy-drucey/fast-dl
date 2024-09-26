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

local level                 = mod.plugins.level
local prestige              = mod.plugins.prestige
local handle                = mod.handle

/*
*	custom check
*
*   checks to see if a customCheck has been included with job, ent, etc.
*
*   @param  : ply pl
*   @param  : mix targ
*   @param  : bool bJob
*/

local function custom_check( pl, targ, bJob )
    return ( targ.CustomCheckFailMsg and ( isfunction( targ.CustomCheckFailMsg ) and targ.CustomCheckFailMsg( pl, targ ) ) or helper.str:ok( targ.CustomCheckFailMsg ) and targ.CustomCheckFailMsg ) or ( bJob and ln( 'sel_msg_custom_job_restrct' ) or ln( 'sel_msg_custom_ent_restrct' ) )
end

/*
*	job > check switch
*
*   @param  : ent job
*   @return : bool bCanJoin
*   @return : bool bVisible
*   @return : str, tbl msg
*   @return : bool bIsCustom
*/

function mod.jobs:bCanSwitch( job )
    local pl = LocalPlayer( )

    /*
    *	job > current
    */

    if job.team == mod.jobs.current then
        local bShow = ( #RPExtraTeams > 1 and cfg.tabs.jobs.bShowCurrJob ) or true
        return false, bShow, { ln( 'sel_btn_job_current_txt' ), cfg.tabs.jobs.clrs.list.btn_gra_j or self.cf_g.sel.clrs.btn_act_txt }
    end

    /*
    *	job > max slots
    *
    *   @params
    *       > bCanJoin, bVisible, msg, bIsCustom
    *
    *   @default
    *       > false, true, customCheck, nil
    */

    if ( job.max and job.max > 0 and job.max <= 999 and table.Count( team.GetPlayers( job.team ) ) >= job.max ) then
        return false, true, { ln( 'sel_notice_slots_max' ), cfg.tabs.jobs.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.jobs.clrs.list.btn_gra_u }
    end

    /*
    *	job > need group
    *
    *   @params
    *       > bCanJoin, bVisible, msg, bIsCustom
    *
    *   @default
    *       > false, true, customCheck, nil
    */

    local param_groups = handle:GetGroups( job )
    if param_groups then
        local bHasGroup, lst = handle:GetGroupsReq( job )
        if not bHasGroup then
            local err = ln( 'sel_desc_grps_s', lst )
            return false, true, err
        end
    end

    /*
    *	job > need current job
    *
    *   @params
    *       > bCanJoin, bVisible, msg, bIsCustom
    *
    *   @default
    *       > false, true, customCheck, nil
    */

    local param_job = handle:GetJobs( job )
    if param_job then
        local bHasReq, lst = handle:GetJobsReq( job )
        if not bHasReq then
            local err = ln( 'sel_desc_jobs_s', lst )
            return false, true, err
        end
    end

    /*
    *	job > custom check
    *
    *   @params
    *       > bCanJoin, bVisible, msg, bIsCustom
    *
    *   @default
    *       > false, cfg, customCheck, true
    */

    if ( job.customCheck and not job.customCheck( pl ) ) then
        return false, cfg.tabs.jobs.unavail.bShowCustoms, custom_check( pl, job, true ), true
    end

    /*
    *	job > level requirements
    *
    *   @params
    *       > bCanJoin, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( level:bEnabled( ) ) and not level:HasReq( pl, job ) then
        return false, true, { ln( 'sel_notice_req_lvl_i', level:Get( job ) ), cfg.tabs.jobs.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.jobs.clrs.list.btn_gra_u }
    end

    /*
    *	shipment > prestige requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( prestige:bEnabled( ) ) and not prestige:HasReq( pl, job ) then
        return false, true, { ln( 'sel_notice_req_pre_i', prestige:Get( job ) ), cfg.tabs.jobs.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.jobs.clrs.list.btn_gra_u }
    end

    return true
end

/*
*	weps > list viewable
*
*   returns int, tbl of viewable weapons by player
*
*   @param  : void
*   @return : int, tbl
*/

function mod.weps:Viewable( )
    local src               = DarkRP.getCategories( ).weapons
                            if not src then return 0 end

    mod.weps.src            = src
    local i                 = 0
    for cat in helper.get.data( src ) do

        local i_ents        = #cat.members
                            if not cat.members or i_ents < 1 then continue end
                            if ( cat.canSee and not cat.canSee( LocalPlayer( ) ) ) then continue end

        local i_err = 0
        for v in helper.get.data( cat.members ) do
            local bCanBuy, bShow    = self:bCanBuy( v )

            if not bCanBuy and not bShow then
                i_err = i_err + 1
            end
        end

        /*
        *	cats > skip loading entire cat if errors greater than ents in cat
        */

        if i_err >= i_ents then continue end

        i = i + 1
    end

    return i
end

/*
*	weps > can buy
*
*   @param  : ent wep
*   @return : bool bCanBuy
*   @return : bool bVisible
*   @return : str, tbl msg
*   @return : bool bIsCustom
*   @return : int cost
*/

function mod.weps:bCanBuy( wep )

    /*
    *	check valid data
    */

    if not wep then
        base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_weps' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        return
    end

    /*
    *	general
    */

    local pl                = LocalPlayer( )
    local bAdminOnly        = ( wep.admin == 1 or tostring( wep.admin ) == 'true' and true ) or false
    local bSAdminOnly       = ( wep.superadmin == 1 or tostring( wep.superadmin ) == 'true' and true ) or false

    /*
    *	wep > can buy
    */

    local canbuy, suppress, msg, price          = hook.Call( 'canBuyPistol', nil, pl, wep )
    local cost                                  = price or wep.getPrice and wep.getPrice( pl, wep.pricesep ) or wep.pricesep

    /*
    *	wep > admin override
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > true, true, nil, nil, nil
    */

    if cfg.dev.admin_override and pl:IsSuperAdmin( ) then
        return true, true, ln( 'sel_notice_admin_or' ), false, cost
    end

    /*
    *	wep > admin / superadmin only
    *
    *   determines if wep can only be bought by admin
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > conditional
    */

    if ( bAdminOnly and not pl:IsAdmin( ) ) then
        return false, false, ln( 'sel_notice_admin_only' ), false, cost
    elseif ( bAdminOnly and pl:IsAdmin( ) ) then
        return true, true, nil, false, cost
    elseif ( bSAdminOnly and not pl:IsSuperAdmin( ) ) then
        return false, false, ln( 'sel_notice_sadmin_only' ), false, cost
    elseif ( bSAdminOnly and pl:IsSuperAdmin( ) ) then
        return true, true, nil, false, cost
    end

    /*
    *	wep > allowed
    *
    *   the teams allowed to buy this wep.
    *   If this field is not set then all jobs can buy the wep.
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, nil, nil, nil, nil
    */

    local err = ( GAMEMODE.Config.restrictbuypistol and ln( 'sel_msg_custom_gun_restrct' ) ) or ln( 'sel_msg_custom_ent_restrct' )
    if ( istable( wep.allowed ) and not table.HasValue( wep.allowed, pl:Team( ) ) ) then return false, cfg.tabs.weapons.unavail.bShow, err, false, cost end

    /*
    *	wep > custom check
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, cfg, customCheck, true, <val>
    */

    if ( wep.customCheck and not wep.customCheck( pl ) ) then
        if wep.customHideUnavail or wep.bHideUnavail then
            return false, false, custom_check( pl, wep ), true, cost
        else
            return false, cfg.tabs.weapons.unavail.bShowCustoms, custom_check( pl, wep ), true, cost
        end
    end

    /*
    *	wep > can afford
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, false, <val>
    */

    if ( not pl:canAfford( cost ) ) then
        return
            false,
            true,
            { ln( 'sel_notice_noafford_amt', handle:GetCostDiff( cost, false, true ) ), cfg.tabs.weapons.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.weapons.clrs.list.btn_gra_u },
            false,
            cost
    end

    /*
    *	wep > level requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( level:bEnabled( ) ) and not level:HasReq( pl, wep ) then
        return false, true, { ln( 'sel_notice_req_lvl_i', level:Get( wep ) ), cfg.tabs.weapons.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.weapons.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	wep > prestige requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( prestige:bEnabled( ) ) and not prestige:HasReq( pl, wep ) then
        return false, true, { ln( 'sel_notice_req_pre_i', prestige:Get( wep ) ), cfg.tabs.weapons.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.weapons.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	wep > can buy
    */

    if canbuy == false then
        return false, not suppress, msg, false, cost
    end

    /*
    *	wep > everything else
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    */

    return true, true, msg, false, cost
end

/*
*	shipments > list viewable
*
*   returns int, tbl of viewable shipments by player
*
*   @param  : void
*   @return : int, tbl
*/

function mod.ship:Viewable( )
    local src               = DarkRP.getCategories( ).shipments
                            if not src then return 0 end

    mod.ship.src            = src
    local i                 = 0
    for cat in helper.get.data( src ) do

        local i_ents        = #cat.members
                            if not cat.members or i_ents < 1 then continue end
                            if ( cat.canSee and not cat.canSee( LocalPlayer( ) ) ) then continue end

        local i_err = 0
        for v in helper.get.data( cat.members ) do
            local bCanBuy, bShow    = self:bCanBuy( v )

            if not bCanBuy and not bShow then
                i_err = i_err + 1
            end
        end

        /*
        *	cats > skip loading entire cat if errors greater than ents in cat
        */

        if i_err >= i_ents then continue end

        i = i + 1
    end

    return i
end

/*
*	shipment > can buy
*
*   @param  : ent ship
*   @return : bool bCanBuy
*   @return : bool bVisible
*   @return : str, tbl msg
*   @return : bool bIsCustom
*   @return : int cost
*/

function mod.ship:bCanBuy( ship )

    /*
    *	check valid data
    */

    if not ship then
        base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_ship' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        return
    end

    /*
    *	general
    */

    local pl                = LocalPlayer( )
    local bAdminOnly        = ( ship.admin == 1 or tostring( ship.admin ) == 'true' and true ) or false
    local bSAdminOnly       = ( ship.superadmin == 1 or tostring( ship.superadmin ) == 'true' and true ) or false

    /*
    *	shipment > can buy
    */

    local canbuy, suppress, msg, price          = hook.Call( 'canBuyShipment', nil, pl, ship )
    local cost                                  = price or ship.getPrice and ship.getPrice( pl, ship.price ) or ship.price

    /*
    *	shipment > admin override
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > true, true, nil, nil, nil
    */

    if cfg.dev.admin_override and pl:IsSuperAdmin( ) then
        return true, true, ln( 'sel_notice_admin_or' ), false, cost
    end

    /*
    *	shipment > admin / superadmin only
    *
    *   determines if shipment can only be bought by admin
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > conditional
    */

    if ( bAdminOnly and not pl:IsAdmin( ) ) then
        return false, false, ln( 'sel_notice_admin_only' ), false, cost
    elseif ( bAdminOnly and pl:IsAdmin( ) ) then
        return true, true, nil, false, cost
    elseif ( bSAdminOnly and not pl:IsSuperAdmin( ) ) then
        return false, false, ln( 'sel_notice_sadmin_only' ), false, cost
    elseif ( bSAdminOnly and pl:IsSuperAdmin( ) ) then
        return true, true, nil, false, cost
    end

    /*
    *	shipment > allowed
    *
    *   the teams allowed to buy this shipment.
    *   If this field is not set then all jobs can buy the shipment.
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, nil, nil, nil, nil
    */

    if ( istable( ship.allowed ) and not table.HasValue( ship.allowed, pl:Team( ) ) ) then return false, cfg.tabs.shipments.unavail.bShow, ln( 'sel_msg_custom_ent_restrct' ), false, cost end

    /*
    *	shipment > custom check
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, cfg, customCheck, true, <val>
    */

    if ( ship.customCheck and not ship.customCheck( pl ) ) then
        if ship.customHideUnavail or ship.bHideUnavail then
            return false, false, custom_check( pl, ship ), true, cost
        else
            return false, cfg.tabs.shipments.unavail.bShowCustoms, custom_check( pl, ship ), true, cost
        end
    end

    /*
    *	shipment > can afford
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, false, <val>
    */

    if ( not pl:canAfford( cost ) ) then
        return
            false,
            true,
            { ln( 'sel_notice_noafford_amt', handle:GetCostDiff( cost, false, true ) ), cfg.tabs.shipments.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.shipments.clrs.list.btn_gra_u },
            false,
            cost
    end

    /*
    *	shipment > level requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( level:bEnabled( ) ) and not level:HasReq( pl, ship ) then
        return false, true, { ln( 'sel_notice_req_lvl_i', level:Get( ship ) ), cfg.tabs.shipments.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.shipments.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	shipment > prestige requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( prestige:bEnabled( ) ) and not prestige:HasReq( pl, ship ) then
        return false, true, { ln( 'sel_notice_req_pre_i', prestige:Get( ship ) ), cfg.tabs.shipments.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.shipments.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	shipment > can buy
    */

    if canbuy == false then
        return false, not suppress, msg, false, cost
    end

    /*
    *	shipment > everything else
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    */

    return true, true, msg, false, cost

end

/*
*	ammo > list viewable
*
*   returns int, tbl of viewable ammo by player
*
*   @param  : void
*   @return : int, tbl
*/

function mod.ammo:Viewable( )
    local src               = DarkRP.getCategories( ).ammo
                            if not src then return 0 end

    mod.ammo.src            = src

    return #GAMEMODE.AmmoTypes, GAMEMODE.AmmoTypes
end

/*
*	ents > list viewable
*
*   returns int, tbl of viewable ents by player
*
*   @param  : void
*   @return : int, tbl
*/

function mod.ents:Viewable( )
    local src               = DarkRP.getCategories( ).entities
                            if not src then return 0 end

    mod.ents.src            = src
    local i                 = 0
    for cat in helper.get.data( src ) do

        local i_ents        = #cat.members
                            if not cat.members or i_ents < 1 then continue end
                            if ( cat.canSee and not cat.canSee( LocalPlayer( ) ) ) then continue end

        local i_err = 0
        for v in helper.get.data( cat.members ) do
            local bCanBuy, bShow    = self:bCanBuy( v )

            if not bCanBuy and not bShow then
                i_err = i_err + 1
            end
        end

        /*
        *	cats > skip loading entire cat if errors greater than ents in cat
        */

        if i_err >= i_ents then continue end

        i = i + 1
    end

    return i
end

/*
*	ents > can buy
*
*   determines how player interacts with certain entities
*
*   @param  : ent ent
*   @return : bool bCanBuy
*   @return : bool bVisible
*   @return : str, tbl msg
*   @return : bool bIsCustom
*   @return : int cost
*/

function mod.ents:bCanBuy( ent )

    /*
    *	check valid data
    */

    if not ent then
        base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_ents' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        return
    end

    /*
    *	general
    */

    local pl                = LocalPlayer( )
    local bAdminOnly        = ( ent.admin == 1 or tostring( ent.admin ) == 'true' and true ) or false
    local bSAdminOnly       = ( ent.superadmin == 1 or tostring( ent.superadmin ) == 'true' and true ) or false

    /*
    *	ent > can buy
    */

    local canbuy, suppress, msg, price          = hook.Call( 'canBuyCustomEntity', nil, pl, ent )
    local cost                                  = price or ent.getPrice and ent.getPrice( pl, ent.price ) or ent.price

    /*
    *	ent > admin override
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > true, true, nil, nil, nil
    */

    if cfg.dev.admin_override and pl:IsSuperAdmin( ) then
        return true, true, ln( 'sel_notice_admin_or' ), false, cost
    end

    /*
    *	ent > admin / superadmin only
    *
    *   determines if ent can only be bought by admin
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > conditional
    */

    if ( bAdminOnly and not pl:IsAdmin( ) ) then
        return false, false, ln( 'sel_notice_admin_only' ), false, cost
    elseif ( bAdminOnly and pl:IsAdmin( ) ) then
        return true, true, nil, false, cost
    elseif ( bSAdminOnly and not pl:IsSuperAdmin( ) ) then
        return false, false, ln( 'sel_notice_sadmin_only' ), false, cost
    elseif ( bSAdminOnly and pl:IsSuperAdmin( ) ) then
        return true, true, nil, false, cost
    end

    /*
    *	ent > allowed
    *
    *   the teams allowed to buy this entity.
    *   If this field is not set then all jobs can buy the entity.
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, nil, nil, nil, nil
    */

    if ( istable( ent.allowed ) and not table.HasValue( ent.allowed, pl:Team( ) ) ) then return false, cfg.tabs.entities.unavail.bShow, ln( 'sel_msg_custom_ent_restrct' ), false, cost end

    /*
    *	ent > custom check
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, cfg, customCheck, true, <val>
    */

    if ( ent.customCheck and not ent.customCheck( pl ) ) then
        if ent.customHideUnavail or ent.bHideUnavail then
            return false, false, custom_check( pl, ent ), true, cost
        else
            return false, cfg.tabs.entities.unavail.bShowCustoms, custom_check( pl, ent ), true, cost
        end
    end

    /*
    *	ent > can afford
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, false, <val>
    */

    if ( not pl:canAfford( cost ) ) then
        return
            false,
            true,
            { ln( 'sel_notice_noafford_amt', handle:GetCostDiff( cost, false, true ) ), cfg.tabs.entities.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.entities.clrs.list.btn_gra_u },
            false,
            cost
    end

    /*
    *	ent > level requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( level:bEnabled( ) ) and not level:HasReq( pl, ent ) then
        return false, true, { ln( 'sel_notice_req_lvl_i', level:Get( ent ) ), cfg.tabs.entities.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.entities.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	ent > prestige requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( prestige:bEnabled( ) ) and not prestige:HasReq( pl, ent ) then
        return false, true, { ln( 'sel_notice_req_pre_i', prestige:Get( ent ) ), cfg.tabs.entities.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.entities.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	ent > can buy
    */

    if canbuy == false then
        return false, not suppress, msg, false, cost
    end

    /*
    *	ent > everything else
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    */

    return true, true, msg, false, cost
end

/*
*	ammo > can buy
*
*   @param  : ent item
*   @return : bool bCanBuy
*   @return : bool bVisible
*   @return : str, tbl msg
*   @return : bool bIsCustom
*   @return : int cost
*/

function mod.ammo:bCanBuy( item )

    /*
    *	check valid data
    */

    if not item then
        base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_ammo' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        return
    end

    /*
    *	general
    */

    local pl                = LocalPlayer( )
    local bAdminOnly        = ( item.admin == 1 or tostring( item.admin ) == 'true' and true ) or false
    local bSAdminOnly       = ( item.superadmin == 1 or tostring( item.superadmin ) == 'true' and true ) or false

    /*
    *	ammo > can buy
    */

    local canbuy, suppress, msg, price          = hook.Call( 'canBuyAmmo', nil, pl, item )
    local cost                                  = price or item.getPrice and item.getPrice( pl, item.price ) or item.price

    /*
    *	ammo > admin override
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > true, true, nil, nil, nil
    */

    if cfg.dev.admin_override and pl:IsSuperAdmin( ) then
        return true, true, ln( 'sel_notice_admin_or' ), false, cost
    end

    /*
    *	ammo > admin / superadmin only
    *
    *   determines if ammo can only be bought by admin
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > conditional
    */

    if ( bAdminOnly and not pl:IsAdmin( ) ) then
        return false, false, ln( 'sel_notice_admin_only' ), false, cost
    elseif ( bAdminOnly and pl:IsAdmin( ) ) then
        return true, true, nil, false, cost
    elseif ( bSAdminOnly and not pl:IsSuperAdmin( ) ) then
        return false, false, ln( 'sel_notice_sadmin_only' ), false, cost
    elseif ( bSAdminOnly and pl:IsSuperAdmin( ) ) then
        return true, true, nil, false, cost
    end

    /*
    *	ammo > custom check
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, cfg, customCheck, true, <val>
    */

    if ( item.customCheck and not item.customCheck( pl ) ) then
        if item.customHideUnavail or item.bHideUnavail then
            return false, false, custom_check( pl, item ), true, cost
        else
            return false, cfg.tabs.ammo.unavail.bShowCustoms, custom_check( pl, item ), true, cost
        end
    end

    /*
    *	ammo > can afford
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, false, <val>
    */

    if ( not pl:canAfford( cost ) ) then
        return
            false,
            true,
            { ln( 'sel_notice_noafford_amt', handle:GetCostDiff( cost, false, true ) ), cfg.tabs.ammo.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.ammo.clrs.list.btn_gra_u },
            false,
            cost
    end

    /*
    *	ammo > level requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( level:bEnabled( ) ) and not level:HasReq( pl, item ) then
        return false, true, { ln( 'sel_notice_req_lvl_i', level:Get( item ) ), cfg.tabs.ammo.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.ammo.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	ammo > prestige requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( prestige:bEnabled( ) ) and not prestige:HasReq( pl, item ) then
        return false, true, { ln( 'sel_notice_req_pre_i', prestige:Get( item ) ), cfg.tabs.ammo.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.ammo.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	ammo > can buy
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, conditional, <val>, false, <val>
    */

    if canbuy == false then
        return false, not suppress, msg, false, cost
    end

    /*
    *	ammo > everything else
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    */

    return true, true, msg, false, cost
end

/*
*	vehicle > list viewable
*
*   returns int, tbl of viewable food by player
*
*   @param  : void
*   @return : int, tbl
*/

function mod.vehc:Viewable( )
    local src               = DarkRP.getCategories( ).vehicles
                            if not src then return 0 end

    mod.vehc.src            = src
    local i                 = 0
    for cat in helper.get.data( src ) do

        local i_ents        = #cat.members
                            if not cat.members or i_ents < 1 then continue end
                            if ( cat.canSee and not cat.canSee( LocalPlayer( ) ) ) then continue end

        local i_err = 0
        for v in helper.get.data( cat.members ) do
            local bCanBuy, bShow    = self:bCanBuy( v )

            if not bCanBuy and not bShow then
                i_err = i_err + 1
            end
        end

        /*
        *	cats > skip loading entire cat if errors greater than ents in cat
        */

        if i_err >= i_ents then continue end

        i = i + 1
    end

    return i
end

/*
*	vehicle > can buy
*
*   @param  : ent vehc
*   @return : bool bCanBuy
*   @return : bool bVisible
*   @return : str, tbl msg
*   @return : bool bIsCustom
*   @return : int cost
*/

function mod.vehc:bCanBuy( vehc )

    /*
    *	check valid data
    */

    if not vehc then
        base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_vehc' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        return
    end

    /*
    *	general
    */

    local pl                = LocalPlayer( )
    local bAdminOnly        = ( vehc.admin == 1 or tostring( vehc.admin ) == 'true' and true ) or false
    local bSAdminOnly       = ( vehc.superadmin == 1 or tostring( vehc.superadmin ) == 'true' and true ) or false

    /*
    *	vehicle > can buy
    */

    local canbuy, suppress, msg, price          = hook.Call( 'canBuyVehicle', nil, pl, vehc )
    local cost                                  = price or vehc.getPrice and vehc.getPrice( pl, vehc.price ) or vehc.price

    /*
    *	vehicle > admin override
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > true, true, nil, nil, nil
    */

    if cfg.dev.admin_override and pl:IsSuperAdmin( ) then
        return true, true, ln( 'sel_notice_admin_or' ), false, cost
    end

    /*
    *	vehicle > admin / superadmin only
    *
    *   determines if vehicle can only be bought by admin
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > conditional
    */

    if ( bAdminOnly and not pl:IsAdmin( ) ) then
        return false, false, ln( 'sel_notice_admin_only' ), false, cost
    elseif ( bAdminOnly and pl:IsAdmin( ) ) then
        return true, true, nil, false, cost
    elseif ( bSAdminOnly and not pl:IsSuperAdmin( ) ) then
        return false, false, ln( 'sel_notice_sadmin_only' ), false, cost
    elseif ( bSAdminOnly and pl:IsSuperAdmin( ) ) then
        return true, true, nil, false, cost
    end

    /*
    *	vehicle > allowed
    *
    *   the teams allowed to buy this vehicle.
    *   If this field is not set then all jobs can buy the vehicle.
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, nil, nil, nil, nil
    */

    if ( istable( vehc.allowed ) and not table.HasValue( vehc.allowed, pl:Team( ) ) ) then return false, cfg.tabs.vehicles.unavail.bShow, ln( 'sel_msg_custom_ent_restrct' ), false, cost end

    /*
    *	vehicle > custom check
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, cfg, customCheck, true, <val>
    */

    if ( vehc.customCheck and not vehc.customCheck( pl ) ) then
        if vehc.customHideUnavail or vehc.bHideUnavail then
            return false, false, custom_check( pl, vehc ), true, cost
        else
            return false, cfg.tabs.vehicles.unavail.bShowCustoms, custom_check( pl, vehc ), true, cost
        end
    end

    /*
    *	vehicle > can afford
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, false, <val>
    */

    if ( not pl:canAfford( cost ) ) then
        return
            false,
            true,
            { ln( 'sel_notice_noafford_amt', handle:GetCostDiff( cost, false, true ) ), cfg.tabs.vehicles.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.vehicles.clrs.list.btn_gra_u },
            false,
            cost
    end

    /*
    *	vehicle > level requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( level:bEnabled( ) ) and not level:HasReq( pl, vehc ) then
        return false, true, { ln( 'sel_notice_req_lvl_i', level:Get( vehc ) ), cfg.tabs.vehicles.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.vehicles.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	vehicle > prestige requirements
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, nil, nil
    */

    if ( prestige:bEnabled( ) ) and not prestige:HasReq( pl, vehc ) then
        return false, true, { ln( 'sel_notice_req_pre_i', prestige:Get( vehc ) ), cfg.tabs.vehicles.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.vehicles.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	vehicle > can buy
    */

    if canbuy == false then
        return false, not suppress, msg, false, cost
    end

    /*
    *	vehicle > everything else
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    */

    return true, true, msg, false, cost

end

/*
*	food > list viewable
*
*   returns int, tbl of viewable food by player
*
*   @param  : void
*   @return : int, tbl
*/

function mod.food:Viewable( )
    local src               = FoodItems
                            if not src then return 0 end

    mod.food.src            = src

    local i = 0
    for k, v in pairs( src ) do
        local bCanBuy, bCanSee  = self:bCanBuy( v )
                                if not bCanSee then continue end

        i = i + 1
    end

    return i
end

/*
*	food > can buy
*
*   @param  : ent food
*   @return : bool bCanBuy
*   @return : bool bVisible
*   @return : str, tbl msg
*   @return : bool bIsCustom
*   @return : int cost
*/

function mod.food:bCanBuy( food )

    /*
    *	check valid data
    */

    if not food then
        base.msg:target( LocalPlayer( ), 'F4', rlib.settings.cmsg.clrs.target_tri, ln( 'lst_load_err_name_food' ), rlib.settings.cmsg.clrs.msg, ln( 'lst_load_err_msg' ) )
        return
    end

    /*
    *	general
    */

    local pl                = LocalPlayer( )
    local bAdminOnly        = ( food.admin == 1 or tostring( food.admin ) == 'true' and true ) or false
    local bSAdminOnly       = ( food.superadmin == 1 or tostring( food.superadmin ) == 'true' and true ) or false
    local cost              = food.price or 0

    /*
    *	food > admin override
    *
    *   allows superadmin to buy anything or become any job; no matter what restriction is in place.
    *   shouldnt be turned on unless you have a specific reason
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > true, true, nil, nil, nil
    */

    if cfg.dev.admin_override and pl:IsSuperAdmin( ) then
        return true, true, ln( 'sel_notice_admin_or' ), false, cost
    end

    /*
    *	food > admin / superadmin only
    *
    *   determines if food can only be bought by admin
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > conditional
    */

    if ( bAdminOnly and not pl:IsAdmin( ) ) then
        return false, false, ln( 'sel_notice_admin_only' ), false, cost
    elseif ( bAdminOnly and pl:IsAdmin( ) ) then
        return true, true, nil, false, cost
    elseif ( bSAdminOnly and not pl:IsSuperAdmin( ) ) then
        return false, false, ln( 'sel_notice_sadmin_only' ), false, cost
    elseif ( bSAdminOnly and pl:IsSuperAdmin( ) ) then
        return true, true, nil, false, cost
    end

    /*
    *	food > check cook job
    *
    *   determines if food item requires cook job to purchase
    *
    *   @params
    *       > bCanBuy       ( if purchasable )
    *       > bVisible      ( if bShowCustoms = true )
    *       > reason
    */

    if not handle:CanBuyFood( food ) then
        return false, cfg.tabs.food.unavail.bShow, { ln( 'sel_notice_req_cook' ), cfg.tabs.food.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.food.clrs.list.btn_gra_u }, false, cost
    end

    /*
    *	food > custom check
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, cfg, customCheck, true, <val>
    */

    if ( food.customCheck and not food.customCheck( pl ) ) then
        if food.customHideUnavail or food.bHideUnavail then
            return false, false, custom_check( pl, food ), true, cost
        else
            return false, cfg.tabs.food.unavail.bShowCustoms, custom_check( pl, food ), true, cost
        end
    end

    /*
    *	food > can afford
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    *
    *   @default
    *       > false, true, customCheck, false, <val>
    */

    if ( not pl:canAfford( cost ) ) then
        return
            false,
            true,
            { ln( 'sel_notice_noafford_amt', handle:GetCostDiff( cost, false, true ) ), cfg.tabs.food.clrs.list.btn_gra_u.a == 0 and cfg.tabs.general.sel.clrs.amsg.cus_box or cfg.tabs.food.clrs.list.btn_gra_u },
            false,
            cost
    end

    /*
    *	food > everything else
    *
    *   @params
    *       > bCanBuy, bVisible, msg, bIsCustom, cost
    */

    return true, true, nil, false, cost
end