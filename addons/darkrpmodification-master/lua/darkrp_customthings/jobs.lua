--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------
This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
      Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomJobFields

Add your custom jobs under the following line:
---------------------------------------------------------------------------]]
TEAM_CITIZEN = DarkRP.createJob("Citizen", {
    color = Color(20, 150, 20),
    model = {
        "models/player/zelpa/male_01.mdl",
        "models/player/zelpa/male_02.mdl",
        "models/player/zelpa/male_03.mdl",
        "models/player/zelpa/male_04.mdl",
        "models/player/zelpa/male_05.mdl",
        "models/player/zelpa/male_07.mdl",
        "models/player/zelpa/male_08.mdl",
        "models/player/zelpa/male_09.mdl",
        "models/player/zelpa/male_10.mdl",
        "models/player/zelpa/male_11.mdl",
        "models/player/zelpa/female_01.mdl",
        "models/player/zelpa/female_01_b.mdl",
        "models/player/zelpa/female_02.mdl",
        "models/player/zelpa/female_02_b.mdl",
        "models/player/zelpa/female_03.mdl",
        "models/player/zelpa/female_03_b.mdl",
        "models/player/zelpa/female_04.mdl",
        "models/player/zelpa/female_04_b.mdl",
        "models/player/zelpa/female_06.mdl",
        "models/player/zelpa/female_06_b.mdl",
        "models/player/zelpa/female_07.mdl",
        "models/player/zelpa/female_07_b.mdl"
    },
    description = [[
        The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.
        
         Roleplay Guidelines:
		- You are not allowed to raid or mug and may only kill people in self defence
		- You must not interfere with raids or police business.
		- Citizens should look for jobs to do so there is more variety for the entire server to RP with.
    ]],
    weapons = {"weapon_fists"},
    command = "citizen",
    max = 0,
    salary = 45,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
    canDemote = false,
})

TEAM_HOBO = DarkRP.createJob("Hobo", {
    color = Color(150, 75, 0),
    model = "models/jessev92/player/l4d/m9-hunter.mdl",	
    description = [[
The Hobo is the city's most unfortunate yet resilient member. You live off the streets, surviving on scraps and the mercy of others. Life as a Hobo is           tough,but you’ve embraced it with creativity and determination. From begging for coins to building makeshift shelters from whatever you find, you carve out a life of freedom. While society may look down on you, your street smarts and adaptability make you a unique part of the urban ecosystem.
        
Roleplay Guidelines:
- You may build a shelter on the sidewalk.
- You are not allowed to raid and may only kill people in self defence
- You are allowed to have quick hobo fights so long as no one else gets in the way
- It is FailRP to buy or own things that hobos should not have within RP. No cars, or owning buildings.    
    ]],
    weapons = {"weapon_fists"},
    command = "hobo",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
    canDemote = false,
    hobo = true,
})

TEAM_CLUB = DarkRP.createJob("Club Owner", {
	color = Color(128, 0, 128),
    model = "models/player/10ension/kiryukiwamipm/kiryu_kiwami_pm.mdl",	
    description = [[
As the Club Owner, you are the mastermind behind one of the city's most thriving nightlife spots. Whether you choose to manage the glamorous Showgirls Club or the sleek Downtown Club, it’s your responsibility to keep the drinks flowing, the entertainment alive, and the patrons happy. Hire staff such as bartenders, strippers, and security guards to maintain the atmosphere of your establishment. You are free to host events, manage entry fees, and run the business as you see fit — within the law, of course. But be wary: the police may take an interest in the more questionable activities within your club.
        
Roleplay Guidelines:
- As a Club Owner, you're running a legal business. Any involvement in illegal activities, such as drug deals or money laundering, must be done discreetly. Engaging in such activities without proper roleplay or in plain view of the police could result in a raid or punishment from admins.
- You may only own one club at a time.
- You're allowed to set rules for entry and behavior within your club. However, if you enforce rules, such as charging an entry fee, you must roleplay the process (using /me or /advert to announce the fee) and cannot use it as a way to "randomly kill" or eject players without valid reason (this would be considered FailRP or RDM).
- Hosting events (such as parties or VIP nights) must be properly roleplayed and announced via /advert or similar systems. You can charge entry fees or run promotions however you must make it very clear to the client before proceeding.
    ]],
    weapons = {"weapon_fists"},
    command = "clubowner",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
    canDemote = false,
})

