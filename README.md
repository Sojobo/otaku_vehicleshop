# otaku_vehicleshop

## Features

- **Buy Vehicles**
Purchase confirmation, categorized pages and pagination all included
- **Sell Vehicles**
The config file also allows for adjusting the sell-back rate
- **Featured Page**
I use this as a "Limited Edition" cover page on my server
- **Open Source**
Modify to your liking or contribute to the github directly through PRs
- **Version Checking**
Automatic version checking makes sure you don't fall behind with any important updates!
- **Optiona JobVehicleSpawn Support**
Config.PoliceJob = false Set this to true if you want esx_policejob to work correctly! should work with other policejobs and/or other jobs that require vehicle spawning

## Requirements

To run otaku_vehicleshop you will need to be using the following resources;

- es_extended
- mysql-async

## Download & Installation

- Import otaku_vehicleshop.sql in your database
- Add this in your server.cfg: "ensure otaku_vehicleshop"

## Help & Support

Join us on Discord to see our other resources or find help & support for any issues you run into.
Pull requests and feature requests are always welcome.

Discord: https://discord.gg/EMeDvZ7FVV

For anyone wondering what to do about the hash column in the database just leave it empty and the server will auto populate it on startup!
And for anyone having trouble with the database not wanting to save the vehicle when hash is left empty simply put a 0 in hash and let it save and just remove the 0 right after!

## If you're using esx_policejob follow this guide

go to esx_policejob/client/vehicle.lua

Ctrl + F to search and search for:

ESX.TriggerServerCallback('esx_vehicleshop:retrieveJobVehicles', function(jobVehicles)

and replace esx_vehicleshop with otaku_vehicleshop so it looks like this:

ESX.TriggerServerCallback('otaku_vehicleshop:retrieveJobVehicles', function(jobVehicles)

Then do the same for the rest

Search for this:

TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.plate, false)

and replace esx_vehicleshop with otaku_vehicleshop:

TriggerServerEvent('otaku_vehicleshop:setJobVehicleState', data2.current.plate, false)

Search for this:

local newPlate = exports['esx_vehicleshop']:GeneratePlate()

and once again replace esx_vehicleshop with otaku_vehicleshop:

local newPlate = exports['otaku_vehicleshop']:GeneratePlate()


## Preview video of the script
[![Otaku Vehicleshop](https://i.imgur.com/sUexFGm.png)](https://www.youtube.com/watch?v=o1ak6P9nf98 "Otaku Vehicleshop")
