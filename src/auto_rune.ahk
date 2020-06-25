#include header.ahk

rune_keys := ini_read_array("config.ini", "tibia_hotkeys", "rune")
boots_keys := ini_read_array("config.ini", "tibia_hotkeys", "boots")
food_keys := ini_read_array("config.ini", "tibia_hotkeys", "food")
mana_waste_keys := ini_read_array("config.ini", "tibia_hotkeys", "mana_waste")
ring_keys := ini_read_array("config.ini", "tibia_hotkeys", "ring")

SetTimer, FOOD, % -random_k(0, 1)
SetTimer, BOOTS, % -random_k(2, 3)
SetTimer, RING, % -random_k(4, 5)
SetTimer, RUNE, % -random_k(6, 7)
SetTimer, MANA_WASTE, % -random_k(8, 9)
Return

FOOD:
    control_send_random_key_window(food_keys, main_char_window)
    if (random(1, 5) = 5)
        SetTimer, FOOD, % random(500, 1500)
    Else
        SetTimer, FOOD, % random_k(240, 360)
    Return

BOOTS:
    Critical
    control_send_random_key_inactive_window(boots_keys, main_char_window)
    SetTimer, BOOTS, % random_k(300, 450)
    Return

RING:
    Critical
    control_send_random_key_inactive_window(ring_keys, main_char_window)
    SetTimer, RING, % random_k(452, 455)
    Return

RUNE:
    control_send_random_key_inactive_window(rune_keys, main_char_window)
    if (random(1, 10) = 10)
        SetTimer, RUNE, % random_k(2, 5)
    Else
        SetTimer, RUNE, % random_k(70, 80)
    Return

MANA_WASTE:
    control_send_random_key_inactive_window(mana_waste_keys, main_char_window)
    SetTimer, MANA_WASTE, % random_k(100, 115)
    Return