local svprio1 = priocfg.PrioOne.Basic.DefaultStatus
local svprio2 = priocfg.PrioTwo.Basic.DefaultStatus
local cooldown1 = 0
local cooldown2 = 0

RegisterNetEvent('Server:Request:Sync')
AddEventHandler('Server:Request:Sync', function()
    local src = source
    TriggerClientEvent('Client:Sync', src, 'prio1', svprio1)
    TriggerClientEvent('Client:Sync', src, 'prio2', svprio2)
end)

function Cooldown1()
    if cooldown1 ~= 0 then
        while cooldown1 > 0 do
            svprio1 = priocfg.PrioOne.Text.CooldownText .. ' (' .. cooldown1 .. ' Mins)'
            TriggerClientEvent('Client:Sync', -1, 'prio1', svprio1)
            cooldown1 = cooldown1 - 1;
            Citizen.Wait(60 * 1000)
        end
    end
    if cooldown1 == 0 then
        svprio1 = priocfg.PrioOne.Text.AvailableText
        TriggerClientEvent('Client:Sync', -1, 'prio1', svprio1)
    end
end

function Cooldown2()
    if cooldown2 ~= 0 then
        while cooldown2 > 0 do
            svprio2 = priocfg.PrioTwo.Text.CooldownText .. ' (' .. cooldown2 .. ' Mins)'
            TriggerClientEvent('Client:Sync', -1, 'prio2', svprio2)
            cooldown2 = cooldown2 - 1;
            Citizen.Wait(60 * 1000)
        end
    end
    if cooldown2 == 0 then
        svprio2 = priocfg.PrioTwo.Text.AvailableText
        TriggerClientEvent('Client:Sync', -1, 'prio2', svprio2)
    end
end

RegisterCommand(priocfg.Reset.ResetCommand, function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, priocfg.Reset.AcePermission) then
        svprio1 = priocfg.PrioOne.Basic.DefaultStatus
        svprio2 = priocfg.PrioTwo.Basic.DefaultStatus
        Notify(GetPlayerName(source) .. ' has reset priority statuses.')
    else
        TriggerClientEvent('chatMessage', source, '^1Invalid Permissions.')
    end
end)


RegisterCommand(priocfg.PrioOne.Commands.Command, function(source, args, rawCommand)
    local src = source
    if CheckPemrs(src, priocfg.PrioOne.Basic.AcePermission) then
        if args[1] == priocfg.PrioOne.Commands.Hold then
            svprio1 = priocfg.PrioOne.Text.HoldText
            TriggerClientEvent('Client:Sync', -1, 'prio1', svprio1)
        elseif args[1] == priocfg.PrioOne.Commands.Available then
            svprio1 = priocfg.PrioOne.Text.AvailableText
            TriggerClientEvent('Client:Sync', -1, 'prio1', svprio1)
        elseif args[1] == priocfg.PrioOne.Commands.Active then
            svprio1 = priocfg.PrioOne.Text.ActiveText .. ' (#' .. source .. ')'
            TriggerClientEvent('Client:Sync', -1, 'prio1', svprio1)
        elseif args[1] == priocfg.PrioOne.Commands.Cooldown then
            cooldown1 = priocfg.PrioOne.Basic.CooldownTimer
            Cooldown1()
        else
            TriggerClientEvent('chatMessage', src, '^1Invalid Argument.')
            return
        end
    else
        TriggerClientEvent('chatMessage', src, '^1Invalid Permissions.')
        return
    end
    Notify('The priority status for the ' .. priocfg.PrioOne.Basic.ZoneName .. ' has been changed to ' .. svprio1 .. '.')
end)

RegisterCommand(priocfg.PrioTwo.Commands.Command, function(source, args, rawCommand)
    local src = source
    if CheckPemrs(src, priocfg.PrioTwo.Basic.AcePermission) then
        if args[1] == priocfg.PrioTwo.Commands.Hold then
            svprio2 = priocfg.PrioTwo.Text.HoldText
            TriggerClientEvent('Client:Sync', -1, 'prio2', svprio2)
        elseif args[1] == priocfg.PrioTwo.Commands.Available then
            svprio2 = priocfg.PrioTwo.Text.AvailableText
            TriggerClientEvent('Client:Sync', -1, 'prio2', svprio2)
        elseif args[1] == priocfg.PrioTwo.Commands.Active then
            svprio2 = priocfg.PrioTwo.Text.ActiveText .. ' (#' .. source .. ')'
            TriggerClientEvent('Client:Sync', -1, 'prio2', svprio2)
        elseif args[1] == priocfg.PrioTwo.Commands.Cooldown then
            cooldown2 = priocfg.PrioTwo.Basic.CooldownTimer
            Cooldown2()
        else
            TriggerClientEvent('chatMessage', src, '^1Invalid Argument.')
            return
        end
    else
        TriggerClientEvent('chatMessage', src, '^1Invalid Permissions.')
        return
    end
    Notify('The priority status for the ' .. priocfg.PrioTwo.Basic.ZoneName .. ' has been changed to ' .. svprio2 .. '.')
end)

function CheckPemrs(source, perm)
    local result = false
    if not priocfg.EnablePermissionChecking then
        result = true
    else
        if IsPlayerAceAllowed(source, perm) then
            result = true
        end
    end
    return result
end
