local sqlite = {}
sqlite.__index = sqlite
function sqlite:CreateTable(tblname, info)
    local query = string.format("CREATE TABLE IF NOT EXISTS %s (SteamID64 TEXT PRIMARY KEY, %s)", tblname, info)
    local result = sql.Query(query)
    if result == false then
        ErrorNoHalt("[SQLite] " .. sql.LastError() .. "\n")
        return false
    end
    return true
end

function sqlite:Insert(ply, tblname, column, value)
    if not IsValid(ply) then return false end
    local steamID64 = sql.SQLStr(ply:SteamID64())
    local escapedValue = sql.SQLStr(value)
    local query = string.format("INSERT OR REPLACE INTO %s (SteamID64, %s) VALUES (%s, %s)", tblname, column, steamID64, escapedValue)
    local result = sql.Query(query)
    if result == false then
        ErrorNoHalt("[SQLite] " .. sql.LastError() .. "\n")
        return false
    end
    return true
end

function sqlite:PlayerTbl(ply, tblname)
    if not IsValid(ply) then return nil end
    return sql.QueryValue(string.format("SELECT admin FROM %s WHERE SteamID64 = %s", tblname, sql.SQLStr(ply:SteamID64())))
end
return sqlite