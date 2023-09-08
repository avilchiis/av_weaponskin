local txd, duiObj, dui, tx = nil, nil, nil, nil

RegisterCommand(Config.Command, function()
    local hasWeapon = verifyWeapon()
    if hasWeapon then
        local input = lib.inputDialog('Weapon Skin', {
            {type = 'input', label = 'Image URL', description = 'Enter a valid image url'},
            {type = 'checkbox', label = 'Remove Current Skin'},
        })
        if input then
            if input[1] then
                txd = CreateRuntimeTxd(hasWeapon.name)
                duiObj = CreateDui(input[1], 250, 250)
                dui = GetDuiHandle(duiObj)
                tx = CreateRuntimeTextureFromDuiHandle(txd, "skin", dui)
                AddReplaceTexture(hasWeapon.ytd, hasWeapon.texture, hasWeapon.name, "skin")
            end
            if input[2] then
                if IsDuiAvailable(duiObj) then
                    DestroyDui(duiObj)
                    duiObj = nil
                end
                AddReplaceTexture(hasWeapon.ytd, hasWeapon.texture, hasWeapon.ytd, hasWeapon.texture)
            end
        end
    else
        lib.notify({
            title = 'Weapon Skin',
            description = "This weapon is not compatible",
            type = 'error'
        })
    end
end)

function verifyWeapon()
    local ped = PlayerPedId()
    local weaponhash = GetSelectedPedWeapon(ped)
    return Config.Weapons[tostring(weaponhash)]
end