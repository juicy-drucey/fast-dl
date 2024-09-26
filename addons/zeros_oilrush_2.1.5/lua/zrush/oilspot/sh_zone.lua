/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

zrush = zrush or {}
zrush.OilSpotZone = zrush.OilSpotZone or {}
zrush.OilSpotZone.List = zrush.OilSpotZone.List or {}
zrush.OilSpotZone.Oilspots = zrush.OilSpotZone.Oilspots or {}

zclib.Zone.Setup("zrush_oilspot_zone",{
    script = "Zero´s OilRush",

    // The path of the save file
    path =  "zrush/" .. string.lower(game.GetMap()) .. "_oilspot_zones" .. ".txt",

    // Return the var we store the data in
    GetData = function() return zrush.OilSpotZone.List end,

    // Gets called when the zone data loads
    Load = function(data)
        zrush.OilSpotZone.List = data
        zrush.Print("Updated Oilspot Zones!")
    end,

    // Gets called when the zone data gets removed
    Remove = function()
        zrush.OilSpotZone.List = {}
    end,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 2800b6f4cc234b290aaf088177c24fea83afc5f88732e1f1472f205941526354

    // The name of the toolgun lua file
    ToolName = "zrush_oilspot_zoner",

    // Draw the name of the zone in the pewview
    DrawZone = function(zoneID, zoneData)
        draw.SimpleText(zrush.language["OilSpotSpawner"], zclib.GetFont("zclib_font_medium"), 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    // Gets called when a zone is about to get removed
    OnZoneRemoved = function(zone_id, zone_data)
        if zrush.OilSpotZone.Oilspots[zone_id] then
            for _, oilspot in pairs(zrush.OilSpotZone.Oilspots[zone_id]) do
                if IsValid(oilspot) then
                    SafeRemoveEntity(oilspot)
                end
            end
        end
    end,

    // If set then the zones will snap
    //SnapSize = 10,

    // Overwrites how much extra height will be added when drawing the Zone Box
    //ExtraHeight = 10,
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

    // If set then the drawn zones will be filled
    FillZone = true,
})
