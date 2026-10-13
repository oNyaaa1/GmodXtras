local function ChatSay(ply, text)
    local argz = string.Explode(" ", text)
    if isfunction(GarrysModx.ChatSay[argz[1]]) then
        GarrysModx.ChatSay[argz[1]](ply, text)
        return ""
    end
end

local meta = FindMetaTable("Player")
function meta:PvPModeStatus()
    if self.PvPMode == nil then self.PvPMode = false end
    return self.PvPMode == true
end

hook.Add("PlayerSay", "GmodXChat", ChatSay)