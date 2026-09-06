-- Reactor- und Turbine control by Thor_s_Crafter --
-- GitHub installerUpdate --
-- Ersatz fuer den urspruenglichen Pastebin-Updater.

local URL = "https://raw.githubusercontent.com/ZaroniaZhacora/reactor-turbine-program/main/install/installer.lua"
local target = "/reactor-turbine-program/install/installer.lua"

if fs.exists(target) then
  fs.delete(target)
end

local response = http.get(URL)
if not response then
  error("Installer-Download fehlgeschlagen: " .. URL)
end

local data = response.readAll()
response.close()

local file = fs.open(target, "w")
if not file then
  error("Installer konnte nicht geschrieben werden.")
end
file.write(data)
file.close()

shell.run(target)
