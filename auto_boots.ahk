#include header.ahk

Global boots_keys := ini_read_array("config.ini", "tibia_hotkeys", "boots")
SetTimer, BOOTS, % -random_k(4, 6)
Return

BOOTS:
    control_send_random_key_inactive_window(boots_keys, main_char_window)
    SetTimer, BOOTS, % -random_k(300, 450)
    Return