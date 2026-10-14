local Guide = {}
Guide.PhraseLang = {}
function GarrysModx:Guide(phrase)
    Guide.PhraseLang[#Guide.PhraseLang + 1] = phrase
end

GarrysModx:Guide("Tutorial")
GarrysModx:Guide("Guide:")
GarrysModx:Guide("Console:")
GarrysModx:Guide("gmodx_tags - Collection of tags")
GarrysModx:Guide("gmodx_adduser - Adds users with flags <name> <tags> <global> e.g: gmodx_adduser 'onyaa' 'a,b,c,d' true")
GarrysModx:Guide("gmodx_kick <name> <reason>")
GarrysModx:Guide("gmodx_banuser <name> <length> <reason>")
GarrysModx:Guide("gmodx_slay <name>")
GarrysModx:Guide("gmodx_heal <name> <amount>")
GarrysModx:Guide("gmodx_stun <name> <amount>")
GarrysModx:Guide("gmodx_armor <name> <amount>")
GarrysModx:Guide("gmodx_ragdoll <name> <amount>")
GarrysModx:Guide("gmodx_god <name>")
GarrysModx:Guide("CHAT:")
GarrysModx:Guide("/setaccess - Adds users with flags <name> <tags> <global> e.g: /setaccess 'onyaa' 'a,b,c,d' true")
GarrysModx:Guide("/kick <name> <reason>")
GarrysModx:Guide("/ban <name> <length> <reason>")
GarrysModx:Guide("/slay <name>")
GarrysModx:Guide("/heal <name> <amount>")
GarrysModx:Guide("/tags")
GarrysModx:Guide("/stun <name> <amount>")
GarrysModx:Guide("/armor <name> <amount>")
GarrysModx:Guide("/ragdoll <name>")
GarrysModx:Guide("/god <name>")
function Guide:Tutorial(py)
    local str = string.find(GarrysModx.AdminMatrix.MyTags, py)
    if str then
        for k, v in pairs(Guide.PhraseLang) do
            print(v)
        end
    end
end

concommand.Add("gmodx_tutorial", function(ply) Guide:Tutorial("u") end)
GarrysModx.GodsTarget = {}
net.Receive("gods_target", function()
    -- Gods Halo
    GarrysModx.GodsTarget[net.ReadEntity()] = net.ReadBool()
end)

timer.Create("gmodx_Halo", 0.1, 0, function()
    for k, v in pairs(player.GetAll()) do
        if IsValid(v) and GarrysModx.GodsTarget[v] then
            local bone = v:LookupBone("ValveBiped.Bip01_Head1")
            local pos = v:GetBonePosition(bone)
            local eff = EffectData()
            eff:SetStart(pos + v:GetUp() * 15)
            eff:SetOrigin(pos + v:GetUp() * 15)
            eff:SetColor(255, 255, 255)
            util.Effect("selection_halo", eff)
        end
    end
end)