local QBCore = exports[SConfig.CoreName]:GetCoreObject()
local kick1 = false
local kick2 = false
RegisterNetEvent('NuiBlocker:KickPlayer', function()
    kick1 = true
    if not SConfig.BanPlayer then
        DropPlayer(source, SConfig.Rreason)
    else
        LogFunction(source)
        BanPlayerFromHere(source)
    end
end)
RegisterNetEvent('NuiBlocker:KickPlayer2', function()
    if not kick1 then
        kick2 = true
        if not SConfig.BanPlayer then
            DropPlayer(source, SConfig.Rreason)
        else
            LogFunction(source)
            BanPlayerFromHere(source)
        end
    end
end)
RegisterNetEvent('NuiBlocker:KickPlayer3', function()
    if not SConfig.BanPlayer then
        DropPlayer(source, SConfig.Rreason)
    else
        LogFunction2(source)
        BanPlayerFromHere(source)
    end
end)

function BanPlayerFromHere(source)
    local src = source
    MySQL.insert(
        'INSERT INTO bc_bans (name, license, discord, ip, fivem, hwd1, hwd2, hwd3, hwd4, hwd5, hwd6, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        {
            GetPlayerName(src),
            QBCore.Functions.GetIdentifier(src, 'license') or '',
            QBCore.Functions.GetIdentifier(src, 'discord') or '',
            QBCore.Functions.GetIdentifier(src, 'ip') or '',
            QBCore.Functions.GetIdentifier(src, 'fivem') or '',
            GetPlayerToken(src, 0) or '',
            GetPlayerToken(src, 1) or '',
            GetPlayerToken(src, 2) or '',
            GetPlayerToken(src, 3) or '',
            GetPlayerToken(src, 4) or '',
            GetPlayerToken(src, 5) or '',
            'WaveShield Ban : Player Suspicious',
            2147483647,
            'WaveShield'
        })
    DropPlayer(src, "WaveShield Ban : Player Suspicious")
end
exports('BanPlayer', BanPlayerFromHere)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local name = GetPlayerName(source)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local discord = QBCore.Functions.GetIdentifier(source, 'discord')
    local ip = QBCore.Functions.GetIdentifier(source, 'ip')
    local fivem = QBCore.Functions.GetIdentifier(source, 'fivem')
    local hwd1 = GetPlayerToken(source, 0)
    local hwd2 = GetPlayerToken(source, 1)
    local hwd3 = GetPlayerToken(source, 2)
    local hwd4 = GetPlayerToken(source, 3)
    local hwd5 = GetPlayerToken(source, 4)
    local hwd6 = GetPlayerToken(source, 5)
    local result = MySQL.Sync.fetchAll(
        'SELECT * FROM bc_bans WHERE name = @name OR license = @license OR discord = @discord OR ip = @ip OR fivem = @fivem OR hwd1 = @hwd1 OR hwd2 = @hwd2 OR hwd3 = @hwd3 OR hwd4 = @hwd4 OR hwd5 = @hwd5 OR hwd6 = @hwd6',
        {
            ['@name'] = name,
            ['@license'] = license,
            ['@discord'] = discord,
            ['@ip'] = ip,
            ['@fivem'] = fivem,
            ['@hwd1'] = hwd1,
            ['@hwd2'] = hwd2,
            ['@hwd3'] = hwd3,
            ['@hwd4'] = hwd4,
            ['@hwd5'] = hwd5,
            ['@hwd6'] = hwd6
        })
    if result[1] then
        local ban = result[1]
        local timeTable = os.date('*t', tonumber(ban.expire))
        if ban.expire > os.time() then
            deferrals.done('You have been banned from the server:\n' ..
                ban.reason ..
                '\nYour ban expires ' ..
                timeTable.day ..
                '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n')
        end
    end
end)

