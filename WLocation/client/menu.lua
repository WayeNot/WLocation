ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    while true do
        local interval = 500
        local posPlayer = GetEntityCoords(PlayerPedId())
        local point = WayeLocation.Pos[1].pos
        local dist = #(posPlayer-point)
        if dist <= 10.0 then
            DrawMarker(22, WayeLocation.Pos[1].pos, 0.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.7, 0.7, 0.7, 241, 90, 34, 1.0, true, true, 2, false, nil, nil, false)
            if dist <= 5.0 then
                Visual.Subtitle('Appuyer sur [~o~E~s~] pour accéder à la ~o~Location')
                if IsControlJustPressed(1, 51) then
                    OpenLocation()
                end
            end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(WayeLocation.Pos[1].pos)
    SetBlipSprite(blip, 225)
    SetBlipDisplay(blip, 2)
    SetBlipColour(blip, 17)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Supérette')
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    local Hash = GetHashKey(WayeLocation.Ped.Hash)
    local Pos = WayeLocation.Ped[1].pos
    local Heading = WayeLocation.Ped.Heading
    while not HasModelLoaded(Hash) do
    RequestModel(Hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", Hash, Pos, Heading, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)