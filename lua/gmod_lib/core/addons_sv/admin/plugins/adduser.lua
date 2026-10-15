local lite = include("gmod_lib/core/server/sqlite.lua")
local meta = FindMetaTable("Player")
function GarrysModx:FindPlayer(name)
    for k, v in pairs(player.GetAll()) do
        if not isstring(name) then return nil end
        local Correcto = v:Nick():lower():find(name:lower())
        if Correcto == 1 then
            --
            return v
        end
    end
    return NULL
end

function meta:SetUserTag(ply, name, tag, admin, global)
    if ply.OnWatchs then
        ply:ChatPrint("[GmodX] You're currently on watch")
        return
    end

    global = global or false
    if string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["immunity"]) and ply ~= self then
        local str = "[GmodX] " .. tostring(self:Nick()) .. " is Immortal from being SetUserTagged except themselfs!"
        print(str)
        ply:ChatPrint(str)
        return
    end

    if self:IsSuperAdmin() or string.find(self:GetTags(), GarrysModx.AdminMatrix.Tags["adduser"]) then
        if not isstring(tag) then return end
        local person = GarrysModx:FindPlayer(name:lower())
        if person == NULL then return end
        lite:Insert(person, "gmodx_admin", "admin", tag)
        person:AddUserTag(tag)
        local str = Format("[GmodX] Set Admin Tags tag '%s' to %s by Admin: %s", tag, person:Nick(), admin)
        print(str)
        if global == true then
            PrintMessage(HUD_PRINTTALK, str)
        else
            person:ChatPrint(str)
        end
    end
end

concommand.Add("gmodx_adduser", function(ply, cmd, args)
    --gmodx_adduser
    ply:SetUserTag(ply, tostring(args[1]), tostring(args[2]), tostring(ply:Nick()), tobool(args[3]))
end)

local function SetConsoleTag(ply, name, tag, global)
    if IsValid(ply) then -- Console
        return
    end

    global = global or false
    if not isstring(tag) then return end
    local person = GarrysModx:FindPlayer(name:lower())
    if person == NULL then return end
    lite:Insert(person, "gmodx_admin", "admin", tag)
    person:AddUserTag(tag)
    local str = Format("[GmodX] Set Admin Tags tag '%s' to %s by Admin: Console", tag, person:Nick())
    print(str)
    if global == true then
        PrintMessage(HUD_PRINTTALK, str)
    else
        person:ChatPrint(str)
    end
end

concommand.Add("gmodx_console_adduser", function(ply, cmd, args)
    --gmodx_adduser
    SetConsoleTag(ply, tostring(args[1]), tostring(args[2]), tobool(args[3]))
end)

concommand.Add("gmodx_tags", function(ply)
    local info = ply:GetTags()
    local str = Format("[GmodX] Your Admin Tags '%s'", info)
    ply:ChatPrint(str)
    for k, v in SortedPairsByValue(GarrysModx.AdminMatrix.Tags, false) do
        ply:PrintMessage(HUD_PRINTCONSOLE, "[Command: " .. k .. "] - [Tag: " .. v .. "]\n")
    end
end)