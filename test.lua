local webhookURL = "https://discord.com/api/webhooks/1346416926246830125/pg2nsLOVvJYOvjLmDwvYvti9zknqfwz7KO5qTsPA1Q-vwt1YziX6IUH4FhPkOwIu78ht"

local player = game:GetService("Players").LocalPlayer
local username = player.Name
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local gameIcon = string.format("https://www.roblox.com/Thumbs/Asset.ashx?width=512&height=512&assetId=%d", game.PlaceId)

local data = {
    ["embeds"] = {{
        ["title"] = "Webhook Triggered",
        ["description"] = string.format("Username: **%s**\nGame: **%s**", username, gameName),
        ["color"] = 0x3498db,
        ["thumbnail"] = {["url"] = gameIcon}
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
