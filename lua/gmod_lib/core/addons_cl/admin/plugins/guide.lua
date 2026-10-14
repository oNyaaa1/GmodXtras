local Guide = {}
Guide.PhraseLang = {}
function GarrysModx:Guide(AddPhrase, phrase)
    Guide.PhraseLang[AddPhrase] = phrase
end

GarrysModx:Guide(1, "Tutorial")
GarrysModx:Guide(2, "Guide:")
GarrysModx:Guide(3, "gmodx_tags - Collection of tags")
GarrysModx:Guide(4, "gmodx_adduser - Adds users with flags <name> <tags> <global> e.g: gmodx_adduser 'onyaa' 'a,b,c,d' true")
GarrysModx:Guide(5, "gmodx_kick <name> <reason>")
GarrysModx:Guide(6, "gmodx_banuser <name> <length> <reason>")
GarrysModx:Guide(7, "gmodx_slay <name>")
GarrysModx:Guide(8, "gmodx_heal <name> <amount>")
GarrysModx:Guide(8, "gmodx_stun <name> <amount>")
GarrysModx:Guide(8, "gmodx_armor <name> <amount>")
GarrysModx:Guide(9, "CHAT: /setaccess - Adds users with flags <name> <tags> <global> e.g: /setaccess 'onyaa' 'a,b,c,d' true")
GarrysModx:Guide(10, "CHAT: /kick <name> <reason>")
GarrysModx:Guide(11, "CHAT: /ban <name> <length> <reason>")
GarrysModx:Guide(12, "CHAT: /slay <name>")
GarrysModx:Guide(13, "CHAT: /heal <name> <amount>")
GarrysModx:Guide(14, "CHAT: /tags")
GarrysModx:Guide(15, "CHAT: /stun <name> <amount>")
GarrysModx:Guide(15, "CHAT: /armor <name> <amount>")
function Guide:Tutorial(py)
    local str = string.find(GarrysModx.AdminMatrix.MyTags, py)
    if str then
        for k, v in pairs(Guide.PhraseLang) do
            print(v)
        end
    end
end

concommand.Add("gmodx_tutorial", function(ply) Guide:Tutorial("u") end)