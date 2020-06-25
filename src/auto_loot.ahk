#include header.ahk

SetDefaultMouseSpeed, 0

tool_tip_id := 5

Global sqm := 60
Global half_sqm := 12 ;less than half sqm

;char position
char_x := 870
char_y := 410

auto_loot_suspend_hk := ini_read("config.ini", "hotkeys", "toggle_auto_loot_on_off")
auto_loot_hk := ini_read("config.ini", "hotkeys", "auto_loot")

Hotkey, IfWinActive, %main_char_window%
Hotkey, %auto_loot_suspend_hk%, SUSP
Hotkey, %auto_loot_hk%, AUTO_LOOT

return

SUSP:
    Suspend
    on_off_tooltip("Auto Loot", main_char_window, tool_tip_id)
    SetTimer, REMOVE_TOOL_TIP, -2000
    Return

REMOVE_TOOL_TIP:
    Tooltip,,,, %tool_tip_id%
    return

AUTO_LOOT:
    loot_all(char_x, char_y)
    Return

loot_all(byRef char_x, byref char_y) {

    MouseGetPos, mouse_x, mouse_y

    send("{Shift down}")
    loot(char_x, char_y, 0, 0)   ;center
    loot(char_x, char_y, -1, -1) ;north-west
    loot(char_x, char_y, 0, -1)  ;north
    loot(char_x, char_y, 1, -1)  ;north-east
    loot(char_x, char_y, 1, 0)   ;east
    loot(char_x, char_y, 1, 1)   ;south-east
    loot(char_x, char_y, 0, 1)   ;south
    loot(char_x, char_y, -1, 1)  ;south-west
    loot(char_x, char_y, -1, 0)  ;west
    send("{Shift up}")

    click(mouse_x, mouse_y, 0) ;return mouse to its original position
}

loot(x, y, byRef x_sign, byRef y_sign) {

    x := x + x_sign*sqm
    y := y + y_sign*sqm
    x_min := x - half_sqm
    x_max := x + half_sqm
    y_min := y - half_sqm
    y_max := y + half_sqm

    click_random(x_min, x_max, y_min, y_max, "right")
    random_sleep(11, 14)
}