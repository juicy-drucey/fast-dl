if SERVER then
	slib.setLang("gprotect", "de", "colliding-too-much", "%s's Entities kollidieren zu sehr!")
	slib.setLang("gprotect", "de", "too-many-obstructs", "%s's Entity blockiert zu viele schlechte Entities!")
	slib.setLang("gprotect", "de", "blacklisted-multiple", "Du hast %s Modelle erfolgreich zu den blockieren Modellen hinzugefügt!")
	slib.setLang("gprotect", "de", "unblacklisted-multiple", "Du hast %s Modelle erfolgreich von den blockierten Modellen entfernt!")
	slib.setLang("gprotect", "de", "blacklisted-multiple-ent", "Du hast %s Entities erfolgreich zur Blacklist hinzugefügt!")
	slib.setLang("gprotect", "de", "unblacklisted-multiple-ent", "Du hast %s Entities erfolgreich von der Blacklist entfernt!")
	slib.setLang("gprotect", "de", "added-blacklist", "Du hast %s erfolgreich zu den blockieren Modellen hinzugefügt!")
	slib.setLang("gprotect", "de", "removed-blacklist", "Du hast %s erfolgreich von den blockierten Modellen entfernt")
	slib.setLang("gprotect", "de", "added-blacklist-ent", "Du hast %s erfolgreich zur Entity-Blacklist hinzugefügt!")
	slib.setLang("gprotect", "de", "removed-blacklist-ent", "Du hast %s erfolgreich von der Entity-Blacklist entfernt!")
	slib.setLang("gprotect", "de", "attempted-unfreeze-all", "%s hat versucht, alles nach dem Spawn einer Duplikation zu entfrieren!")
	slib.setLang("gprotect", "de", "attempted-upscaled-ent", "%s hat versucht, ein hochskaliertes Entity mit Adv Dupe 2 zu spawnen!")
	slib.setLang("gprotect", "de", "attempted-rope-spawning", "%s hat versucht, Seile mit Adv Dupe 2 zu spawnen!")
	slib.setLang("gprotect", "de", "attempted-no-gravity", "%s hat versucht, Entities ohne Schwerkraft mit Adv Dupe 2 zu spawnen!")

	slib.setLang("gprotect", "de", "model-restricted", "Die Nutzung dieses Modells wurde beschränkt!")
	slib.setLang("gprotect", "de", "classname-restricted", "Die Nutzung dieser Entity-Klasse wurde beschränkt!")
	slib.setLang("gprotect", "de", "attempted-blackout", "%s hat versucht, den Blackout-Exploit zu nutzen!")
	slib.setLang("gprotect", "de", "spam-spawning", "%s versucht, Entities/Props zu spammen.")

	slib.setLang("gprotect", "de", "too-complex-model", "Dieses Modell wurde eingeschränkt, es ist zu komplex!")
	slib.setLang("gprotect", "de", "too-big-prop", "Dein Prop ist zu groß, desshalb haben wir es entfernt!")
	slib.setLang("gprotect", "de", "successfull-fpp-blockedmodels", "Du hast die blockierten Modelle erfolgreich von FPP nach gProtect übertragen!")
	slib.setLang("gprotect", "de", "successfull-fpp-grouptools", "Du hast die Gruppentools erfolgreich von FPP nach gProtect übertragen!")
	slib.setLang("gprotect", "de", "unsuccessfull-transfer", "Es scheint so als gäbe es ein Problem mit der Datenübertragung! (MySQL wird nicht unterstützt)")

	slib.setLang("gprotect", "de", "you-ghosted-props", "Du hast %s's Props geghostet")
	slib.setLang("gprotect", "de", "you-frozen-props", "Du hast %s's Props eingefroren!")
	slib.setLang("gprotect", "de", "you-removed-props", "Du hast %s's Props entfernt!")

	slib.setLang("gprotect", "de", "props-ghosted", "Deine Props wurden geghostet!")
	slib.setLang("gprotect", "de", "props-frozen", "Deine Props wurden eingefroren!")
	slib.setLang("gprotect", "de", "props-removed", "Deine Props wurden entfernt!")

	slib.setLang("gprotect", "de", "everyones-props-ghosted", "Jemand hat alle Props gehostet!")
	slib.setLang("gprotect", "de", "everyones-props-frozen", "Jemand hat alle Props eingefroren")
	slib.setLang("gprotect", "de", "disconnected-ents-removed", "Du hast alle Entities von getrennten Spielern etnfernt!")

	slib.setLang("gprotect", "de", "insufficient-permission", "Du hast nicht die Berechtigung, dies zu tun!")
	slib.setLang("gprotect", "de", "spawn-to-close", "Dein Prop kann nicht in jemanden gespawnt werden!")
	slib.setLang("gprotect", "de", "entity-ghosted", "Dein Entitiy wurde gehostet!")
