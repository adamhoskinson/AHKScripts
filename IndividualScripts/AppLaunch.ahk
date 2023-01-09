#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SpotifyPath := "!!!SetSpotifyPath!!!"
TodoPath := "!!!SetTodoPath!!!"

#^+!t::
if WinExist(Todo ahk_exe chrome.exe)
    WinActivate
else
    run, %TodoPath%%
return

#^+!s::
if WinExist(ahk_exe Spotify.exe)
    WinActivate
else
    run, %SpotifyPath%
return