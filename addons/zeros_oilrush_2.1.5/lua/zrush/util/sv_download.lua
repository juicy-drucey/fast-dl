/*
    Addon id: 4cef70ec-6b46-4fa9-be31-55c16a7211ec
    Version: 2.1.5 (stable)
*/

if CLIENT then return end

resource.AddWorkshop( "2532060111" ) // Zeros Lua Libary Contentpack
//https://steamcommunity.com/sharedfiles/filedetails/?id=2532060111


if zrush.config.FastDL then
	zrush = zrush or {}
	zrush.force = zrush.force or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f7721e15d65a41844f7cce3e057476bdf1e6729178598d02322c34148dafd0c1

	function zrush.force.AddDir(path)
		local files, folders = file.Find(path .. "/*", "GAME")

		for k, v in pairs(files) do
			resource.AddFile(path .. "/" .. v)
		end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- c6ab9e59f46f19283b015eea2de9cc203740eab4970ed9a2952ed19dc22d35f2

		for k, v in pairs(folders) do
			zrush.force.AddDir(path .. "/" .. v)
		end
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821

	resource.AddSingleFile("materials/entities/zrush_barrel.png")
	resource.AddSingleFile("materials/entities/zrush_drillpipe_holder.png")
	resource.AddSingleFile("materials/entities/zrush_npc.png")
	resource.AddSingleFile("materials/entities/zrush_machinecrate.png")

	resource.AddSingleFile("particles/zrush_burner_vfx.pcf")
	resource.AddSingleFile("particles/zrush_drill_vfx.pcf")
	resource.AddSingleFile("particles/zrush_oil_vfx.pcf")
	resource.AddSingleFile("particles/zrush_refinery_vfx.pcf")

	resource.AddSingleFile("resource/fonts/gothic.ttf")
	resource.AddSingleFile("resource/fonts/gothicb.ttf")
	resource.AddSingleFile("resource/fonts/gothicbi.ttf")
	resource.AddSingleFile("resource/fonts/gothici.ttf")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561199237832821


	zrush.force.AddDir("sound/zrush")

	zrush.force.AddDir("models/zerochain/props_oilrush")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7efdf2c8887b497532b997595a8ca0761a6c02c524ca73b7706da51a427c7a22

	zrush.force.AddDir("materials/zerochain/zrush/particles")
	zrush.force.AddDir("materials/zerochain/zrush/ui")

	zrush.force.AddDir("materials/zerochain/props_oilrush")
	zrush.force.AddDir("materials/zerochain/props_oilrush/barrel")
	zrush.force.AddDir("materials/zerochain/props_oilrush/burner")
	zrush.force.AddDir("materials/zerochain/props_oilrush/drillhole")
	zrush.force.AddDir("materials/zerochain/props_oilrush/drillpipe")
	zrush.force.AddDir("materials/zerochain/props_oilrush/drilltower")
	zrush.force.AddDir("materials/zerochain/props_oilrush/machinecrate")
	zrush.force.AddDir("materials/zerochain/props_oilrush/modulebase")
	zrush.force.AddDir("materials/zerochain/props_oilrush/oilpump")
	zrush.force.AddDir("materials/zerochain/props_oilrush/oilspot")
	zrush.force.AddDir("materials/zerochain/props_oilrush/refinery")
else
	resource.AddWorkshop("1393715099") // Zeros OilRush Contentpack
end
