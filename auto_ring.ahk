#include header.ahk

Global ring_keys := ini_read_array("config.ini", "tibia_hotkeys", "ring")
SetTimer, RING, % -random_k(7, 9)
Return

RING:
    control_send_random_key_inactive_window(ring_keys, main_char_window)
    SetTimer, RING, % -random_k(452, 455)
    Return