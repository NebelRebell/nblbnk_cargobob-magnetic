--[[
######################################################################################
#  _  _   ___   ___   ___   _      ___     _     _  _   _  __                   _    #
# | \| | | __| | _ ) | __| | |    | _ )   /_\   | \| | | |/ /      _ _    ___  | |_  #
# | .` | | _|  | _ \ | _|  | |__  | _ \  / _ \  | .` | | ' <   _  | ' \  / -_) |  _| #
# |_|\_| |___| |___/ |___| |____| |___/ /_/ \_\ |_|\_| |_|\_\ (_) |_||_| \___|  \__| #
######################################################################################
# # # # # # # # # # # # # # # # # # # # # # # # # # #
#    ___ _____  __  _    ___ ___   _   _____   __   #
#   | __/ __\ \/ / | |  | __/ __| /_\ / __\ \ / /   #
#   | _|\__ \>  <  | |__| _| (_ |/ _ \ (__ \ V /    #
#   |___|___/_/\_\ |____|___\___/_/ \_\___| |_|     #
#####################################################
]]--

---Key: https://docs.fivem.net/game-references/controls/
local Keys = {
	["ESC"] = 322, 		["F1"] = 288, 		["F2"] = 289, 		["F3"] = 170, 		["F5"] = 166, 
	["F6"] = 167, 		["F7"] = 168, 		["F8"] = 169, 		["F9"] = 56, 		["F10"] = 57,
	["~"] = 243, 		["1"] = 157, 		["2"] = 158, 		["3"] = 160, 		["4"] = 164, 
	["5"] = 165,		["6"] = 159, 		["7"] = 161, 		["8"] = 162, 		["9"] = 163, 
	["-"] = 84, 		["="] = 83, 		["TAB"] = 37,		["Q"] = 44, 		["W"] = 32, 
	["E"] = 38, 		["R"] = 45, 		["T"] = 245, 		["Y"] = 246, 		["U"] = 303, 
	["P"] = 199, 		["["] = 39, 		["]"] = 40, 		["ENTER"] = 18, 	["CAPS"] = 137, 
	["A"] = 34, 		["S"] = 8, 			["D"] = 9, 			["F"] = 23, 		["G"] = 47, 
	["H"] = 74, 		["K"] = 311, 		["L"] = 182, 		["LEFTSHIFT"] = 21, ["Z"] = 20, 
	["X"] = 73, 		["C"] = 26, 		["V"] = 0, 			["B"] = 29,			["N"] = 249, 
	["M"] = 244, 		[","] = 82, 		["."] = 81, 		["LEFTCTRL"] = 36, 	["LEFTALT"] = 19,
	["SPACE"] = 22,		["RIGHTCTRL"] = 70, ["HOME"] = 213, 	["PAGEUP"] = 10, 	["PAGEDOWN"] = 11,
	["DELETE"] = 178, 	["LEFT"] = 174,		["RIGHT"] = 175, 	["TOP"] = 27, 		["DOWN"] = 173, 
	["NENTER"] = 201, 	["N4"] = 108, 		["N5"] = 60, 		["N6"] = 107,		["BACKSPACE"] = 177,
	["N+"] = 96, 		["N-"] = 97, 		["N7"] = 117, 		["N8"] = 61, 		["N9"] = 118
}


local bobs = {
    GetHashKey("CARGOBOB"),
    GetHashKey("CARGOBOB2"),
    GetHashKey("CARGOBOB3"),
    GetHashKey("CARGOBOB4"),
}

local MAX_MAGNET_STRENGTH = 5000
local MAX_PULL_STRENGTH = 5000
local MAX_PullRopeLength = 1000

local magnetActive = false
local magnetPower = false

local playerJob = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000) -- Check job every 10 seconds.
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        if ESX then
            local playerData = ESX.GetPlayerData()
            if playerData and playerData.job then
                playerJob = playerData.job.name
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if playerJob == 'mechanic' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            if IsControlJustPressed(1, 74) then
                for i = 1, #bobs do
                    local rightveh = IsVehicleModel(veh, bobs[i])
                    if rightveh then
                        if not magnetActive then
                            Citizen.InvokeNative(0x7BEB0C7A235F6F3B, veh, 1)
                            Citizen.InvokeNative(0x9A665550F8DA349B, veh, false)
                            magnetActive = true
                        else
                            Citizen.InvokeNative(0x9A665550F8DA349B, veh, false)
                            Citizen.InvokeNative(0x9768CF648F54C804, veh)
                            magnetActive = false
                            magnetPower = false
                        end
                    end
                end
            elseif IsControlJustPressed(1, 36) and IsControlJustPressed(1, 38) and magnetActive then
                if not magnetPower then
                    Citizen.InvokeNative(0x9A665550F8DA349B, veh, true)
                    Citizen.InvokeNative(0xBCBFCD9D1DAC19E2, veh, MAX_MAGNET_STRENGTH)
                    Citizen.InvokeNative(0xA17BAD153B51547E, veh, MAX_MAGNET_STRENGTH)
                    Citizen.InvokeNative(0x685D5561680D088B, veh, MAX_MAGNET_STRENGTH)
                    Citizen.InvokeNative(0x6D8EAC07506291FB, veh, MAX_PullRopeLength)
                    Citizen.InvokeNative(0xED8286F71A819BAA, veh, MAX_PULL_STRENGTH)
                    
                    local attachedVeh = Citizen.InvokeNative(0x873B82D42AC2B9E5, veh)
                    if attachedVeh and attachedVeh ~= 0 then
                        Citizen.InvokeNative(0x89F149B6131E57DA, attachedVeh, false)
                    end
                    magnetPower = true
                else
                    Citizen.InvokeNative(0x9A665550F8DA349B, veh, false)
                    local attachedVeh = Citizen.InvokeNative(0x873B82D42AC2B9E5, veh)
                    if attachedVeh and attachedVeh ~= 0 then
                        Citizen.InvokeNative(0x89F149B6131E57DA, attachedVeh, true)
                    end
                    magnetPower = false
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if playerJob == 'mechanic' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            if IsControlPressed(0, 0xA0) and IsControlJustPressed(0, 0x4F) then
                if Citizen.InvokeNative(0x6E08BF5B3722BAC9, veh) or Citizen.InvokeNative(0x1821D91AD4B56108, veh) then
                    local vehattached = Citizen.InvokeNative(0x873B82D42AC2B9E5, veh)
                    Citizen.InvokeNative(0x9A665550F8DA349B, veh, false)
                    Citizen.InvokeNative(0xADF7BE450512C12F, vehattached)
                    Citizen.InvokeNative(0x9768CF648F54C804, veh)
                end
            end
        end
    end
end)
