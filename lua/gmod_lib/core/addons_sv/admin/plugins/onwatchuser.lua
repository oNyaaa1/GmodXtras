local meta = FindMetaTable("Player")
util.AddNetworkString("gmodx_writeerr")
function meta:OnWatch(ply)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["serv_rcon"]) then
        ply.OnWatchs = not ply.OnWatchs
        local str = "[GmodX] You're now on watch %s!"
        print(Format(str, ply.OnWatchs))
        ply:ChatPrint(Format(str, ply.OnWatchs))
    end
end

concommand.Add("gmodx_onwatch", function(ply, cmd, args) ply:OnWatch(ply, args[1]) end)
hook.Add("PlayerInitialSpawn", "AdminsTrust", function(ply) ply.OnWatchs = false end)