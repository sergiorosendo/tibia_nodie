#include header.ahk

soft := 0
soft_cnt := 7
stop := False

repair_boots_hk := ini_read("config.ini", "hotkeys", "repair_boots")

Hotkey, IfWinActive, %main_char_window%
Hotkey, %repair_boots_hk%, REPAIR_BOOTS
Hotkey, ~Escape, STOP
return

STOP:
    SetTimer, REPAIR_BOOTS, Delete
    stop := true
    soft := 0
    return

REPAIR_BOOTS:

    if !window_active(main_char_window)
        Goto, STOP

    if (soft = 0)
    {

        stop := False
        activate_npc_channel()
    }

    soft := soft + 1

    send_string("repair")
    send_string("yes")

    if ((soft >= soft_cnt) or stop)
        Goto, STOP
    Else
        SetTimer, REPAIR_BOOTS, % -random(1, 50)
    return