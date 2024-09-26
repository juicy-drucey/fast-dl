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
*   SETTINGS > RULES
*/

    /*
    *	rules > general
    *
    *   you can either display rules via a website; or use text only for your players. the options below
    *   will determine what happens when a player clicks the rules button on your script.
    *
    *   @note   :   if use_text = false -> set the rules website url in:
    *               lua\modules\arivia\cfg\sh_3_nav.lua
    *               cfg.nav.btn.rules_int = 'your url'
    */

        cfg.rules =
        {
            use_text            = true,
            clrs                =
            {
                primary         = Color( 30, 30, 30, 255 ),
                text            = Color( 255, 255, 255, 255 ),
                btn_web_box     = Color( 48, 61, 103, 255 ),
                btn_web_txt     = Color( 255, 255, 255, 255 ),
            },
        }

    /*
    *	rules > text
    *
    *   the text below will display only if you set:
    *       use_text = true
    */

        cfg.rules.text = [[

---General Roleplay Rules---

- Do not RDM (Random Death Match) - killing another player without a valid roleplay reason or initiation.

- Do not VDM (Vehicle Death Match) - Killing another player with a vehicle.

- Do not RDA/RDT (Random Arrest/Taze) - arresting a player without a valid roleplay reason.

- Do not Metagame - the use of information gained from a 3rd party program (Example: Discord, Forums, etc) or an OOC (Out of Character) setting in a roleplay scenario.

- Do not Powergame - creating nonconsensual RP against another player (Example: telling them that they have non-existent drugs in their possession so you have an excuse to arrest them), scamming or interrupting a transaction, bending RP to create an unfair advantage or win an RP situation that you otherwise may have lost.

- Do not FailRP - treat each situation with a touch of realism. Example: jumping on the body of a tased player to intentionally kill them.

- Do not Fading Door Abuse - using the keybind or other owner/gang/player exclusive methods to open/close doors when involved in a roleplay situation. Example: using your keybind to open/close a door during a base raid or a wiremod trigger that only opens the door for the owner & doesn't hold for the minimum 4 seconds.

- Do not Door Abuse - spamming doors open/closed to prevent a door from being opened by another player.

- Do not break NLR - when killed, you must forget everything that happened in the past life, and may not return to the location of your death for at least 5 minutes or until the situation has ended.

- Do not self-supply - using a job ability to buy weapons, explosives, armor or other entities for yourself and/or your group, even if they pay for it. You should buy these items from another player instead.

- FearRP is not enforced on this server. If you feel that you can get yourself out of a dangerous situation with the weapons you have, godspeed!

- Disrespect/harassment of players in an OOC (Out of Character) manner is not permitted. You may use reasonable RP disrespect, so long as the target and/or a staff member has not asked you to stop.

- Disconnecting from the server after being raided is not permitted and may result in a ban. If you lose a raid, don't be a spoil sport - give them 30 minutes to benefit from the raid before you leave.

- If you are not directly involved in a roleplay situation you are to remain well clear of it and not interfere with others involved.

- Once you are downed (killed but able to be revived) in a hostile situation, you can no longer return to that combat situation if revived by a paramedic. However, since NLR doesn't apply if revived, you may remember what occurred during this situation and use it in RP at a later time.

- When a combat situation has ended (all opposing parties have been downed), you must move on from the incident and allow Paramedics to do their job. Do not hold Paramedics at gunpoint to prevent them from doing or threaten to kill them for doing their job.

- You cannot place False Hits - a hit placed for any non RP reason, a reason that is not sensible within RP bounds, a reason that breaches other server rules, etc. Staff may deem your hit reason invalid at any time for any of the above reasons (or others as deemed necessary by Management), and cannot be used in future.

---RAIDER RULES---

- When initiating a raid, the first raider must type /raid, all others type /assist before entering the base/building. All raiders involved must wait a 10 minute raid/assist cooldown. A raid must be finished within 10 minutes from the time it started. You cannot raid the same base again for at least 30 minutes after the raid ends. You MUST type /raidover after finishing a raid. Only 1 Battle Medic is allowed when raiding.

- You can only raid with the party (AKA /gang) or organisation (/orgs) members that you're currently basing with.

- You cannot join a raid after the first raider has entered base/building.

- You may not build or move props during a raid.

- During a PD raid you may only KOS law enforcement and secret service. You may KOS the mayor if they have not surrendered after 3 warnings have been given or if they are hostile. You must give ample warning for anyone else to leave. Example: /y Leave now or you will be shot!. You must leave the PD as soon as the raid is completed, do not loiter.

- You must give ample warning for anyone to leave who is not part of the base you are raiding, but are inside the base/area. This excludes those who are attempting to stop you from raiding. Example: /y Leave now or you will be shot!

- You cannot 'code' raid. Using keypad codes to raid a base.

- Further to PD Raid Rules. You can demand realistic things from the Mayor during a raid if they are surrendered. If they fail to comply you are allowed to kill them.

- Realistic things to ask during PD Raid: Lowering taxes, remove a law (that isn't default) etc. If the Mayor complies, you cannot kill them.

---COUNTER RAID RULES---
        
- Before counter raiding any raid you must type /counter.

- You MUST continue the raid when countering. You cannot kill raiders and leave as a favour to the base owner.

- You cannot counter raid the bank raid. This may only be countered by law enforcement.

---DEFENDER RULES---

- You must give ample warning for anyone else to leave who are not part of the raid but are in the base/area. Example: /y Leave now or you will be shot!

- You may not build or move props during a raid.
        
---VEHICLE RULES---
        
- You cannot steal job vehicles. (e.g. Police vehicles, swat vehicles, ambulances)

- You must drive vehicles in a reasonably roleplay manner. Driving like an idiot will result in your car being deleted and/or you receiving a car ban for the rest of the session.

- Intentionally damaging or blowing up vehicles to annoy, injure or kill other players without a valid RP reason is not allowed.
        
---DEFAULT DARKRP LAWS---

- Murder, assault, mugging and kidnapping are illegal by default and cannot be changed.

- Breaking and entering into any building is illegal and cannot be changed.

- All forms of drugs are illegal unless the mayor says otherwise.

- Money printers are illegal unless stored inside of a Banker's vault.

- Black Market Dealers are considered illegal at all times. They cannot be arrested on sight based on their job, they must be selling/intending to sell (opening up a shop, doing side deals, etc) their illegal weapons.

- Attacking other citizens is illegal unless in self-defense.

- It is illegal to discharge any weapon other than a licensed pistol (only when used in self-defense), at all times.

- It is illegal to/attempt to enter a government facility or a bank with any weapons, unless you are a member of Law Enforcement or Banker/Security of said bank.

- Laundering money is against the law
        
---BUILDING RULES---

- You can have a maximum of 2 doors as a base entrance whilst basing with other players. This limit increases to a maximum of 3 doors when basing alone. You cannot have nocollided doors in your entrance. These doors may consist of map doors (ROLLER DOORS ARE NOT PERMITTED!) and fading doors which can be controlled by keypads & E2 ONLY, and must hold for at least 4 seconds. Doors cannot be one-way visibility. Doors and doorways must be a material unique to the adjoined walls.

- You can use ONE additional keypad (that must be toggleable ONLY) to protect valuables inside the base. It cannot be a part of your entrance.

- Your entrance cannot require players to crouch (including keypads) - it must be fully accessible whilst standing, and cannot include an elevator. Your entrance hallway must fit two players side-by-side at all times. Your base entrance can only be 16 blocks in length. Blindfire is not permitted. Entrance doors (and doorway) must be at least the same dimensions as a standard map door, and cannot be double/triple stacked, etc.

- KOS signs are allowed but must be visible and state ALL conditions to follow to prevent KOS. Vague conditions are not permitted, at discretion of server staff.

- Shooting holes are allowed (but must remain open for 2 seconds, with a min size of 2x2, and cannot be one-way visibility). These must be connected to a wiremod button / delay setup. You cannot use damage detectors to open the shooting windows. 

- Roof bases are allowed but you must have an open path to the entrance, unobstructed. Blacked out bases, sky bases and underwater bases are not permitted. You may have a maximum of 1 base.

- Foot / head peaks / drop traps are not allowed. Defenders and Raiders must be able to equally see each other at the same level.

- Casino E2s / Wire must be inside your base, not on the street.

- All PD doors must be accessible, you cannot block any entrances to PD permanently.

- You cannot have keypads or KOS signs on ladders. This includes map ladders, props acting as ladders (teeth props, etc), etc. Any type of ladder should not be part of your entrance way.

- The entrance or base cannot be difficult to navigate and cannot create an unfair advantage for defenders. Staff members reserve the right to ask you to change it. Senior Staff and Management overrule existing base-approvals.

- When using Prox Mines, you cannot use any method to prevent their detonation against players/entities in any situation. This includes, but isn't limited to, using fading doors in base entrances to prevent detonation.

- You cannot use explosives in any manner other than the intended use. Finding ways to make explosives OP, using them as base defenses, etc. Management have final say if a base design/contraption is permitted to be used.

- Megabasing is not allowed. You cannot block off parts of the map or use multiple buildings/rooftops.

- You can now utilize a map door as part of your entrance. It can be locked using keys. You shouldn't have more than one map door as part of your entrance. You cannot use roller doors / garage doors still.

---PARTY / ORGANISATION RULES---

- Party/Gang refers to the session based party system TAU offers. Org/Organisation refers to the permanent system that will save over sessions.

- You may have a maximum of 5 people in a party/gang. Job limits apply, see Player Basing Rules and Job Specific Rules.

- All members of the party/gang must base together in the same base, you cannot have separate bases.

- You cannot assist party/gang members that are caught up in another situation (for example, being arrested by Police) unless you too are being arrested.

- You can have as many members added to your org as is possible in the /orgs menu. (See 'Max Members')

- You may only defend the base that you are living in without using a counter raid, not other bases owned by your organisation. You must counter-raid any other base (/counter).

- You do not need to initiate separately on people who are interacting with a member of your organisation, so long as you were a part of the RP when it started. However, if another player initiates on a party/org member, you can only help your member if the situation involves you.

- If you enter into the RP situation after it has started, you must initiate separately. You cannot initiate into a situation that you have no RP involvement in. Being in an Org with someone does not make you involved.

---BASE RULES---

- A base has a maximum occupancy of 5 players who must be in a party (/gang) or organisation together (/orgs). This limit includes up to a maximum of 1 Battle Medic. You must own all doors in your base, and anyone basing with you must be added to all doors.

- The Gangster / Mafia sides are not required to be in a gang or organisation, and may have as many members in a base together as the server permits.

- A base may wish to have players visit, but they cannot: buy/store any entities or assist with base defense.



        ]]