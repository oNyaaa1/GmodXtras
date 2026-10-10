local lite = include("gmod_lib/core/server/sqlite.lua")
GarrysModx.AdminMatrix = GarrysModx.AdminMatrix or {}
local AdminMatrix = GarrysModx.AdminMatrix
AdminMatrix.Tags = {
    ["banuser"] = "b",
    ["kickuser"] = "b",
    ["adduser"] = "a",
}

hook.Add("InitPostEntity", "GMODXtrasAdmin", function() lite:CreateTable("gmodx_admin", "admin TEXT") end)
local function LoadPlayerTags(ply)
    if not IsValid(ply) then return end
    local info = lite:PlayerTbl(ply, "gmodx_admin")
    if info == nil then
        lite:Insert(ply, "gmodx_admin", "admin", "u")
        info = "u"
        local str = Format("[AdminMatrix] Added default tag 'u' to %s", ply:Nick())
        ply:ChatPrint(str)
        print(str)
    else
        local str = Format("[AdminMatrix] Has Tags tag '%s' to %s", info, ply:Nick())
        print(str)
        ply:ChatPrint(str)
    end

    ply:AddUserTag(info)
end

hook.Add("PlayerAuthed", "GMODXtrasAdminAuthenticated", function(ply) LoadPlayerTags(ply) end)
local meta = FindMetaTable("Player")
function meta:AddUserTag(tag)
    if not isstring(tag) then return end
    self.Tags = tag
end

function meta:GetTags()
    return tostring(self.Tags)
end