elseif CLIENT then
	slib.setLang("gprotect", "de", "title", "gProtect - Einstellungen")
	slib.setLang("gprotect", "de", "buddies-title", "gProtect - Freunde")

	slib.setLang("gprotect", "de", "world", "Welt")
	slib.setLang("gprotect", "de", "disconnected", "Getrennt")
	slib.setLang("gprotect", "de", "toolgun-name", "Blacklist Props")
	slib.setLang("gprotect", "de", "toolgun-desc", "Verwalte blockierte Modelle")
	slib.setLang("gprotect", "de", "toolgun-leftclick", "Füge zu blockierten Modellen hinzu")
	slib.setLang("gprotect", "de", "toolgun-rightclick", "Entferne von blockieren Modellen")
	slib.setLang("gprotect", "de", "toolgun-help", "Schieße auf ein Prop mit dem Werkzeug")
	slib.setLang("gprotect", "de", "remove-on-blacklist", "Entferne prop auf der Blacklist")
	slib.setLang("gprotect", "de", "player-list", "Spielerliste")

	slib.setLang("gprotect", "de", "toolgun", "Toolgun")
	slib.setLang("gprotect", "de", "physgun", "Physgun")
	slib.setLang("gprotect", "de", "gravity-gun", "Gravity Gun")
	slib.setLang("gprotect", "de", "canproperty", "Kann-Eigenschaft")

	slib.setLang("gprotect", "de", "add-blocked-models", "Füge zu blockierten Modellen hinzu")
	slib.setLang("gprotect", "de", "remove-blocked-models", "Entferne von blockierten Modellen")

	slib.setLang("gprotect", "de", "add-blacklisted-ents", "Füge zur Entity-Blacklist hinzu")
	slib.setLang("gprotect", "de", "remove-blacklisted-ents", "Entferne von Entity-Blacklist")
	slib.setLang("gprotect", "de", "copy-clipboard", "In Zwischenablage kopieren")

	slib.setLang("gprotect", "de", "general", "Allgemeines")
	slib.setLang("gprotect", "de", "ghosting", "Ghosting")
	slib.setLang("gprotect", "de", "damage", "Schaden")
	slib.setLang("gprotect", "de", "anticollide", "Anti Kollision")
	slib.setLang("gprotect", "de", "spamprotection", "Spam Schutz")
	slib.setLang("gprotect", "de", "spawnrestriction", "Spawn Beschränkung")
	slib.setLang("gprotect", "de", "toolgunsettings", "Toolgun Einstellungen")
	slib.setLang("gprotect", "de", "physgunsettings", "Physgun Einstellungen")
	slib.setLang("gprotect", "de", "gravitygunsettings", "Gravgun Einstellungen")
	slib.setLang("gprotect", "de", "canpropertysettings", "Kann-Eigenschaft Einstellungen")
	slib.setLang("gprotect", "de", "advdupe2", "Adv Dupe 2")
	slib.setLang("gprotect", "de", "miscs", "Sonstiges")

	slib.setLang("gprotect", "de", "ghost-props", "Props ghosten")
	slib.setLang("gprotect", "de", "remove-props", "Props entfernen")
	slib.setLang("gprotect", "de", "freeze-props", "Props einfrieren")
	slib.setLang("gprotect", "de", "highlight-ents", "Markiere Entities")
	slib.setLang("gprotect", "de", "unhighlight-ents", "Demarkiere Entities")

	slib.setLang("gprotect", "de", "ghost-everyones-props", "Ghoste alle Props")
	slib.setLang("gprotect", "de", "freeze-everyones-props", "Friere alle Props ein")
	slib.setLang("gprotect", "de", "remove-disconnected-props", "Entferne Props von getrennten Spielern")

	slib.setLang("gprotect", "de", "general_remDiscPlyEnt", "Entferne Entities von getrennten Spielern")
	slib.setLang("gprotect", "de", "general_remDiscPlyEnt_tooltip", "Dies entfernt Entities von getrennten Spielern (deaktiviert falls -1.)")
	slib.setLang("gprotect", "de", "general_blacklist", "Blacklist")
	slib.setLang("gprotect", "de", "general_blacklist_tooltip", "Hier werden Klassennamen hinzugefügt, welche von allen Modulen beschützt werden.")
	slib.setLang("gprotect", "de", "general_protectedFrozenEnts", "Geschützte eingefrorene Entities")
	slib.setLang("gprotect", "de", "general_protectedFrozenEnts_tooltip", "Dies ist eine Liste von Entities, die im eingefrorenen Zustand geschützt werden.")
	slib.setLang("gprotect", "de", "general_protectedFrozenGroup", "Geschützte eingefrorene Gruppe")
	slib.setLang("gprotect", "de", "general_protectedFrozenGroup_tooltip", "Diese Kollisionsgruppe wird eingefrorenen Entities zugewiesen.")

	slib.setLang("gprotect", "de", "ghosting_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "ghosting_enabled_tooltip", "Aktiviere das Ghosting-Modul?")
	slib.setLang("gprotect", "de", "ghosting_ghostColor", "Ghosting Farbe")
	slib.setLang("gprotect", "de", "ghosting_ghostColor_tooltip", "Wähle eine Farbe für geghostete Entities")
	slib.setLang("gprotect", "de", "ghosting_antiObscuring", "Anti-Obscuring")
	slib.setLang("gprotect", "de", "ghosting_antiObscuring_tooltip", "Dies verhindert, dass Props entfroren werden, während sie in anderen Objekten stecken. Füg einfach Entities ein, welche nicht verdeckt werden sollen!")
	slib.setLang("gprotect", "de", "ghosting_onPhysgun", "Ghost bei Physgun?")
	slib.setLang("gprotect", "de", "ghosting_onPhysgun_tooltip", "Dies ghostet Entities, welche von der Physgun gehalten werden.")
	slib.setLang("gprotect", "de", "ghosting_useBlacklist", "Verwende Blacklist")
	slib.setLang("gprotect", "de", "ghosting_useBlacklist_tooltip", "Diese Option ghostet Gegenstände auf der Blacklist, falls das Modul aktiv ist.")
	slib.setLang("gprotect", "de", "ghosting_entities", "Entities")
	slib.setLang("gprotect", "de", "ghosting_entities_tooltip", "Klassennamen in dieser Liste werden geghostet. Dies verändert nicht die Blacklist von anderen Modulen.")

	slib.setLang("gprotect", "de", "damage_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "damage_enabled_tooltip", "Aktiviere das Schadens-Modul?")
	slib.setLang("gprotect", "de", "damage_useBlacklist", "Verwende Blacklist")
	slib.setLang("gprotect", "de", "damage_useBlacklist_tooltip", "Diese Option betrachtet die allgemeine Blacklist als eine Entity Blacklist in diesem Modul!")
	slib.setLang("gprotect", "de", "damage_entities", "Entitiy Blacklist")
	slib.setLang("gprotect", "de", "damage_entities_tooltip", "Klassennamen in dieser Liste werden keinen Schaden zufügen, wenn Deaktiviere Schaden aktiv ist, dies modifiziert nicht die Blacklist, die durch andere Module verwendet wird.")
	slib.setLang("gprotect", "de", "damage_blacklistedEntPlayerDamage", "Deaktiviere Schaden von Entities auf der Blacklist")
	slib.setLang("gprotect", "de", "damage_blacklistedEntPlayerDamage_tooltip", "Wenn dies aktiviert ist, dann bekommen Spieler keinen Schaden von Entities, welche auf der Blacklist stehen.")
	slib.setLang("gprotect", "de", "damage_vehiclePlayerDamage", "Deaktiviere Fahrzeugschaden")
	slib.setLang("gprotect", "de", "damage_vehiclePlayerDamage_tooltip", "Wenn dies aktiviert ist, dann bekommen Spieler keinen Schaden von Fahrzeugen.")
	slib.setLang("gprotect", "de", "damage_worldPlayerDamage", "Deaktivierte Weltschaden")
	slib.setLang("gprotect", "de", "damage_worldPlayerDamage_tooltip", "Wenn dies aktiviert ist, dann bekommen Spieler keinen Schaden von Entities, die auf der Blacklist stehen.")
	slib.setLang("gprotect", "de", "damage_immortalEntities", "Unsterbliche Entities")
	slib.setLang("gprotect", "de", "damage_immortalEntities_tooltip", "Klassennamen in dieser Liste werden keinen Schaden nehmen, es sei denn, der Spieler ist in einer Ausnahmegruppe!")
	slib.setLang("gprotect", "de", "damage_bypassGroups", "Ausnahme Gruppen")
	slib.setLang("gprotect", "de", "damage_bypassGroups_tooltip", "Füge Gruppen in dieser Liste hinzu, welche die Schadensbeschränkung umgehen. '*' heißt alle!")
	slib.setLang("gprotect", "de", "damage_canDamageWorldEntities", "Kann Welt-Entities schaden")
	slib.setLang("gprotect", "de", "damage_canDamageWorldEntities_tooltip", "Gruppen in dieser Liste können Welt-Entities Schaden zufügen. '*' heißt alle!")

	slib.setLang("gprotect", "de", "anticollide_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "anticollide_enabled_tooltip", "Aktiviere das Anti-Kollisions Modul?")
	slib.setLang("gprotect", "de", "anticollide_notifyStaff", "Benachrichtige Teammitglieder")
	slib.setLang("gprotect", "de", "anticollide_notifyStaff_tooltip", "Sollen Erkennungen Teammitglieder benachrichtigen? NB: Dies kann verwendet werden, um Teammitglieder zu nerven.")
	slib.setLang("gprotect", "de", "anticollide_protectDarkRPEntities", "Schütze DarkRP Entities")
	slib.setLang("gprotect", "de", "anticollide_protectDarkRPEntities_tooltip", "Sollen wir DarkRP-Entities schützen? (0 = Deaktiviert, 1 = Ghost, 2 = Einfrieren, 3 = Entfernen, 4 = Entfernen & Erstattung)")
	slib.setLang("gprotect", "de", "anticollide_DRPentitiesThreshold", "DRP Entities Schwelle")
	slib.setLang("gprotect", "de", "anticollide_DRPentitiesThreshold_tooltip", "Wie viele Kollisionen kann ein DRP Entity innerhalb einer Sekunde haben, bevor das System ausgelöst wird?")
	slib.setLang("gprotect", "de", "anticollide_DRPentitiesException", "DRP Entities Ausnahme")
	slib.setLang("gprotect", "de", "anticollide_DRPentitiesException_tooltip", "Welche Kollisionen sollen wir ignorieren? (0 = Keine, 1 = Unterschiedliche Besitzer, 2 = Kein Besitzer)")
	slib.setLang("gprotect", "de", "anticollide_protectSpawnedEntities", "Schütze gespawnte Entities")
	slib.setLang("gprotect", "de", "anticollide_protectSpawnedEntities_tooltip", "Sollen wir gespawnte Entities schützen? (0 = Deaktiviert, 1 = Ghost, 2 = Einfrieren, 3 = Entfernen")
	slib.setLang("gprotect", "de", "anticollide_entitiesThreshold", "Gespawnte Entities Schwelle")
	slib.setLang("gprotect", "de", "anticollide_entitiesThreshold_tooltip", "Wie viele Kollisionen kann ein Entity innerhalb einer Sekunde haben, bevor das System ausgelöst wird?")
	slib.setLang("gprotect", "de", "anticollide_entitiesException", "Gespawnte Entities Ausnahme")
	slib.setLang("gprotect", "de", "anticollide_entitiesException_tooltip", "Welche Kollisionen sollen wir ignorieren? (0 = Keine, 1 = Unterschiedliche Besitzer, 2 = Kein Besitzer)")
	slib.setLang("gprotect", "de", "anticollide_protectSpawnedProps", "Schütze gespawnte Props")
	slib.setLang("gprotect", "de", "anticollide_protectSpawnedProps_tooltip", "Sollen wir gespawnte Props schützen? (0 = Deaktiviert, 1 = Ghost, 2 = Einfrieren, 3 = Entfernen")
	slib.setLang("gprotect", "de", "anticollide_propsThreshold", "Gespawnte Props Schwelle")
	slib.setLang("gprotect", "de", "anticollide_propsThreshold_tooltip", "Wie viele Kollisionen kann ein Prop innerhalb einer Sekunde haben, bevor das System ausgelöst wird?")
	slib.setLang("gprotect", "de", "anticollide_propsException", "Gespawnte Props Ausnahme")
	slib.setLang("gprotect", "de", "anticollide_propsException_tooltip", "Welche Kollisionen sollen wir ignorieren? (0 = Keine, 1 = Unterschiedliche Besitzer, 2 = Kein Besitzer)")
	slib.setLang("gprotect", "de", "anticollide_useBlacklist", "Verwende Blacklist")
	slib.setLang("gprotect", "de", "anticollide_useBlacklist_tooltip", "Entities auf der Blacklist werden geghostet falls diese zu sehr kollidieren und dies aktiviert ist.")
	slib.setLang("gprotect", "de", "anticollide_ghostEntities", "Entities")
	slib.setLang("gprotect", "de", "anticollide_ghostEntities_tooltip", "Klassennamen in dieser Liste werden geghostet, falls diese zu sehr kollidieren.")

	slib.setLang("gprotect", "de", "spamprotection_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "spamprotection_enabled_tooltip", "Aktiviere das Spamschutz Modul?")
	slib.setLang("gprotect", "de", "spamprotection_threshold", "Schwelle")
	slib.setLang("gprotect", "de", "spamprotection_threshold_tooltip", "Wenn du so viele Props gleichzeitig spawnst, dann greift das System ein, es sei denn, die unten definierte Verzögerung ist abgelaufen.")
	slib.setLang("gprotect", "de", "spamprotection_delay", "Verzögerung")
	slib.setLang("gprotect", "de", "spamprotection_delay_tooltip", "Dieser Timer löscht die obere Schwelle.")
	slib.setLang("gprotect", "de", "spamprotection_action", "Bestrafung")
	slib.setLang("gprotect", "de", "spamprotection_action_tooltip", "Dies entscheidet, wie mit Spammern umgegangen werden soll! (1 = Verweigere Spawn, 2 = Entity/Prop ghosten)")
	slib.setLang("gprotect", "de", "spamprotection_notifyStaff", "Benachrichtige Teammitglieder")
	slib.setLang("gprotect", "de", "spamprotection_notifyStaff_tooltip", "Sollen Erkennungen Teammitglieder benachrichtigen? NB: Dies kann verwendet werden, um Teammitglieder zu nerven.")
	slib.setLang("gprotect", "de", "spamprotection_protectProps", "Schütze Props")
	slib.setLang("gprotect", "de", "spamprotection_protectProps_tooltip", "Dies schützt Props vor Spam.")
	slib.setLang("gprotect", "de", "spamprotection_protectEntities", "Schütze Entities")
	slib.setLang("gprotect", "de", "spamprotection_protectEntities_tooltip", "Dies schützt Entities vor Spam")

	slib.setLang("gprotect", "de", "spawnrestriction_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "spawnrestriction_enabled_tooltip", "Aktiviere das Spawn-EinschränkungsModul?")
	slib.setLang("gprotect", "de", "spawnrestriction_propSpawnPermission", "Prop Spawnberechtigungen")
	slib.setLang("gprotect", "de", "spawnrestriction_propSpawnPermission_tooltip", "Dies schränkt das Spawnen von Props vollständig ein! (Füge Nutzergruppen hier hinzu, um diese zu erlauben, * bedeutet alle!)")
	slib.setLang("gprotect", "de", "spawnrestriction_SENTSpawnPermission", "SENT Spawnberechtigungen")
	slib.setLang("gprotect", "de", "spawnrestriction_SENTSpawnPermission_tooltip", "Dies schränkt das Spawnen von SENTs vollständig ein! (Füge Nutzergruppen hier hinzu, um diese zu erlauben, * bedeutet alle!)")
	slib.setLang("gprotect", "de", "spawnrestriction_SWEPSpawnPermission", "SWEP Spawnberechtigungen")
	slib.setLang("gprotect", "de", "spawnrestriction_SWEPSpawnPermission_tooltip", "Dies schränkt das Spawnen von SWEPs vollständig ein! (Füge Nutzergruppen hier hinzu, um diese zu erlauben, * bedeutet alle!)")
	slib.setLang("gprotect", "de", "spawnrestriction_vehicleSpawnPermission", "Fahrzeug Spawnberechtigungen")
	slib.setLang("gprotect", "de", "spawnrestriction_vehicleSpawnPermission_tooltip", "Dies schränkt das Spawnen von Fahrzeugen vollständig ein! (Füge Nutzergruppen hier hinzu, um diese zu erlauben, * bedeutet alle!)")
	slib.setLang("gprotect", "de", "spawnrestriction_NPCSpawnPermission", "NPC Spawnberechtigungen")
	slib.setLang("gprotect", "de", "spawnrestriction_NPCSpawnPermission_tooltip", "Dies schränkt das Spawnen von NPCs vollständig ein! (Füge Nutzergruppen hier hinzu, um diese zu erlauben, * bedeutet alle!)")
	slib.setLang("gprotect", "de", "spawnrestriction_ragdollSpawnPermission", "Ragdoll Spawnberechtigungen")
	slib.setLang("gprotect", "de", "spawnrestriction_ragdollSpawnPermission_tooltip", "Dies schränkt das Spawnen von Ragdolls vollständig ein! (Füge Nutzergruppen hier hinzu, um diese zu erlauben, * bedeutet alle!)")
	slib.setLang("gprotect", "de", "spawnrestriction_effectSpawnPermission", "Effekte Spawnberechtigungen")
	slib.setLang("gprotect", "de", "spawnrestriction_effectSpawnPermission_tooltip", "Dies schränkt das Spawnen von Effekten vollständig ein! (Füge Nutzergruppen hier hinzu, um diese zu erlauben, * bedeutet alle!)")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedEntities", "Blockierte SENTs")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedEntities_tooltip", "Platziere hier Klassennamen von Entities, welche nie gespawnt werden sollen!")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedEntitiesIsBlacklist", "Blockierte Klassen sind Blacklist")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedEntitiesIsBlacklist_tooltip", "Falls aktiviert, dann werden Klassen in der Liste blockiert, ansonsten kannst du nur diese Klassen spawnen.")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedModels", "Blockierte Modelle")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedModels_tooltip", "Platziere Modellnamen, damit Props mit diesem Modellnamen nicht spawnen!")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedModelsisBlacklist", "Blockierte Modelle sind Blacklist")
	slib.setLang("gprotect", "de", "spawnrestriction_blockedModelsisBlacklist_tooltip", "Falls aktiviert, dann werden Modelle in dieser Liste blockiert, ansonsten kannst du nur diese Modelle spawnen.")
	slib.setLang("gprotect", "de", "spawnrestriction_bypassGroups", "Ausnahme Gruppen")
	slib.setLang("gprotect", "de", "spawnrestriction_bypassGroups_tooltip", "Diese Gruppen können blockierte SENTs und Modelle umgehen.")
	slib.setLang("gprotect", "de", "spawnrestriction_maxModelSize", "Maximale Modellgröße")
	slib.setLang("gprotect", "de", "spawnrestriction_maxModelSize_tooltip", "Falls dies größer 0 ist, entfernt es größere Props direkt nach dem Spawn.")

	slib.setLang("gprotect", "de", "toolgunsettings_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "toolgunsettings_enabled_tooltip", "Aktiviere das Werkzeug-Einstellungsmodul?")
	slib.setLang("gprotect", "de", "toolgunsettings_targetWorld", "Kann Weltentities anvisieren")
	slib.setLang("gprotect", "de", "toolgunsettings_targetWorld_tooltip", "Dies bedeutet, dass sie Weltentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "toolgunsettings_targetPlayerOwned", "Kann Spielerentities anvisieren")
	slib.setLang("gprotect", "de", "toolgunsettings_targetPlayerOwned_tooltip", "Dies bedeutet, dass sie Spielerentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "toolgunsettings_restrictTools", "Eingeschränkte Werkzeuge")
	slib.setLang("gprotect", "de", "toolgunsettings_restrictTools_tooltip", "Die Werkzeuge hier können von niemanden außer den Ausnahmegruppen benutzt werden.")
	slib.setLang("gprotect", "de", "toolgunsettings_groupToolRestrictions", "Gruppen Werkzeugeinschränkungen")
	slib.setLang("gprotect", "de", "toolgunsettings_groupToolRestrictions_tooltip", "Konfiguriere Werkzeugbeschränkungen nach Werkzeug")
	slib.setLang("gprotect", "de", "toolgunsettings_entityTargetability", "Entity Anvisierbarkeit")
	slib.setLang("gprotect", "de", "toolgunsettings_entityTargetability_tooltip", "Dies ist nützlich, wenn z.B Spieler die Toolgun nur auf ihre eigenen Props anwenden können!")
	slib.setLang("gprotect", "de", "toolgunsettings_bypassGroups", "Ausnahme Gruppen")
	slib.setLang("gprotect", "de", "toolgunsettings_bypassGroups_tooltip", "Gruppen in dieser Liste umgehen die Wekzeugbeschränkungsliste von oben!")

	slib.setLang("gprotect", "de", "physgunsettings_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "physgunsettings_enabled_tooltip", "Aktiviere das Physgun Einstellungsmodul?")
	slib.setLang("gprotect", "de", "physgunsettings_targetWorld", "Kann Welt-Entities anvisieren")
	slib.setLang("gprotect", "de", "physgunsettings_targetWorld_tooltip", "Dies bedeutet, dass sie Weltentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "physgunsettings_targetPlayerOwned", "Kann Spielerentities anvisieren")
	slib.setLang("gprotect", "de", "physgunsettings_targetPlayerOwned_tooltip", "Dies bedeutet, dass sie Spielerentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "physgunsettings_DisableReloadUnfreeze", "Deaktiviere Nachladen-Entfrieren")
	slib.setLang("gprotect", "de", "physgunsettings_DisableReloadUnfreeze_tooltip", "Dies verhindert, dass Personen Props mit Nachladen entfrieren.")
	slib.setLang("gprotect", "de", "physgunsettings_PickupVehiclePermission", "Fahrzeug aufheben Berechtigung")
	slib.setLang("gprotect", "de", "physgunsettings_PickupVehiclePermission_tooltip", "Personen in diesen Gruppen können Fahrzeuge aufheben!")
	slib.setLang("gprotect", "de", "physgunsettings_StopMotionOnDrop", "Stoppe Bewegung beim Fallenlassen")
	slib.setLang("gprotect", "de", "physgunsettings_StopMotionOnDrop_tooltip", "Dies verhindert Proppushing/Propkilling.")
	slib.setLang("gprotect", "de", "physgunsettings_blockMultiplePhysgunning", "Blockiere mehrfaches Physgunnen")
	slib.setLang("gprotect", "de", "physgunsettings_blockMultiplePhysgunning_tooltip", "Dies verhindert, dass jemand ein Entity physgunnt, welches bereits gephysgunnt wird!")
	slib.setLang("gprotect", "de", "physgunsettings_maxDropObstructs", "Maximale Blockierschwelle")
	slib.setLang("gprotect", "de", "physgunsettings_maxDropObstructs_tooltip", "Dies ist die Schwelle von wie vielen Blockierungen von Entities, welche auf der Blacklist stehen, bis das System ausgelöst wird!")
	slib.setLang("gprotect", "de", "physgunsettings_maxDropObstructsAction", "Maximale Blockierschwelle Auslösaktion")
	slib.setLang("gprotect", "de", "physgunsettings_maxDropObstructsAction_tooltip", "Dies ist wie wir mit Auslösungen umgehen (1 = Ghost, 2 = Einfrieren, 3 = Entfernen)")
	slib.setLang("gprotect", "de", "physgunsettings_blockedEntities", "Blockierte Entities")
	slib.setLang("gprotect", "de", "physgunsettings_blockedEntities_tooltip", "Füge hier Entities hinzu und sie werden von niemanden, der nicht in einer Ausnahmegruppe ist, gephysgunnt werden können.")
	slib.setLang("gprotect", "de", "physgunsettings_bypassGroups", "Ausnahme Gruppen")
	slib.setLang("gprotect", "de", "physgunsettings_bypassGroups_tooltip", "Füge Nutzergruppen in dieser Liste hinzu, damit diese die blockierten Entities umgehen, '*' bedeutet alle!")

	slib.setLang("gprotect", "de", "gravitygunsettings_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "gravitygunsettings_enabled_tooltip", "Aktiviere das Gravity Gun Einstellungsmodul?")
	slib.setLang("gprotect", "de", "gravitygunsettings_targetWorld", "Kann Welt-Entities anvisieren")
	slib.setLang("gprotect", "de", "gravitygunsettings_targetWorld_tooltip", "Dies bedeutet, dass sie Weltentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "gravitygunsettings_targetPlayerOwned", "Kann Spielerentities anvisieren")
	slib.setLang("gprotect", "de", "gravitygunsettings_targetPlayerOwned_tooltip", "Dies bedeutet, dass sie Spielerentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "gravitygunsettings_DisableGravityGunPunting", "Deaktiviere Gravity Gun Werfen")
	slib.setLang("gprotect", "de", "gravitygunsettings_DisableGravityGunPunting_tooltip", "Dies ist die Wurfattacke der Gravity Gun.")
	slib.setLang("gprotect", "de", "gravitygunsettings_blockedEntities", "Blockierte Entities")
	slib.setLang("gprotect", "de", "gravitygunsettings_blockedEntities_tooltip", "Füge hier Entities hinzu und sie werden von niemanden, der nicht in einer Ausnahmegruppe ist, gephysgunnt werden können.")
	slib.setLang("gprotect", "de", "gravitygunsettings_bypassGroups", "Ausnahme Gruppen")
	slib.setLang("gprotect", "de", "gravitygunsettings_bypassGroups_tooltip", "Füge Nutzergruppen in dieser Liste hinzu, damit diese die blockierten Entities umgehen, '*' bedeutet alle!")

	slib.setLang("gprotect", "de", "canpropertysettings_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "canpropertysettings_enabled_tooltip", "Aktiviere das Kann-Eigenschaft Einstellungsmodul?")
	slib.setLang("gprotect", "de", "canpropertysettings_targetWorld", "Kann Welt-Entities anvisieren")
	slib.setLang("gprotect", "de", "canpropertysettings_targetWorld_tooltip", "Dies bedeutet, dass sie Weltentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "canpropertysettings_targetPlayerOwned", "Kann Spielerentities anvisieren")
	slib.setLang("gprotect", "de", "canpropertysettings_targetPlayerOwned_tooltip", "Dies bedeutet, dass sie Spielerentities und -props anvisieren können! (Füge Nutzergruppen hier hinzu, um diese zu erlauben. * bedeutet alle!)")
	slib.setLang("gprotect", "de", "canpropertysettings_blockedProperties", "Blockierte Eigenschaften")
	slib.setLang("gprotect", "de", "canpropertysettings_blockedProperties_tooltip", "Füge Eigenschaften zu dieser Liste hinzu")
	slib.setLang("gprotect", "de", "canpropertysettings_blockedPropertiesisBlacklist", "Blockierte Eigenschaften sind Blacklist")
	slib.setLang("gprotect", "de", "canpropertysettings_blockedPropertiesisBlacklist_tooltip", "Falls aktiviert, dann werden Eigenschaften in der Liste blockiert, ansonsten kannst du nur diese Eigenschaften nutzen.")
	slib.setLang("gprotect", "de", "canpropertysettings_blockedEntities", "Blockierte Entities")
	slib.setLang("gprotect", "de", "canpropertysettings_blockedEntities_tooltip", "Füge hier Entities hinzu, damit sie von niemanden mehr anvisiert können, außer von den Leuten in der Ausnahme Gruppe!")
	slib.setLang("gprotect", "de", "canpropertysettings_bypassGroups", "Ausnahme Gruppen")
	slib.setLang("gprotect", "de", "canpropertysettings_bypassGroups_tooltip", "Gruppen in dieser Liste umgehen die Kann-Eigenschaft Beschränkungsliste von oben!")

	slib.setLang("gprotect", "de", "advdupe2_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "advdupe2_enabled_tooltip", "Sollen Erkennungen Teammitglieder benachrichtigen? NB: Dies kann verwendet werden, um Teammitglieder zu nerven.")
	slib.setLang("gprotect", "de", "advdupe2_notifyStaff", "Benachrichtige Teammitglieder")
	slib.setLang("gprotect", "de", "advdupe2_notifyStaff_tooltip", "Sollen Erkennungen Teammitglieder benachrichtigen? NB: Dies kann verwendet werden, um Teammitglieder zu nerven.")
	slib.setLang("gprotect", "de", "advdupe2_PreventRopes", "Verhindere Seil-Spawn")
	slib.setLang("gprotect", "de", "advdupe2_PreventRopes_tooltip", "Verhindere das Spawnen von Seilen! (1 = Verhindere Spawn, 2 = Spawn aber beheben)")
	slib.setLang("gprotect", "de", "advdupe2_PreventScaling", "Verhindere Skalierung")
	slib.setLang("gprotect", "de", "advdupe2_PreventScaling_tooltip", "Verhindere das Spawnen von hochskalierten Props. (1 = Verhindere Spawn, 2 = Spawn aber beheben)")
	slib.setLang("gprotect", "de", "advdupe2_PreventNoGravity", "Verhindere keine Schwerkraft")
	slib.setLang("gprotect", "de", "advdupe2_PreventNoGravity_tooltip", "Verhindere das Spawnen von Props ohne Schwerkraft. (1 = Verhindere Spawn, 2 = Spawn aber beheben)")
	slib.setLang("gprotect", "de", "advdupe2_PreventUnfreezeAll", "Verhindere Unfreeze All")
	slib.setLang("gprotect", "de", "advdupe2_PreventUnfreezeAll_tooltip", "Verhindere, dass Personen alle Props entfrieren. (1 = Verhindere Spawn, 2 = Spawn aber beheben)")
	slib.setLang("gprotect", "de", "advdupe2_BlacklistedCollisionGroups", "Kollisionsgruppe Blacklist")
	slib.setLang("gprotect", "de", "advdupe2_BlacklistedCollisionGroups_tooltip", "Dies schützt vor Props die du nicht anvisieren kannst. NB: Werte müssen Kollisions-ENUMs sein")
	slib.setLang("gprotect", "de", "advdupe2_WhitelistedConstraints", "Verbindungs Whitelist")
	slib.setLang("gprotect", "de", "advdupe2_WhitelistedConstraints_tooltip", "Dies dient um ungewollte Verbindungen zu verhindern.")

	slib.setLang("gprotect", "de", "miscs_enabled", "Aktiviert")
	slib.setLang("gprotect", "de", "miscs_enabled_tooltip", "Aktiviere das Sonstiges Modul?")
	slib.setLang("gprotect", "de", "miscs_ClearDecals", "Clear decals Timer")
	slib.setLang("gprotect", "de", "miscs_ClearDecals_tooltip", "Timer in Sekunden. Dies löscht die Decals für alle Spieler nach dem Timer :)")
	slib.setLang("gprotect", "de", "miscs_NoBlackoutGlitch", "Verhindere Blackout-Exploit")
	slib.setLang("gprotect", "de", "miscs_NoBlackoutGlitch_tooltip", "Zahl Dies verhindert den 'pp/copy'  (1 = Benachrichtigung, 2 = Kick, 3 = Ban).")
	slib.setLang("gprotect", "de", "miscs_FadingDoorLag", "Verhindere Fading Door Lag")
	slib.setLang("gprotect", "de", "miscs_FadingDoorLag_tooltip", "Dies verhindert, dass Personen den Server mit dem Fading Door Werkzeug zum Absturz bringen.")
	slib.setLang("gprotect", "de", "miscs_DisableMotion", "Deaktiviere Bewegung")
	slib.setLang("gprotect", "de", "miscs_DisableMotion_tooltip", "Dies deaktiviert die Bewegung für alle Entities auf der Blacklist.")
	slib.setLang("gprotect", "de", "miscs_freezeOnSpawn", "Friere beim Spawn ein")
	slib.setLang("gprotect", "de", "miscs_freezeOnSpawn_tooltip", "Dies friert Props ein, sobald diese gespawnt werden")
	slib.setLang("gprotect", "de", "miscs_preventFadingDoorAbuse", "Verhindere Fading Door Missbrauch")
	slib.setLang("gprotect", "de", "miscs_preventFadingDoorAbuse_tooltip", "Dies verhindert, dass Personen in Fading Doors festgesetzt werden.")
	slib.setLang("gprotect", "de", "miscs_preventSpawnNearbyPlayer", "Verhindere Spawn in der Nähe")
	slib.setLang("gprotect", "de", "miscs_preventSpawnNearbyPlayer_tooltip", "Falls jemand näher als dieser Wert zur Spawnposition befindet, wird das Prop nicht gespawnt (0 bedeutet deaktiviert)")
	slib.setLang("gprotect", "de", "miscs_DRPEntForceOwnership", "Erzwinge Besitz auf DarkRP Entities")
	slib.setLang("gprotect", "de", "miscs_DRPEntForceOwnership_tooltip", "Dies erzwingt den Besitz von Entities, welche im F4 Menü gekauft wurden")
end