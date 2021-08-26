local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("esx-Scrap:packageScrap")
AddEventHandler("esx-Scrap:packageScrap", function()
    local player = ESX.GetPlayerFromId(source)

    local currentScrap = player.getInventoryItem("SteelScrap")["count"]
    
    if currentScrap >= 10 then
        player.removeInventoryItem("SteelScrap", 10)
		TriggerClientEvent("esx-Scrap:packagePl", source)      
    else
        TriggerClientEvent("esx:showNotification", source, "You don't have enough Scrap to Package.")
    end
end)

RegisterServerEvent("esx-Scrap:sell")
AddEventHandler("esx-Scrap:sell", function()
    local player = ESX.GetPlayerFromId(source)
        player.addMoney(1200)
        TriggerClientEvent("esx:showNotification", source, "You got Paid $1200.")
end)
