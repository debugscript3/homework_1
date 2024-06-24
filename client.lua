ENGINE_STATE = false

addCommandHandler("veh", function(command, model)
    local WRONG_SYNTAX = "/veh <model>"

    if not model or not tonumber(model) then return outputChatBox(WRONG_SYNTAX, 255, 0, 0) end
    triggerServerEvent("onPlayerWantCreateVehicle", localPlayer, model)
end)

addEventHandler("onClientVehicleStartEnter", root, function(player,seat,door)
    local vehicle_type = getElementData(source, "is_temp")

    if (player == localPlayer) and (seat == 0) and (vehicle_type == true) then
        ENGINE_STATE = getVehicleEngineState(source)
        local player_data = getElementData(player, "temp_vehicle")
        if player_data ~= source then 
            outputChatBox("В автомобиль может сесть только владелец", 255, 0, 0)
            cancelEvent()
            return
        end
    end
end)

addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(source)
    local vehicle_type = getElementData(source, "is_temp")
    if vehicle_type ~= true then return end
    
    if ENGINE_STATE == true then
        setVehicleEngineState(source, true)
    else
        setVehicleEngineState(source, false)
        setVehicleOverrideLights(source, 1)
    end
end)

bindKey("e", "down", function()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then return end

    local vehicle_type = getElementData(vehicle, "is_temp")
    if vehicle_type ~= true then return end

    setVehicleEngineState(vehicle, not getVehicleEngineState(vehicle))
end)

bindKey("l", "down", function()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then return end

    local vehicle_type = getElementData(vehicle, "is_temp")
    if vehicle_type ~= true then return end

    if getVehicleOverrideLights(vehicle) ~= 2 then
        setVehicleOverrideLights(vehicle, 2)
    else
        setVehicleOverrideLights(vehicle, 1)
    end
end)

bindKey("lshift", "down", function()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then return end

    local vehicle_type = getElementData(vehicle, "is_temp")
    if vehicle_type ~= true then return end

    local x, y, z = getElementPosition(vehicle)
    local sx, sy, sz = getElementVelocity(vehicle)
    if sz ~= 0 then return end
    setElementPosition(vehicle, x, y, z + 1)
    
end)
