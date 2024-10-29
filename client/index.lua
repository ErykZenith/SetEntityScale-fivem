local function SetEntityScale(entity, scaleX, scaleY, scaleZ)
    if GetEntityType(entity) == 1 then
        local attachedEntity = GetEntityAttachedTo(entity)
        if IsPedInAnyVehicle(entity, false) then
            entity = GetVehiclePedIsIn(entity, false)
        elseif DoesEntityExist(attachedEntity) then
            entity = attachedEntity
        end
    end

    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    rightVector = vector3(rightVector.x / #(rightVector), rightVector.y / #(rightVector), rightVector.z / #(rightVector))
    forwardVector = vector3(forwardVector.x / #(forwardVector), forwardVector.y / #(forwardVector), forwardVector.z / #(forwardVector))
    upVector = vector3(upVector.x / #(upVector), upVector.y / #(upVector), upVector.z / #(upVector))

    rightVector = {x = rightVector.x * scaleX, y = rightVector.y * scaleX, z = rightVector.z * scaleX}
    forwardVector = {x = forwardVector.x * scaleY, y = forwardVector.y * scaleY, z = forwardVector.z * scaleY}
    upVector = {x = upVector.x * scaleZ, y = upVector.y * scaleZ, z = upVector.z * scaleZ}

    if GetEntityType(entity) == 1 then
        local foundGround, groundZ = GetGroundZFor_3dCoord(position.x, position.y, position.z, true)
        if foundGround then
            position = vector3(position.x, position.y, groundZ + math.max(scaleX, scaleY, scaleZ))
        end
    end

    SetEntityMatrix(entity,
        rightVector.x, rightVector.y, rightVector.z,
        forwardVector.x, forwardVector.y, forwardVector.z,
        upVector.x, upVector.y, upVector.z,
        position.x, position.y, position.z
    )
end

CreateThread(function()
    while true do
        SetEntityScale(PlayerPedId(), 0.1, 0.1, 0.1)
        Wait(0)
    end
end)