local meta = FindMetaTable("Player")
function meta:SlayUser(ply)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Slayed except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["slayuser"]) then
        self:Kill()
        local str = "[GmodX] " .. tostring(self:Nick()) .. " slayed by Admin: %s!"
        print(Format(str, ply:Nick()))
        PrintMessage(HUD_PRINTTALK, Format(str, ply:Nick()))
    end
end

concommand.Add("gmodx_slay", function(ply, cmd, args)
    local target = GarrysModx:FindPlayer(args[1])
    if target == nil then return end
    target:SlayUser(ply)
end)