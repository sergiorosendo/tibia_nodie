#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Run, _lo.exe, Min
Run, _rm.exe, Min
Run, _re.exe, Min
Run, _dr.exe, Min
Run, _gf.exe, Min
Run, _lt.exe, Min
Run, _np.exe, Min
Run, _hp.exe, Min
Run, _po.exe, Min
Run, _ha.exe, Min

OnExit("ExitFunc")

ExitFunc()
{
    Process, Close, _lo.exe
    Process, Close, _rm.exe
    Process, Close, _re.exe
    Process, Close, _dr.exe
    Process, Close, _gf.exe
    Process, Close, _lt.exe
    Process, Close, _np.exe
    Process, Close, _hp.exe
    Process, Close, _po.exe
    Process, Close, _ha.exe
}

#include min_win_tray.ahk

return
