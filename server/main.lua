ESX = nil
local Categories = {}
local Vehicles = {}

TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
	end
)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute(
		"DELETE FROM owned_vehicles WHERE plate = @plate",
		{
			["@plate"] = plate
		}
	)
end

MySQL.ready(
	function()
		Categories = MySQL.Sync.fetchAll("SELECT * FROM vehicle_categories ORDER BY label ASC")
		local vehicles = MySQL.Sync.fetchAll("SELECT * FROM vehicles")

		for i = 1, #vehicles, 1 do
			local vehicle = vehicles[i]
			vehicle.loaded = false

			for j = 1, #Categories, 1 do
				if Categories[j].name == vehicle.category then
					vehicle.categoryLabel = Categories[j].label
					break
				end
			end

			if (vehicle.hash == "") then
				vehicle.hash = GetHashKey(vehicle.model)
				MySQL.Async.execute(
					"UPDATE vehicles SET hash = @hash WHERE model = @model",
					{
						["@hash"] = vehicle.hash,
						["@model"] = vehicle.model
					}
				)
			end

			Vehicles[tostring(vehicle.hash)] = vehicle
		end

		-- send information after db has loaded, making sure everyone gets vehicle information
		TriggerClientEvent("otaku_vehicleshop:sendCategories", -1, Categories)
		TriggerClientEvent("otaku_vehicleshop:sendVehicles", -1, Vehicles)
	end
)

RegisterServerEvent("otaku_vehicleshop:setVehicleOwned")
AddEventHandler(
	"otaku_vehicleshop:setVehicleOwned",
	function(vehicleProps)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		MySQL.Async.execute(
			"INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename) VALUES (@owner, @plate, @vehicle, @vehiclename)",
			{
				["@owner"] = xPlayer.identifier,
				["@plate"] = vehicleProps.plate,
				["@vehicle"] = json.encode(vehicleProps),
				["@vehiclename"] = Vehicles[tostring(vehicleProps.model)].name
			},
			function(rowsChanged)
				TriggerClientEvent(
					"esx:showAdvancedNotification",
					_source,
					"Vehicle Registration",
					_U("vehicle_belongs", vehicleProps.plate),
					"fas fa-car",
					"green",
					3
				)
			end
		)
	end
)

RegisterServerEvent("otaku_vehicleshop:setVehicleOwnedPlayerId")
AddEventHandler(
	"otaku_vehicleshop:setVehicleOwnedPlayerId",
	function(playerId, vehicleProps)
		local xPlayer = ESX.GetPlayerFromId(playerId)

		MySQL.Async.execute(
			"INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename) VALUES (@owner, @plate, @vehicle, @vehiclename)",
			{
				["@owner"] = xPlayer.identifier,
				["@plate"] = vehicleProps.plate,
				["@vehicle"] = json.encode(vehicleProps),
				["@vehiclename"] = Vehicles[tostring(vehicleProps.model)].name
			},
			function(rowsChanged)
				TriggerClientEvent(
					"esx:showAdvancedNotification",
					playerId,
					"Vehicle Registration",
					_U("vehicle_belongs", vehicleProps.plate),
					"fas fa-car",
					"green",
					3
				)
			end
		)
	end
)

RegisterServerEvent("otaku_vehicleshop:addToList")
AddEventHandler(
	"otaku_vehicleshop:addToList",
	function(target, model, plate)
		local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)
		local dateNow = os.date("%Y-%m-%d %H:%M")

		if xPlayer.job.name ~= "cardealer" then
			print(("otaku_vehicleshop: %s attempted to add a sold vehicle to list!"):format(xPlayer.identifier))
			return
		end

		MySQL.Async.execute(
			"INSERT INTO vehicle_sold (client, model, plate, soldby, date) VALUES (@client, @model, @plate, @soldby, @date)",
			{
				["@client"] = xTarget.getName(),
				["@model"] = model,
				["@plate"] = plate,
				["@soldby"] = xPlayer.getName(),
				["@date"] = dateNow
			}
		)
	end
)

ESX.RegisterServerCallback(
	"otaku_vehicleshop:getCategories",
	function(source, cb)
		cb(Categories)
	end
)

ESX.RegisterServerCallback(
	"otaku_vehicleshop:getVehicles",
	function(source, cb)
		cb(Vehicles)
	end
)

ESX.RegisterServerCallback(
	"otaku_vehicleshop:buyVehicle",
	function(source, cb, vehicleModel)
		local xPlayer = ESX.GetPlayerFromId(source)
		local vehicleData = nil

		for k, v in pairs(Vehicles) do
			if v.model == vehicleModel then
				vehicleData = v
				break
			end
		end

		if not vehicleData.instore then -- SABS time.
		-- Place your automated banning system here, if you have one
		-- exports["sabs"]:banPlayer(source, "Exploiting #100 (" .. vehicleModel .. ")")
		end

		if xPlayer.getAccount("bank").money >= vehicleData.price then
			xPlayer.removeAccountMoney("bank", vehicleData.price)
			cb(true)
		else
			cb(false)
		end
	end
)

ESX.RegisterServerCallback(
	"otaku_vehicleshop:resellVehicle",
	function(source, cb, plate, model)
		local resellPrice = 0

		-- calculate the resell price
		for k, v in pairs(Vehicles) do
			if GetHashKey(v.model) == model then
				resellPrice = ESX.Math.Round(v.price / 100 * Config.ResellPercentage)
				break
			end
		end

		if resellPrice == 0 then
			print(("otaku_vehicleshop: %s attempted to sell an unknown vehicle!"):format(GetPlayerIdentifiers(source)[1]))
			cb(false)
		end

		local xPlayer = ESX.GetPlayerFromId(source)

		MySQL.Async.fetchAll(
			"SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate",
			{
				["@owner"] = xPlayer.identifier,
				["@plate"] = plate
			},
			function(result)
				if result[1] then -- does the owner match?
					local vehicle = json.decode(result[1].vehicle)
					if vehicle.model == model then
						if vehicle.plate == plate then
							xPlayer.addAccountMoney("bank", resellPrice)
							RemoveOwnedVehicle(plate)

							cb(true)
						else
							print(("otaku_vehicleshop: %s attempted to sell an vehicle with plate mismatch!"):format(xPlayer.identifier))
							cb(false)
						end
					else
						print(("otaku_vehicleshop: %s attempted to sell an vehicle with model mismatch!"):format(xPlayer.identifier))
						cb(false)
					end
				else
					cb(false)
				end
			end
		)
	end
)

ESX.RegisterServerCallback(
	"otaku_vehicleshop:isPlateTaken",
	function(source, cb, plate)
		MySQL.Async.fetchAll(
			"SELECT * FROM owned_vehicles WHERE plate = @plate",
			{
				["@plate"] = plate
			},
			function(result)
				cb(result[1] ~= nil)
			end
		)
	end
)
