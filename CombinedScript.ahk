#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;;; Variables

; HyperMouseScroll ---------------------------------------------------------

swapy := false
swapx := false
MaxScrollLimit := 15
PixelsPerScrollStep := 10
ScrollScanIntervalMS := 30
DeadZone := 3

; WinMove -----------------------------------------------------------

WinMoveAmount = 40
WinSetToWidth = % Floor(A_ScreenWidth*2/3)
WinSetToHeight = % Floor(A_ScreenHeight*2/3)

; AppLaunch -----------------------------------------------------------

SpotifyPath := "!!!SetSpotifyPath!!!"
TodoPath := "!!!SetTodoPath!!!"

; CommitMessage -----------------------------------------------------------

GitRepoLocation := "!!!SetRepoPath!!!"

;;; Scripts

; HyperMouseScroll ---------------------------------------------------------

running := 0
dy := 0
dx := 0

loop
{
	sleep %ScrollScanIntervalMS%

	if (running) {
		mousegetpos, mx, my
        delx := (mx-mxLast)
        dely := (my-myLast)
        if (abs(delx)>abs(dely)){
            if (delx>DeadZone Or delx<-DeadZone){
                dx := dx + delx
            }
        }
        Else
        {
            if (dely>DeadZone Or dely<-DeadZone){
                dy := dy + dely
            }
        }

		scrollsNx := floor(abs(dx / PixelsPerScrollStep))
        scrollsNy := floor(abs(dy / PixelsPerScrollStep))

        nx := min(scrollsNx, MaxScrollLimit)
		ny := min(scrollsNy, MaxScrollLimit)

        if (ny>0)
        {
            directiony := (dy >= 0) ^ swapy

            if (nx>0)
            {
                directionx := (dx >= 0) ^ swapx

                if (directionx = 1)
                {
			        send, {WheelRight %nx%}
                }

		        else if (directionx = 0)
                {
			        send, {WheelLeft %nx%}
                }

                dx := 0
            }

            if (directiony = 1)
            {
			    send, {wheeldown %ny%}
            }

		    else if (directiony = 0)
            {
			    send, {wheelup %ny%}
            }

            dy := 0
        }
        else if(nx>0)
        {
            directionx := (dx >= 0) ^ swapx

            if (directionx = 1)
            {
			    send, {WheelRight %nx%}
            }
		    else if (directionx = 0)
            {
			    send, {WheelLeft %nx%}
            }

            dx := 0
        }

        mouseMove, mxLast, myLast, 0
	}
}

F17::
    if (running == 0)
    {
	    running := 1
        dy := 0
        dx := 0
	    mousegetpos, mxLast, myLast
    }
    return

F17 up::
	running := 0
    return

; WinMove -----------------------------------------------------------

#^+!j::
WinGetPos, X, Y, W, H, A
WinMove, A,,X-WinMoveAmount, %Y%, %W%, %H%
return


#^+!l::
WinGetPos, X, Y, W, H, A
WinMove, A,,X+WinMoveAmount, %Y%, %W%, %H%
return


#^+!i::
WinGetPos, X, Y, W, H, A
WinMove, A,,%X%, Y-WinMoveAmount, %W%, %H%
return


#^+!k::
WinGetPos, X, Y, W, H, A
WinMove, A,,%X%, Y+WinMoveAmount, %W%, %H%
return


#^+!r::
WinGetPos, X, Y,W,H, A
WinGet minmax, MinMax, A
If (MinMax == 1){
    WinRestore, A
}
WinMove,A,,(A_ScreenWidth/2)-(WinSetToWidth/2), (A_ScreenHeight/2)-(WinSetToHeight/2), WinSetToWidth, WinSetToHeight
return

; AppLaunch -----------------------------------------------------------

#^+!t::
if WinExist("Todo ahk_exe chrome.exe")
    WinActivate
else
    run, %TodoPath%
return

#^+!s::
if WinExist("ahk_exe Spotify.exe")
    WinActivate
else
    run, %SpotifyPath%
return

; VolumeControl -----------------------------------------------------------

F15 & WheelUp::
Send {Volume_Up 1}
return
F15 & WheelDown::
Send {Volume_Down 1}
return

; CommitMessage -----------------------------------------------------------

F16::
RunWait, %ComSpec% /c cd %GitRepoLocation% && git branch --show-current  | clip
StringUpper Clipboard, Clipboard
Send, ^v {Ctrl Up}{BackSpace}{BackSpace} -{Space}
return
