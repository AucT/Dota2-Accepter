; <COMPILER: v1.0.48.5>
#SingleInstance force
Menu, tray, NoStandard
Menu, tray, add, Info
Menu, tray, Default, Info
Menu, tray, add, About
Menu, tray, add, Rosh
Menu, tray, add, Exit
IniRead, accepter, %A_temp%\d2a.ini, Config, Accepter, F11
IniRead, PosX, %A_temp%\d2a.ini, Config, Custom PosX, %A_Space%
IniRead, PosY, %A_temp%\d2a.ini, Config, Custom PosY, %A_Space%
Hotkey,%accepter%, accept
return



accept:
gojoin:=!gojoin
if gojoin
{
if (!PosX){
x:=A_ScreenWidth*.4
} else {
x:=PosX
}
if (!PosY){
y:=A_ScreenHeight*.497
} else {
y:=PosY
}
gosub, Accepter
sleep 100
SetTimer, Accepter, 2012
}
else
{
ToolTip
SetTimer, Accepter, off
}
return

Accepter:
ifWinActive,Dota 2
{
ToolTip, Dota2 Accepter is active`nPress %accepter% to deactivate
MouseMove,x,y
sleep,1
Click
}
return

Info:
gui, font, s10 w500
Gui, Add, Text, x5 y5 h30, Press
Gui, Add, Hotkey, vaccepter x55 y5 w50 h20 , %accepter%
Gui, Add, Text, x105 y5, to activate/deactivate


Gui, Add, Edit, vNewPosX x5 y30 w50 h20 , %PosX%
Gui, Add, Text, x60 y30, Position X*
Gui, Add, Edit, vNewPosY x5 y50 w50 h20 , %PosY%
Gui, Add, Text, x60 y50, Position Y*
Gui, Add, Text, x5 y75, *Position in pixels where to click. Leave blank for default.


Gui, Add, Button, gsaveconfig x3 y92 w354 h30,Save
Gui, Show, w360 h125,Dota2 Accepter Config
return

saveconfig:
gui, submit
IniWrite,%accepter%, %A_temp%\d2a.ini, Config, Accepter
IniWrite,%NewPosX%, %A_temp%\d2a.ini, Config, Custom PosX
IniWrite,%NewPosY%, %A_temp%\d2a.ini, Config, Custom PosY
reload
return

GuiEscape:
gui, destroy
return
Exit:
ExitApp
return

About:
Run http://auct.eu/d2a/
return

Rosh:
MsgBox 64, Rosh Notifier, Alt+click the clock in game!`nRosh respawns after a random time between 8-11 minutes`nAegis is removed after 5 minutes
return
