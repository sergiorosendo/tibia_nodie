#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Run, auto_log_in.exe, Min
Run, auto_rune.exe, Min
;Run, repair_soft.exe, Min
;Run, drag_rings.exe, Min
Run, gfb_macro.exe, Min
Run, auto_loot.exe, Min
Run, npc_shortcuts.exe, Min
Run, auto_hp.exe, Min
Run, auto_potion.exe, Min
Run, auto_haste.exe, Min

OnExit("ExitFunc")

ExitFunc()
{
    ;Process, Close, auto_log_in.exe
    Process, Close, auto_rune.exe
    ;Process, Close, repair_soft.exe
    ;Process, Close, drag_rings.exe
    Process, Close, gfb_macro.exe
    Process, Close, auto_loot.exe
    Process, Close, npc_shortcuts.exe
    Process, Close, auto_hp.exe
    Process, Close, auto_potion.exe
    Process, Close, auto_haste.exe
}

#include min_win_tray.ahk

return
