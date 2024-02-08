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

RegisterNetEvent('4C868m8XNbZWJuKnRT1LJpZSY27bwS27qH2JBM31RPtv01tBZ2'..GetCurrentResourceName())
AddEventHandler('4C868m8XNbZWJuKnRT1LJpZSY27bwS27qH2JBM31RPtv01tBZ2'..GetCurrentResourceName(), function()
    local rockstarLicense = GetPlayerIdentifier(source, 0)
    local _source = source
    local result = MySQL.Sync.fetchAll('SELECT token FROM ProAntiHack123AnticheatHackAntiStopperHack WHERE rockstar_license = @license AND resource_name = @resource', {
        ['@license'] = rockstarLicense,
        ['@resource'] = GetCurrentResourceName()
    })
    if #result > 0 then
        TriggerClientEvent('T8BW2Fq7lG1XKBapgFYDjU1gE2sLqdjcz1cb2tLA965FgfXpB2'..GetCurrentResourceName(), _source, result[1].token)
    else
        local tokenInput = rockstarLicense .. GetCurrentResourceName()
        local newToken = ProHashingAlg(tostring(tokenInput))
        MySQL.Sync.execute('INSERT INTO ProAntiHack123AnticheatHackAntiStopperHack (rockstar_license, resource_name, token) VALUES (@license, @resource, @token)', {
            ['@license'] = rockstarLicense,
            ['@resource'] = GetCurrentResourceName(),
            ['@token'] = newToken
        })
        TriggerClientEvent('T8BW2Fq7lG1XKBapgFYDjU1gE2sLqdjcz1cb2tLA965FgfXpB2'..GetCurrentResourceName(), _source, newToken)
    end
end)

function verifyToken(source, hashedToken)
    local rockstarLicense = GetPlayerIdentifier(source, 0)
    local result = MySQL.Sync.fetchAll('SELECT token FROM ProAntiHack123AnticheatHackAntiStopperHack WHERE rockstar_license = @license AND resource_name = @resource', {
        ['@license'] = rockstarLicense,
        ['@resource'] = GetCurrentResourceName()
    })

    if #result > 0 then
        local rehashedToken = ProHashingAlg(tostring(result[1].token))
        if rehashedToken == hashedToken then
            MySQL.Sync.execute('UPDATE ProAntiHack123AnticheatHackAntiStopperHack SET token = @token WHERE rockstar_license = @license AND resource_name = @resource', {
                ['@license'] = rockstarLicense,
                ['@resource'] = GetCurrentResourceName(),
                ['@token'] = rehashedToken
            })
            return true
        else
            return false
        end
    else
        return false
    end
end

function sRegisterNetEvent(eventName, handler)
    RegisterNetEvent(eventName, function(...)
        local args = {...}
        local _source = source
        local argsStr = {}
        for _, arg in ipairs(args) do
            table.insert(argsStr, tostring(arg))
        end
        local token = #args > 0 and args[#args] or nil
        if _source ~= "" and _source then
            if not token or not verifyToken(_source, token) then  
                if GetPlayerIdentifier(_source, 0) then
                    print("Kicked " .. _source .. " for failing the token check (" .. GetPlayerIdentifier(_source, 0) .. ") | Event: " .. eventName .. " : " .. table.concat(argsStr, " "))
                    DropPlayer(_source, "Script integrity failed...")
                end
                return
            end
        end
        if not token == "" and not token == nil then
            table.remove(args, #args)
        end
        source = _source
        if handler then
        handler(table.unpack(args))
        end
    end)
end

--[[RegisterNetEvent = function(eventName, handler)
    sRegisterNetEvent(eventName, handler)
end]]
