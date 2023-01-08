#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#^+!t::
if WinExist("Todo | Trello")
    WinActivate
else
    run, "C:\Users\AdamHoskinson\Desktop\AHK\Todo.lnk"
return

#^+!s::
if WinExist("Spotify Premium")
    WinActivate
else
    run, "C:\Users\AdamHoskinson\AppData\Roaming\Spotify\Spotify.exe"
return