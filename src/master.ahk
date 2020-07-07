#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Run, auto_log_in.ahk, Min
Run, auto_rune.ahk, Min
;Run, repair_soft.ahk, Min
;Run, drag_rings.ahk, Min
Run, gfb_macro.ahk, Min
Run, auto_loot.ahk, Min
Run, npc_shortcuts.ahk, Min
Run, auto_hp.ahk, Min
Run, auto_potion.ahk, Min
Run, auto_haste.ahk, Min

OnExit("ExitFunc")

ExitFunc()
{
    Run,%ComSpec% /c Taskkill -f -im autohotkey.exe,%A_ScriptDir%,Hide
    ;Process, Close, auto_log_in.ahk
    ;Process, Close, auto_rune.ahk
    ;Process, Close, repair_soft.ahk
    ;Process, Close, drag_rings.ahk
    ;Process, Close, gfb_macro.ahk
    ;Process, Close, auto_loot.ahk
    ;Process, Close, npc_shortcuts.ahk
    ;Process, Close, auto_hp.ahk
    ;Process, Close, auto_potion.ahk
    ;Process, Close, auto_haste.ahk
}

#include min_win_tray.ahk

return
