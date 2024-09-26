/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/

zgo2 = zgo2 or {}
zgo2.Backpack = zgo2.Backpack or {}

/*
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 3198271ffe3580e77dcdbbfd2ed320261e012e96aa33dd1da5d29f0b668843bb
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	The backpack swep can be used to transport weed

*/

file.CreateDir( "zgo2" )
file.CreateDir( "zgo2/backpack" )

/*
	Saves the players backpack
*/
function zgo2.Backpack.Save(ply)
	if not ply.zgo2_backpack then ply.zgo2_backpack = {} end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	// Do we even want to save the data?
	if not zgo2.config.Backpack.Save.Enabled then return end

	local SteamID64 = ply:SteamID64()
	local path = "zgo2/backpack/" .. SteamID64 .. ".txt"

	// Delete old savefile
	file.Delete(path)

	// Create new savefile
	if ply.zgo2_backpack and table.Count(ply.zgo2_backpack) > 0 then
		file.Write(path, util.TableToJSON(ply.zgo2_backpack, true))

		zgo2.Print("[Backpack] Successfully saved [" .. SteamID64 .. "] inventory!")
	end
end

/*
	Save on disconnect
*/
zclib.Hook.Add("zclib_PlayerDisconnect", "zgo2.Backpack.SaveOnDeconnect", function(steamid)
	local ply = player.GetBySteamID( steamid )
	if IsValid(ply) then
		zgo2.Backpack.Save(ply)
	end
end)

/*
	Saves the backpack Data for all players
*/
function zgo2.Backpack.SaveForAll()
	for k,v in pairs(player.GetAll()) do
		if not IsValid(v) then continue end
		zgo2.Backpack.Save(v)
	end
end
zclib.Hook.Add("ShutDown", "zgo2.Backpack.Save", function() zgo2.Backpack.SaveForAll() end)

/*
	Load the players Backpack
*/
function zgo2.Backpack.Load(ply)
	if not ply.zgo2_backpack then ply.zgo2_backpack = {} end

	local SteamID64 = ply:SteamID64()
	local path = "zgo2/backpack/" .. SteamID64 .. ".txt"
	if not file.Exists(path, "DATA") then return end

	local data = file.Read(path, "DATA")
	if not data then return end
	data = util.JSONToTable(data)
	if not data then return end

	ply.zgo2_backpack = data or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	zgo2.Print("[Backpack] Successfully loaded [" .. SteamID64 .. "] inventory!")
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432

/*
	Delets the players backpack data
*/
function zgo2.Backpack.Delete(ply)
	ply.zgo2_backpack = {}

	local SteamID64 = ply:SteamID64()
	local path = "zgo2/backpack/" .. SteamID64 .. ".txt"
	if not file.Exists(path, "DATA") then return end
	file.Delete(path)
end


/*
	Clean up any savefile which is older then 1 month
*/
function zgo2.Backpack.CleanUp()
	local path = "zgo2/backpack/"
	local files = file.Find(path .. "*", "DATA")

	for k, v in pairs(files) do

		if file.Exists(path .. v, "DATA") and (os.time() - file.Time(path .. v, "DATA")) > zgo2.config.Backpack.Save.LifeTime then
			file.Delete(path .. v)
		end
	end
end
timer.Simple(3,zgo2.Backpack.CleanUp)
