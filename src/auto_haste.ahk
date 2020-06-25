#include header.ahk

SetBatchLines, 7ms
tool_tip_id := 4

Global vocation := "MS"

;Keys
Global haste := ini_read("healer_config.ini", "tibia_hotkeys", "auto_haste_spell")

Global heal
if (vocation = "MS")
    heal := ini_read("healer_config.ini", "tibia_hotkeys", "exura_vita")
if (vocation = "ED")
    heal := ini_read("healer_config.ini", "tibia_hotkeys", "exura_vita")
if (vocation = "RP")
    heal := ini_read("healer_config.ini", "tibia_hotkeys", "exura_gran_san")
if (vocation = "EK")
    heal := ini_read("healer_config.ini", "tibia_hotkeys", "exura_ico")

;check interval in milliseconds
Global auto_haste_check_interval := ini_read("healer_config.ini", "auto_heal", "auto_haste_check_interval")

;boolean
Global auto_haste := (ini_read("healer_config.ini", "auto_heal", "auto_haste") = "true") ? true : false

Global min_reaction_time := 1
Global max_reaction_time := 75

Global haste_cooldown := 2050
Global heal_cooldown := 1050
Global haste_exhausted := false
Global heal_exhausted := false

;ahk hotkeys
Global auto_haste_suspend_hk := ini_read("healer_config.ini", "hotkeys", "toggle_auto_haste_on_off")


Hotkey, IfWinActive, %main_char_window%
Hotkey, %auto_haste_suspend_hk%, SUSP

SetTimer, TRY_HASTE, -3000
return

SUSP:
    Suspend
    on_off_tooltip("Auto haste", main_char_window, tool_tip_id)
    SetTimer, REMOVE_TOOL_TIP, -2000
    if !is_suspended()
        SetTimer, TRY_HASTE, -500
    Return

REMOVE_TOOL_TIP:
    Tooltip,,,, %tool_tip_id%
    return

REMOVE_HASTE_EXHAUSTION:
    haste_exhausted := false
    return

REMOVE_HEAL_EXHAUSTION:
    heal_exhausted := false
    return

TRY_HASTE:
    if is_suspended()
        SetTimer, TRY_HASTE, Off
    else if !window_active(main_char_window)
        SetTimer, TRY_HASTE, -3000
    else if heal_slow_auto_haste()
        SetTimer, TRY_HASTE, % -auto_haste_check_interval
    SetTimer, TRY_HASTE, % -auto_haste_check_interval
    return

old_heal_slow() {

    if !has_status_condition("slowed")
        return false

    if !haste_exhausted
    {

        cast_haste()
        return true
    }
    else if !heal_exhausted
    {

        cast_heal()
        return true
    }

    return false
}

heal_slow_auto_haste() {
    ; auto heals slow and maintains haste trough checking if character has the haste condition

    if has_status_condition("haste")
       return false

    if !haste_exhausted
    {

        cast_haste()
        return true
    }
    else if !heal_exhausted
    {

        cast_heal()
        return true
    }

    return false
}

keep_hasted() {

    if !(auto_haste and !haste_exhausted and !has_status_condition("haste") and has_status_condition("logout_block"))
        return false

    cast_haste()
    return true
}

cast_haste() {


    haste_exhausted := true
    SetTimer, REMOVE_HASTE_EXHAUSTION, % -haste_cooldown
    sleep(random(min_reaction_time, max_reaction_time))
    send(haste)
}

cast_heal() {

    heal_exhausted := true
    SetTimer, REMOVE_HEAL_EXHAUSTION, % -heal_cooldown
    sleep(random(min_reaction_time, max_reaction_time))
    send(heal)
}