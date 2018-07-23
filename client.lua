local ESX					= nil
local killer 			= nil
local weapon 			= nil
local killername 	= nil
local deadname 		= nil
local dna 				= {}
local weapons = {
	[-1569615261] = {name = 'WEAPON_UNARMED', hash = 2725352035, text = 'Knytnäve'},
	[-1716189206] = {name = 'WEAPON_KNIFE', hash = 2578778090, text = 'Kniv'},
	[1737195953]  = {name = 'WEAPON_NIGHTSTICK', hash = 1737195953, text = 'Batong'},
	[2508868239]  = {name = 'WEAPON_BAT', hash = 2508868239, text = 'Basebollträ'},
	[1317494643]  = {name = 'WEAPON_HAMMER', hash = 1317494643, text = 'Hammare'},
	[1141786504]  = {name = 'WEAPON_GOLFCLUB', hash =1141786504, text = 'Golfklubba'},
	[2227010557]  = {name = 'WEAPON_CROWBAR', hash =2227010557, text = 'Kofot'},
	[2460120199]  = {name = 'WEAPON_DAGGER', hash =2460120199, text = 'Dolk'},
	[3638508604]  = {name = 'WEAPON_KNUCKLE', hash =3638508604, text = 'Knogjärn'},
	[4191993645]  = {name = 'WEAPON_HATCHET', hash =4191993645, text = 'Yxa'},
	[3713923289]  = {name = 'WEAPON_MACHETE', hash =3713923289, text = 'Machete'},
	[3756226112]  = {name = 'WEAPON_SWITCHBLADE', hash =3756226112, text = 'Fickkniv'},
	[3441901897]  = {name = 'WEAPON_BATTLEAXE', hash =3441901897, text = 'Yxa'},
	[2484171525]  = {name = 'WEAPON_POOLCUE', hash =2484171525, text = 'Biljardkö'},
	[419712736]   = {name = 'WEAPON_WRENCH', hash =419712736, text = 'Skiftnyckel'}
}
local inMarker = false
local PlayerData = {}
local dnaOpen = false

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function notification(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Display marker, Enter/Exit events
Citizen.CreateThread(function ()
  while true do
    Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
			v = Config.Computer
	    if( v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos.x, v.Pos.y, v.Pos.z, true) < 50 ) then
	      DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
	    end
			if( v.Type ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x ) then
	      inMarker = true
				notification(v.Hint)
			else
				inMarker = false
	    end
		end
  end
end)

-- Key events
Citizen.CreateThread(function ()
  while true do
    Wait(0)
		if inMarker and IsControlJustReleased(0, 38) then
			SetNuiFocus(true, true)
			dnaOpen = true
			SendNUIMessage({
			  action = "open"
			})
		end
	end
end)

-- Remove DNA (empty the array)
RegisterNetEvent('jsfour-dna:remove')
AddEventHandler('jsfour-dna:remove', function()
	dna = {}
end)

-- Grab DNA from a player
RegisterNetEvent('jsfour-dna:get')
AddEventHandler('jsfour-dna:get', function( player )
	if dna.p == nil then
		local ped = GetPlayerPed(player)

		if IsPedFatallyInjured(ped) then
			killerped = GetPedSourceOfDeath(ped)
			killerid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killerped))
			killername = GetPlayerName(NetworkGetPlayerIndexFromPed(killerped))

			deadname = GetPlayerName(player)
			_weapon = GetPedCauseOfDeath(GetPlayerPed(player))

			for k, v in pairs(weapons) do
				if k == _weapon then
					weapon = v.text
				end
			end

			Citizen.Wait(1000)

			if weapon ~= nil then
				dna = {k = killerid, d = deadname, w = weapon, p = GetPlayerServerId(player)}
			else
				ESX.ShowNotification('Hittade inget spår av DNA..')
			end
		else
			dna = {k = nil, d = nil, w = nil, p = GetPlayerServerId(player)}
		end
	else
		ESX.ShowNotification('Du har redan ett DNA på dig, lämna in det först.')
	end
end)

-- Freeze ped if dna menu is open
Citizen.CreateThread(function()
  while true do
    if dnaOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisableControlAction(0, 24, active) -- Attack
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
    end
    Citizen.Wait(0)
  end
end)

-- Server callback
RegisterNetEvent('jsfour-dna:callback')
AddEventHandler('jsfour-dna:callback', function(_type, data, _type1, val)
	SendNUIMessage({
		action = _type,
		array = data,
		atype  = _type1,
		value = val
	})
	if data == 'upload-failed' then
		dna = {}
	end
end)

-- Javascript callbacks
--dna = {k = 1, d = 'Kurt', w = 'weapon', p = 1}
--dna = {k = nil, d = nil, w = nil, p = 1}
-- Upload DNA
RegisterNUICallback('upload', function(data, cb)
	if dna.p ~= nil then
		TriggerServerEvent('jsfour-dna:save', dna)
		dna = {}
	else
		SendNUIMessage({
			action = "callback",
			array = 'upload-fail'
		})
	end

	cb('ok')
end)

-- Fetch DNA
RegisterNUICallback('fetch', function(data, cb)
	TriggerServerEvent('jsfour-dna:fetch', data.type)
	cb('ok')
end)

-- Remove DNA
RegisterNUICallback('remove', function(data, cb)
	if data.name ~= nil then
		TriggerServerEvent('jsfour-dna:remove', 'name', data.name)
	elseif data.id ~= nil then
		TriggerServerEvent('jsfour-dna:remove', 'id', data.id)
	elseif data.match ~= nil then
		TriggerServerEvent('jsfour-dna:remove', 'match', data.match)
	end
	cb('ok')
end)

-- Try to match DNA
RegisterNUICallback('match', function(data, cb)
	TriggerServerEvent('jsfour-dna:match', data.id)
	cb('ok')
end)

-- Close DNA menu
RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
	dnaOpen = false
	cb('ok')
end)
