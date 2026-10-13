GarrysModx.AdminMatrix = {}

net.Receive("gmodx_hastags", function()
    GarrysModx.AdminMatrix.MyTags = net.ReadString()
end)