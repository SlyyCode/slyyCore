fx_version "adamant"
game "gta5"
lua54 "yes"
version "1.0.0"
author "Slyy"

client_scripts {
    "src/main.lua",
    "src/modules/**/client/*.lua",
}

server_scripts {
    "src/main.lua",
    "src/modules/**/server/*.lua",
    "src/modules/**/server/object/*.lua",
}