local meta = FindMetaTable("Player")
util.AddNetworkString("gmodx_writeerr")
function meta:LuaRunConsole(ply, strrc)
    if ply.OnWatchs then
        ply:ChatPrint("[GmodX] You're currently on watch")
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["serv_rcon"]) then
        RunString(tostring(strrc))
        net.Start("gmodx_writeerr")
        net.WriteString(tostring(strrc))
        net.Send(ply)
        local str = "[GmodX] You ran %s!"
        print(Format(str, strrc))
        ply:ChatPrint(Format(str, strrc))
    end
end

concommand.Add("gmodx_lua", function(ply, cmd, args) ply:LuaRunConsole(ply, args[1]) end)