local function GetWepOn(tbl)
    local wep_log = {}
    for _, j in pairs(tbl) do
        if GarrysModx.Latex[j:GetClass()] then continue end
        wep_log[_] = j:GetClass()
    end
    return wep_log
end

local function RemoveWepsSpawn(ply)
    timer.Simple(0, function()
        local strings = GetWepOn(ply:GetWeapons())
        for k, v in pairs(strings) do
            ply:StripWeapon(v)
        end
    end)
end

hook.Add("PlayerSpawn", "GmodXRemoveDont", RemoveWepsSpawn)