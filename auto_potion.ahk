#include header.ahk

tool_tip_id := 2

Global vocation := "MS"
;Keys
Global mana_potion := ini_read("healer_config.ini", "tibia_hotkeys", "mana_potion")
Global ultimate_health_potion := ini_read("healer_config.ini", "tibia_hotkeys", "ultimate_health_potion")
Global supreme_health_potion := ini_read("healer_config.ini", "tibia_hotkeys", "supreme_health_potion")
Global great_spirit_potion := ini_read("healer_config.ini", "tibia_hotkeys", "great_spirit_potion")
Global ultimate_spirit_potion := ini_read("healer_config.ini", "tibia_hotkeys", "ultimate_spirit_potion")
Global make_rune := ini_read("healer_config.ini", "tibia_hotkeys", "make_rune")

;Thresholds
Global mana_potion_threshold := ini_read("healer_config.ini", "auto_heal", "mana_potion_threshold")
Global ultimate_health_potion_threshold := ini_read("healer_config.ini", "auto_heal", "ultimate_health_potion_threshold")
Global supreme_health_potion_threshold := ini_read("healer_config.ini", "auto_heal", "supreme_health_potion_threshold")
Global great_spirit_potion_threshold := ini_read("healer_config.ini", "auto_heal", "great_spirit_potion_threshold")
Global ultimate_spirit_potion_threshold := ini_read("healer_config.ini", "auto_heal", "ultimate_spirit_potion_threshold")
Global make_rune_threshold := ini_read("healer_config.ini", "auto_heal", "make_rune_threshold")

;boolean
Global make_rune_to_prevent_full_mana := (ini_read("healer_config.ini", "auto_heal", "make_rune_to_prevent_full_mana") = "true") ? true : false

;check interval in milliseconds
Global auto_potion_check_interval := ini_read("healer_config.ini", "auto_heal", "auto_potion_check_interval")

Global potion_cooldown := 1100
Global min_reaction_time := 1
Global max_reaction_time := 75

Global hp_bar_x_beg := 190
Global hp_bar_x_end := 837
Global hp_bar_y := 8

Global mp_bar_x_beg := 1554
Global mp_bar_x_end := 907
Global mp_bar_y := 8

;ahk hotkeys
Global auto_potion_suspend_hk := ini_read("healer_config.ini", "hotkeys", "toggle_auto_potion_on_off")



Hotkey, IfWinActive, %main_char_window%
Hotkey, %auto_potion_suspend_hk%, SUSP

SetTimer, TRY_HEAL, -3000
SetTimer, TRY_MAKE_RUNE, -2500
return

return

SUSP:
    Suspend
    on_off_tooltip("Auto potion", main_char_window, tool_tip_id)
    SetTimer, REMOVE_TOOL_TIP, -2000
    if !is_suspended() {

        SetTimer, TRY_HEAL, -500
        SetTimer, TRY_MAKE_RUNE, -2500
    }
    Return

REMOVE_TOOL_TIP:
    Tooltip,,,, %tool_tip_id%
    return

TRY_HEAL:
    if is_suspended()
        SetTimer, TRY_HEAL, Off
    else if !window_active(main_char_window)
        SetTimer, TRY_HEAL, -3000
    else if use_hp_potion() or use_mp_potion()
         SetTimer, TRY_HEAL, % -potion_cooldown
    else
        SetTimer, TRY_HEAL, % -auto_potion_check_interval
    return

TRY_MAKE_RUNE:
    if is_suspended()
        SetTimer, TRY_MAKE_RUNE, Off
    else if !window_active(main_char_window)
        SetTimer, TRY_MAKE_RUNE, -4000
    else {

        try_make_rune(make_rune_threshold, make_rune)
        SetTimer, TRY_MAKE_RUNE, -4000
    }
    return

use_hp_potion() {

    if (vocation = "MS")
        return false
    if (vocation = "ED")
        return false
    if (vocation = "EK")
        return check_hp_threshold(supreme_health_potion_threshold, supreme_health_potion) or check_hp_threshold(ultimate_health_potion_threshold, ultimate_health_potion)
    if (vocation = "RP")
        return check_hp_threshold(ultimate_spirit_potion_threshold, ultimate_spirit_potion) or check_hp_threshold(great_spirit_potion_threshold, great_spirit_potion)
}

use_mp_potion() {

    return check_mp_threshold(mana_potion_threshold, mana_potion)
}

try_make_rune(byref threshold, byref key) {

    if !make_rune_to_prevent_full_mana
        return false
    if (vocation != "MS" and vocation != "ED")
        return False

    mp_bar_x := mp_bar_x_beg - threshold*(mp_bar_x_beg - mp_bar_x_end)

    if is_mp_color(pixel_get_color(mp_bar_x, mp_bar_y))
    {

        sleep(random(min_reaction_time, max_reaction_time))
        send(key)

        return true
    }

    return false
}

check_hp_threshold(byRef threshold, byRef key) {

    hp_bar_x := hp_bar_x_beg + threshold*(hp_bar_x_end - hp_bar_x_beg)

    if !is_hp_color(pixel_get_color(hp_bar_x, hp_bar_y))
    {

        sleep(random(min_reaction_time, max_reaction_time))
        send(key)
        return True
    }

    return False
}

check_mp_threshold(byRef threshold, byRef key) {

    mp_bar_x := mp_bar_x_beg - threshold*(mp_bar_x_beg - mp_bar_x_end)

    if !is_mp_color(pixel_get_color(mp_bar_x, mp_bar_y))
    {

        sleep(random(min_reaction_time, max_reaction_time))
        send(key)

        return True
    }

    return False
}

is_hp_color(byRef bgr) {

    return is_red(bgr) or is_yellow(bgr) or is_green(bgr)
}

is_mp_color(byRef bgr) {

    return is_blue(bgr)
}
