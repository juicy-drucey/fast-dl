include( "ballistic_shields/sh_bs_util.lua" )

--------------------- BALLISTIC SHIELDS V1.1.22 -------------------------
-- BEFORE SENDING A SUPPORT TICKET PLEASE MAKE SURE YOU'VE INSTALLED WORKSHOP
-- CONTENT ON YOUR SERVER! LINK: https://steamcommunity.com/sharedfiles/filedetails/?id=1819166858
-- IF YOU'RE HAVING ANY ISSUES READ THE HOW-TOS SECTION OF THE SCRIPT FOR ANY POSSIBLE SOLUTIONS

---- CONFIG ----
-- AVALAIBLE LANGUAGES - English, German, French, Danish, Turkish, Russian, Chinese, Spanish
bshields.config.language = "English"
-- DISABLE HUD
bshields.config.disablehud = false
-- MINIMUM RIOT SHIELD DAMAGE
bshields.config.rshielddmgmin = 16
-- MAXIMUM RIOT SHIELD DAMAGE
bshields.config.rshielddmgmax = 24
-- HEAVY SHIELD EXPLOSION DAMAGE REDUCITON (IN %)
bshields.config.hshieldexpl = 50
-- HEAVY SHIELD MELEE DAMAGE REDUCTION (IN %)
bshields.config.hshieldmelee = 20
-- RIOT SHIELD MELEE DAMAGE REDUCTION (IN %)
bshields.config.rshieldmelee = 60
-- HEAVY SHIELD BREACH COOLDOWN (IN SECONDS)
bshields.config.hshieldcd = 20
-- DOOR RESPAWN TIMER (IN SECONDS)
bshields.config.doorrespawn = 60
-- MAXIMUM AMOUNT OF DEPLOYED SHIELDS
bshields.config.maxshields = 3
-- SHOULD FADING DOORS BE BREACHABLE?
bshields.config.breachfdoors = false
-- ALLOW BREACHING UNOWNED DOORS
bshields.config.breachudoors = true
-- REMOVE DEPLOYED SHIELDS ON JOB CHANGE
bshields.config.removeonjobchange = true
-- REMOVE DEPLOYED SHIELDS ON DEATH
bshields.config.removeondeath = false


-------- CUSTOM TEXTURES, LEAVE "" FOR DEFAULT "POLICE" TEXT. ----------
--- FOR EDITING USE THE 256x256 TEMPLATE INCLUDED IN THE MAIN FOLDER ---

-- HEAVY SHIELD
bshields.config.hShieldTexture = ""
-- RIOT SHIELD
bshields.config.rShieldTexture = ""
-- DEPLOYABLE SHIELD
bshields.config.dShieldTexture = "" 
---------- YOU NEED TO RECONNECT IN ORDER TO SEE ANY CHANGES! ----------


-- [CW2] YOU NEED THIS ADDON: https://steamcommunity.com/sharedfiles/filedetails/?id=1771994451
-- SHOULD RIOT SHIELD BE BULLETPROOF? [CW2 AND TFA ONLY] --
bshields.config.rshieldbp = false


-- PREVENT THESE MODELS FROM USING RIGHT HAND BONE ATTACHMENT
bshields.config.pmodels = {
	["models/player/ven/tk_501_01/tk_501.mdl"] = true,
	["models/player/ven/tk_501_02/tk_501.mdl"] = true,
	["models/player/ven/tk_incinerator_01/tk_incinerator.mdl"] = true,
	["models/player/ven/tk_incinerator_02/tk_incinerator.mdl"] = true
}