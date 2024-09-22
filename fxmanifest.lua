fx_version 'cerulean'
game 'gta5'

author 'Jayson Liu'

description 'Fivem Traffic Accident Script'

dependencies {
  'ox_lib'
}

version '1.0.2'

shared_scripts {
  '@ox_lib/init.lua',
}

files {config.lua}

client_scripts {
    'client.lua'
  }
