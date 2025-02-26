fx_version 'cerulean'
games { 'gta5' }

ui_page 'index.html'

files { 
    'index.html', 
    'index.js',
    'styles.css'
}

shared_scripts {
    'config.lua',
    'nfts_to_assets.lua'
}

client_scripts {
    'nui.lua',
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
