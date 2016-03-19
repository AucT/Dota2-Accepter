#SingleInstance force
Menu, tray, NoStandard
Menu, tray, add, Config
Menu, tray, Default, Config
Menu, tray, add, About
Menu, tray, add, Check update, UpdateCheck
Menu, tray, add
Menu, tray, add, SteamIdFinder
Menu, tray, add, Dotabuff
Menu, tray, add
Menu, tray, add, Rosh, Rosh
Menu, tray, add
Menu, tray, add, Open cfg folder, autoexec.cfg
Menu, tray, add, Exit
;Menu, Tray, Icon, %A_ScriptDir%\%A_ScriptName%,1,1

Version=v1.2
IniRead, RunAtStart, %A_MyDocuments%\d2a.ini, Config, RunAtStart, 0
if RunAtStart {
FileCreateShortcut , %A_ScriptDir%\%A_ScriptName%, %A_Startup%\D2A.lnk
} else{
IfExist %A_Startup%\D2A.lnk
FileDelete, %A_Startup%\D2A.lnk
}

IniRead, accepter, %A_MyDocuments%\d2a.ini, Config, Accepter, F11
IniRead, rageq, %A_MyDocuments%\d2a.ini, Config, RageQuit, !F4

IniRead, PosX, %A_MyDocuments%\d2a.ini, Config, Custom PosX, %A_Space%
IniRead, PosY, %A_MyDocuments%\d2a.ini, Config, Custom PosY, %A_Space%
IniRead, AcceptMethod, %A_MyDocuments%\d2a.ini, Config, AcceptMethod, 1

if (AcceptMethod==1){
AcceptMethod1:=1
AcceptMethod2:=0
}else {
AcceptMethod1:=0
AcceptMethod2:=1
}


RegRead, SteamPath, HKEY_CURRENT_USER, Software\Valve\Steam, SteamPath

Hotkey,%accepter%, accept
Hotkey,%rageq%, RQ
return

accept:
gojoin:=!gojoin
if gojoin
{
if (!PosX){
x:=A_ScreenWidth*.5
} else {
x:=PosX
}
if (!PosY){
y:=A_ScreenHeight*.4907
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
if (AcceptMethod==1){
send {vk0D}
}else {
MouseMove,x,y
sleep,1
Click
}
}
return

Config:
Gui, Destroy
gui, font, s10 w500

Gui, Add, Hotkey, vaccepter x5 y5 w50 h20 , %accepter%
Gui, Add, Text, x60 y5, to activate/deactivate Dota2 Accepter
Gui, Add, Hotkey, vrageq x5 y30 w50 h20 , %rageq%
Gui, Add, Text, x60 y30, to RageQuit

Gui, Add, Edit, vNewPosX x5 y55 w50 h20 , %PosX%
Gui, Add, Text, x60 y55, Position X*
Gui, Add, Edit, vNewPosY x5 y80 w50 h20 , %PosY%
Gui, Add, Text, x60 y80, Position Y*
Gui, Add, Text, x5 y100, *Position in pixels where to click. Leave blank for default. Used for clicker method.

Gui, Add, Text, x5 y140, Every 2 seconds produce:
Gui, Add, Radio, x5 y160 altsubmit vAcceptMethod Checked%AcceptMethod1%, Enter Press
Gui, Add, Radio, x5 y180 altsubmit Checked%AcceptMethod2%, Mouse Click
gui, Add, checkbox, Checked%RunatStart% vRunatStart x5 y210, Run tool at startup

Gui, Add, Button, gsaveconfig x3 y230 w354 h30,Save

Gui, Show, w360 h260,Dota2 Accepter Config
return



saveconfig:
gui, submit
IniWrite,%accepter%, %A_MyDocuments%\d2a.ini, Config, Accepter
IniWrite,%rageq%, %A_MyDocuments%\d2a.ini, Config, RageQuit
IniWrite, %RunatStart%, %A_MyDocuments%\d2a.ini, Config, RunatStart
IniWrite,%NewPosX%, %A_MyDocuments%\d2a.ini, Config, Custom PosX
IniWrite,%NewPosY%, %A_MyDocuments%\d2a.ini, Config, Custom PosY
IniWrite,%AcceptMethod%, %A_MyDocuments%\d2a.ini, Config, AcceptMethod
if RunAtStart {
FileCreateShortcut , %A_ScriptDir%\%A_ScriptName%, %A_Startup%\D2A.lnk
} else{
IfExist %A_Startup%\D2A.lnk
FileDelete, %A_Startup%\D2A.lnk
}
reload
return

RQ:
Process,Close,dota.exe
Process,Close,dota2.exe
return

GuiEscape:
GuiClose:
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

SteamIdFinder:
FileRead, Contents, %SteamPath%\logs\connection_log.txt
StringGetPos, pos, Contents,ConnectionCompleted(),R,1
FoundPos := RegExMatch(Contents, "(?<=\[U:\d:)(\d+)(?=\] 'OK')", SteamID, pos)
Run https://steamid.xyz/%SteamID%
return

Dotabuff:
FileRead, Contents, %SteamPath%\logs\connection_log.txt
StringGetPos, pos, Contents,ConnectionCompleted(),R,1
FoundPos := RegExMatch(Contents, "(?<=\[U:\d:)(\d+)(?=\] 'OK')", SteamID, pos)
Run http://www.dotabuff.com/players/%SteamID%
return

autoexec.cfg:
;FileAppend, , %SteamPath%\steamapps\common\dota 2 beta\game\dota\cfg\autoexec.cfg
;Run, Notepad.exe %SteamPath%\steamapps\common\dota 2 beta\game\dota\cfg\autoexec.cfg
Run, Explore %SteamPath%/steamapps/common/dota 2 beta/game/dota/cfg
return


UpdateCheck:
UrlDownloadToFile, https://dl.dropboxusercontent.com/u/45755423/D2A/latestD2A.html, %A_MyDocuments%\latestD2A.html
FileReadLine, NetVer, %A_MyDocuments%\latestD2A.html, 1
If (Version <> NetVer)
{
   ;MsgBox, 4,Check for update, %NetVer% is available! `nWould you like to download new version?
   MsgBox 68, Update is available , Dota 2 Accepter %NetVer% is available! `nWould you like to download new version?,5
IfMsgBox Yes
	run, http://auct.eu/d2a/
}
else
   MsgBox 64, Info ,Your Dota 2 Accepter is up to date!,2
return