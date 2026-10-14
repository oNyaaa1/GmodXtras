local lite = include("gmod_lib/core/server/sqlite.lua")
local meta = FindMetaTable("Player")
hook.Add("InitPostEntity", "GMODXtrasBanintegrety", function()
    if not file.IsDir("gmodx_banuser", "DATA") then file.CreateDir("gmodx_banuser") end
    if not file.Exists("gmodx_banuser/ban.txt", "DATA") then file.Write("gmodx_banuser/ban.txt", util.TableToJSON({}, true)) end
    game.ConsoleCommand("sv_hibernate_think 1\n")
end)

function GarrysModx:SpecialFind()
    return util.JSONToTable(file.Read("gmodx_banuser/ban.txt", "DATA"))
end

function UpdateBanList(sid)
    local tbl = GarrysModx:SpecialFind()
    local Timer = {}
    local name = ""
    for k, v in pairs(tbl) do
        if v.SteamID == sid then
            local Times = v.Time
            Times = Times - 1
            tbl[k] = {
                SteamID = sid,
                Time = Times,
                REASON = v.REASON,
                Nick = v.Nick
            }

            name = v.Nick
            if tonumber(Times) <= 0 then
                Timer[sid] = true
                table.remove(tbl, k)
            end
        end
    end

    if Timer[sid] then
        print("[GMODx] Unbanned Player " .. sid .. " Nick: " .. name)
        Timer[sid] = nil
    end

    file.Write("gmodx_banuser/ban.txt", util.TableToJSON(tbl, true))
end

timer.Create("UpdateUpdate", 60 * 5, 0, function() print("[GMODx] BanList: " .. #GarrysModx:SpecialFind()) end)
timer.Create("UpdateBanList", 5, 0, function()
    if #GarrysModx:SpecialFind() <= 0 then return end
    for k, v in pairs(GarrysModx:SpecialFind()) do
        UpdateBanList(v.SteamID)
    end
end)

function meta:BanUser(ply, sid, time, reason)
    local tbl = GarrysModx:SpecialFind()
    local alrbanned = false
    for k, v in pairs(tbl) do
        if v == sid then alrbanned = true end
    end

    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being banned!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if alrbanned == true then print("[GmodX] Already Banned") end
    table.insert(tbl, {
        SteamID = sid,
        Time = time,
        REASON = reason,
        Nick = sql.SQLStr(self:Nick())
    })

    PrintMessage(HUD_PRINTTALK, Format("%s is banned for %s \nTime Left: %s",self:Nick(), reason, tostring(string.FormattedTime(time, "Minutes:%02i Seconds:%02i"))))
    file.Write("gmodx_banuser/ban.txt", util.TableToJSON(tbl, true))
    self:Kick(reason .. "\nTime Left: " .. tostring(string.FormattedTime(time, "Minutes:%02i Seconds:%02i")))
end

concommand.Add("gmodx_banuser", function(ply, cmd, args)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["banuser"]) then
        local target = GarrysModx:FindPlayer(args[1])
        if target == nil then return end
        target:BanUser(ply, target:SteamID64(), args[2], args[3])
    end
end)

hook.Add("CheckPassword", "access_whitelist", function(steamID64)
    local tbl = GarrysModx:SpecialFind()
    local str = NULL
    local reason = NULL
    local length = 0
    for k, v in pairs(tbl) do
        if v.SteamID == steamID64 then
            str = v.SteamID
            reason = v.REASON
            length = v.Time
        end
    end

    if str ~= NULL and str then return false, "Dropped Reason: " .. reason .. "\nTime Left: " .. tostring(string.FormattedTime(length, "Minutes:%02i Seconds:%02i")) end
end)