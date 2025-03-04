local webhookURL = "https://discord.com/api/webhooks/1346485414847844474/d-lClHW5w-mIp32WZjxMy5c8FUosFxwx-Qx4D2BuY3-N13JcaWMz0oMlG6pbEH4IQvNq"

local player = game:GetService("Players").LocalPlayer
local username = player.Name
local gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local gameName = gameInfo.Name
local gameIcon = string.format("https://www.roblox.com/Thumbs/Asset.ashx?width=512&height=512&assetId=%d", game.PlaceId)

local data = {
    ["embeds"] = {{
        ["title"] = "Webhook Triggered",
        ["description"] = string.format("Username: **%s**\nGame: **%s**", username, gameName),
        ["color"] = 0x3498db,
        ["image"] = {["url"] = gameIcon}
    }}
}

local json = game:GetService("HttpService"):JSONEncode(data)

request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
if request then
    request({
        Url = webhookURL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = json
    })
end
