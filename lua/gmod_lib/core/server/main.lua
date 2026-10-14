local lite = include("gmod_lib/core/server/sqlite.lua")
GarrysModx.Latex = {
    ["weapon_physgun"] = true,
    ["weapon_physcannon"] = true,
    ["gmod_tool"] = true,
    ["gmod_camera"] = true,
    ["weapon_crowbar"] = true
}

GarrysModx.ChatSay = {
    ["/pvp"] = function(ply, text)
        if ply.PvPMode == nil then ply.PvPMode = false end
        ply.PvPMode = not ply.PvPMode
        local status = ply.PvPMode == true and "Enabled PVP feel free to fight" or "Disabled"
        PrintMessage(HUD_PRINTTALK, tostring(ply:Nick()) .. " Has PVP: " .. status)
    end,
    ["/slay"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:SlayUser(ply)
    end,
    ["/heal"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:HealUser(ply.argz[3])
    end,
    ["/setaccess"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:SetUserTag(ply, tostring(argz[2]), tostring(argz[3]), tostring(ply:Nick()), tobool(argz[4]))
    end,
    ["/ban"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:BanUser(ply, target:SteamID64(), argz[3], argz[4])
    end,
    ["/kick"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:KickUser(ply, argz[3])
    end,
    ["/guide"] = function(ply, text) ply:ConCommand("gmodx_tutorial") end,
    ["/tags"] = function(ply, text) ply:ConCommand("gmodx_tags") end,
    ["/stun"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:StunUser(ply, argz[3])
    end,
    ["/slap"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:SlapUser(ply, argz[3])
    end,
    ["/armor"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:ArmorUser(ply, argz[3])
    end,
    ["/god"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:GodUser(ply)
    end,
    ["/ragdoll"] = function(ply, text)
        local argz = string.Explode(" ", text)
        local targe = argz[2]
        local target = GarrysModx:FindPlayer(targe)
        if target == NULL then return end
        target:RagdollUser(ply)
    end,
}