TEAM_SHOWGIRL = DarkRP.createJob("Stripper", {
	color = Color(255, 20, 147),
    model = "models/kuma96/nikki/nikki_pm.mdl",	
    description = [[
As a stripper, your job is to entertain others and keep the party alive. Whether performing in clubs or private venues, you're here to add some excitement to the nightlife. Use your charm and dance skills to attract tips and keep the audience engaged.
        
Key Responsibilities:
- Perform dances and entertain customers.
- Work at the designated showgirls club in the hood or private parties.
- Earn tips from clients.
    ]],
    weapons = {"weapon_fists"},
    command = "stripper",
    max = 4,
    salary = 80,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
    canDemote = false,
})

TEAM_BANKER = DarkRP.createJob("Banker", {
	color = Color(0, 128, 128),
    model = "models/sentry/gtav/business/busi2pm.mdl",	
    description = [[
As a banker, your role is to offer secure storage and financial services to other players. Players can store valuable items in your bank for safekeeping, protecting them from potential theft or loss. It's your job to ensure that their assets (such as printers) are well-protected while managing the day-to-day operations of the bank. You are also responsible for working with the authorities to prevent bank robberies and ensure the safety of all deposits.
        
Roleplay Guidelines:
- Bankers cannot be involved in illegal activities, including robbery or assisting criminals as this is fail RP.
- Bankers may NOT take the cash of clients money printers or other valuables when storing them in the vault for safekeeping.
    ]],
    weapons = {"weapon_fists"},
    command = "banker",
    max = 2,
    salary = 130,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
    canDemote = false,
})

TEAM_BARTENDER = DarkRP.createJob("Bartender", {
    color = Color(192, 192, 192),
    model = "models/player/sophie-bear/shizuo/shizuo.mdl", "models/player/sophie-bear/shizuo/shizuoc.mdl",
    description = [[
As a bartender, you're the heart of the bar, serving drinks and keeping customers happy. Work behind the counter at the showgirls or at the local nightclub, mix drinks, and keep the atmosphere lively. Chat with patrons, manage orders, and make sure the bar stays stocked. Whether you're serving the regulars or newcomers, you're here to create a fun, friendly, and safe environment.
    ]],
    weapons = {"weapon_fists"},
    command = "bartender",
    max = 4,
    salary = 80,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
    canDemote = false,
})

TEAM_GUARD = DarkRP.createJob("Security Guard", {
	color = Color(128, 128, 128),
    model = {
		"models/player/guard_pack/guard_01.mdl", 
		"models/player/guard_pack/guard_02.mdl", 
		"models/player/guard_pack/guard_03.mdl", 
		"models/player/guard_pack/guard_04.mdl", 
		"models/player/guard_pack/guard_05.mdl", 
		"models/player/guard_pack/guard_06.mdl", 
		"models/player/guard_pack/guard_07.mdl", 
		"models/player/guard_pack/guard_08.mdl", 
		"models/player/guard_pack/guard_09.mdl"
    },
    description = [[
As a Security Guard, your duty is to protect private property, businesses, and individuals from theft, vandalism, and any other threats. You are hired by shop owners, wealthy citizens, and even corporate establishments to ensure their safety and peace of mind. While you are not a police officer, your role is crucial in maintaining order in the areas you're hired to guard. You work under a contract with your employer and must follow their guidelines while respecting the law.
        
Roleplay Guidelines:
- You are not a law enforcement officer, so you cannot arrest individuals or use high-tier military-grade weapons.
- You must act professionally while on duty, respecting the rights of others and avoiding unnecessary violence.
- You can only be hired to protect specific locations or people, and you should follow the instructions of your employer.
- When off duty, you’re a regular citizen with no special privileges or authority.
    ]],
    weapons = { 
            "stunstick", 
            "weapon_fists"
     },
    command = "securityguard",
    max = 6,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Citizens",
})

