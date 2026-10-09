local function ChatSay(ply, text)
    if ply.ChatCD == nil then ply.ChatCD = 0 end
    if ply.PvPMode == nil then ply.PvPMode = false end
    if GarrysModx.ChatSay[text] and ply.ChatCD <= CurTime() then
        ply.ChatCD = CurTime() + 30
        ply.PvPMode = not ply.PvPMode
        local status = ply.PvPMode == true and "Enabled PVP feel free to fight" or "Disabled"
        for k, v in pairs(player.GetAll()) do
            v:ChatPrint(tostring(v:Nick()) .. " Has PVP: " .. status)
        end
        return ""
    elseif GarrysModx.ChatSay[text] and ply.ChatCD > CurTime() then
        local time = ply.ChatCD - CurTime()
        ply:ChatPrint(Format("You need to wait %d seconds! for /pvp", time))
        return ""
    end
end

local meta = FindMetaTable("Player")
function meta:PvPModeStatus()
    if self.PvPMode == nil then self.PvPMode = false end
    return self.PvPMode == true
end

hook.Add("PlayerSay", "GmodXChat", ChatSay)