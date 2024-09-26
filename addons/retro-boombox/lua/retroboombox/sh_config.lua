RetroBoombox.Config.Language = "en"

--[[
	https://wiki.facepunch.com/gmod/Enums/KEY
]]
RetroBoombox.Config.KeyBase = KEY_LALT

RetroBoombox.Config.ShouldUseParticles = false
RetroBoombox.Config.MaxSoundVolume = 100
-- This is the square of the max distance.
RetroBoombox.Config.MaxSoundDistance = 1160000
RetroBoombox.Config.BoomboxCanBeDestroyed = true

--[[
	If this parameter is set to false, everyone can use
	every boombox.

	If this parameter is set to true,
	if the boombox is owned by someone, only the owner can use it.
	if the boombox is not owned by someone, everyone can use it.
]]
RetroBoombox.Config.BoomboxUseLimitedToOwner = false

--[[
	Radios available on the boombox.

	HOW TO GET A RADIO URL : https://www.youtube.com/watch?v=nKWdXDtIpmo
]]

RetroBoombox.Config.Frequencies = {
	-- French :
	{
		name = "NRJ France",
		logo = "https://www.nrj.fr/uploads/assets/common/logos/logo-nrj2.svg",
		url = "http://185.52.127.163/fr/30001/mp3_128.mp3"
	},
	{
		name = "Fun Radio",
		logo = "https://images-eu.ssl-images-amazon.com/images/I/61SBhLAGLNL.png",
		url = "http://streaming.radio.funradio.fr/fun-1-44-96"
	},
	{
		name = "Skyrock",
		logo = "https://images-na.ssl-images-amazon.com/images/I/51HBJRLl3AL.png",
		url = "http://www.skyrock.fm/stream.php/tunein16_64mp3.mp3"
	},
	{
		name = "Chérie FM",
		logo = "https://cdn-profiles.tunein.com/s3124/images/logog.png",
		url = "http://cdn.nrjaudio.fm/audio1/fr/30201/mp3_128.mp3?origine=fluxradios"
	},
	{
		name = "RTL",
		logo = "https://i.imgur.com/WUd8hQW.png",
		url = "http://streaming.radio.rtl.fr/rtl-1-44-96"
	},
	{
		name = "RTL 2",
		logo = "https://i.imgur.com/uYuban5.png",
		url = "http://streaming.radio.rtl2.fr/rtl2-1-44-96"
	},
	{
		name = "Virgin radio",
		logo = "https://www.virginradio.fr/desktop/modules/network/images/logo/app/virginradio.png",
		url = "https://ais-live.cloud-services.paris:8443/virgin.mp3"
	},
	{
		name = "Nostalgie France",
		logo = "https://players.nrjaudio.fm/live-metadata/player/img/player-files/nosta/logos/640x640/P_Nostalgie_logo_premium_1.png",
		url = "http://cdn.nrjaudio.fm/audio1/fr/30601/mp3_128.mp3?origine=fluxradios"
	},
	{
		name = "Radio Orient",
		logo = "https://i.imgur.com/lKn6qMd.png",
		url = "http://stream3.broadcast-associes.com:8405/Radio-Orient"
	},

	-- English : 
	{
		name = "Radio paradise",
		logo = "https://images-eu.ssl-images-amazon.com/images/I/51A-N2vXAlL.png",
		url = "https://stream.radioparadise.com/mp3-128"
	},
	{
		name = "BBC radio",
		logo = "https://images.radio.orange.com/radios/large_bbc_radio_1.png",
		url = "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p"
	},
	{
		name = "Kiss",
		logo = "https://i.iheart.com/v3/re/new_assets/cfe7bd3b-e0ec-40e9-8e2b-6ed7df4cc446",
		url = "http://broadcast.infomaniak.net/kisswestcoast-128.mp3"
	},
	{
		name = "ONE HIP HOP",
		logo = "https://i.imgur.com/qsUYZdX.png",
		url = "http://listen.one.hiphop/live.mp3"
	},
	{
		name = "HITS Radio",
		logo = "https://i.imgur.com/X9c3RKz.png",
		url = "https://16803.live.streamtheworld.com/977_JAMZ.mp3"
	},
	{
		name = "Star 983 FM",
		logo = "https://i.imgur.com/foRPZZQ.png",
		url = "https://www.streamvortex.com:8444/s/11010"
	},
	{
		name = "Hive365",
		logo = "https://i.imgur.com/SmQteeC.png",
		url = "https://wprelay.hive365.co.uk:8088/live"
	},

	-- German :
	{
		name = "BigFM",
		logo = "https://images-na.ssl-images-amazon.com/images/I/51MpthsMrVL.png",
		url = "https://streams.bigfm.de/bigfm-deutschland-128-mp3"
	},
	{
		name = "DEFJAY",
		logo = "https://i.imgur.com/yQHpwXT.png",
		url = "https://icepool.silvacast.com/DEFJAY.mp3"
	},
	{
		name = "Black Beats",
		logo = "https://static-media.streema.com/media/cache/48/a2/48a2aab3606106e758540d50f610ba0c.jpg",
		url = "http://rautemusik-de-hz-fal-stream15.radiohost.de/blackbeats?ref=radiode"
	},
	{
		name = "ILoveMusic",
		logo = "https://i.imgur.com/N9D7tvZ.png",
		url = "https://streams.ilovemusic.de/iloveradio15.mp3?hadpreroll"
	},
	{
		name = "Energy Berlin",
		logo = "https://www.nrj.fr/uploads/assets/common/logos/logo-nrj2.svg",
		url = "https://scdn.nrjaudio.fm/de/33001/mp3_128.mp3?origine=wlan&cdn_path=adswizz_lbs8&adws_out_b1"
	},
	{
		name = "JamFM",
		logo = "https://i.imgur.com/shRL9tu.png",
		url = "https://stream.jam.fm/jamfm-live/mp3-128/radioDE/"
	},

	-- Polish
	{
		name = "Radio ZET",
		logo = "https://i.imgur.com/igJm8pv.png",
		url = "http://zgl-kon-01.cdn.eurozet.pl:8000"
	},
	{
		name = "Złote Przeboje",
		logo = "https://i.imgur.com/JBygkPE.png",
		url = "https://ssl.stream.radioagora.pl/tuba8936-1.mp3"
	},
}

