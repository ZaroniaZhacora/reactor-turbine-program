-- Reactor- und Turbine control by Thor_s_Crafter --
-- Version 2.3 --
-- GitHub-Installer (Deutsch) --
-- Nur der Downloadweg wurde von Pastebin auf GitHub umgestellt.

local BASE_URL = "https://raw.githubusercontent.com/ZaroniaZhacora/reactor-turbine-program/main"

local function ensureDir(path)
  if not fs.exists(path) then
    fs.makeDir(path)
  end
end

local function download(relPath, target)
  local url = BASE_URL .. "/" .. relPath
  local response = http.get(url)
  if not response then
    error("Download fehlgeschlagen: " .. url)
  end

  local data = response.readAll()
  response.close()

  local file = fs.open(target, "w")
  if not file then
    error("Datei konnte nicht geschrieben werden: " .. target)
  end
  file.write(data)
  file.close()
end

ensureDir("/reactor-turbine-program")
ensureDir("/reactor-turbine-program/config")
ensureDir("/reactor-turbine-program/program")
ensureDir("/reactor-turbine-program/start")
ensureDir("/reactor-turbine-program/install")
ensureDir("/reactor-turbine-program/changelog")

-- Loads the option file if not present yet
if not fs.exists("/reactor-turbine-program/config/options.txt") then
  download("config/options.txt", "/reactor-turbine-program/config/options.txt")
end

-- Reads the version --Currently deprecated
local optionList = {}
local file = fs.open("/reactor-turbine-program/config/options.txt","r")
local listElement = file.readLine()
while listElement do
  table.insert(optionList,listElement)
  listElement = file.readLine()
end
file.close()

local version = optionList[3]
local nVersion = 2.3

-- Update?
local update
if fs.exists("/reactor-turbine-program/program/turbineControl.lua") then
  update = true
else
  update = false
end

-- First time installation
if not update then
  term.clear()
  term.setCursorPos(1,1)
  print("Reaktor- und Turbinenprogramm von Thor_s_Crafter")
  print("Version 2.3")
  print()
  print("Ueber das Programm:")
  print("Das Programm kontrolliert einen BigReactors-Reaktor.")
  print("Es koennen auch bis zu 32 Turbinen angeschlossen werden.")
  print("Der Computer muss mit Wired Modems am Reaktor (und ggf. Turbinen) verbunden werden.")
  print("Ausserdem muss ein Energiespeicher und ein Monitor angeschlossen werden.")
  print("Der Monitor muss min. 7 Bloecke breit und 4 Bloecke hoch sein.")
  print("Wird das Programm mit Turbinen betrieben, sollte der Reaktor pro Turbine mindestens 2000mb/t Steam produzieren koennen.")
  print()
  write("Bitte Enter druecken...")
  local leer = read()

  local out = true
  while out do
    term.clear()
    term.setCursorPos(1,1)
    print("Es wird empfohlen den Computer zu labeln.")
    term.write("Computer labeln? (j/n): ")

    local input = read()
    if input == "j" then
      print()
      shell.run('label set "TurbineComputer"')
      print()
      print('ComputerLabel auf "TurbineComputer" gesetzt.')
      print()
      sleep(2)
      out = false
    elseif input == "n" then
      print()
      print("ComputerLabel wurde nicht gesetzt.")
      print()
      out = false
    end
  end

  local out2 = true
  while out2 do
    term.clear()
    term.setCursorPos(1,1)
    print("Es wird empfohlen das Programm zum Startup hinzuzufugen.")
    print("Dadurch wird das Programm beim Starten des Computers automatisch ausgefuehrt.")
    term.write("Startup hinzufuegen? (j/n): ")

    local input = read()
    if input == "j" then
      local startupFile = fs.open("startup","w")
      startupFile.writeLine('shell.run("/reactor-turbine-program/start/start.lua")')
      startupFile.close()
      print()
      print("Startup wurde installiert.")
      print()
      out2 = false
    elseif input == "n" then
      print()
      print("Startup wurde nicht installiert.")
      print()
      out2 = false
    end
  end

  sleep(1)
end

term.clear()
term.setCursorPos(1,1)

print("Checke und loesche vorhandene Programme...")

if fs.exists("/reactor-turbine-program/config/input.lua") then
  fs.delete("/reactor-turbine-program/config/input.lua")
end
if fs.exists("/reactor-turbine-program/config/touchpoint.lua") then
  fs.delete("/reactor-turbine-program/config/touchpoint.lua")
end
if fs.exists("/reactor-turbine-program/program") then
  fs.delete("/reactor-turbine-program/program")
end
if fs.exists("/reactor-turbine-program/start") then
  fs.delete("/reactor-turbine-program/start")
end
if fs.exists("/reactor-turbine-program/changelog") then
  fs.delete("/reactor-turbine-program/changelog")
end

ensureDir("/reactor-turbine-program/program")
ensureDir("/reactor-turbine-program/start")
ensureDir("/reactor-turbine-program/changelog")
ensureDir("/reactor-turbine-program/install")

print("Lade neue Programmteile...")
download("config/input.lua", "/reactor-turbine-program/config/input.lua")
download("config/touchpoint.lua", "/reactor-turbine-program/config/touchpoint.lua")
download("program/editOptions.lua", "/reactor-turbine-program/program/editOptions.lua")
download("program/reactorControl.lua", "/reactor-turbine-program/program/reactorControl.lua")
download("program/turbineControl.lua", "/reactor-turbine-program/program/turbineControl.lua")
download("start/menu.lua", "/reactor-turbine-program/start/menu.lua")
download("start/start.lua", "/reactor-turbine-program/start/start.lua")
download("install/installerUpdate.lua", "/reactor-turbine-program/install/installerUpdate.lua")

print("Fertig!")

if fs.exists("startup") then
  fs.delete("startup")
  local startupFile = fs.open("startup","w")
  startupFile.writeLine('shell.run("/reactor-turbine-program/start/start.lua")')
  startupFile.close()
end

term.clear()
term.setCursorPos(1,1)

if not update then
  print("Die Installation wurde erfolgreich abgeschlossen!")
  print("Das Programm ist nun einsatzbereit!")
  print()
  term.setTextColor(colors.yellow)
  print("Beim ersten Start ist es notwendig den Computer manuell neu zu starten!")
  print('Dazu bitte "reboot" eingeben oder "Strg + R" kurz gedrueckt halten.')
  term.setTextColor(colors.white)
  print()
  print("Danke, dass du mein Programm benutzt! ;)")
  print("Viel Spass damit.")
  print("(Thor_s_Crafter)")
  print()
end

error("Installer beendet. (Das ist kein Fehler! Bitte ignorieren!)")
