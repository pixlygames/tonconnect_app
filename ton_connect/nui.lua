local ui = false

RegisterCommand('showuitest', function()
    ui = not ui
    if ui then
        SendNUIMessage({ showUI = true }) -- Sends a message to the js file.
        SetNuiFocus(true, true) -- Enables NUI focus
    else
        SendNUIMessage({ showUI = false }) -- Sends a message to the js file.
        SetNuiFocus(false, false) -- Disables NUI focus
    end
end)

RegisterKeyMapping('showuitest', 'Opens the UI', 'keyboard', 'F12') -- Keymapping allows players to rebind if they want.

RegisterNUICallback('enableNuiFocus', function(data, cb)
    if data.enable then
        SetNuiFocus(true, true)
    else
        SetNuiFocus(false, false)
    end
    cb('ok')
end)
