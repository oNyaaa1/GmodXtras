GarrysModx = GarrysModx or {}
GarrysModx.Reject = false
local function add_filessh(dir)
    local files, folders = file.Find(dir .. "*", "LUA")
    for _, file_name in pairs(files) do
        if SERVER then AddCSLuaFile(dir .. file_name) end
        include(dir .. file_name)
        print("[GarrysModx] Shared: " .. dir .. file_name)
    end

    for _, folder_name in pairs(folders) do
        add_filessh(dir .. folder_name .. "/")
    end
end

local function add_filessv(dir)
    local files, folders = file.Find(dir .. "*", "LUA")
    for _, file_name in pairs(files) do
        if SERVER then
            include(dir .. file_name)
            print("[GarrysModx] Server: " .. dir .. file_name)
        end
    end

    for _, folder_name in pairs(folders) do
        add_filessv(dir .. folder_name .. "/")
    end
end

local function add_files(dir)
    local files, folders = file.Find(dir .. "*", "LUA")
    for _, file_name in pairs(files) do
        if SERVER then AddCSLuaFile(dir .. file_name) end
        if CLIENT then
            include(dir .. file_name)
            print("[GarrysModx] Client: " .. dir .. file_name)
        end
    end

    for _, folder_name in pairs(folders) do
        add_files(dir .. folder_name .. "/")
    end
end

add_filessh("gmod_lib/core/libs/")
add_filessh("gmod_lib/core/shared/")
add_filessv("gmod_lib/core/server/")
add_files("gmod_lib/core/client/")
add_filessv("gmod_lib/core/addons_sv/")
add_files("gmod_lib/core/addons_cl/")