TEAM_GUN = DarkRP.createJob("Gun Dealer", {
    color = Color(255, 140, 0, 255),
    model = "models/player/monk.mdl",
    description = [[
As a Gun Dealer, your role is to supply the city’s law-abiding citizens, law enforcement, and security personnel with legal firearms and ammunition. Operating as a legitimate business owner, you sell weapons that are within the confines of the law. You can establish your own gun shop, set prices, and manage your inventory responsibly. While you can’t access black market or illegal weapons, your stock of standard arms makes you an essential resource for personal defense and professional security needs.

Roleplay Guidelines:
- You can only base with other gun dealers and security guards.
- You can build vending machines that sell your shipments around the map, however you must comply with all previous building rules.
        ]],
    weapons = {"weapon_fists"},
    command = "gundealer",
    max = 2,
    salary = 80,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Citizens",
})

TEAM_MEDIC = DarkRP.createJob("Paramedic", {
	color = Color(128, 0, 0),
    model = {
        "models/player/gems_paramedic2/female_01.mdl",
        "models/player/gems_paramedic2/female_02.mdl",
        "models/player/gems_paramedic2/female_03.mdl",
        "models/player/gems_paramedic2/female_04.mdl",
        "models/player/gems_paramedic2/female_06.mdl",
        "models/player/gems_paramedic2/male_01.mdl",
        "models/player/gems_paramedic2/male_02.mdl",
        "models/player/gems_paramedic2/male_03.mdl",
        "models/player/gems_paramedic2/male_04.mdl",
        "models/player/gems_paramedic2/male_05.mdl",
        "models/player/gems_paramedic2/male_06.mdl",
        "models/player/gems_paramedic2/male_07.mdl",
        "models/player/gems_paramedic2/male_08.mdl",
        "models/player/gems_paramedic2/male_09.mdl"
    },
    description = [[
As a paramedic, your primary duty is to respond to emergencies and provide life-saving medical care to citizens and other players. Whether it's healing	injuries, reviving downed players, or assisting during accidents, you ensure the safety and well-being of the community. Keep your medical equipment ready and always be on alert for distress calls. You are a non-combatant and should avoid violence unless in self-defence.
        
Roleplay Guidelines:
- You are a neutral class, do not involve yourself in crime - treat everyone equally. You may not refuse to heal.
- You are not allowed to kill other players unless within self defence.
- You are neutral. You cannot base with other jobs OR inside of the PD.
        
    ]],
    weapons = {
        "defibrillator_advanced",
        "med_kit_advanced"
    },
    command = "medic",
    max = 6,
    salary = 170,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
})

TEAM_BOOKIE = DarkRP.createJob("Betfred Bookie", {
	color = Color(173, 255, 47), 
    model = "models/player/gman_high.mdl",
    description = [[
Description

Roleplay Guidelines:
- 
        ]],
    weapons = {"weapon_fists"},
    command = "bookie",
    max = 2,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
})

----Criminals----

TEAM_HITMAN = DarkRP.createJob("Hitman", {
    color = Color(255, 0, 0),
    model = "models/player/hitman_absolution_47_classic.mdl",
    description = [[
As a Hitman, you are a hired gun, available to eliminate targets for a price. Whether your clients seek revenge, business competition removal, or have a personal vendetta, you’re the one they call when they need someone taken out. You are not a vigilante; you act only on paid contracts and must always have a valid reason to kill your target. Working in a morally gray area, your services are essential for those who want their problems solved with finality.
        
Roleplay Guidelines:
- You cannot accept a hit on the same player within 15 minutes of completing the previous hit.
- Do not blow up your target with explosives if other people are around. If you kill your target with an explosive and it kills other people in the area, it          will be treated as RDM if reported.
- You cannot under any circumstance take or destroy valuables. You are not a raiding/thief class.of trust.
        ]],
    weapons = {
        "cw_deagle", 
        "weapon_fists"
    },
    command = "hitman",
    max = 2,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Criminals",
    ammo = {
        [".50 AE"] = 7,
    },
})

