local flt = 0
net.Receive("GmodX_Unconcious", function() flt = net.ReadFloat() end)
hook.Add("HUDPaint", "GMODXtras_Blind", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    if flt ~= 1 then return end
    surface.SetDrawColor(Color(255, 255, 255, 255))
    surface.DrawRect(0, 0, ScrW(), ScrH())
end)