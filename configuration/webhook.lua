Webhook = {}
Webhook["main"] = "https://discord.com/api/webhooks/1241724285349920859/bmgcnXHbl6kOFmmGuIu64j9zkKE6XM1VQdLEa8nHylAtWar0TyxJS9thfkROc9gUtNdf"

slyyCore.injectWebhook = function(id, value)
    Webhook[id] = value
end