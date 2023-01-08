#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

MoveAmount = 40
SetToWidth = % Floor(A_ScreenWidth*2/3)
SetToHeight = % Floor(A_ScreenHeight*2/3)

#^+!j::
WinGetPos, X, Y, W, H, A
WinMove, A,,X-MoveAmount, %Y%, %W%, %H%
return


#^+!l::
WinGetPos, X, Y, W, H, A
WinMove, A,,X+MoveAmount, %Y%, %W%, %H%
return


#^+!i::
WinGetPos, X, Y, W, H, A
WinMove, A,,%X%, Y-MoveAmount, %W%, %H%
return


#^+!k::
WinGetPos, X, Y, W, H, A
WinMove, A,,%X%, Y+MoveAmount, %W%, %H%
return


#^+!r::
WinGetPos, X, Y,W,H, A
WinGet minmax, MinMax, A
If (MinMax == 1){
    WinRestore, A
}
WinMove,A,,(A_ScreenWidth/2)-(SetToWidth/2), (A_ScreenHeight/2)-(SetToHeight/2), SetToWidth, SetToHeight
return