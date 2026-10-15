local function ChatSay(ply, text)
    local argz = string.Explode(" ", text)
    local txt = argz[1]
    if isfunction(GarrysModx.ChatSay[txt]) then
        GarrysModx.ChatSay[txt](ply, text)
        return ""
    end
end

local meta = FindMetaTable("Player")
function meta:PvPModeStatus()
    if self.PvPMode == nil then self.PvPMode = false end
    return self.PvPMode == true
end

hook.Add("PlayerSay", "GmodXChat", ChatSay)