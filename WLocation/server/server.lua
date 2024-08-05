ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('WayeLoc:RentCar')
AddEventHandler('WayeLoc:RentCar', function(label, name, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local getMoney = xPlayer.getAccount('money').money
    local getBank = xPlayer.getAccount('bank').money

    function BuySucess(accountType)
        xPlayer.removeAccountMoney(accountType, price)
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'Gérard', '~o~Location', 'Votre véhicule arrive !', nil, 8)
        Wait(3000)
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'Banque', 'Conseiler', 'Un prélèvement a été effectué sur votre compte pour une location !', nil, 8)
        TriggerClientEvent('WayeLoc:RentCarGood', _src, label, name, price)
    end

    if getMoney >= price then
        BuySucess('money')
    elseif getBank >= price then
        BuySucess('bank')
    else
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'Gérard', '~o~Location', 'Va chercher de l\'argent !', nil, 8)
    end

    print(getMoney..' - '..getBank)
end)