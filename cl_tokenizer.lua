local currenttoken = nil
function hObQlNRJwiz7h3KCeLeOTkmjo5ufdXDJDQS93wJ6lNA3zdP9BF(pEvent, ...)
    local payload = msgpack.pack({...})

    if payload:len() < 5000 then
        TriggerServerEventInternal(pEvent, payload, payload:len())
    else
        TriggerLatentServerEventInternal(pEvent, payload, payload:len(), 128000)
    end
end
RegisterNetEvent('T8BW2Fq7lG1XKBapgFYDjU1gE2sLqdjcz1cb2tLA965FgfXpB2'..GetCurrentResourceName())
AddEventHandler('T8BW2Fq7lG1XKBapgFYDjU1gE2sLqdjcz1cb2tLA965FgfXpB2'..GetCurrentResourceName(), function(receivedString)
    currenttoken = receivedString
end)
function ProHashingAlg(input)
    local hash = 0
    local prime = 31

    for i = 1, #input do
        local char = string.byte(input, i) + i
        hash = (hash * prime + char) % 1000000007
    end

    hash = (hash * 123456789) % 1000000007
    local hashStr = tostring(hash)

    while #hashStr < 19 do
        hashStr = hashStr .. string.sub(tostring(hash * prime), 1, 2)
        prime = prime + 1
    end

    return string.sub(hashStr, 1, 24)
end
function sTriggerServerEvent(eventName, ...)
    local args = {...}
    local eventArgs = {}
    for i = 1, #args do
        table.insert(eventArgs, args[i])
    end
    if table.includes(whitelist, eventName) then
        local oldtoken = currenttoken
        hObQlNRJwiz7h3KCeLeOTkmjo5ufdXDJDQS93wJ6lNA3zdP9BF('4C868m8XNbZWJuKnRT1LJpZSY27bwS27qH2JBM31RPtv01tBZ2'..GetCurrentResourceName())
        while oldtoken == currenttoken do
            Citizen.Wait(0)
        end
        table.insert(eventArgs, ProHashingAlg(tostring(currenttoken)))
    end
    hObQlNRJwiz7h3KCeLeOTkmjo5ufdXDJDQS93wJ6lNA3zdP9BF(eventName, table.unpack(eventArgs))
end
function table.includes(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end
TriggerServerEvent = function(eventName, ...)
    sTriggerServerEvent(eventName, ...)
end