TEAM_THIEF = DarkRP.createJob("Thief", {
    color = Color(75, 75, 75),
    model = {
        "models/player/suits/robber_open.mdl",
        "models/player/suits/robber_shirt.mdl",
        "models/player/suits/robber_shirt_2.mdl",
        "models/player/suits/robber_tie.mdl",
        "models/player/suits/robber_tuckedtie.mdl"
    },
    description = [[
As a Thief, you rely on quick thinking and a sharp eye to spot opportunities for profit. Whether you're breaking into homes, picking pockets, or raiding businesses, your goal is to accumulate wealth through illegal activities. You’re no stranger to risk, and while your job is dangerous, the rewards can besubstantial. You can work alone or collaborate with other criminals to maximize your earnings, and basing with a gang or crew can help you secure your loot and plan bigger operations.
        
Roleplay Guidelines:
- Thieves can base with only other Thieves.
- You cannot carjack job related vehicles, such as police cars, ambulances, tow trucks, garbage trucks, etc.
- You don't need to /advert on this server. Instead, you are required to use /raid, /counter, /mug or /carjack. Once you have completed your raid, use /raidover.
- The max you can mug someone for is $10,000
- Raid, mug and carjack are all on a 10 minute cooldown each.
- You cannot raid a base with a building sign.
    ]],
    weapons = {"weapon_fists",
               "lockpick",
               "pickpocket",
               "keypad_cracker"
        },
    command = "thief",
    max = 8,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Criminals",
})

TEAM_MAFIA = DarkRP.createJob("Mafia", {
    color = Color(0, 0, 0),
    model = {
		"models/humans/mafia/male_02.mdl", 
		"models/humans/mafia/male_04.mdl", 
		"models/humans/mafia/male_06.mdl", 
		"models/humans/mafia/male_07.mdl", 
		"models/humans/mafia/male_08.mdl", 
		"models/humans/mafia/male_09.mdl"
    },
    description = [[
As a member of the mafia, you are a loyal soldier in the city’s most notorious crime syndicate. You follow the orders of the Godfather, carrying out various illegal activities to ensure the mafia’s power and wealth. Your tasks range from enforcing protection rackets, conducting raids, and assisting in drug smuggling operations. It’s your duty to protect the organisation and eliminate rivals, while avoiding the attention of the police. Stay loyal, work together with your fellow mafia members, and ensure that the mafia remains the most feared group in downtown.
        
Roleplay Guidelines:
-If the Godfather dies during the raid, you must leave the area.
- The Godfather must call /raid, and all members must call /assist.
- You may conduct gang violence (if someone disrespects your gang, give them a warning to stop - then resort to violence).
- The Godfather needs to have at least 1 member before raiding.
- You are only allowed to base with your gang.
    ]],
    weapons = { 
    "weapon_fists"},
    command = "mafia",
    max = 6,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Criminals",
})

