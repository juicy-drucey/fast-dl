RetroBoombox = {}
RetroBoombox.Config = {}
RetroBoombox.OriginalMats = {}
RetroBoombox.Config.MaxSoundVolume = 100
RetroBoombox.Config.MaxSoundDistance = 1160000

function RetroBoombox:LoadLanguage()
	local chosenLang = RetroBoombox.Config.Language or "en"

	local dirLang = "retroboombox/languages/" .. chosenLang .. ".lua"

	if not file.Exists(dirLang, "LUA") then chosenLang = "en" end

	if SERVER then
		AddCSLuaFile(dirLang)
	end
	RetroBoombox.Lang = include(dirLang)
end

function RetroBoombox:Init()
	local directories = { -- for priority order
		[ 1 ] = 'shared',
		[ 2 ] = 'server',
		[ 3 ] = 'client',
	}
	for _, file_name in pairs( file.Find( 'retroboombox/sh_*.lua', 'LUA' ) ) do

		-- include shared
		include( 'retroboombox/' .. file_name )
		if SERVER then
			-- AddCSLuaFile shared
			AddCSLuaFile( 'retroboombox/' .. file_name )
		end
	end
	for _, file_name in pairs( file.Find( 'retroboombox/cl_*.lua', 'LUA' ) ) do
		if SERVER then	
			-- AddCSLuaFile client
			AddCSLuaFile( 'retroboombox/' .. file_name )
		elseif CLIENT then
			-- include client
		end
	end
	for _, file_name in pairs( file.Find( 'retroboombox/sv_*.lua', 'LUA' ) ) do
		if SERVER then	
			-- include server
			include( 'retroboombox/' .. file_name )
		end
	end

	self:LoadLanguage()

	for _, dir in pairs( directories ) do
		for _, file_name in pairs( file.Find( 'retroboombox/' .. dir .. '/sh_*.lua', 'LUA' ) ) do

			-- include shared
			include( 'retroboombox/' .. dir .. '/' .. file_name )
			if SERVER then
				-- AddCSLuaFile shared
				AddCSLuaFile( 'retroboombox/' .. dir .. '/' .. file_name )
			end
		end
		for _, file_name in pairs( file.Find( 'retroboombox/' .. dir .. '/cl_*.lua', 'LUA' ) ) do
			if SERVER then	
				-- AddCSLuaFile client
				AddCSLuaFile( 'retroboombox/' .. dir .. '/' .. file_name )
			elseif CLIENT then
				-- include client
				include( 'retroboombox/' .. dir .. '/' .. file_name )
			end
		end
		for _, file_name in pairs( file.Find( 'retroboombox/' .. dir .. '/sv_*.lua', 'LUA' ) ) do
			if SERVER then	
				-- include server
				include( 'retroboombox/' .. dir .. '/' .. file_name )
			end
		end
	end
end

function RetroBoombox:L(sKey)
	return RetroBoombox.Lang[sKey] or sKey
end

RetroBoombox:Init()