/*
    Addon id: 64edeaec-8955-454a-aac4-1d19d72ee4af
    Version: v1.6.0 (stable)
*/


zclib.Hook.Add("zclib_PlayerInitialized", "zgo2_zclib_PlayerInitialized", function()

	// NOTE This is really important since we only can build the materials once the draw function of the client is running
	timer.Simple(1,function()

		// Lets preload some fancy images which can be used for the ScreenEffect later
		zclib.Imgur.GetMaterial("7MWdbsI", function(result) end)
		zclib.Imgur.GetMaterial("a28XrS6", function(result) end)
		zclib.Imgur.GetMaterial("qlBMyAB", function(result) end)
		zclib.Imgur.GetMaterial("dD44NaU", function(result) end)
		zclib.Imgur.GetMaterial("SJNDvNB", function(result) end)
		zclib.Imgur.GetMaterial("8SXjP1Y", function(result) end)
		zclib.Imgur.GetMaterial("6QtEPYP", function(result) end)
		zclib.Imgur.GetMaterial("Xvd21ZO", function(result) end)
		zclib.Imgur.GetMaterial("TMbL3hA", function(result) end)
		zclib.Imgur.GetMaterial("9vesYIc", function(result) end)
		zclib.Imgur.GetMaterial("p8hx90B", function(result) end)
		zclib.Imgur.GetMaterial("7BKe2Tt", function(result) end)
		zclib.Imgur.GetMaterial("xizvhL7", function(result) end)
		zclib.Imgur.GetMaterial("kX4KPrQ", function(result) end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5559b70aef9c1abf2cb1ba55b1f16f11d321a43feaba0104044967bf0f5f93a3

		zgo2.Print("PreBuild Bong Skins")

		local keyId = 1
		timer.Create("zclib_load_bongs_materials", 0.3, table.Count(zgo2.config.Bongs), function()
			local key = table.GetKeys(zgo2.config.Bongs)[keyId]

			local bongTable = zgo2.config.Bongs[key]

			if istable(bongTable) then
				local data = zgo2.Bong.VerifyData(bongTable)
				zgo2.config.Bongs[key] = data

				// Predownload the imgur images
				zclib.Imgur.GetMaterial(tostring(data.style.url), function(result)
					zgo2.Bong.RebuildMaterial(data)
				end)
			end

			keyId = keyId + 1
		end)

		-- timer.Simple(0.2,function()
		-- 	for k, v in pairs(zgo2.config.Bongs) do
		-- 		local data = zgo2.Bong.VerifyData(v)
		-- 		zgo2.config.Bongs[k] = data

		-- 		// Predownload the imgur images
		-- 		zclib.Imgur.GetMaterial(tostring(data.style.url), function(result)
		-- 			zgo2.Bong.RebuildMaterial(data)
		-- 		end)
		-- 	end
		-- end)

		-- timer.Simple(0.4,function()
		-- 	// Send the player the default plants
		-- 	for k, v in pairs(zgo2.Plant.GetAll()) do

		-- 		local data = zgo2.Plant.VerifyData(v)

		-- 		// Build normal plant materials
		-- 		zgo2.Plant.RebuildMaterial(data)

		-- 		timer.Simple(0, function()
		-- 			// Build dried plant materials
		-- 			zgo2.Plant.RebuildMaterial(data,false,true)
		-- 		end)

		-- 		// Download ScreenEffect BaseTexture
		-- 		zclib.Imgur.GetMaterial(tostring(data.screeneffect.basetexture_url), function()

		-- 			// Download ScreenEffect refract texture
		-- 			zclib.Imgur.GetMaterial(tostring(data.screeneffect.refract_url), function()

		-- 				zgo2.ScreenEffect.RebuildMaterial(data)
		-- 			end)
		-- 		end)

		-- 		if data.screeneffect.audio_music and data.screeneffect.audio_music ~= "" then
		-- 			zgo2.ScreenEffect.SetMusic(data,data.screeneffect.audio_music)
		-- 		end
		-- 	end
		-- end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- bd9238194797e7a3a04c8c75d4f4f015d7462772843771f20f1d36c5388fc432
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

		local keyId = 1
		local plants = zgo2.Plant.GetAll()
		timer.Create("zclib_load_pots_materials", 0.3, table.Count(plants), function()
			local key = table.GetKeys(plants)[keyId]
			local plantTable = zgo2.config.Bongs[key]

			if istable(plantTable) then
				local data = zgo2.Plant.VerifyData(plantTable)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 392e0b69f013fac88b0ca32a370aadaa85d42104a0c169250a82c12e4c6498ab
	
				// Build normal plant materials
				zgo2.Plant.RebuildMaterial(data)
	
				timer.Simple(0, function()
					// Build dried plant materials
					zgo2.Plant.RebuildMaterial(data, false, true)
				end)
	
				// Download ScreenEffect BaseTexture
				zclib.Imgur.GetMaterial(tostring(data.screeneffect.basetexture_url), function()
	
					// Download ScreenEffect refract texture
					zclib.Imgur.GetMaterial(tostring(data.screeneffect.refract_url), function()
	
						zgo2.ScreenEffect.RebuildMaterial(data)
					end)
				end)
				
				if data.screeneffect.audio_music and data.screeneffect.audio_music ~= "" then
					zgo2.ScreenEffect.SetMusic(data,data.screeneffect.audio_music)
				end
			end
		end)

		timer.Simple(0.6, function()
			for k, v in pairs(zgo2.config.Pots) do

				local data = zgo2.Pot.VerifyData(v)

				zgo2.config.Pots[k] = data
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f69c95600bf898b66d56b7a9e25fb8a12eebe9e851363b0f35df32e1d4d4724b

				// Predownload the imgur images
				zclib.Imgur.GetMaterial(tostring(data.style.url), function(result)
					zgo2.Pot.RebuildMaterial(data)
				end)
			end
		end)

		timer.Simple(10, function()
			LocalPlayer().zgo2_Initialized = true
			zgo2.Print("Fully Initialized!")
		end)
	end)
end)
