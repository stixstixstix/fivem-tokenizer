Name the script to ProAntiHack123AnticheatHackAntiStopperHack

Make sure oxmysql is installed

Install the sql table

Add these lines to fxmanifest.lua of script to protect:

server_script '@ProAntiHack123AnticheatHackAntiStopperHack/sv_tokenizer.lua' -- Required for protection

client_script '@ProAntiHack123AnticheatHackAntiStopperHack/cl_tokenizer.lua' -- Required for protection

server_script '@oxmysql/lib/MySQL.lua' -- Required for protection's requirements

Change events on your serverside events from RegisterNetEvent to sRegisterNetEvent to protect it

Clientsided triggers will automatically have a token added (you can add a event to the whitelist in the whitelist table in cl_tokenizer if you don't want it to automatically add a token)


I highly HIGHLY recommend you change the encryption system (ProHashingAlg) in both the client and server script and obfuscate the client script
