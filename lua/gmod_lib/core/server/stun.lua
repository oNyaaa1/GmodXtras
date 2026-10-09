util.AddNetworkString("GmodX_Unconcious")
local function HandleStun(ply)
    ply.Stunned = true
    timer.Simple(math.random(2, 5), function()
        ply.Stunned = false
        net.Start("GmodX_Unconcious")
        net.WriteFloat(0)
        net.Send(ply)
        ply.Hits = 0
    end)
end

hook.Add("StartCommand", "GMODxStunXtended", function(ply, cmd)
    if ply.Stunned and ply:PvPModeStatus() then
        --Stop moving
        cmd:ClearMovement()
        cmd:SetViewAngles(Angle(math.random(math.sin(-11), math.cos(11)), math.random(math.sin(-11), math.cos(11)), 0))
        net.Start("GmodX_Unconcious")
        net.WriteFloat(1)
        net.Send(ply)
    end
end)

hook.Add("EntityTakeDamage", "GMODxStun", function(target, dmginfo)
    if target:IsPlayer() and target:PvPModeStatus() then
        --handleStun
        if target.Hits == nil then target.Hits = 0 end
        target.Hits = target.Hits + 1
        if target.Hits > 3 then --HandleStun
            HandleStun(target)
        end
    else
        dmginfo:ScaleDamage(0)
    end
end)