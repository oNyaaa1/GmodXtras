local lite = include("gmod_lib/core/server/sqlite.lua")
local meta = FindMetaTable("Player")
function GarrysModx:FindPlayer(name)
    for k, v in pairs(player.GetAll()) do
        local Correcto = v:Nick():lower():find(name:lower())
        if Correcto == 1 then
            --
            return v
        end
    end
    return NULL
end

function meta:SetUserTag(name, tag, admin, global)
    local person = GarrysModx:FindPlayer(name)
    if person == NULL then return end
    global = global or false
    local info = self:GetTags()
    local find_Str = string.find(info, tag)
    if not self:IsSuperAdmin() or tostring(find_Str) ~= "1" then return end
    if not isstring(tag) then return end
    lite:Insert(person, "gmodx_admin", "admin", tag)
    self.Tags = tag
    local str = Format("[AdminMatrix] Set Tags tag '%s' to %s by %s", tag, person:Nick(), admin)
    print(str)
    if global == true then
        PrintMessage(HUD_PRINTTALK, str)
    else
        self:ChatPrint(str)
    end
end

concommand.Add("gmodx_adduser", function(ply, cmd, args)
    --gmodx_adduser
    ply:SetUserTag(tostring(args[1]), tostring(args[2]), tostring(ply:Nick()), tobool(args[3]))
end)