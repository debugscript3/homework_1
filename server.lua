function onPlayerWantCreateVehicle(model)
    local player = client or source
    local px, py, pz = getElementPosition(player)
    local vehicle_data = getElementData(player, "temp_vehicle")

    if vehicle_data ~= false and isElement(vehicle_data) then destroyElement(vehicle_data) end

    local elem_vehicle = createVehicle(model, px, py+5, pz)
    setElementData(player, "temp_vehicle", elem_vehicle)
    setElementData(elem_vehicle, "is_temp", true)
end
addEvent("onPlayerWantCreateVehicle", true)
addEventHandler("onPlayerWantCreateVehicle", root, onPlayerWantCreateVehicle)

addEventHandler("onPlayerQuit", root, function()
	local vehicle_data = getElementData(source, "temp_vehicle")
    if vehicle_data ~= false and isElement(vehicle_data) then
        destroyElement(vehicle_data)
        setElementData(source, "temp_vehicle", false)
        return
    end
end)