fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"config-side/config.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"config-side/config.lua",
	"server-side/*"
}

escrow_ignore {
	"config-side/config.lua"
}

files {
	"web-side/*"
}