TEAM_GODFATHER = DarkRP.createJob("The Godfather", {
    color = Color(54, 69, 79),
    model = "models/vito.mdl",
    description = [[
As the Godfather, you are the undisputed leader of the mafia. You oversee all criminal operations within the city, ensuring that your gang  is the most powerful force in downtown. You command respect from your mafia members, guiding them in their roles and ensuring loyalty. Rival gangs, police, and even the government are obstacles in your path to total dominance. Work strategically, build alliances, and eliminate anyone who threatens your reign.
        
Roleplay Guidelines:
-If the Godfather dies during the raid, you must leave the area.
- The Godfather must call /raid, and all members must call /assist.
- You may conduct gang violence (if someone disrespects your gang, give them a warning to stop - then resort to violence).
- The Godfather needs to have at least 1 member before raiding.
- You are only allowed to base with your gang.

    ]],
    weapons = {
        "lockpick ",
        "unarrest_stick",
        "weapon_fists",
        "csgo_falchion_bluesteel"
    },
    command = "godfather",
    max = 1,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Criminals",
    canDemote = false,
    PlayerDeath = function(ply, weapon, killer)
        ply:teamBan()
        ply:changeTeam(GAMEMODE.DefaultTeam, true)
        DarkRP.notifyAll(0, 4, "The Godfather has died!") 
    end,
})

----Government----

TEAM_POLICE = DarkRP.createJob("Police Officer", {
    color = Color(25, 25, 170),
    model = {
        "models/nz_police/nz_police_hl2_females/nz_police_pm/nz_police_female_01_pm.mdl",
        "models/nz_police/nz_police_hl2_females/nz_police_pm/nz_police_female_02_pm.mdl",
        "models/nz_police/nz_police_hl2_females/nz_police_pm/nz_police_female_03_pm.mdl",
        "models/nz_police/nz_police_hl2_females/nz_police_pm/nz_police_female_04_pm.mdl",
        "models/nz_police/nz_police_hl2_females/nz_police_pm/nz_police_female_05_pm.mdl",
        "models/nz_police/nz_police_hl2_females/nz_police_pm/nz_police_female_06_pm.mdl",
        "models/nz_police/nz_police_hl2_females/nz_police_pm/nz_police_female_07_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_01_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_02_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_03_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_04_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_05_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_06_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_07_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_08_pm.mdl",
        "models/nz_police/nz_police_hl2_males/nz_police_pm/nz_police_male_09_pm.mdl"
    },
    description = [[
Roleplay Guidelines:
- You may only wanted a player (/wanted) if you have witnessed them commit a crime, or are wanting to bring them in for questioning.
- You must follow normal NLR rules when responding to any bank or PD raids.
- If you hear money printers, you may use this information to start an investigation into someone's base, so long as you have permission from the police chief or mayor.
- You may set up a police checkpoint, however it is required that any barriers that are used be left unfrozen and can be broken by a car.
- You are NOT permitted to have a KOS sign at any police checkpoints. If a player pulls a gun on you, however, you may shoot to protect your life.
- You may warrant/wanted someone without having previously known the person's name in RP. This is the only exception to the strict metagaming rules.
- Weapon checks are only to be performed inside the PD or at Police Checkpoints, provided there is a sign outside giving fair warning to players that they will be searched if they enter the PD or pass through the checkpoint.
- The only exception to this rule is if you see a crime being committed, you may weapon check the player prior to arrest.
- You may own a printer as a corrupt cop, however you can be arrested by other police if caught.
- You are not allowed to kill the mayor or other officers while being corrupt under any circumstance.
- You are allowed to make your own base or home outside of the PD.
- Unless someone is actively shooting, you must prioritise arresting players.
- Corruption can only go as far using printers, drugs, leaving PD doors open and bribes.
    ]],
    weapons = {
        "arrest_stick",
        "stunstick",
        "unarrest_stick",
        "weaponchecker",
        "door_ram",
        "cw_fiveseven",
        "weapon_fists",
        "stungun"
    },
    command = "police",
    max = 6,
    salary = 90,
    admin = 0,
    vote = true,
    hasLicense = true,
    category = "Government",
    canDemote = true,
    PlayerSpawn = function(ply)
        ply:SetArmor(25)
        ply:SetMaxArmor(50)
    end,
    ammo = {
        ["5.7x28MM"] = 20,
        ["ammo_stungun"] = 4
    },
})

