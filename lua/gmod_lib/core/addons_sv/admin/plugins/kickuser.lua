local meta = FindMetaTable("Player")
function meta:KickUser(reason)
    if string.find(self:GetTags(), "z") then
        print("[GmodX] Immortal from being kicked")
        return
    end

    self:Kick(reason)
end

concommand.Add("gmodx_kick", function(ply, cmd, args)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["kickuser"]) then
        local target = GarrysModx:FindPlayer(args[1])
        if target == nil then return end
        target:KickUser(args[2])
    end
end)