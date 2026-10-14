local meta = FindMetaTable("Player")
util.AddNetworkString("gods_target")
function meta:GodUser(ply)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Slayed except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["goduser"]) then
        if not self.God then self.God = false end
        self.God = not self.God
        if self.God then
            self:GodEnable()
            net.Start("gods_target")
            net.WriteEntity(self)
            net.WriteBool(true)
            net.Broadcast()
        else
            self:GodDisable()
            net.Start("gods_target")
            net.WriteEntity(self)
            net.WriteBool(false)
            net.Broadcast()
        end

        local Godded = self.God and "God Enabled" or "God Disabled"
        local str = "[GmodX] " .. tostring(self:Nick()) .. " %s by Admin: %s!"
        print(Format(str, Godded, ply:Nick()))
        PrintMessage(HUD_PRINTTALK, Format(str, Godded, ply:Nick()))
    end
end

concommand.Add("gmodx_god", function(ply, cmd, args)
    local target = GarrysModx:FindPlayer(args[1])
    if target == nil then return end
    target:GodUser(ply)
end)