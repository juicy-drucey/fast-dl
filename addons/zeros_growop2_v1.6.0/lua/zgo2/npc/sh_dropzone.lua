/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.DropZone = zgo2.DropZone or {}
zgo2.DropZone.List = zgo2.DropZone.List or {}

// Package Drop System
/*

	The player need to deliver the weed to the specified location and the Package need to idle at the location for 60 seconds or so
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

*/

if SERVER then
    file.CreateDir("zgo2")

    concommand.Add("zgo2_DropZone_remove", function(ply, cmd, args)
        if zclib.Player.IsAdmin(ply) then
            zclib.Zone.Remove("zgo2_drop_zone")
			zclib.Notify(ply, "Removed all dropzones for " .. string.lower(game.GetMap()) .. "!", 0)
        end
    end)
end

zclib.Zone.Setup("zgo2_drop_zone",{
    script = "Zero´s GrowOP 2",

    // The path of the save file
    path =  "zgo2/" .. string.lower(game.GetMap()) .. "_dropzones" .. ".txt",

    // Return the var we store the data in
    GetData = function() return zgo2.DropZone.List end,

    // Gets called when the zone data loads
    Load = function(data)
        zgo2.DropZone.List = data
        zgo2.Print("Updated DropZones!")
    end,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    // Gets called when the zone data gets removed
    Remove = function()
        zgo2.DropZone.List = {}
    end,

    // The name of the toolgun lua file
    ToolName = "zgo2_dropzone",

    // Draw the name of the zone in the pewview
    DrawZone = function(zoneID, zoneData)
        draw.SimpleText("DropZone", zclib.GetFont("zclib_font_medium"), 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,

    // Gets called when a zone is about to get removed
    //OnZoneRemoved = function(zone_id, zone_data) end,

    // If set then the zones will snap
    //SnapSize = 10,

    // The default height of the zone
    BaseHeight = 50,

    // Overwrites how much extra height will be added when drawing the Zone Box
    ExtraHeight = 25,

    // If set then the drawn zones will be filled
    FillZone = true,

	// Makes the zones visible through the map
	WriteZ = false,
})

// If the provided position is inside one of the zones then we return true
function zgo2.DropZone.Overlap(pos)
    return zclib.Zone.CheckAll("zgo2_drop_zone",pos)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832812

if CLIENT then
    // Highlights the problem zone
    function zgo2.DropZone.HighlightZone(zoneid)
        zclib.Zone.DrawSingle("zgo2_drop_zone",zoneid)
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

/*
	Returns the first zone which is not in use currently by a player
*/
function zgo2.DropZone.GetFree()
	local list = {}
	for k,v in pairs(zgo2.DropZone.List) do
		if not IsValid(v.User) then
			table.insert(list,k)
		end
	end
	return list[math.random(#list)]
end
