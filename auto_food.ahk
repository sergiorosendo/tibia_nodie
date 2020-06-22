#include header.ahk

Global food_keys := ini_read_array("config.ini", "tibia_hotkeys", "food")
SetTimer, FOOD, % -random_k(1, 3)
Return

FOOD:
    food()
    SetTimer, FOOD, % -random_k(240, 360)
    Return

food() {

    control_send_random_key_window(food_keys, main_char_window)
    if (random(1, 5) = 5) {

        sleep(random_k(0, 1))
        control_send_random_key_window(food_keys, main_char_window)
    }
}