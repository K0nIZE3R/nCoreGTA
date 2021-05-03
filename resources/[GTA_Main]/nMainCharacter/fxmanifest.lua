fx_version 'cerulean'
game 'gta5'

name 'RageUI';
description 'RageUI, and a project specially created to replace the NativeUILua-Reloaded library. This library allows to create menus similar to the one of Grand Theft Auto online.'

files {
    'json/**/*'
}

client_scripts {
    "core_rageui/RMenu.lua",
    "core_rageui/menu/RageUI.lua",
    "core_rageui/menu/Menu.lua",
    "core_rageui/menu/MenuController.lua",

    "core_rageui/components/*.lua",

    "core_rageui/menu/elements/*.lua",

    "core_rageui/menu/items/*.lua",

    "core_rageui/menu/panels/*.lua",

    "core_rageui/menu/windows/*.lua",
}

client_scripts {
    'config/config.lua',
    'client/client_main.lua',
    'client/client_menu.lua'
}

server_script '@mysql-async/lib/MySQL.lua'
server_script 'server/server_main.lua'