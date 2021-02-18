fx_version "bodacious"
game "gta5"

author "Sojobo#0001"
description "Otaku Vehicle Shop"
version "1.1.0"

dependency "es_extended"
ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/ui.css",
	"html/ui.js",
	"html/header.png",
	"version.json"
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"locales/*.lua",
	"config.lua",
	"server/main.lua"
}

client_scripts {
	"@es_extended/locale.lua",
	"locales/*.lua",
	"config.lua",
	"client/utils.lua",
	"client/main.lua"
}

exports {
	"GeneratePlate",
	"getVehicleData"
}
