ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('esx_scrap:getItem')
AddEventHandler('esx_scrap:getItem', function()
local player = ESX.GetPlayerFromId(source)
    local luck = math.random(1, 3)

    if luck == 1 then

        player.addInventoryItem('SteelScrap', math.random(1,2))
		TriggerClientEvent('esx:showNotification', source, "You found Scrap Metal!")

    elseif luck == 2 then

        player.addInventoryItem('SteelScrap', math.random(3,5))
		TriggerClientEvent('esx:showNotification', source, "You found Scrap Metal!")
    else
		TriggerClientEvent('esx:showNotification', source, "You didnt find any Scrap Metal?")
    end
end)