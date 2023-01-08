#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Note Requires wsl for tr command
;Change to your repository location
F16::
RunWait, %ComSpec% /c cd C:\Users\AdamHoskinson\source\repos\driveworks && git branch --show-current  | wsl tr '[:lower:]' '[:upper:]'| clip
Send, ^v {Ctrl Up}{BackSpace}{BackSpace} - {Space}
return