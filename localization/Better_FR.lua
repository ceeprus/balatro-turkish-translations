--- STEAMODDED HEADER
--- MOD_NAME: Better French
--- MOD_ID: Better_FR
--- MOD_AUTHOR: [The Balatro FR Loc Mod Community]
--- MOD_DESCRIPTION: A humble community-made version of the French localization of Balatro
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------

G.F_NO_ACHIEVEMENTS = false

local mod = SMODS.current_mod

local function apply_sprites()
	sendDebugMessage("Application des sprites...")

	SMODS.Atlas { key = "Booster", path = { ['fr'] = 'boosters.png', }, px = 71, py = 95, prefix_config = { key = false } }
	SMODS.Atlas { key = "Tarot", path = { ['fr'] = 'Tarots.png', }, px = 71, py = 95, prefix_config = { key = false } }
	SMODS.Atlas { key = "Voucher", path = { ['fr'] = 'Vouchers.png', }, px = 71, py = 95, prefix_config = { key = false } }
	SMODS.Atlas { key = "icons", path = { ['fr'] = 'icons.png', }, px = 66, py = 66, prefix_config = { key = false } }
	SMODS.Atlas { key = "Joker", path = { ['fr'] = 'Jokers.png', }, px = 71, py = 95, prefix_config = { key = false } }
	SMODS.Atlas { key = "blind_chips", path = { ['fr'] = "BlindChips.png", }, px = 34, py = 34, prefix_config = { key = false }, atlas_table = 'animation_atli', frames = 21 }
	SMODS.Atlas { key = "shop_sign", path = { ['fr'] = "ShopSignAnimation.png", }, px = 113, py = 57, prefix_config = { key = false }, atlas_table = 'animation_atli', frames = 4 }
end

local function apply_font()
	for _, v in ipairs(G.FONTS) do
		-- If the file exists with the same path in our mod pack, use it instead
		if love.filesystem.getInfo(mod.path .. v.file) then
			v.FONT = love.graphics.newFont(mod.path .. v.file, v.render_scale)
		end
	end
end

local function apply_patch()
	init_localization()
	apply_sprites()
	apply_font()
end

if G.LANG.key == "fr" then
	apply_patch()
end

G.set_language_ref = G.set_language
function G:set_language()
	self:set_language_ref()

	if self.LANG.key == "fr" then
		apply_patch()
	end
end

------------MOD CODE END----------------------
----------------------------------------------

