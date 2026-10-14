local meta = FindMetaTable("Player")
local ListOfRagdolls = {}
function meta:RagdollUser(ply)
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being Slayed except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if ply:IsSuperAdmin() or string.find(ply:GetTags(), GarrysModx.AdminMatrix.Tags["ragdolluser"]) then
        if not self.RD_RagDoll then
            self.RD_RagDoll = false
            self.RD_lastPos = NULL
            self.RD_Weps = {}
            self.ents = NULL
        end

        self.RD_RagDoll = not self.RD_RagDoll
        ListOfRagdolls[self:SteamID64()] = true
        if self.RD_RagDoll then
            self.ents = ents.Create("prop_ragdoll")
            self.ents:SetModel(self:GetModel())
            self.ents:SetPos(self:GetPos())
            self.ents:Spawn()
            self.ents:Activate()
            self:Spectate(OBS_MODE_CHASE)
            self:SpectateEntity(self.ents)
            self.RD_lastPos = self:GetPos()
            for k, v in pairs(self:GetWeapons()) do
                self.RD_Weps[k] = v:GetClass()
            end

            self:StripWeapons()
        else
            self:Spawn()
            if self.RD_lastPos then self:SetPos(self.RD_lastPos) end
            for k, v in pairs(self.RD_Weps) do
                self:Give(v)
            end

            ply.ents:Remove()
        end

        local Godded = ply.RD_RagDoll and "Ragdoll Enabled" or "Ragdoll Disabled"
        local str = "[GmodX] " .. tostring(self:Nick()) .. " %s by Admin: %s!"
        print(Format(str, Godded, ply:Nick()))
        PrintMessage(HUD_PRINTTALK, Format(str, Godded, ply:Nick()))
    end
end

concommand.Add("gmodx_ragdoll", function(ply, cmd, args)
    local target = GarrysModx:FindPlayer(args[1])
    if target == nil then return end
    target:RagdollUser(ply)
end)

hook.Add("CanPlayerSuicide", "gmodx_ragdoll", function(ply) if ply.RD_RagDoll then return false end end)
hook.Add("PlayerDisconnected", "gmodx_ragdoll", function(ply) if ply.RD_RagDoll then ply.ents:Remove() end end)
hook.Add("PlayerInitialSpawn", "gmodx_ragdoll", function(ply)
    if IsValid(ply) and ply:IsFullyAuthenticated() and ListOfRagdolls[ply:SteamID64()] then ply.RD_RagDoll = true end
    timer.Simple(2, function()
        if IsValid(ply) and ply:IsFullyAuthenticated() and ListOfRagdolls[ply:SteamID64()] then
            if not ply.RD_RagDoll then
                ply.RD_RagDoll = false
                ply.RD_lastPos = NULL
                ply.RD_Weps = {}
                ply.ents = NULL
            end

            ply.RD_RagDoll = true
            ply.ents = ents.Create("prop_ragdoll")
            ply.ents:SetModel(ply:GetModel())
            ply.ents:SetPos(ply:GetPos())
            ply.ents:Spawn()
            ply.ents:Activate()
            ply:Spectate(OBS_MODE_CHASE)
            ply:SpectateEntity(ply.ents)
            ply.RD_lastPos = ply:GetPos()
            for k, v in pairs(ply:GetWeapons()) do
                ply.RD_Weps[k] = v:GetClass()
            end

            ply:StripWeapons()
        end
    end)
end)