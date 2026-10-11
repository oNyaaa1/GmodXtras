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

function sqlite:Update(sid, tblname, column, value)
    local escapedValue = sql.SQLStr(tostring(value))
    local query = string.format("UPDATE %s SET %s = %s WHERE SteamID64 = %s", tblname, column, escapedValue, sid)
    local result = sql.Query(query)
    if result == false then
        ErrorNoHalt("[SQLite] " .. sql.LastError() .. "\n")
        return false
    end

    -- Insert a row if the player doesn't already exist.
    if sql.QueryValue(string.format("SELECT SteamID64 FROM %s WHERE SteamID64 = %s", tblname, sid)) == nil then
        query = string.format("INSERT INTO %s (SteamID64, %s) VALUES (%s, %s)", tblname, column, sid, escapedValue)
        result = sql.Query(query)
        if result == false then
            ErrorNoHalt("[SQLite] " .. sql.LastError() .. "\n")
            return false
        end
    end
    return true
end

function sqlite:PlayerTbl(ply, tblname)
    if not IsValid(ply) then return nil end
    return sql.QueryValue(string.format("SELECT * FROM %s WHERE SteamID64 = %s", tblname, sql.SQLStr(ply:SteamID64())))
end

function sqlite:PlayerTblSid(sid, tblname)
    return sql.QueryValue(string.format("SELECT * FROM %s WHERE SteamID64 = %s", tblname, sid))
end

return sqlite