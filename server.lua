----   ____    ____         ----
----  /\  _`\ /\  _`\       ----
----  \ \ \/\ \ \ \L\ \     ----
----   \ \ \ \ \ \ ,  /     ----
----    \ \ \_\ \ \ \\ \    ----
----     \ \____/\ \_\ \_\  ----
----      \/___/  \/_/\/ /  ----

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('dr:BuyGuns')
AddEventHandler('dr:BuyGuns', function(index)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = Config.Guns[index].price
    local getMoney = xPlayer.getMoney(price)
    if getMoney >= price then
        if Config.ESXInventory then
            local item = Config.Guns[index].item
            if Config.WeightSystem then
                if xPlayer.canCarryItem(item, 1) then
                    xPlayer.removeMoney(price)
                    xPlayer.addWeapon(item, 1)
                else
                    if Config.SendAlert then
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'turuncu', text = 'Üstün dolu.', length = 5000 })
                        return
                    else
                        TriggerClientEvent('mythic_notify:client:DoHudText', _source, { type = 'turuncu', text = 'Üstün dolu.', length = 5000 })
                        return
                    end
                end
            else
                xPlayer.removeMoney(price)
                xPlayer.addWeapon(item, 1)
            end
        else
            local item = string.upper(Config.Guns[index].item)
            if Config.WeightSystem then
                if xPlayer.canCarryItem(item, 1) then
                    xPlayer.removeMoney(price)
                    xPlayer.addInventoryItem(item, 1)
                else
                    if Config.SendAlert then
                        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'turuncu', text = 'Üstün dolu.', length = 5000 })
                        return
                    else
                        TriggerClientEvent('mythic_notify:client:DoHudText', _source, { type = 'turuncu', text = 'Üstün dolu.', length = 5000 })
                        return
                    end
                end
            else
                xPlayer.removeMoney(price)
                xPlayer.addInventoryItem(item, 1)
            end
        end
    else
        if Config.SendAlert then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Yeterli Paran Yok.', length = 5000 })
        else
            TriggerClientEvent('mythic_notify:client:DoHudText', _source, { type = 'error', text = 'Yeterli Paran Yok.', length = 5000 })
        end
    end
end)
