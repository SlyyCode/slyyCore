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