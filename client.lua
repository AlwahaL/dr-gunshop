----   ____    ____         ----
----  /\  _`\ /\  _`\       ----
----  \ \ \/\ \ \ \L\ \     ----
----   \ \ \ \ \ \ ,  /     ----
----    \ \ \_\ \ \ \\ \    ----
----     \ \____/\ \_\ \_\  ----
----      \/___/  \/_/\/ /  ----


ESX = nil

local PlayerData = {}
local playerjob = "unemployed"
Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
	  end
	
	  while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
	end
	playerjob = ESX.GetPlayerData().job.name
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(response)
    playerjob = response.name
end)


CreateThread(function()
    Citizen.Wait(100)
    while true do
        local sleep = 4000
        local _source = source
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for i = 1, #Config.Coords, 1 do
            if Config.UseJob then
                if playerjob == Config.Job then
                    local xdxd = Config.Coords[i]
                    local dstCheck = GetDistanceBetweenCoords(pedCoords, xdxd.x, xdxd.y, xdxd.z, true)
                    if dstCheck <= 10.0 then
                        sleep = 5
                        if dstCheck <= 5.0 then
                            local text = "Gunshop"
                            local size = 1.7
                            if dstCheck <= 0.75 then
                                text = 'Silahcıya erişmek için [~b~E~w~] tuşuna bas'
                                size = 0.75
                                if IsControlJustPressed(0, 38) then
                                    OpenGunShopMenu()
                                end
                            end
                            ESX.Game.Utils.DrawText3D(xdxd,text,size)
                        end
                    end
                end
            else
                local xdxd = Config.Coords[i]
                local dstCheck = GetDistanceBetweenCoords(pedCoords, xdxd.x, xdxd.y, xdxd.z, true)
                if dstCheck <= 10.0 then
                    sleep = 5
                    if dstCheck <= 5.0 then
                        local text = "Gunshop"
                        local size = 1.7
                        if dstCheck <= 0.75 then
                            text = 'Silahcıya erişmek için [~b~E~w~] tuşuna bas'
                            size = 0.75
                            if IsControlJustPressed(0, 38) then
                                OpenGunShopMenu()
                            end
                        end
                        ESX.Game.Utils.DrawText3D(xdxd,text,size)
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)


function OpenGunShopMenu()
    local elements = {}

	for i = 1, #Config.Guns, 1 do
        table.insert(elements, {label = Config.Guns[i].Label..' : '..Config.Guns[i].price..' $', value = i})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'GunShop', {
		title    = 'Materyal',
		align    = 'top-right',
		elements = elements
    }, function(data, menu)
        TriggerServerEvent('dr:BuyGuns', data.current.value)
        menu.close()
	end, function(data, menu)
		menu.close()
    end)
end