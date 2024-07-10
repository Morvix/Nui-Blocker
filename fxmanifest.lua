fx_version 'cerulean'
game 'gta5'
lua54 'yes'
-- ui_page 'http://localhost:5173/'
ui_page 'web/build/index.html'
client_script {
	'client/cl_config.lua',
	'client/client.lua',
}
server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/sh_config.lua',
	'server/server.lua',
}
files {
	'web/build/index.html',
	'web/build/**/*',
}
escrow_ignore {
	'server/sh_config.lua',
	'client/cl_config.lua',
}
-- use_fxv2_oal 'yes'