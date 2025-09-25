--######################################################################################
--#  _  _   ___   ___   ___   _      ___     _     _  _   _  __                   _    #
--# | \| | | __| | _ ) | __| | |    | _ )   /_\   | \| | | |/ /      _ _    ___  | |_  #
--# | .` | | _|  | _ \ | _|  | |__  | _ \  / _ \  | .` | | ' <   _  | ' \  / -_) |  _| #
--# |_|\_| |___| |___/ |___| |____| |___/ /_/ \_\ |_|\_| |_|\_\ (_) |_||_| \___|  \__| #
--#																					 #
--######################################################################################

local QBCore = exports['qb-core']:GetCoreObject()

local Keys = {
    ["H"] = 74, -- Magnet raus/rein
    ["E"] = 38  -- Magnet an/aus
}

local bobs = {
    GetHashKey("CARGOBOB"),
    GetHashKey("CARGOBOB2"),
    GetHashKey("CARGOBOB3"),
    GetHashKey("CARGOBOB4"),
}

local magnetVisible = false
local magnetPower = false
local attachedVehicle = nil
local playerJob = nil

-- Job Check
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local playerData = QBCore.Functions.GetPlayerData()
        if playerData and playerData.job then
            playerJob = playerData.job.name
        end
    end
end)

-- Steuerung
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsUsing(ped)

        if playerJob == "mechanic" then
            -- Haken ein/aus
            if IsControlJustPressed(1, Keys["H"]) then
                for i = 1, #bobs do
                    if IsVehicleModel(veh, bobs[i]) then
                        if not magnetVisible then
                            Citizen.InvokeNative(0x7BEB0C7A235F6F3B, veh, 1) -- Haken zeigen
                            magnetVisible = true
                            QBCore.Functions.Notify("Magnet ausgefahren", "success")
                        else
                            if attachedVehicle then
                                DetachEntity(attachedVehicle, true, true)
                                attachedVehicle = nil
                                magnetPower = false
                            end
                            Citizen.InvokeNative(0x9768CF648F54C804, veh) -- Haken entfernen
                            magnetVisible = false
                            QBCore.Functions.Notify("Magnet eingefahren", "error")
                        end
                    end
                end
            end

            -- Magnet AN/AUS mit E
            if IsControlJustPressed(1, Keys["E"]) and magnetVisible then
                if not magnetPower and attachedVehicle == nil then
                    local pos = GetEntityCoords(veh)
                    local foundVeh = GetClosestVehicle(pos.x, pos.y, pos.z - 5.0, 5.0, 0, 70)
                    if foundVeh and foundVeh ~= 0 then
                        AttachEntityToEntity(foundVeh, veh, GetEntityBoneIndexByName(veh, "hook_arm"),
                            0.0, 0.0, -5.0,
                            0.0, 0.0, 0.0,
                            true, true, false, false, 2, true)
                        attachedVehicle = foundVeh
                        magnetPower = true
                        QBCore.Functions.Notify("Fahrzeug angezogen", "primary")
                    else
                        QBCore.Functions.Notify("Kein Fahrzeug gefunden", "error")
                    end
                else
                    if attachedVehicle then
                        DetachEntity(attachedVehicle, true, true)
                        QBCore.Functions.Notify("Fahrzeug freigegeben", "primary")
                        attachedVehicle = nil
                    end
                    magnetPower = false
                end
            end
        end
    end
end)

-- Notfall-Entfernung per Befehl
RegisterCommand("removehook", function()
    local veh = GetVehiclePedIsUsing(PlayerPedId())
    if Citizen.InvokeNative(0x6E08BF5B3722BAC9, veh) or Citizen.InvokeNative(0x1821D91AD4B56108, veh) then
        local vehattached = Citizen.InvokeNative(0x873B82D42AC2B9E5, veh)
        Citizen.InvokeNative(0xADF7BE450512C12F, vehattached)
        Citizen.InvokeNative(0x9768CF648F54C804, veh)
        QBCore.Functions.Notify("Haken manuell entfernt", "error")
    end
end, false)