TEAM_CHIEF = DarkRP.createJob("Police Chief", {
	color = Color(123, 104, 238),
    model = "models/kerry/detective/male_07.mdl",
    description = [[
        The Chief is the leader of the Police force.
        Coordinate the police force to enforce law in the city.
        Hit a player with arrest baton to put them in jail.
        Bash a player with a stunstick and they may learn to obey the law.
        The Battering Ram can break down the door of a criminal, with a warrant for their arrest.
        Type /wanted <name> to alert the public to the presence of a criminal.
        Type /jailpos to set the Jail Position
       
		Roleplay Guidelines:
		- You may only wanted a player (/wanted) if you have witnessed them commit a crime, or are wanting to bring them in for questioning.
		- You must follow normal NLR rules when responding to any bank or PD raids.
		- If you hear money printers, you may use this information to start an investigation into someone's base, so long as you have permission from the police 			chief or mayor.
		- You may set up a police checkpoint, however it is required that any barriers that are used be left unfrozen and can be broken by a car.
		- You are NOT permitted to have a KOS sign at any police checkpoints. If a player pulls a gun on you, however, you may shoot to protect your life.
		- You may warrant/wanted someone without having previously known the person's name in RP. This is the only exception to the strict metagaming rules.
		- Weapon checks are only to be performed inside the PD or at Police Checkpoints, provided there is a sign outside giving fair warning to players that they 			will be searched if they enter the PD or pass through the checkpoint.
		- The only exception to this rule is if you see a crime being committed, you may weapon check the player prior to arrest.
		- You may own a printer as a corrupt cop, however you can be arrested by other police if caught.
		- You are not allowed to kill the mayor or other officers while being corrupt under any circumstance.
		- You are allowed to make your own base or home outside of the PD.
		- Unless someone is actively shooting, you must prioritise arresting players.
		- Corruption can only go as far using printers, drugs, leaving PD doors open and bribes.
        ]],
    weapons = {"arrest_stick", "unarrest_stick", "cw_g4p_mp412_rex", "stunstick", "door_ram", "weaponchecker", "weapon_fists", "stungun"},
    command = "chief",
    max = 1,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = true,
    chief = true,
    NeedToChangeFrom = TEAM_POLICE,
    ammo = {
        [".357 Magnum"] = 6,
        ["ammo_stungun"] = 4
    },
    category = "Government",
    canDemote = true,
    PlayerSpawn = function(ply)
        ply:SetArmor(50)
        ply:SetMaxArmor(75)
    end,
})

TEAM_MAYOR = DarkRP.createJob("Mayor", {
    color = Color(150, 20, 20, 255),
    model = "models/player/donald_trump.mdl",
    description = [[
    The Mayor of the city creates laws to govern the city.
    If you are the mayor you may create and accept warrants.
    Type /wanted <name>  to warrant a player.
    Type /jailpos to set the Jail Position.
    Type /lockdown initiate a lockdown of the city.
    Everyone must be inside during a lockdown.
    The cops patrol the area.
    /unlockdown to end a lockdown
        
    Roleplay Guidelines:    
	All laws you create must be realistic to a degree. You cannot override default laws.
	- Laws for jaywalking are not allowed
	- You are not allowed to have any KOS Laws.
	- You can use any firearm to defend yourself.
	- You cannot prevent cops from accessing the PD.
	- When there is no Mayor, the default DarkRP laws apply, previous laws are void.
	- You cannot make laws that target specific jobs negatively (e.g: Hobos must be in the sewer or get arrested)
        ]],
    weapons = {"weapon_fists",
               "unarrest_stick"
        },
    command = "mayor",
    max = 1,
    salary = 200,
    admin = 0,
    vote = true,
    hasLicense = false,
    mayor = true,
    category = "Government",
})

----VIP JOBS----

