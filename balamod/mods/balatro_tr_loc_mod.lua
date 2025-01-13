local mod_id = "balatro_fr_loc_mod"
local mod_name = "Balatro FR Loc MOD"
local mod_version = "v1.0.1"
local mod_authors = "Balatro FR Loc MOD's Team"

if not loadImageDataFromPath then
    -- pour pas ecraser les updates du mod pour patcher les images
    function loadImageDataFromPath(filePath)
        local img_data = nil
        local f = io.open(filePath, "rb")
        if f then
            local data = f:read("*all")
            f:close()
            if data then
                data = love.filesystem.newFileData(data, "tempname")
                data = love.image.newImageData(data)
                img_data = data
            end
        end

        if not img_data then
            sendDebugMessage("Image does not exist: " .. filePath)
            local patch = love.filesystem.getSaveDirectory() .. "/pack/"
            local original_name = string.gsub(filePath, patch:gsub("([^%w])", "%%%1"), "resources/textures/")
            return original_name
        end
        sendDebugMessage("Image does exist: " .. filePath)
        return img_data
    end
end

table.insert(mods,
        {
            mod_id = mod_id,
            name = mod_name,
            version = mod_version,
            author = mod_authors,
            enabled = true,
            description = {
                "Traduction Française revue et corrigée :",
                "- Mise à jour des textes",
                "- Mise à jour des images",
                "",
                "Par : Arkana Ravneik, SweZ, Behel, Pipomantis, Signez, Wok, Furtys, Bleh!",
                "Un grand merci à UwU pour la réalisation de ce mod."
            },
            on_enable = function()
                -- Customize translations
                local localeFile = love.filesystem.newFile("mods/fr/fr.lua")

                if localeFile:open("r") then
                    localeFile:close()
                else
                    return
                end

                local patch = [[
                    if G.SETTINGS.language == "fr" then
                        G.localization = love.filesystem.load('mods/fr/fr.lua')()
                        init_localization()
                    end
                ]]

                injectTail("game.lua", "Game:set_language", patch)

                pcall(function()
                    -- pcall pour pas que ça explose si ça foire
                    load(patch)()
                end)

                local texturePackModFile = love.filesystem.newFile("mods/custom_texture_pack.lua")
                if texturePackModFile:open("r") then
                    texturePackModFile:close()
                else
                    local function_body = extractFunctionBody("game.lua", "Game:set_render_settings")
                    local save_path = love.filesystem.getSaveDirectory() .. "/pack/"
                    local modified_function_code = string.gsub(function_body, "\"resources/textures/\"", "\"" .. save_path .. "\"")

                    local to_patch1 = "love.graphics.newImage(self.animation_atli[i].path"
                    local to_patch2 = "love.graphics.newImage(self.asset_atli[i].path"
                    local to_patch3 = "love.graphics.newImage(self.asset_images[i].path"
                    local to_patch4 = "resources/textures/1x/playstack-logo.png"
                    local to_patch5 = "resources/textures/1x/localthunk-logo.png"

                    local patch1 = "love.graphics.newImage(loadImageDataFromPath(self.animation_atli[i].path)"
                    local patch2 = "love.graphics.newImage(loadImageDataFromPath(self.asset_atli[i].path)"
                    local patch3 = "love.graphics.newImage(loadImageDataFromPath(self.asset_images[i].path)"
                    local patch4 = save_path .. "1x/playstack-logo.png"
                    local patch5 = save_path .. "1x/localthunk-logo.png"

                    modified_function_code = string.gsub(modified_function_code, to_patch1:gsub("([^%w])", "%%%1"), patch1:gsub("([^%w])", "%%%1"))
                    modified_function_code = string.gsub(modified_function_code, to_patch2:gsub("([^%w])", "%%%1"), patch2:gsub("([^%w])", "%%%1"))
                    modified_function_code = string.gsub(modified_function_code, to_patch3:gsub("([^%w])", "%%%1"), patch3:gsub("([^%w])", "%%%1"))
                    modified_function_code = string.gsub(modified_function_code, to_patch4:gsub("([^%w])", "%%%1"), patch4:gsub("([^%w])", "%%%1"))
                    modified_function_code = string.gsub(modified_function_code, to_patch5:gsub("([^%w])", "%%%1"), patch5:gsub("([^%w])", "%%%1"))

                    local escaped_function_body = function_body:gsub("([^%w])", "%%%1")
                    current_game_code["game.lua"] = current_game_code["game.lua"]:gsub(escaped_function_body, modified_function_code)

                    sendDebugMessage("Game code updated")

                    local new_function, load_error = load(modified_function_code)
                    if new_function then
                        sendDebugMessage("Function loaded")
                        local success, result = pcall(new_function)
                        if success then
                            sendDebugMessage("Function executed")
                        else
                            sendDebugMessage("Function execution failed: " .. result)
                        end
                    else
                        sendDebugMessage("Function load failed: " .. load_error)
                    end

                    sendDebugMessage(modified_function_code)

                    G:set_render_settings()
                    G:init_item_prototypes()
                end

                for _, v in ipairs(G.FONTS) do
                    local from_mod = string.gsub(v.file, 'resources/fonts/', 'pack/')

                    if love.filesystem.exists(from_mod) then
                        -- If the file exists with the same path in our mod pack, use it instead
                        v.FONT = love.graphics.newFont(from_mod, v.render_scale)
                    end
                end

                -- force the french language to refresh its font file
                G.LANGUAGES['fr'].font = G.FONTS[1]
                G:set_language()
            end,
        }
)
