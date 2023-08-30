--[[
######################################################################################
#  _  _   ___   ___   ___   _      ___     _     _  _   _  __                   _    #
# | \| | | __| | _ ) | __| | |    | _ )   /_\   | \| | | |/ /      _ _    ___  | |_  #
# | .` | | _|  | _ \ | _|  | |__  | _ \  / _ \  | .` | | ' <   _  | ' \  / -_) |  _| #
# |_|\_| |___| |___/ |___| |____| |___/ /_/ \_\ |_|\_| |_|\_\ (_) |_||_| \___|  \__| #
#																					 #
######################################################################################
]]--
fx_version 'cerulean'
game 'gta5'
author 'NebelRebell'
discription 'Cargobob Magnet for Mechanics'
version '1.0'
lua54 'yes'

client_scripts {
    '@es_extended/locale.lua',
	'client.lua'
}

server_scripts {
    '@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@es_extended/locale.lua'
}

dependencies {
}