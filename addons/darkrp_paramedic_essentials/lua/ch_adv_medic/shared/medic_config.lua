CH_AdvMedic = CH_AdvMedic or {}
CH_AdvMedic.Config = CH_AdvMedic.Config or {}
CH_AdvMedic.Config.Design = CH_AdvMedic.Config.Design or {}

-- SET LANGUAGE
-- Available languages: English: en - French: fr - Danish: da - German: de - Russian: ru - Spanish: es - Portuguese: pl - Chinese: cn - Turkish: tr
CH_AdvMedic.Config.Language = "en" -- Set the language of the script.

-- General Config
CH_AdvMedic.Config.AllowedTeams = { -- This is a list of paramedic teams. They can access the ambulance NPC and get the new health kit.
	["Medic"] = true,
	["Paramedic"] = true,
}

CH_AdvMedic.Config.DeadCanHearPlayersVoiceDistance = 250000 -- Dead players can hear alive players voices within a distance

CH_AdvMedic.Config.NotificationTime = 6 -- Amount of seconds notifications display for this addon.

CH_AdvMedic.Config.DistanceTo3D2D = 500000 -- Distance between player and NPCs to draw 3d2d above head

-- Recharge Stations
CH_AdvMedic.Config.DefaultCharges = 10 -- Amount of charges the recharge stations has when they spawns on startup.
CH_AdvMedic.Config.RegainTime = 20 -- Amount of minutes between the recharge stations regains their charges.
CH_AdvMedic.Config.RegainCharges = 5 -- Amount of charges the recharge stations regain after the 'RegainTime'
CH_AdvMedic.Config.NotifyMedics = true -- Should all the teams in the table above be notified when it has regained it's recharges. 
CH_AdvMedic.Config.MinimumCharge = 20 -- Percentage % the medkit must be below before the medics can recharge.

-- Health Kit
CH_AdvMedic.Config.MedkitHealDelay = 1.7 -- Amount of seconds between healing yourself/others. [Default = 1.7]
CH_AdvMedic.Config.MinHealthToGive = 2 -- Minimum amount of health to give when healing others/yourself.
CH_AdvMedic.Config.MaxHealthToGive = 5 -- Maximum amount of health to give when healing others/yourself.

CH_AdvMedic.Config.HealDistanceToTarget = 6000 -- Distance between the medic and target to heal them?

CH_AdvMedic.Config.HealthkitUseCharges = true -- Should we use the charge/recharge system for health kits? Set to false to disable meaning you can always heal without needing recharge stations.

