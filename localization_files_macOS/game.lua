-- Balatro TR (macOS / Apple Arcade): kayit klasorunden yuklenen game.lua.
-- Oyunun kendi game.lua'sini okur, Turkce dil satirini ve Ingilizce yedekli
-- yuklemeyi ekleyip calistirir. Desen bulunamazsa orijinali degistirmeden calisir.
local function read_original()
  local base = love.filesystem.getSource()
  for _, p in ipairs({base .. "/game.lua", base .. "/game/game.lua"}) do
    local f = io.open(p, "r")
    if f then local c = f:read("*a"); f:close(); return c end
  end
end
local code = read_original()
assert(code, "Balatro TR: orijinal game.lua bulunamadi")
local TRLINE = [==[['tr'] = {font = 1, label = "Türkçe", key = 'tr', omit = false, beta = true, button = "Dil Geri Bildirimi", warning = {'Bu dil henüz Beta sürümündedir. Geri bildirim tuşuna tıklayarak','bize yardımcı olabilir ve çeviriyi geliştirebilirsiniz.', 'Doğrulamak için tekrar tıkla'}},]==]
local MERGE = [==[
      if G.SETTINGS.language == 'tr' then
        local base = assert(loadstring(love.filesystem.read('localization/en-us.lua')))()
        local function merge(b, o) for k, v in pairs(o) do if type(v) == 'table' and type(b[k]) == 'table' and #v == 0 then merge(b[k], v) else b[k] = v end end end
        merge(base, self.localization)
        self.localization = base
      end
]==]
if not code:find("['tr'] = {", 1, true) then
  local a, b = code:find("%['ru'%] = %b{},?[^\n]*\n")
  local key = "self.localization = assert(loadstring(love.filesystem.read('localization/'..G.SETTINGS.language..'.lua')))()\n"
  local c, d = code:find(key, 1, true)
  if a and c then
    code = code:sub(1, d) .. MERGE .. code:sub(d + 1)
    code = code:sub(1, b) .. "            " .. TRLINE .. "\n" .. code:sub(b + 1)
  end
end
return assert(loadstring(code, "@game.lua"))()
