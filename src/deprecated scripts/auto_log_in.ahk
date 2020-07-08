#include header.ahk

Global main_char_id := 0
Global char_cnt = 8

first_log_in := false

Global acc_name := ini_read("config.ini", "accounts", "acc_name")
Global pass := ini_read("config.ini", "account", "pass")


run_tibia()
SetTimer, AUTO_LOG_IN, -1000

Hotkey, IfWinActive, Tibia
Hotkey, >^>!F12, LOG_IN
return

LOG_IN:

    log_in()
    return

AUTO_LOG_IN:

    SetTimer, AUTO_LOG_IN, % random_k(120, 240)

    if (((A_Hour = 04) AND (A_Min >= 55) AND (A_Min <= 59)) OR ((A_Hour = 05) AND (A_Min >= 00) AND (A_Min <= 05)))
    {

        first_log_in := True
        return
    }

    if !window_exist("Tibia")
        return

    if !connected_to_internet()
        return

    tray_tip("Tibia", "Character offline", 2000, 3)

    window_activate("Tibia")

    if !window_active("Tibia")
        return

    if first_log_in
    {
        train_characters()
        first_log_in := False
    }

    if !connected_to_internet()
        return

    log_in_character(main_char_id)

    if window_active(main_char_window)
        window_minimize(main_char_window)

    return

log_in() {

    if !window_active("Tibia")
        return false

    send_sleep("{Esc}", random(400, 600))

    ; uncomment these if account name is not saved by the tibia client
    ;if !is_log_in_screen()
    ;   return false

    ;clipboard := acc_name
    ;ClipWait, 0, 0

    ;send_sleep("^v", random(400, 600))
    ;clipboard := ""

    ;send_sleep("{Tab}", random(400, 600))

    if !is_log_in_screen()
        return false

    clipboard := pass
    ClipWait, 0, 0

    send_sleep("^v", random(400, 600))

    clipboard := ""

    send_sleep("{Enter}", random_k(1, 2))

    return wait_char_selection_screen()
}

train_characters() {

    char_id := 0
    while (char_id < char_cnt)
    {

        if (char_id != main_char_id)
            train_character(char_id)

        char_id := char_id + 1
    }
}

train_character(byRef char_id) {

    if !window_active("Tibia")
        send_sleep("^l", random_k(2, 3))

    send_sleep("{Esc}", random_k(0, 1))

    if !wait_log_in_screen()
        return false

    log_in_character(char_id)

    if get_statue_position(x, y)
    {
        click(x, y, "right")
        random_sleep_k(3, 4)
    }
    else
        send_sleep("^l", random_k(2, 3))

    return true
}

get_statue_position(byRef x, byRef y) {

    if !get_statue_file_name(statue_file_name)
    {

        tray_tip("Train Character", "Unknown vocation", 2000, 3)
        return false
    }

    tries := 20
    i := 0
    found := false

    while (i < tries) {

        if find_image(statue_file_name, x, y)
        {
            found := true
            break
        }

        i := i + 1
        sleep(random_k(1, 2))
    }

    if !found
    {

        tray_tip("Train Character", "Statue not found", 2000, 3)
        return false
    }

    if (statue_file_name = "images/sword_statue.png")
    {
        x := x + 66
        y := y + 28
    }

    if (statue_file_name = "images/distance_statue.png")
    {
        x := x + 87
        y := y + 21
    }

    return true
}

get_statue_file_name(byref statue_file_name) {

    if (equipment_has_image("images/hat.png"))
        statue_file_name := "images/magic_statue.png"
    else if (equipment_has_image("images/mace.png"))
        statue_file_name := "images/club_statue.png"
    else if (equipment_has_image("images/sword.png"))
        statue_file_name := "images/sword_statue.png"
    else if (equipment_has_image("images/axe.png"))
        statue_file_name := "images/axe_statue.png"
    else if (equipment_has_image("images/bow.png"))
        statue_file_name := "images/distance_statue.png"
    else {
        statue_file_name := ""
        return false
    }

    return true
}

log_in_character(byref char_id) {

    if !log_in()
    {
        send_sleep("{Esc}", random(200, 300))
        return false
    }

    send_sleep("{Down}", random(200, 300))

    i := 0
    while (i != char_id) {

        send_sleep("{Down}", random(200, 300))
        i := i + 1
        if (i >= char_cnt)
            break
    }

    send_sleep("{Enter}", random_k(1, 2))

    return wait_logged_in()
}

wait_char_selection_screen() {

    tries := 10
    i := 0

    while (i < tries)
    {

        if find_image("images/select_character.png")
            return True

        i := i + 1
        sleep(random_k(1, 2))
    }

    return false
}

wait_log_in_screen() {

    tries := 10
    i := 0

    while (i < tries)
    {

        if is_log_in_screen()
            return True

        i := i + 1
        sleep(random_k(1, 2))
    }

    return false
}

is_log_in_screen() {

    return find_image("images/log_in.png")
}