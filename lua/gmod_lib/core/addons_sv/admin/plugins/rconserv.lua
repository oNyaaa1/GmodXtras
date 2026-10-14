local meta = FindMetaTable("Player")
function meta:RconConsole(ply, strrc)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["serv_rcon"]) then
        game.ConsoleCommand(tostring(strrc) .. "\n")
        local str = "[GmodX] You ran %s!"
        print(Format(str, strrc))
        ply:ChatPrint(Format(str, strrc))
    end
end

concommand.Add("gmodx_rcon", function(ply, cmd, args) ply:RconConsole(ply, args[1]) end)