local meta = FindMetaTable("Player")
function meta:SlapUser(ply, length)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Slapped except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    length = length or 5
    timer.Create("Gmodx_Slapping", 1, 0, function()
        local slapped = self:GetPos() + Vector(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
        self:SetEyeAngles(self:EyeAngles() - slapped:Angle())
        self:SetVelocity(slapped * self:GetUp() * -10)
    end)

    timer.Simple(length, function()
        timer.Remove("Gmodx_Slapping")
        self:SetEyeAngles(self:EyeAngles() + Angle(0, 0, 0))
    end)

    local str = "[GmodX] " .. tostring(self:Nick()) .. " slapped for %s second by Admin: %s!"
    print(Format(str, length, ply:Nick()))
    PrintMessage(HUD_PRINTTALK, Format(str, length, ply:Nick()))
end

concommand.Add("gmodx_slap", function(ply, cmd, args)
    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["slayuser"]) then
        local target = GarrysModx:FindPlayer(args[1])
        if target == nil then return end
        target:SlapUser(ply, args[2])
    end
end)