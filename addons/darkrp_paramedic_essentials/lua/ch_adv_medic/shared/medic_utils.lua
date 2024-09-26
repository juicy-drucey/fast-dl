--[[
	Language functions
--]]
function CH_AdvMedic.LangString( text )
	local translation = text .." (Translation missing)"
	local lang = CH_AdvMedic.Config.Language or "en"
	
	if CH_AdvMedic.Config.Lang[ text ] then
		translation = CH_AdvMedic.Config.Lang[ text ][ lang ]
	end
	
	return translation
end