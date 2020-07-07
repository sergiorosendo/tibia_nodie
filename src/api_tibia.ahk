#include api_misc.ahk

Global activate_chat_key := ini_read("config.ini", "tibia_hotkeys", "activate_chat")
Global activate_npc_channel_key := ini_read("config.ini", "tibia_hotkeys", "activate_npc_channel")

run_tibia() {

    SetTitleMatchMode, 1

    if !window_exist("Tibia")
    {
        SetTitleMatchMode, 3
        RunWait, Tibia.exe, C:\Users\user\AppData\Local\Tibia\
        sleep(random_k(9, 12))
    }

    SetTitleMatchMode, 3
}

activate_npc_channel() {

    send_sleep(activate_chat_key, random(75, 115))
    send_sleep(activate_npc_channel_key, random(75, 115))
    send_string("hi")
}

trade() {

    activate_npc_channel()
    send_string("trade")
}

travel(byRef city) {

    activate_npc_channel()
    send_string(city)
    if (city = darashia) send_string("yes")
    send_string("yes")
}

equipment_has_image(image_file_name)
{

    return find_image(image_file_name)
}

logged_in() {

    SetTitleMatchMode, 1

    logged := window_exist("Tibia - ")

    SetTitleMatchMode, 3

    return logged
}

wait_logged_in() {


    tries := 10
    i := 0

    while (i < tries)
    {

        if logged_in()
            return true

        i := i + 1
        sleep(random_k(1, 2))
    }

    return false
}

Global status_box_x_beg := 851
Global status_box_x_end := 897
Global status_box_y_beg := 9
Global status_box_y_end := 16 ;first layer only

has_status_condition(byref status_condition) {

    folder := "img/"
    extension := ".png"
    status_condition_image := folder . status_condition . extension

    return find_image_in(status_condition_image, status_box_x_beg, status_box_y_beg, status_box_x_end, status_box_y_end)
}
