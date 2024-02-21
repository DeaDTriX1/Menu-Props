ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


object = {}

function MenuProps()
    local MenuProps = RageUI.CreateMenu("Menu Props", "~b~Menu des différents Props.")
    local PropsSup = RageUI.CreateSubMenu(MenuProps, "", "Menu Supprésions Props")

    RageUI.Visible(MenuProps, not RageUI.Visible(MenuProps))
    while MenuProps do
        Citizen.Wait(0)


                RageUI.IsVisible(MenuProps, true, true, true, function()
                    local coords  = GetEntityCoords(PlayerPedId())

                RageUI.Separator("↓ Menu Props ↓")

                    RageUI.ButtonWithStyle("Supprésions Props", 'Liste des object déja spawn', {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    end, PropsSup)

                    RageUI.ButtonWithStyle("Personnalisée", 'Fait spawn un object de ton choix', {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        local personalise = KeyboardInput("Quelle Props ?", '' , '', 8)
                            SpawnObj(personalise)
                            ESX.ShowNotification('Vous avez fait spawn un props' ..personalise)
                        end
                    end)

                    RageUI.Separator('')
                    RageUI.Separator('↓ Props Définit ↓')
                    RageUI.Separator('')

                        for _, v in pairs (Config.Props) do
                            RageUI.ButtonWithStyle(v.nameprops, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local timer = 1500
                                    local _src = source
                                    SpawnObj(v.modelprops)
                                    local nameprops = v.nameprops
                                    ExecuteCommand("e pickup")
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    Wait(timer)
                                    ClearPedTasks(PlayerPedId())
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    ESX.ShowNotification('Vous avez fait spawn : ' ..nameprops)
                                end
                            end)
                        end

                end, function() 
                end)

                RageUI.IsVisible(PropsSup, true, true, true, function()

                    for k,v in pairs(object) do
                        if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                        RageUI.ButtonWithStyle("Object: "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                local entity = NetworkGetEntityFromNetworkId(v)
                                local ObjCoords = GetEntityCoords(entity)
                                DrawMarker(0, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                            end
                            if Selected then
                                RemoveObj(v, k)
                            end
                        end)
                    end
            
                end, function()
                end)

                if not RageUI.Visible(MenuProps) and not RageUI.Visible(PropsSup) then
                    MenuProps = RMenu:DeleteType("", true)
        end
    end
end

Keys.Register(Config.Touche, 'Props', 'Ouvrir le menu Props', function()
    ESX.TriggerServerCallback("Menu-Props:getUsergroup",function(group)
        if Restrein then
            if (group) == Group.Authorize1  or (group) == Group.Authorize2 or (group) == Group.Authorize3 or (group) == Group.Authorize4 or (group) == Group.Authorize5 then
    	       MenuProps()
            end
        else
            if ActiveMenu then
                MenuProps()
            end
        end
    end)
end)
