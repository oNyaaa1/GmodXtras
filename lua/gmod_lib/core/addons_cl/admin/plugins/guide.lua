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
function Guide:Tutorial(py)
    local str = string.find(GarrysModx.AdminMatrix.MyTags, py)
    if str then
        for k, v in pairs(Guide.PhraseLang) do
            print(v)
        end
    end
end

concommand.Add("gmodx_tutorial", function(ply) Guide:Tutorial("u") end)