function LogFunction(src)
    local src = tonumber(src)
    local discord = QBCore.Functions.GetIdentifier(src, "discord") or "None"
    local name = GetPlayerName(src) or "None"
    local steam = QBCore.Functions.GetIdentifier(src, "steam") or "None"
    local ip = QBCore.Functions.GetIdentifier(src, "ip") or "None"
    local license = QBCore.Functions.GetIdentifier(src, "license") or "None"
    local xbl = QBCore.Functions.GetIdentifier(src, "xbl") or "None"
    local live = QBCore.Functions.GetIdentifier(src, "live") or "None"
    local fivem = QBCore.Functions.GetIdentifier(src, "fivem") or "None"
    local hwd1 = GetPlayerToken(src, 0) or "None"
    local hwd2 = GetPlayerToken(src, 1) or "None"
    local hwd3 = GetPlayerToken(src, 2) or "None"
    local hwd4 = GetPlayerToken(src, 3) or "None"
    local hwd5 = GetPlayerToken(src, 4) or "None"
    local hwd6 = GetPlayerToken(src, 5) or "None"
    local embed = {
        {
            ["color"] = 16711680,
            ["title"] = "UIRP NUI ANTICHEAT\nProper Ban",
            ["description"] = '```Steam Name: ' ..
            name ..
            '\nDiscord :' ..
            discord ..
            '\nSteam Hex :' ..
            steam ..
            '\nIP :' ..
            ip .. '\nLicense: ' .. license .. '\nXBL :' .. xbl .. '\nLive :' .. live .. '\nFivem :' ..
            fivem ..
            '\nHWD1 :' ..
            hwd1 .. '\nHWD2 :' .. hwd2 .. '\nHWD3 :' .. hwd3 .. '\nHWD4 :' .. hwd4 .. '\nHWD5 :' ..
            hwd5 .. '\nHWD6 :' .. hwd6 .. '```',
            ["footer"] = {
                ["text"] = "Made by Kishan",
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/992087042035027990/1196674102346399754/logo.8980558b.png?ex=65b87c9b&is=65a6079b&hm=11568f76eab5bd5df11c6e278399d17a1d71f5cdaf91e603a7923ebdf08795e2&',
            },
            ['author'] = {
                ['name'] = 'Made by Kishan',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/992087042035027990/1196674102346399754/logo.8980558b.png?ex=65b87c9b&is=65a6079b&hm=11568f76eab5bd5df11c6e278399d17a1d71f5cdaf91e603a7923ebdf08795e2&',
            },
        }
    }
    PerformHttpRequest(SConfig.LogWebhook, function(err, text, headers) end, 'POST',
        json.encode({ username = "UIRP NUI ANTICHEAT", embeds = embed, content = "@everyone"  }), { ['Content-Type'] = 'application/json' })
end
function LogFunction2(src)
    local src = tonumber(src)
    local discord = QBCore.Functions.GetIdentifier(src, "discord") or "None"
    local name = GetPlayerName(src) or "None"
    local steam = QBCore.Functions.GetIdentifier(src, "steam") or "None"
    local ip = QBCore.Functions.GetIdentifier(src, "ip") or "None"
    local license = QBCore.Functions.GetIdentifier(src, "license") or "None"
    local xbl = QBCore.Functions.GetIdentifier(src, "xbl") or "None"
    local live = QBCore.Functions.GetIdentifier(src, "live") or "None"
    local fivem = QBCore.Functions.GetIdentifier(src, "fivem") or "None"
    local hwd1 = GetPlayerToken(src, 0) or "None"
    local hwd2 = GetPlayerToken(src, 1) or "None"
    local hwd3 = GetPlayerToken(src, 2) or "None"
    local hwd4 = GetPlayerToken(src, 3) or "None"
    local hwd5 = GetPlayerToken(src, 4) or "None"
    local hwd6 = GetPlayerToken(src, 5) or "None"
    local embed = {
        {
            ["color"] = 16711680,
            ["title"] = "UIRP NUI ANTICHEAT\nURL Blocked",
            ["description"] = '```Steam Name: ' ..
            name ..
            '\nDiscord :' ..
            discord ..
            '\nSteam Hex :' ..
            steam ..
            '\nIP :' ..
            ip .. '\nLicense: ' .. license .. '\nXBL :' .. xbl .. '\nLive :' .. live .. '\nFivem :' ..
            fivem ..
            '\nHWD1 :' ..
            hwd1 .. '\nHWD2 :' .. hwd2 .. '\nHWD3 :' .. hwd3 .. '\nHWD4 :' .. hwd4 .. '\nHWD5 :' ..
            hwd5 .. '\nHWD6 :' .. hwd6 .. '```',
            ["footer"] = {
                ["text"] = "Made by Kishan",
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/992087042035027990/1196674102346399754/logo.8980558b.png?ex=65b87c9b&is=65a6079b&hm=11568f76eab5bd5df11c6e278399d17a1d71f5cdaf91e603a7923ebdf08795e2&',
            },
            ['author'] = {
                ['name'] = 'Made by Kishan',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/992087042035027990/1196674102346399754/logo.8980558b.png?ex=65b87c9b&is=65a6079b&hm=11568f76eab5bd5df11c6e278399d17a1d71f5cdaf91e603a7923ebdf08795e2&',
            },
        }
    }
    PerformHttpRequest(SConfig.LogWebhook, function(err, text, headers) end, 'POST',
        json.encode({ username = "UIRP NUI ANTICHEAT", embeds = embed, content = "@everyone" }), { ['Content-Type'] = 'application/json' })
end
