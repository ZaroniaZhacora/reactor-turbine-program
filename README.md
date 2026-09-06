# Reactor-Turbine-Program 2.3 (ComputerCraft / Big Reactors)

Dies ist die GitHub-Fassung des von Thor_s_Crafter veröffentlichten Reactor-/Turbinenprogramms Version 2.3.

## Ziel

Die eigentliche Programmlogik und Oberfläche bleiben unverändert. Geändert wurde nur die Installations-/Updatequelle:
Pastebin -> GitHub Raw.

## Repository

Der Installer ist bereits auf diese Adresse eingestellt:

https://raw.githubusercontent.com/ZaroniaZhacora/reactor-turbine-program/main

Das Repository muss daher unter folgendem Namen veröffentlicht werden:

ZaroniaZhacora/reactor-turbine-program

und der Standard-Branch muss `main` heißen.

## Struktur

- config/options.txt
- config/input.lua
- config/touchpoint.lua
- program/editOptions.lua
- program/reactorControl.lua
- program/turbineControl.lua
- start/menu.lua
- start/start.lua
- install/installer.lua
- install/installerUpdate.lua
- bootstrap.lua

## Installation auf dem ComputerCraft-PC

Am einfachsten lädst Du zunächst `bootstrap.lua` auf den Computer und startest ihn.
Der Bootstrap lädt anschließend den eigentlichen Installer und dieser wiederum alle Programmteile.

Wichtig: HTTP muss in ComputerCraft aktiviert sein und GitHub Raw muss vom Server erreichbar sein.