-- Defibrillator Config
CH_AdvMedic.Config.DefibrillatorDelay = 2 -- Amount of seconds between using the defibrillator swep.(Don't go below 2!)
CH_AdvMedic.Config.UnconsciousTime = 30 -- Amount of seconds a player is unconscious if killed.
CH_AdvMedic.Config.UnconsciousIfNoMedicTime = 10 -- Amount of seconds a player is unconscious if killed while there are no medics.

CH_AdvMedic.Config.BecomeDarkerWhenDead = true -- Should the screen go more and more dark/black once you get knocked unconscious?
CH_AdvMedic.Config.DarkestAlpha = 250 -- How dark will it get once you die? All black alpha is 255

CH_AdvMedic.Config.RevivalReward = 250 -- How much a medic earns from reviving a player WITHOUT a life alert.

CH_AdvMedic.Config.EnableDeathMoaning = true -- Should players emit death moaning sounds while laying unconscious?
CH_AdvMedic.Config.DisableChatWhenDead = true -- Should the dead player be able to use their chat while unconscious?

CH_AdvMedic.Config.ClickToRespawn = true -- Should the player click to respawn after the time runs out or instantly respawn?

CH_AdvMedic.Config.RevivalFailChance = 25 -- How high is the chance that a revival attempt will fail? 25% fail chance by default.

CH_AdvMedic.Config.ReviveDistanceToTarget = 8000 -- Distance between the medic and target/body to revive them?

CH_AdvMedic.Config.DefibUpdateCharge = 25 -- How much "charge" is given per right click. MUST BE 25 - 50 - 75 or 100!

CH_AdvMedic.Config.PromoteToPreviouslyJobOnRevive = true -- If you demote players to citizen on death, then setting this to true to promote them back to their job if they get revived (like mayors for example)

CH_AdvMedic.Config.HealthAfterRevival = 35 -- How much health does the player have after being revived?

-- Life Alert
CH_AdvMedic.Config.LifeAlertIcon = Material( "icon16/heart_delete.png" ) -- The icon to appear on the player when dead if he/she has a life alert. LIST HERE: http://www.famfamfam.com/lab/icons/silk/preview.php
CH_AdvMedic.Config.LifeAlertRevivalReward = 1000 -- How much a medic earns from reviving a player WITH a life alert.
CH_AdvMedic.Config.LifeAlertNotifyMedic = true -- Notify paramedics about location of dead bodies with life alerts.
CH_AdvMedic.Config.AutoLifeAlert = false -- Enabling this will "give" every player a life alert automatically and remove it from the F4 menu.

CH_AdvMedic.Config.LifeAlertDistance = true -- Should the life alert icon and distance show on bodies with a life alert?
CH_AdvMedic.Config.LifeAlertHalo = true -- Should bodies with a life alert glow with a red halo for medics to see on the map?
CH_AdvMedic.Config.LifeAlertHaloColor = Color( 255, 0, 0, 255 ) -- Color of the halo on dead bodies.

-- Ambulance NPC Configuration
CH_AdvMedic.Config.VehicleModel = "models/lonewolfie/ford_f350_ambu.mdl" -- This is the model for the ambulance.
CH_AdvMedic.Config.VehicleScript = "scripts/vehicles/lwcars/ford_f350_ambu.txt" -- This is the vehicle script for the vehicle.
CH_AdvMedic.Config.VehicleSkin = 0 -- 0 = default, 1 = evo city, 2 = rockford, 3 = paralake, 4 = all white, 5 = zebra, 6 = spirals, 7 = camoflage, 8 = all black
CH_AdvMedic.Config.AmbulanceHealth = 250 -- The amount of health the ambulance has.

CH_AdvMedic.Config.NPCModel = "models/Humans/Group03m/Female_02.mdl" -- This is the model of the NPC to get a ambulance from.
CH_AdvMedic.Config.MaxTrucks = 3 -- The maximum amount of ambulances allowed.

CH_AdvMedic.Config.AutoEnterAmbulance = false -- Automatically put the player into the ambulance when they retrieve it.

-- Health NPC Configuration
CH_AdvMedic.Config.HealthNPCModel = "models/humans/surgeon/surgeon.mdl" -- This is the model of the NPC to regain health.
CH_AdvMedic.Config.HealthPrice = 500 -- This is the price for full health via the NPC.
CH_AdvMedic.Config.ArmorPrice = 1000 -- This is the price for full armor via the NPC.

CH_AdvMedic.Config.OnlyWorkIfNoMedics = false -- Only allow players to heal/armor via the NPC if there are NO medics. Else defaults to config below!
CH_AdvMedic.Config.RequiredMedics = 1 -- Amount of players from the teams in the table (CH_AdvMedic.Config.AllowedTeams). Default is 1 required medic/paramedic/doctor available before you can use the health npc.
CH_AdvMedic.Config.MaximumArmor = 100 -- Maximum amount of armor the armor kit entities can heal a player to.

CH_AdvMedic.Config.NPCSellHealth = true -- Should the health NPC sell health or not? Allows you to disable it if set to false.
CH_AdvMedic.Config.NPCSellArmor = true -- Should the health NPC sell armor or not? Allows you to disable it if set to false.

-- Rank Death Times
CH_AdvMedic.Config.EnableRankDeathTimes = false -- If this feature should be enabled or not (Works only with ULX, SAM & ServerGuard).

CH_AdvMedic.Config.RankDeathTime = {
	{ UserGroup = "user", Time = 20 },
	{ UserGroup = "vip", Time = 15 },
	{ UserGroup = "admin", Time = 15 },
	{ UserGroup = "superadmin", Time = 10 },
	{ UserGroup = "owner", Time = 10 },
}

-- Chat Commands
CH_AdvMedic.Config.AdminReviveCommand = "!arevive" -- Command for admins to revive themselves when unconscious

-- Damage and Injuries System
CH_AdvMedic.Config.EnableInjurySystem = true -- Should the injury system be enabled or not?
CH_AdvMedic.Config.HitsBeforeInjuries = 3 -- Amount of hits from bullets the player can take before he will start to get injured.

CH_AdvMedic.Config.DisableInjuriesForCertainTeams = false -- If this is enabled, the teams below WILL NOT receive injuries when damaged.
CH_AdvMedic.Config.ImmuneInjuriesTeams = { -- The teams that won't get injuried if the config above is enabled.
	["Alien"] = true,
	["Ghost"] = true,
}

CH_AdvMedic.Config.MinHealthFixInjury = 75 -- When healing what's the minimum amount of health a player must have before an injury is fixed.

CH_AdvMedic.Config.BrokenLegWalkSpeed = 100 -- Changes the players walk speed when their leg is broken. Default in DarkRP is 160.
CH_AdvMedic.Config.BrokenLegRunSpeed = 120 -- Same as above but for run speed. Default in DarkRP is 240.

CH_AdvMedic.Config.InternalBleedingInterval = 3 -- Interval between bleedings taking damage from the player slowly.
CH_AdvMedic.Config.DamageFromBleedingMin = 3 -- Minimum amount of damage taken every time the player bleeds from injury.
CH_AdvMedic.Config.DamageFromBleedingMax = 7 -- Maximum amount of damage taken every time the player bleeds from injury.
CH_AdvMedic.Config.EnableBleedingHurtSounds = true -- Should the "im hurt" sounds be enabled when a person is bleeding from injury.

CH_AdvMedic.Config.DisallowedBrokenArmWeapons = { -- List of weapons that cannot be equipped with a broken arm!
	["m9k_jackhammer"] = true,
	["m9k_usas"] = true,
	["m9k_striker12"] = true,
	["m9k_aw50"] = true,
	["m9k_barret_m82"] = true,
	["m9k_m98b"] = true,
	["m9k_svu"] = true,
	["m9k_sl8"] = true,
	["m9k_intervention"] = true,
	["m9k_m24"] = true,
	["m9k_psg1"] = true,
	["m9k_remington7615p"] = true,
	["m9k_dragunov"] = true,
	["m9k_svt40"] = true,
	["m9k_honeybadger"] = true,
	["m9k_smgp90"] = true,
	["m9k_mp7"] = true,
	["m9k_thompson"] = true,
	["m9k_kac_pdw"] = true,
	["m9k_vector"] = true,
	["m9k_magpulpdr"] = true,
	["m9k_ares_shrike"] = true,
	["m9k_fg42"] = true,
	["m9k_minigun"] = true,
	["m9k_m1918bar"] = true,
	["m9k_m249lmg"] = true,
	["m9k_m60"] = true,
	["m9k_pkm"] = true,
}

-- Alternative Gender Models
-- This is here so you can set genders for models male/female models that are not default from GMod. So that they will moan with the correct gender once dead.
-- If a gender is not defined it will return as a male always.
CH_AdvMedic.Config.AlternativeMaleModels = {
	["models/humans/male_gestures.mdl"] = true,
	["models/humans/male_postures.mdl"] = true,
	["models/humans/male_shared.mdl"] = true,
	["models/humans/male_ss.mdl"] = true,
}

CH_AdvMedic.Config.AlternativeFemaleModels = {
	["models/humans/female_gestures.mdl"] = true,
	["models/humans/female_postures.mdl"] = true,
	["models/humans/female_shared.mdl"] = true,
	["models/humans/female_ss.mdl"] = true,
}

--[[
	XP SUPPORT
--]]
CH_AdvMedic.Config.HealPlayerXP = 20 -- Amount of XP given when healing a player.
CH_AdvMedic.Config.RevivePlayerXP = 50 -- Amount of XP given when reviving a player.
CH_AdvMedic.Config.RevivePlayerLifeAlertXP = 20 -- Amount of XP given when reviving a player with a life alert.