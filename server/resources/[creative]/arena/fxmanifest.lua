fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/*"
}