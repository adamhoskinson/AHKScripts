#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
running := 0

; === User settings ===
swapy := false
swapx := false
; swap := true 				; swap scroll direction

; === Internal settings ===
scrollsLimit := 15			; max amount of scroll at once
S := 10					; unit distance (higher S = lower speed)
T := 30					; scan frequency in MS (
DeadZone := 3

; ==============

dy := 0
dx := 0

mxOrig := 0
myOrig := 0

; #if running
loop
{
	sleep %T%

	if (running) {
		; mousegetpos, mx						; get current mouse position
		mousegetpos, mx, my						; get current mouse position
        delx := (mx-mxLast)
        dely := (my-myLast)
        if (delx>DeadZone Or delx<-DeadZone){
            dx := dx + delx
        }
		    			; calculate remainder after division
        if (dely>DeadZone Or dely<-DeadZone){
            dy := dy + dely
        }
        ; delx := abs(mx-mxLast)
        ; dely := abs(my-myLast)
        ; if (delx > DeadZone) ; and 3*delx-dely>0)
        ;     dx := dx + mx-mxLast
        ; if (dely > DeadZone) ; and 3*dely-delx>0)
        ;     dy := dy + my-myLast
		scrollsNx := floor(abs(dx / S))
        scrollsNy := floor(abs(dy / S))

        nx := min(scrollsNx, scrollsLimit)
		ny := min(scrollsNy, scrollsLimit)
		; tooltip,  %scrolls% -- %dy%

        if (ny>0){
            directiony := (dy >= 0) ^ swapy
            if (nx>0){
                directionx := (dx >= 0) ^ swapx
                if (directionx = 1){
			        send, {WheelRight %nx%}
                }
		        else if (directionx = 0){
			        send, {WheelLeft %nx%}
                }

                dx := 0
            }
            if (directiony = 1){
			    send, {wheeldown %ny%}
            }
		    else if (directiony = 0){
			    send, {wheelup %ny%}
            }
            dy := 0
        }
        else if(nx>0){
            directionx := (dx >= 0) ^ swapx
            if (directionx = 1){
			    send, {WheelRight %nx%}
            }
		    else if (directionx = 0){
			    send, {WheelLeft %nx%}
            }
            dx := 0
        }

        mouseMove, mxLast, myLast, 0


	}
}

F17::
    if (running == 0){
	running := 1
    dy := 0
    dx := 0
	mousegetpos, mxLast, myLast
    ; mxOrig := mxLast
    ; myOrig := myLast
    }

return

F17 up::
	running := 0
    ; MouseMove, mxOrig, myOrig
return
