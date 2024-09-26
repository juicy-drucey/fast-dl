--[[---------------------------------------------------------------------------
DarkRP custom shipments and guns
---------------------------------------------------------------------------

This file contains your custom shipments and guns.
This file should also contain shipments and guns from DarkRP that you edited.

Note: If you want to edit a default DarkRP shipment, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the shipment to this file and edit it.

The default shipments and guns can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomShipmentFields


Add shipments and guns under the following line:
---------------------------------------------------------------------------]]
DarkRP.createShipment("AK-74", { model = "models/weapons/w_rif_ak47.mdl", entity = "cw_ak74", price = 12000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("AR-15", { model = "models/weapons/w_rif_m4a1.mdl", entity = "cw_ar15", price = 14000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("G3A3", { model = "models/weapons/w_snip_g3sg1.mdl", entity = "cw_g3a3", price = 15000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("HK UMP .45", { model = "models/weapons/w_smg_ump45.mdl", entity = "cw_ump45", price = 13000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("HK MP5", { model = "models/weapons/w_smg_mp5.mdl", entity = "cw_mp5", price = 15000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("FN Five-Seven", { model = "models/weapons/w_pist_fiveseven.mdl", entity = "cw_fiveseven", price = 15000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Pistols"})

DarkRP.createShipment("IMI Desert Eagle", { model = "models/weapons/w_pist_deagle.mdl", entity = "cw_deagle", price = 16000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Pistols"})

DarkRP.createShipment("MR96", { model = "models/weapons/w_357.mdl", entity = "cw_mr96", price = 12000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Pistols"})

DarkRP.createShipment("L115", { model = "models/weapons/w_cstm_l96.mdl", entity = "cw_l115", price = 32000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Sniper Rifles"})

DarkRP.createShipment("Barrett M98 Bravo", { model = "models/weapons/w_snip_awp.mdl", entity = "cw_g4p_m98b", price = 40000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Sniper Rifles"})

DarkRP.createShipment("HK416", { model = "models/weapons/w_cwkk_hk416.mdl", entity = "cw_kk_hk416", price = 18000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("HK G36C", { model = "models/weapons/cw20_g36c.mdl", entity = "cw_g36c", price = 20000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("M3 Super 90", { model = "models/weapons/w_cstm_m3super90.mdl", entity = "cw_m3super90", price = 20000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Shotguns"})

DarkRP.createShipment("M14 EBR", { model = "models/weapons/w_cstm_m14.mdl", entity = "cw_m14", price = 30000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("M249", { model = "models/weapons/cw2_0_mach_para.mdl", entity = "cw_m249_official", price = 60000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_BMD}, category = "Black Market"})

DarkRP.createShipment("M1911", { model = "models/weapons/cw_pist_m1911.mdl", entity = "cw_m1911", price = 15000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Pistols"})

DarkRP.createShipment("MAC-11", { model = "models/weapons/w_cst_mac11.mdl", entity = "cw_mac11", price = 17000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("Makarov", { model = "models/cw2/pistols/w_makarov.mdl", entity = "cw_makarov", price = 12000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Pistols"})

DarkRP.createShipment("P99", { model = "models/weapons/w_pist_p228.mdl", entity = "cw_p99", price = 15000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Pistols"})

DarkRP.createShipment("FN SCAR-H", { model = "models/cw2/rifles/w_scarh.mdl", entity = "cw_scarh", price = 18000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("Serbu Shorty", { model = "models/weapons/cw2_super_shorty.mdl", entity = "cw_shorty", price = 18000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Shotguns"})

DarkRP.createShipment("VSS Vintorez", { model = "models/cw2/rifles/w_vss.mdl", entity = "cw_vss", price = 18000, amount = 10, separate = false, pricesep = nil, noship = false, allowed = {TEAM_GUN,TEAM_BMD}, category = "Assault Rifles"})

DarkRP.createShipment("IED Detonator", {
	model = "models/weapons/w_camphon2.mdl",
    category = "Black Market",
	entity = "m9k_ied_detonator",
	price = 120000, // Price for a shipment
	amount = 4, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})

DarkRP.createShipment("M79 GL", {
	model = "models/weapons/w_m79_grenadelauncher.mdl",
    category = "Black Market",
	entity = "m9k_m79gl",
	price = 100000, // Price for a shipment
	amount = 5, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})

DarkRP.createShipment("RPG-7", {
	model = "models/weapons/w_rl7.mdl",
    category = "Black Market",
	entity = "m9k_rpg7",
	price = 150000, // Price for a shipment
	amount = 3, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})


DarkRP.createShipment("Prox Mine", {
	model = "models/weapons/w_px.mdl",
    category = "Black Market",
	entity = "m9k_proxy_mine",
	price = 100000, // Price for a shipment
	amount = 4, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})


DarkRP.createShipment("Milkor Mk1", {
	model = "models/weapons/w_milkor_mgl1.mdl",
    category = "Black Market",
	entity = "m9k_milkormgl",
	price = 150000, // Price for a shipment
	amount = 5, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})


DarkRP.createShipment("EX41", {
	model = "models/weapons/w_ex41.mdl",
    category = "Black Market",
	entity = "m9k_ex41",
	price = 110000, // Price for a shipment
	amount = 10, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})


DarkRP.createShipment("Machete", {
	model = "models/weapons/w_fc2_machete.mdl",
    category = "Black Market",
	entity = "m9k_machete",
	price = 30000, // Price for a shipment
	amount = 5, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})


DarkRP.createShipment("M202", {
	model = "models/weapons/w_rocket_launcher.mdl",
    category = "Black Market",
	entity = "m9k_m202",
	price = 175000, // Price for a shipment
	amount = 3, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})

DarkRP.createShipment("Timed C4", {
	model = "models/weapons/w_sb.mdl",
    category = "Black Market",
	entity = "m9k_suicide_bomb",
	price = 160000, // Price for a shipment
	amount = 4, // How many in a shipment
	separate = false,
	pricesep = nil, // Price of individual guns
	noship = false,
	allowed = {TEAM_BMD}, // Allowed teams
})