--[[	
	List of available light colors :
	["white"] = Color( 255, 255, 255, 255 ),
	["green"] = Color( 0, 255, 157, 255 ),
    ["darkgreen"] = Color( 63, 127, 79, 255 ),
    ["lightblue"] = Color( 0, 255, 255, 255 ),
    ["blue"] = Color( 0, 161, 255, 255 ),
    ["hardblue"] = Color( 0, 127, 127, 255 ),
    ["darkblue"] = Color( 0, 31, 127, 255 ),
    ["orange"] = Color( 255, 191, 0, 255 ),
    ["darkorange"] = Color( 255, 93, 0, 255 ),
    ["purple"] = Color( 127, 0, 255, 255 ),
    ["darkpurple"] = Color( 63, 0, 127, 255 ),
    ["red"] = Color( 255, 0, 0, 255 ),
    ["darkred"] = Color( 127, 0, 0, 255 ),
    ["pink"] = Color( 255, 0, 97, 255 ),
	["yellow"] = Color( 255, 229, 0, 255),
	You can use "zero" on lights to make that the is no light.

	The Secondary color should be one of these :
    gold
    silver
    bronze
]]

RetroBoombox.Config.Boombox = {
	[ "boombox_gold" ] = {
		MainColor = "gold",
		SecondaryColor = "gold",
		MainLightsColor = "yellow",
		TubeLightsColor = "yellow",
		SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},
	[ "boombox_silver" ] = {
		MainColor = "silver",
		SecondaryColor = "silver",
		TubeLightsColor = "white",
		MainLightsColor = "white",
		SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},
	[ "boombox_bronze" ] = {
		MainColor = "bronze",
		SecondaryColor = "bronze",
		TubeLightsColor = "darkorange",
		MainLightsColor = "darkorange",
		SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},
	[ "boombox_white" ] = {
	    MainColor = "white",
	    SecondaryColor = "silver",
	    TubeLightsColor = "white",
	    MainLightsColor = "white",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkgreen" ] = {
	    MainColor = "darkgreen",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkgreen",
	    MainLightsColor = "darkgreen",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkred" ] = {
	    MainColor = "darkred",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkred",
	    MainLightsColor = "darkred",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_hardblue" ] = {
	    MainColor = "hardblue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "hardblue",
	    MainLightsColor = "hardblue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_red" ] = {
	    MainColor = "red",
	    SecondaryColor = "silver",
	    TubeLightsColor = "red",
	    MainLightsColor = "red",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_purple" ] = {
	    MainColor = "purple",
	    SecondaryColor = "silver",
	    TubeLightsColor = "purple",
	    MainLightsColor = "purple",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_orange" ] = {
	    MainColor = "orange",
	    SecondaryColor = "silver",
	    TubeLightsColor = "orange",
	    MainLightsColor = "orange",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_pink" ] = {
	    MainColor = "pink",
	    SecondaryColor = "silver",
	    TubeLightsColor = "pink",
	    MainLightsColor = "pink",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkorange" ] = {
	    MainColor = "darkorange",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkorange",
	    MainLightsColor = "darkorange",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkpurple" ] = {
	    MainColor = "darkpurple",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkpurple",
	    MainLightsColor = "darkpurple",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_green" ] = {
	    MainColor = "green",
	    SecondaryColor = "silver",
	    TubeLightsColor = "green",
	    MainLightsColor = "green",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_yellow" ] = {
	    MainColor = "yellow",
	    SecondaryColor = "silver",
	    TubeLightsColor = "yellow",
	    MainLightsColor = "yellow",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_lightblue" ] = {
	    MainColor = "lightblue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "lightblue",
	    MainLightsColor = "lightblue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkblue" ] = {
	    MainColor = "darkblue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkblue",
	    MainLightsColor = "darkblue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_blue" ] = {
	    MainColor = "blue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "blue",
	    MainLightsColor = "blue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_white" ] = {
	    MainColor = "white",
	    SecondaryColor = "silver",
	    TubeLightsColor = "white",
	    MainLightsColor = "white",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkgreen" ] = {
	    MainColor = "darkgreen",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkgreen",
	    MainLightsColor = "darkgreen",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkred" ] = {
	    MainColor = "darkred",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkred",
	    MainLightsColor = "darkred",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_hardblue" ] = {
	    MainColor = "hardblue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "hardblue",
	    MainLightsColor = "hardblue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_red" ] = {
	    MainColor = "red",
	    SecondaryColor = "silver",
	    TubeLightsColor = "red",
	    MainLightsColor = "red",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_purple" ] = {
	    MainColor = "purple",
	    SecondaryColor = "silver",
	    TubeLightsColor = "purple",
	    MainLightsColor = "purple",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_orange" ] = {
	    MainColor = "orange",
	    SecondaryColor = "silver",
	    TubeLightsColor = "orange",
	    MainLightsColor = "orange",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_pink" ] = {
	    MainColor = "pink",
	    SecondaryColor = "silver",
	    TubeLightsColor = "pink",
	    MainLightsColor = "pink",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkorange" ] = {
	    MainColor = "darkorange",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkorange",
	    MainLightsColor = "darkorange",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkpurple" ] = {
	    MainColor = "darkpurple",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkpurple",
	    MainLightsColor = "darkpurple",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_green" ] = {
	    MainColor = "green",
	    SecondaryColor = "silver",
	    TubeLightsColor = "green",
	    MainLightsColor = "green",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_yellow" ] = {
	    MainColor = "yellow",
	    SecondaryColor = "silver",
	    TubeLightsColor = "yellow",
	    MainLightsColor = "yellow",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_lightblue" ] = {
	    MainColor = "lightblue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "lightblue",
	    MainLightsColor = "lightblue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_darkblue" ] = {
	    MainColor = "darkblue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "darkblue",
	    MainLightsColor = "darkblue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},

	[ "boombox_blue" ] = {
	    MainColor = "blue",
	    SecondaryColor = "silver",
	    TubeLightsColor = "blue",
	    MainLightsColor = "blue",
	    SoundLightsColor = "red",
		ScreenBackgroundColor = Color( 32, 32, 32, 255 ),
		ScreenContentColor = Color( 255, 255, 255, 255 ),
	},
}