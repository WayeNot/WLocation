ESX = exports['es_extended']:getSharedObject()

local WayeLoc = RageUI.CreateMenu('Location', 'Intéraction ..')

WayeLoc.Closed = function()
    OpenMenu = false
end

function OpenLocation()
    if OpenMenu then
        RageUI.Visible(WayeLoc, false)
        OpenMenu = false
        return
    else
        RageUI.Visible(WayeLoc, true)
        OpenMenu = true
            CreateThread(function()
            while OpenMenu do
                RageUI.IsVisible(WayeLoc, function()
                    local PedVeh = GetVehiclePedIsIn(PlayerPedId(), false)
                    local PedInVeh = IsPedSittingInVehicle(PlayerPedId(), PedVeh)

                    RageUI.Separator('~l~↓ ~o~Location de véhicules ~l~↓')

                    for k,v in pairs(WayeVeh.Veh) do
                        RageUI.Button(v.label, nil, {RightLabel = v.price..'~r~$'},true, {
                            onSelected = function()
                                TriggerServerEvent('WayeLoc:RentCar', v.label, v.name, v.price)
                                RageUI.CloseAll()
                            end
                        })
                    end

                    if PedInVeh then
                        RageUI.Line()

                        RageUI.Button('Rendre la location', nil, {RightLabel = '~l~→→'},true, {
                            onSelected = function()
                                ESX.Game.DeleteVehicle(PedVeh)
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end

RegisterNetEvent('WayeLoc:RentCarGood')
AddEventHandler('WayeLoc:RentCarGood', function(label, name, price)
    local ModelHash = name
    local spawnPoint = WayeLocation.SpawnVeh[1].pos
    local spawnHeading = WayeLocation.SpawnVeh.Heading
    RequestModel(ModelHash)
    while not HasModelLoaded(ModelHash) do
        Wait(10)
    end

    local ped = PlayerPedId()
    local veh = CreateVehicle(ModelHash, spawnPoint, spawnHeading, true, false)
    TaskWarpPedIntoVehicle(ped, veh, -1)
    SetVehicleNumberPlateText(veh, 'Location')
end)