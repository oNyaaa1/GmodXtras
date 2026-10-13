local meta = FindMetaTable("Player")
function meta:SlayUser(ply)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Slayed except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    self:Kill()
    local str = "[GmodX] " .. tostring(self:Nick()) .. " slayed by Admin: %s!"
    print(Format(str, ply:Nick()))
    ply:ChatPrint(Format(str, ply:Nick()))
end

concommand.Add("gmodx_slay", function(ply, cmd, args)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["slayuser"]) then
        local target = GarrysModx:FindPlayer(args[1])
        if target == nil then return end
        target:SlayUser(ply)
    end
end)