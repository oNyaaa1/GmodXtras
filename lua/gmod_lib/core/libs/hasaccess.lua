local PLAYER = FindMetaTable("Player")
function PLAYER:HasAccess()
    return self:IsAdmin()
end
