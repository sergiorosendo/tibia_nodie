#include header.ahk

tool_tip_id := 3
Global vocation := "MS"

;keys
Global exura := ini_read("healer_config.ini", "tibia_hotkeys", "exura")
Global exura_gran := ini_read("healer_config.ini", "tibia_hotkeys", "exura_gran")
Global exura_vita := ini_read("healer_config.ini", "tibia_hotkeys", "exura_vita")
Global exura_ico := ini_read("healer_config.ini", "tibia_hotkeys", "exura_ico")
Global exura_gran_ico := ini_read("healer_config.ini", "tibia_hotkeys", "exura_gran_ico")
Global exura_gran_san := ini_read("healer_config.ini", "tibia_hotkeys", "exura_gran_san")

;Thresholds
Global exura_threshold := ini_read("healer_config.ini", "auto_heal", "exura_threshold")
Global exura_gran_threshold := ini_read("healer_config.ini", "auto_heal", "exura_gran_threshold")
Global exura_vita_threshold := ini_read("healer_config.ini", "auto_heal", "exura_vita_threshold")
Global exura_ico_threshold := ini_read("healer_config.ini", "auto_heal", "exura_ico_threshold")
Global exura_gran_ico_threshold := ini_read("healer_config.ini", "auto_heal", "exura_gran_ico_threshold")
Global exura_gran_san_threshold := ini_read("healer_config.ini", "auto_heal", "exura_gran_san_threshold")

;check interval in milliseconds
Global auto_heal_spell_check_interval := ini_read("healer_config.ini", "auto_heal", "auto_heal_spell_check_interval")

;bar coordinates
Global hp_bar_x_beg := 190
Global hp_bar_x_end := 837
Global hp_bar_y := 8

;heal_spell_cooldown
Global heal_spell_cooldown := 1100

;reaction time
Global min_reaction_time := 1
Global max_reaction_time := 75

;ahk hotkeys
Global auto_hp_suspend_hk := ini_read("healer_config.ini", "hotkeys", "toggle_auto_heal_spell_on_off")


Hotkey, IfWinActive, %main_char_window%
Hotkey, %auto_hp_suspend_hk%, SUSP

SetTimer, TRY_HEAL, -3000
return

SUSP:
    Suspend
    on_off_tooltip("Auto heal spell", main_char_window, tool_tip_id)
    SetTimer, REMOVE_TOOL_TIP, -2000
    if !is_suspended()
        SetTimer, TRY_HEAL, -500
    Return

REMOVE_TOOL_TIP:
    Tooltip,,,, %tool_tip_id%
    return

TRY_HEAL:
    if is_suspended()
        SetTimer, TRY_HEAL, Off
    else if !window_active(main_char_window)
        SetTimer, TRY_HEAL, -3000
    else if heal()
        SetTimer, TRY_HEAL, % -heal_spell_cooldown
    else
        SetTimer, TRY_HEAL, % -auto_heal_spell_check_interval
    return

heal() {

    if (vocation = "MS")
        return check_hp_threshold(exura_vita_threshold, exura_vita) or check_hp_threshold(exura_gran_threshold, exura_gran) or check_hp_threshold(exura_threshold, exura)
    if (vocation = "ED")
        return check_hp_threshold(exura_vita_threshold, exura_vita) or check_hp_threshold(exura_gran_threshold, exura_gran) or check_hp_threshold(exura_threshold, exura)
    if (vocation = "EK")
        return check_hp_threshold(exura_gran_ico_threshold, exura_gran_icon) or check_hp_threshold(exura_ico_threshold, exura_ico)
    if (vocation = "RP")
        return check_hp_threshold(exura_gran_san_threshold, exura_gran_san) or check_hp_threshold(exura_gran_threshold, exura_gran) or check_hp_threshold(exura_threshold, exura)
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

is_hp_color(byRef bgr) {

    return is_red(bgr) or is_yellow(bgr) or is_green(bgr)
}