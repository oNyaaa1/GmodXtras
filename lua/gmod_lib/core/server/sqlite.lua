local sqlite = {}
sqlite.__new = sqlite
function sqlite:CreateTable(tblname, info)
    sql.Query("CREATE TABLE IF NOT EXISTS " .. tblname .. " ( SteamID64 INTEGER PRIMARY KEY, " .. info .. " )")
end

function sqlite:Insert(tblname, info, info2)
    sql.Query("INSERT OR REPLACE INTO " .. tblname .. " ( SteamID64, " .. info .. " ) VALUES ( " .. ply:SteamID64() .. ", " .. info2 .. " )")
end

function sqlite:PlayerTbl(ply, tblname, info)
    return sql.QueryValue("SELECT  " .. info .. " FROM " .. tblname .. " WHERE SteamID64 = " .. ply:SteamID64())
end
return sqlite