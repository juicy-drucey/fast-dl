include( "ballistic_shields/sh_bs_util.lua" )

bshields.lang = {
	["English"] = {
		["sec"] = "[RMB] VISIBILITY",
		["dshieldprim"] = "[LMB] DEPLOY",
		["hshieldprim"] = "[LMB] BREACH DOOR",
		["rshieldprim"] = "[LMB] ATTACK",
		["hshieldcd1"] = "Wait ",
		["hshieldcd2"] = " seconds to breach next door!"	
	},
	["German"] = {
		["sec"] = "[RMB] SICHTBARKEIT",
		["dshieldprim"] = "[LMB] PLAZIEREN",
		["hshieldprim"] = "[LMB] TÜR AUFBRECHEN",
		["rshieldprim"] = "[LMB] ANGREIFEN",
		["hshieldcd1"] = "Warte ",
		["hshieldcd2"] = " Sekunden für das Aufbrechen der nächsten Tür!"	
	},
	["French"] = {
		["sec"] = "[RMB] VISIBILITÉ",
		["dshieldprim"] = "[LMB] DÉPLOYER",
		["hshieldprim"] = "[LMB] FORCER LA PORTE",
		["rshieldprim"] = "[LMB] ATTAQUER",
		["hshieldcd1"] = "Attendez ",
		["hshieldcd2"] = " secondes pour forcer la porte !"	
	},
	["Danish"] = {
		["sec"] = "[RMB] SIGTBARHED",
		["dshieldprim"] = "[LMB] SÆT",
		["hshieldprim"] = "[LMB] BREACH DØR",
		["rshieldprim"] = "[LMB] ANGRIB",
		["hshieldcd1"] = "Vent ",
		["hshieldcd2"] = " sekunder at bryde ved siden af!"   
	},
	["Turkish"] = {
		["sec"] = "[RMB] GORUNURLUK",
		["dshieldprim"] = "[LMB] YERLESTIR",
		["hshieldprim"] = "[LMB] BREACH DOOR",
		["rshieldprim"] = "[LMB] SALDIR",
		["hshieldcd1"] = "Bekle ",
		["hshieldcd2"] = " bir sonraki kapıyı kırmaya saniye kaldı!"   
	},
	["Russian"] = {
		["sec"] = "[ПКМ] ВИДИМОСТЬ",
		["dshieldprim"] = "[ЛКМ] УСТАНОВИТЬ",
		["hshieldprim"] = "[ЛКМ] СЛОМАТЬ ДВЕРЬ",
		["rshieldprim"] = "[ЛКМ] АТАКОВАТЬ",
		["hshieldcd1"] = "Ждите ",
		["hshieldcd2"] = " секунд прежде чем сломать следующую дверь!"	
	},
	["Chinese"] = {
		["sec"] = "[鼠标右键]改变透明度",
		["dshieldprim"] = "[鼠标左键]部署盾牌",
		["hshieldprim"] = "[鼠标左键]破门",
		["rshieldprim"] = "[鼠标左键]盾击",
		["hshieldcd1"] = "请稍等",
		["hshieldcd2"] = "秒后才能再次破门"	
	},
	["Spanish"] = {
		["sec"] = "[RMB] VISIBILIDAD",
		["dshieldprim"] = "[LMB] DESPLEGAR",
		["hshieldprim"] = "[LMB] DESTRUIR PUERTA",
		["rshieldprim"] = "[LMB] ATACAR",
		["hshieldcd1"] = "¡Espera ",
		["hshieldcd2"] = " segundos antes de destruir otra puerta!"	
	}
}  

if(bshields.lang[bshields.config.language]==nil) then bshields.config.language = "English" end