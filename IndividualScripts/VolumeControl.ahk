#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#MaxHotkeysPerInterval, 300

F15 & WheelUp::
Send {Volume_Up 1}
return
F15 & WheelDown::
Send {Volume_Down 1}
return

; F17 & WheelUp::
; Send {WheelLeft}
; return
; F17 & WheelDown::
; Send {WheelRight}
; return