local meta = FindMetaTable("Player")
function meta:ArmorUser(ply, hp)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Stunned except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    hp = tonumber(hp) or 5
    self:SetArmor(self:Armor() + hp)
    local str = "[GmodX] " .. tostring(self:Nick()) .. " Armoured for %s now has " .. self:Armor() .. " by Admin: %s!"
    print(Format(str, ply:Nick(), self:Nick()))
    PrintMessage(HUD_PRINTTALK, Format(str, hp, ply:Nick()))
end

concommand.Add("gmodx_armor", function(ply, cmd, args)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["armoruser"]) then
        local target = GarrysModx:FindPlayer(args[1])
        if target == nil then return end
        target:ArmorUser(ply, args[2])
    end
end)