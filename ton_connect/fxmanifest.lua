fx_version 'cerulean'
games { 'gta5' }

author 'Pixly Games'

ui_page 'index.html'

files { 
    'index.html', 
    'index.js',
}

client_scripts {
    'nui.lua',
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
