local meta = FindMetaTable("Player")
function meta:KickUser(ply, reason)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being kicked!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["kickuser"]) then
        PrintMessage(HUD_PRINTTALK, Format("[GmodX] %s has kicked %s for reason %s", ply:Nick(), self:Nick(), reason ~= nil and reason or ""))
        self:Kick(reason)
    end
end

concommand.Add("gmodx_kick", function(ply, cmd, args)
    local target = GarrysModx:FindPlayer(args[1])
    if target == nil then return end
    target:KickUser(ply, args[2])
end)