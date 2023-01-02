priocfg = {}

priocfg.ToggleVisibility = 'togglepriohud' -- toggles both prio status
priocfg.EnablePermissionChecking = false -- required to be set to true if you wish to utilise the 'AcePermission' fields below

priocfg.Reset = {
    ResetCommand = 'resetprio',
    AcePermission = 'staff'
}

priocfg.PrioOne = {
    Basic = {
        Display_X = 0.169, -- x screen position
        Display_Y = 0.910, -- y screen position
        Scale = 0.4, -- text size
        ZoneName = 'County', -- zone name for what the status is for
        DefaultStatus = '~g~Available', -- default status when the server restarts
        AcePermission = 'staff', -- permission to use all prio based commands in the section, 'priocfg.EnablePermissionChecking' must be set to true to use this perm check
        CooldownTimer = 20 -- cooldown timer that starts when the cooldown is activated
    },
    Text = {
        Prefix = '~c~County Priority Status~w~: ', -- this should explain itself
        AvailableText = '~g~Available',
        ActiveText = '~y~Active',
        HoldText = '~o~On Hold',
        CooldownText = '~r~Cooldown'
    },
    Commands = {
        Command = 'countyprio', -- prio based commands, an example argument would be /countyprio available
        Hold = 'hold',
        Available = 'available',
        Cooldown = 'cooldown',
        Active = 'start'
    }
}

priocfg.PrioTwo = {
    Basic = {
        Display_X = 0.169,
        Display_Y = 0.930,
        Scale = 0.4,
        ZoneName = 'City',
        DefaultStatus = '~g~Available',
        EnablePermChecking = false,
        AcePermission = 'staff',
        CooldownTimer = 20
    },
    Text = {
        Prefix = '~c~City Priority Status~w~: ',
        AvailableText = '~g~Available',
        ActiveText = '~y~Active',
        HoldText = '~o~On Hold',
        CooldownText = '~r~Cooldown'
    },
    Commands = {
        Command = 'cityprio',
        Hold = 'hold',
        Available = 'available',
        Cooldown = 'cooldown',
        Active = 'start'
    }
}

function Notify(msg) -- Chnage yo noti here
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0 },
        multiline = true,
        args = { "System", msg }
    })
end