TEAM_SWAT = DarkRP.createJob("SWAT", {
	color = Color(100, 149, 237),
    model = {
        "models/player/swat.mdl",
        "models/player/riot.mdl",
        "models/player/gasmask.mdl",
        "models/player/urban.mdl"
    },
    description = [[
 Roleplay Guidelines:
- You may only wanted a player (/wanted) if you have witnessed them commit a crime, or are wanting to bring them in for questioning.
- You must follow normal NLR rules when responding to any bank or PD raids.
- If you hear money printers, you may use this information to start an investigation into someone's base, so long as you have permission from the police chief or mayor.
- You may set up a police checkpoint, however it is required that any barriers that are used be left unfrozen and can be broken by a car.
- You are NOT permitted to have a KOS sign at any police checkpoints. If a player pulls a gun on you, however, you may shoot to protect your life.
- You may warrant/wanted someone without having previously known the person's name in RP. This is the only exception to the strict metagaming rules.
- Weapon checks are only to be performed inside the PD or at Police Checkpoints, provided there is a sign outside giving fair warning to players that they will be searched if they enter the PD or pass through the checkpoint.
- The only exception to this rule is if you see a crime being committed, you may weapon check the player prior to arrest.
- You may own a printer as a corrupt cop, however you can be arrested by other police if caught.
- You are not allowed to kill the mayor or other officers while being corrupt under any circumstance.
- You are allowed to make your own base or home outside of the PD.
- Unless someone is actively shooting, you must prioritise arresting players.
- Corruption can only go as far using printers, drugs, leaving PD doors open and bribes.
    ]],
    weapons = {
        "arrest_stick",
        "stunstick",
        "unarrest_stick",
        "weaponchecker",
        "cw_fiveseven",
        "cw_ar15",
        "weapon_fists",
        "heavy_shield",
        "stungun",
        "cw_flash_grenade",
        "cw_smoke_grenade"
    },
    command = "swat",
    max = 5,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "VIP Jobs",
    canDemote = true,
    customCheck = function(ply) 
    return table.HasValue({"superadmin", "vip", "admin", "owner"}, ply:GetUserGroup()) 
    end,
    CustomCheckFailMsg = "This job is VIP only sorry!",
    PlayerSpawn = function(ply)
        ply:SetArmor(50)
        ply:SetMaxArmor(100)
    end,
    ammo = {
        ["5.7x28MM"] = 20, 
        ["5.56x45MM"] = 30,
        ["ammo_stungun"] = 4
    },
})

TEAM_SWATMEDIC = DarkRP.createJob("SWAT Medic", {
	color = Color(100, 149, 237),
    model = {
        "models/cheddar/cyberpunk/trauma_team/tt_guard.mdl"
    },
    description = [[
Roleplay Guidelines:
- You may only wanted a player (/wanted) if you have witnessed them commit a crime, or are wanting to bring them in for questioning.
- You must follow normal NLR rules when responding to any bank or PD raids.
- If you hear money printers, you may use this information to start an investigation into someone's base, so long as you have permission from the police chief or mayor.
- You may set up a police checkpoint, however it is required that any barriers that are used be left unfrozen and can be broken by a car.
- You are NOT permitted to have a KOS sign at any police checkpoints. If a player pulls a gun on you, however, you may shoot to protect your life.
- You may warrant/wanted someone without having previously known the person's name in RP. This is the only exception to the strict metagaming rules.
- Weapon checks are only to be performed inside the PD or at Police Checkpoints, provided there is a sign outside giving fair warning to players that they will be searched if they enter the PD or pass through the checkpoint.
- The only exception to this rule is if you see a crime being committed, you may weapon check the player prior to arrest.
- You may own a printer as a corrupt cop, however you can be arrested by other police if caught.
- You are not allowed to kill the mayor or other officers while being corrupt under any circumstance.
- You are allowed to make your own base or home outside of the PD.
- Unless someone is actively shooting, you must prioritise arresting players.
- Corruption can only go as far using printers, drugs, leaving PD doors open and bribes.
    ]],
    weapons = {
        "arrest_stick",
        "stunstick",
        "unarrest_stick",
        "weaponchecker",
        "med_kit_advanced",
        "cw_fiveseven",
        "cw_m3super90",
        "weapon_fists",
        "stungun",
        "riot_shield",
        "cw_flash_grenade"
    },
    command = "swatmedic",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "VIP Jobs",
    canDemote = true,
    customCheck = function(ply) 
    return table.HasValue({"superadmin", "vip", "admin", "owner"}, ply:GetUserGroup()) 
    end,
    CustomCheckFailMsg = "This job is VIP only sorry!",
    PlayerSpawn = function(ply)
        ply:SetArmor(50)
        ply:SetMaxArmor(100)
    end,
    ammo = {
        ["5.7x28MM"] = 20, 
        ["12 Gauge"] = 8,
        ["ammo_stungun"] = 4
    },
})

