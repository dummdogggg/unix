local setclipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
local request = request or http_request or (http and http.request) or syn.request

local function getHWID()
    local response = request({Url = "https://kya.jvck.gg/return-headers"}).Body
    local decoded = game:GetService("HttpService"):JSONDecode(response)
    local hwid = nil

    for i, v in pairs(decoded) do
        local lowered = tostring(i):lower()

        if (string.find(lowered, "fingerprint") or string.find(lowered, "identifier")) and not (string.find(lowered, "user")) then
            hwid = v
            break
        end
    end

    return hwid
end

local function checkHWIDInJSONURL(hwid)
    local response = request({Url = "http://your-json-url.com"}).Body -- Replace with your JSON URL
    local decoded = game:GetService("HttpService"):JSONDecode(response)

    -- Check if HWID is in the JSON data
    for key, value in pairs(decoded) do
        if value == hwid then
            return true -- HWID found in JSON data
        end
    end

    return false -- HWID not found in JSON data
end

local hwid = getHWID()

if hwid then
    if not checkHWIDInJSONURL(hwid) then
        if not getgenv().hwidRETURN then
            setclipboard(hwid)
        end

        -- Now send the embed message to the webhook
        local username = game:GetService("Players").LocalPlayer.Name
        local displayName = game:GetService("Players").LocalPlayer.DisplayName
        local placeName = game:GetService("Workspace").Name -- Assuming you want the name of the current place
        local placeId = game.PlaceId
        local dateTime = os.date("%Y-%m-%d %H:%M:%S") -- Current date and time

        local webhookUrl = "https://discord.com/api/webhooks/1222518611672039524/kh6nZ3LElL-nWUn5SI8ap55X28L7w1Zgt-m5kn7ZRoaUHvRL9A8QgD1TfCdgUYtvrQBo" -- Replace this with your actual webhook URL

        local embed = {
            title = "HWID and User Information",
            fields = {
                {name = "HWID", value = hwid},
                {name = "Username", value = username},
                {name = "Display Name", value = displayName},
                {name = "Place Name", value = placeName},
                {name = "Place ID", value = placeId},
                {name = "Date and Time", value = dateTime}
            },
            color = 65280 -- Green color, you can change it as per your preference
        }

        request({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({embeds = {embed}})
        })
    end
end
