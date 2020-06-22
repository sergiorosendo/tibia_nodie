#include header.ahk

Global mana_waste_keys := ini_read_array("config.ini", "tibia_hotkeys", "mana_waste")
SetTimer, MANA_WASTE, % -random_k(13, 15)
Return

MANA_WASTE:
    control_send_random_key_inactive_window(mana_waste_keys, main_char_window)
    SetTimer, MANA_WASTE, % -random_k(100, 115)
    Return
