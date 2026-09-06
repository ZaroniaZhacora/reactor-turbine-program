-- Einmaliger GitHub-Bootstrap fuer ComputerCraft 1.7.10
local url = "https://raw.githubusercontent.com/ZaroniaZhacora/reactor-turbine-program/main/install/installer.lua"
local target = "/reactor-turbine-program/install/installer.lua"

if not fs.exists("/reactor-turbine-program") then fs.makeDir("/reactor-turbine-program") end
if not fs.exists("/reactor-turbine-program/install") then fs.makeDir("/reactor-turbine-program/install") end

local r = http.get(url)
if not r then error("Download fehlgeschlagen: " .. url) end
local data = r.readAll()
r.close()

local f = fs.open(target, "w")
f.write(data)
f.close()

shell.run(target)
