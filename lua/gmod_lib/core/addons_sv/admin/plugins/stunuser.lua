local meta = FindMetaTable("Player")
function meta:StunUser(ply, length)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Stunned except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["slayuser"]) then
        length = length or 5
        net.Start("GmodX_Unconcious")
        net.WriteFloat(1)
        net.Send(self)
        self.StunnedByAdmin = true
        timer.Simple(length, function()
            net.Start("GmodX_Unconcious")
            net.WriteFloat(0)
            net.Send(self)
            self.StunnedByAdmin = false
            self.Hits = 0
        end)

        local str = "[GmodX] " .. tostring(self:Nick()) .. " stunned for %s second by Admin: %s!"
        print(Format(str, length, ply:Nick()))
        PrintMessage(HUD_PRINTTALK, Format(str, length, ply:Nick()))
    end
end

concommand.Add("gmodx_stun", function(ply, cmd, args)
    local target = GarrysModx:FindPlayer(args[1])
    if target == nil then return end
    target:StunUser(ply, args[2])
end)