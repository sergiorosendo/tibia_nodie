#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run, auto_rune.ahk, src, Min
Run, gfb_macro.ahk, src, Min
Run, auto_loot.ahk, src, Min
Run, npc_shortcuts.ahk, src, Min
Run, auto_hp.ahk, src, Min
Run, auto_potion.ahk, src, Min
Run, auto_haste.ahk, src, Min

OnExit("ExitFunc")

ExitFunc()
{
    Run,%ComSpec% /c Taskkill -f -im autohotkey.exe,%A_ScriptDir%,Hide
}

#include src/min_win_tray.ahk

return
