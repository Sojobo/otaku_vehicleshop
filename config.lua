Config = {}
Config.Locale = "en"
Config.VehicleshopInterior = false -- Set this to true if the vehicleshop interior does not load!
Config.PoliceJob = false -- Set this to true if you want otaku_vehicleshop to be compatible with esx_policejob! remember that you do need to edit policejob to use otaku_vehicleshop instead of esx_vehicleshop
Config.DrawDistance = 100.0
Config.ResellPercentage = 70
Config.LtdEditions = true -- If you remove the ltdedition category (i.e. the splash page for 1 special car), set this to false
Config.VersionCheck = true

Config.Zones = {
	ShopEntering = {
		Pos = {x = -38.26, y = -1098.23, z = 26.00},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = 36
	},
	ShopOutside = {
		Pos = {x = -28.637, y = -1085.691, z = 25.565},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 330.0,
		Type = -1
	},
	ResellVehicle = {
		Pos = {x = -44.98, y = -1082.19, z = 26.00},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Type = 25
	}
}
