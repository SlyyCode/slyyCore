fx_version "adamant"
game "gta5"
lua54 "yes"
version "1.0.0"
author "Slyy"

shared_scripts {
    "configuration/global.lua",
    "src/class/config.lua",
    "src/utils/console.lua",
    "src/main.lua",
    "src/utils/events.lua",
    "src/utils/main.lua",
    "src/modules/main.lua",
    -- Addons
    "addons/**/shared/*.lua",
}

client_scripts {
    --RUI
    "libs/rui/RMenu.lua",
    "libs/rui/menu/RageUI.lua",
    "libs/rui/menu/Menu.lua",
    "libs/rui/menu/MenuController.lua",
    "libs/rui/components/*.lua",
    "libs/rui/menu/elements/*.lua",
    "libs/rui/menu/items/*.lua",
    "libs/rui/menu/panels/*.lua",
    "libs/rui/menu/windows/*.lua",
    -- Src
    "src/utils/**/client/*.lua",
    "src/modules/**/client/*.lua",
    -- Addons
    "addons/**/client/*.lua",
}

server_scripts {
    "src/modules/**/server/*.lua",
    "src/utils/**/server/*.lua",
    "src/modules/**/server/object/*.lua",
    -- Addons
    "addons/**/server/*.lua",
}

ui_page {
	"src/view/ui.html"
}

files {
	"src/view/ui.html",
	"src/view/js/*.js",

    "public/css/*.css",
	"public/fonts/*.ttf",
}