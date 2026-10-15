local meta = FindMetaTable("Player")
function meta:HealUser(ply, hp)
    if ply.OnWatchs then
        ply:ChatPrint("[GmodX] You're currently on watch")
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["healuser"]) then
        self:SetHealth(self:Health() + hp)
        if self:Health() <= 0 then self:Kill() end
        local str = "[GmodX] " .. tostring(self:Nick()) .. " Healed for %s now has " .. self:Health() .. " by Admin: %s!"
        print(Format(str, ply:Nick(), self:Nick()))
        PrintMessage(HUD_PRINTTALK, Format(str, hp, ply:Nick()))
    end
end

concommand.Add("gmodx_heal", function(ply, cmd, args)
    local target = GarrysModx:FindPlayer(args[1])
    if target == nil then return end
    target:HealUser(ply, args[2])
end)