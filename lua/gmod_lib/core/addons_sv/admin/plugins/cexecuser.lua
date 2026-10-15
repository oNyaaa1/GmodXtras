local meta = FindMetaTable("Player")
util.AddNetworkString("gmodx_Weirdge")
function meta:cexecUser(ply, reason)
    if ply.OnWatchs then
        ply:ChatPrint("[GmodX] You're currently on watch")
        return
    end

    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being cexec!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["cexecuser"]) then
        PrintMessage(HUD_PRINTTALK, Format("[GmodX] %s has cexec %s for %s", ply:Nick(), self:Nick(), reason ~= nil and reason or ""))
        self:ConCommand(tostring(reason))
    end
end

concommand.Add("gmodx_cexec", function(ply, cmd, args)
    local target = GarrysModx:FindPlayer(args[1])
    if target == nil then return end
    target:cexecUser(ply, args[2])
end)