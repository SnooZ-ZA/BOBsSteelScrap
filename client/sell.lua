ESX                           = nil

local cachedBins = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(5)
    end
end)

local blips = {
      {title="Sell Scrap Metal", colour=4, id=467, x = -448.70, y = -1687.48, z = 18.51}  
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

local scraploc = {
    {x = -448.70, y = -1687.48, z = 18.51}
}
local sellscraploc = {
    {x = -443.61, y = -1666.66, z = 18.53}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(scraploc) do
            DrawMarker(27, scraploc[k].x, scraploc[k].y, scraploc[k].z, 0, 0, 0, 0, 0, 0, 1.600, 1.600, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(sellscraploc) do
            DrawMarker(27, sellscraploc[k].x, sellscraploc[k].y, sellscraploc[k].z, 0, 0, 0, 0, 0, 0, 1.600, 1.600, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(scraploc) do
		
            local plyrecCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local recdist = Vdist(plyrecCoords.x, plyrecCoords.y, plyrecCoords.z, scraploc[k].x, scraploc[k].y, scraploc[k].z)
			
            if recdist <= 1.5 then
				drawText3D(scraploc[k].x, scraploc[k].y, scraploc[k].z + 1.0, '[E] ~b~Package Scrap Here~s~')
				
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("esx-Scrap:packageScrap")
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(sellscraploc) do
		
            local plyrecCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local recSelldist = Vdist(plyrecCoords.x, plyrecCoords.y, plyrecCoords.z, sellscraploc[k].x, sellscraploc[k].y, sellscraploc[k].z)
			
            if recSelldist <= 1.5 then
				drawText3D(sellscraploc[k].x, sellscraploc[k].y, sellscraploc[k].z + 1.0, '[E] ~b~Unpack Trolley Here~s~')
				
				if IsControlJustPressed(0, 38) then
					TriggerEvent("esx-Scrap:box")
				end			
            end
        end
    end
end)



RegisterNetEvent("esx-Scrap:packagePl")
AddEventHandler("esx-Scrap:packagePl",function()
		Citizen.Wait(10)
					exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 10000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "Packaging",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
					Citizen.Wait(10000)
					ClearPedTasks(PlayerPedId())
					Citizen.Wait(300)
					RequestAnimDict("anim@heists@box_carry@")
					while not HasAnimDictLoaded("anim@heists@box_carry@") do
					Citizen.Wait(1)
					end
					TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",1.0, -1.0, -1, 49, 0, 0, 0, 0)
					Citizen.Wait(300)
						attachModel = GetHashKey('prop_rub_trolley03a')
						boneNumber = 28422
						SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
						local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
						RequestModel(attachModel)
							while not HasModelLoaded(attachModel) do
								Citizen.Wait(100)
							end
							attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
							AttachEntityToEntity(attachedProp, GetPlayerPed(-1), bone, 0.0, -0.25, -0.70, 0.0, 10.0, -90.0, 1, 1, 0, 0, 2, 1)
							ESX.ShowNotification("Push the Trolley to storage!")
end)


RegisterNetEvent("esx-Scrap:box")
AddEventHandler("esx-Scrap:box",function()
	if DoesEntityExist(attachedProp) then
		Citizen.Wait(10)
					exports.rprogress:Custom({
								Async = true,
								x = 0.5,
								y = 0.5,
								From = 0,
								To = 100,
								Duration = 3000,
								Radius = 60,
								Stroke = 10,
								MaxAngle = 360,
								Rotation = 0,
								Easing = "easeLinear",
								Label = "Unpacking",
								LabelPosition = "right",
								Color = "rgba(255, 255, 255, 1.0)",
								BGColor = "rgba(107, 109, 110, 0.95)",
								Animation = {
								scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
								--animationDictionary = "missheistfbisetup1", -- https://alexguirre.github.io/animations-list/
								--animationName = "unlock_loop_janitor",
								},
								DisableControls = {
								Mouse = false,
								Player = true,
								Vehicle = true
								},
								})
					Citizen.Wait(3000)
					ClearPedTasks(PlayerPedId())
					RemoveAnimDict("anim@heists@box_carry@")
					DeleteEntity(attachedProp)
					TriggerServerEvent("esx-Scrap:sell")
		else
		ESX.ShowNotification("Go Package First!")
		end
end)