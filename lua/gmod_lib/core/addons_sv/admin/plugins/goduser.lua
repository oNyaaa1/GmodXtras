local meta = FindMetaTable("Player")
function meta:GodUser(ply)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Slayed except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if not ply.God then ply.God = false end
    ply.God = not ply.God
    if ply.God then
        self:GodEnable()
    else
        self:GodDisable()
    end

    local Godded = ply.God and "God Enabled" or "God Disabled"
    local str = "[GmodX] " .. tostring(self:Nick()) .. " %s by Admin: %s!"
    print(Format(str, Godded, ply:Nick()))
    PrintMessage(HUD_PRINTTALK, Format(str, Godded, ply:Nick()))
end

concommand.Add("gmodx_god", function(ply, cmd, args)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["slayuser"]) then
        local target = GarrysModx:FindPlayer(args[1])
        if target == nil then return end
        target:GodUser(ply)
    end
end)