TEAM_BMD = DarkRP.createJob("Black Market Dealer", {
	color = Color(255, 215, 0), 
    model = {
        "models/watch_dogs/characters/mgs5_big_boss_trenchcoat_eyepatch.mdl",
        "models/watch_dogs/characters/mgs5_big_boss_trenchcoat.mdl"
    },
    description = [[
As a Black Market Dealer, you thrive in the shadows, dealing in illegal and highly sought-after goods that the average gun dealer cannot provide. From high-powered weaponry to forbidden contraband, you supply the underground with everything they need to get ahead in the criminal world. Be cautious—law enforcement will always be on your tail, and the risk of capture is high. Discretion and smart alliances are key to survival. 
        
Roleplay Guidelines:
- It is illegal to operate a black market, so if you are discovered to have a shop and selling illegal arms the law can and will put a search warrant.
- You may not setup shop with another gun dealer or another black market dealer 
- You may have up to 4 security guards in your shop
        
    ]],
    weapons = {"weapon_fists"},
    command = "blackmarket",
    max = 2,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "VIP Jobs",
    customCheck = function(ply) 
    return table.HasValue({"superadmin", "vip", "admin", "owner"}, ply:GetUserGroup()) 
    end,
    CustomCheckFailMsg = "This job is VIP only sorry!",
})

TEAM_TRACEUR = DarkRP.createJob("Traceur", {
	color = Color(128, 128, 0),
    model = {
        "models/player/faith.mdl"
    },
    description = [[
As a Traceur, you are a master of parkour, using speed, agility, and urban acrobatics to navigate downtown with ease. Whether you're fleeing from police, evading criminals, or simply showing off your skills, you move swiftly across rooftops and through alleys. While not inherently tied to criminal activity, your agility can give you an edge in dangerous situations.
        
Roleplay Guidelines:
- You are not allowed to climb into peoples bases and take their stuff
- You are not allowed to raid or mug
- Do not abuse the climb swep in any way.
    ]],
    weapons = {"weapon_fists",
               "climb_swep2",
               "lockpick",
               "pickpocket",
               "keypad_cracker"
        },
    command = "traceur",
    max = 3,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "VIP Jobs",
    customCheck = function(ply) 
    return table.HasValue({"superadmin", "vip", "admin", "owner"}, ply:GetUserGroup()) 
    end,
    CustomCheckFailMsg = "This job is VIP only sorry!",
})

TEAM_DJ = DarkRP.createJob("DJ", {
	color = Color(255, 0, 255), 
    model = {
        "models/player/yonderplayermodel/yonder_playermodel.mdl"
    },
    description = [[
Play some fucking sick tunes cunt 
        
Roleplay Guidelines:
- If you are asked by Staff to change your music you are required to do so.
    ]],
    weapons = {"weapon_fists", "retro_boombox_base"},
    command = "dj",
    max = 3,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "VIP Jobs",
    customCheck = function(ply) 
    return table.HasValue({"superadmin", "vip", "admin", "owner"}, ply:GetUserGroup()) 
    end,
    CustomCheckFailMsg = "This job is VIP only sorry!",
})
--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN
--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
    [TEAM_POLICE] = true,
    [TEAM_CHIEF] = true,
    [TEAM_MAYOR] = true,
    [TEAM_SWAT] = true
}
--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_HITMAN)
