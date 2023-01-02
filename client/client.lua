local prio1 = priocfg.PrioOne.Basic.DefaultStatus
local prio2 = priocfg.PrioTwo.Basic.DefaultStatus
local synced = false
local visible = true

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', priocfg.PrioOne.Commands.Command, 'Change the priority status for the ' .. priocfg.PrioOne.Basic.ZoneName, {{ name="Argument", help="" }})
    TriggerEvent('chat:addSuggestion', priocfg.PrioTwo.Commands.Command, 'Change the priority status for the ' .. priocfg.PrioTwo.Basic.ZoneName, {{ name="Argument", help="" }})
    if not synced then
        if NetworkIsSessionStarted() then
            TriggerServerEvent('Server:Request:Sync')
            synced = true
        end
    end
end)

RegisterNetEvent('Client:Sync')
AddEventHandler('Client:Sync', function(type, update)
    if type == 'prio1' then
        prio1 = update
    else
        prio2 = update
    end
end)

function DrawHud()
    Citizen.CreateThread(function()
        while visible do
            Draw(priocfg.PrioOne.Text.Prefix .. '' .. prio1, priocfg.PrioOne.Basic.Display_X, priocfg.PrioOne.Basic.Display_Y, priocfg.PrioOne.Basic.Scale, 4)
            Draw(priocfg.PrioTwo.Text.Prefix .. '' .. prio2, priocfg.PrioTwo.Basic.Display_X, priocfg.PrioTwo.Basic.Display_Y, priocfg.PrioTwo.Basic.Scale, 4)
            Citizen.Wait(0)
        end
        TerminateThisThread()
    end)
end

DrawHud()

RegisterCommand(priocfg.ToggleVisibility, function()
    visible = not visible
    DrawHud()
    TriggerEvent('chatMessage', '^3Info^0: Prio HUD toggled.')
end)

function Draw(text, x, y, scale, font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextOutline()
    SetTextJustification(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
