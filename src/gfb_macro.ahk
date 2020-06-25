#include header.ahk

tool_tip_id := 1
auto_gfb_suspend_hk := ini_read("config.ini", "hotkeys", "toggle_auto_gfb_on_off")
gfb_1_key := ini_read("config.ini", "hotkeys", "gfb_1")
gfb_2_key := ini_read("config.ini", "hotkeys", "gfb_2")

Hotkey, IfWinActive, %main_char_window%
Hotkey, %auto_gfb_suspend_hk%, SUSP
Hotkey, %gfb_1_key%, GFB_1
Hotkey, %gfb_2_key%, GFB_2

Return

SUSP:
    Suspend
    on_off_tooltip("Auto GFB", main_char_window, tool_tip_id)
    SetTimer, REMOVE_TOOL_TIP, -2000
    Return

REMOVE_TOOL_TIP:
    Tooltip,,,, %tool_tip_id%
    return

GFB_1:
    random_sleep(5, 10)
    Click
    return

GFB_2:
    random_sleep(5, 10)
    Click
    return