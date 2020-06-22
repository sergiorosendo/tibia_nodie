ini_read(ByRef ini_file, ByRef ini_section, ByRef ini_key, ByRef ini_default := "error")
{

    IniRead, output_var, %ini_file%, %ini_section%, %ini_key%, %ini_default%
    return %output_var%
}

ini_read_array(ByRef ini_file, ByRef ini_section, ByRef ini_key, ByRef ini_default := "error") {

    IniRead, output_str, %ini_file%, %ini_section%, %ini_key%, %ini_default%
    arr := StrSplit(output_str, ", ")
    return %arr%
}

random_sleep_k(ByRef min, ByRef max) {

	sleep(random_k(min, max))
}

random_sleep(ByRef min, ByRef max) {

	sleep(random(min, max))
}

random_k(ByRef min, ByRef max) {

    random, n, % min*1000, % max*1000
	return %n%
}

random(ByRef min, ByRef max) {

    random, r, %min%, %max%
	return %r%
}


send_sleep(ByRef key, ByRef t) {

    send(key)
    sleep(t)
}

send(ByRef key) {

    Send, %key%
}

send_active_window(ByRef key, ByRef window) {

    if !window_active(window)
        return

    send(key)
}

sleep(ByRef t) {

    Sleep, %t%
}

send_random_key(byRef key_array) {

    send(random_array_element(key_array))
}

control_send_random_key_window(byRef key_array, ByRef window) {

    control_send(random_array_element(key_array), window)
}

random_array_element(ByRef array) {

    return array[random(1, array.MaxIndex())]
}

control_send_random_key_active_window(byRef key_array, ByRef window) {

    if window_active(window)
        return control_send_random_key_window(key_array, window)
}

control_send_random_key_inactive_window(byRef key_array, ByRef window) {

    if !window_active(window)
        return control_send_random_key_window(key_array, window)
}

control_send(ByRef key, ByRef window) {

    ControlSend, ahk_parent, %key%, %window%
}

connected_to_internet(flag = 0x40) {

    return DllCall("Wininet.dll\InternetGetConnectedState", "Str", flag, "Int", 0)
}

window_active(ByRef window) {

    return WinActive(window)
}

window_activate(ByRef window) {

    window_show(window)
    WinActivate, %window%
}

window_exist(ByRef window) {

    return WinExist(window)
}

window_show(byRef window) {

    WinShow, %window%
}

window_minimize(byRef window) {

    WinMinimize, %window%
}

is_green(ByRef bgr) {

    r := bgr & 0xff
    g := ((bgr >> 8) & 0xff) - 32 ;variation allowed
    b := (bgr >> 16) & 0xff
    return g > r && g > b
}

is_yellow(ByRef bgr) {

    r := bgr & 0xff
    if (r < 120)
        return false

    g := (bgr >> 8) & 0xff
    if (g < 120)
        return false

    d := abs(g - r)
    if (d > 32 + 32)
        return false

    d += ((bgr >> 16) & 0xff) + 16

    return r > d && g > d
}

is_red(ByRef bgr) {

    r := (bgr & 0xff) - 32
    g := (bgr >> 8) & 0xff
    b := (bgr >> 16) & 0xff
    return r > b && r > g
}

is_blue(ByRef bgr) {

    r := bgr & 0xff
    g := (bgr >> 8) & 0xff
    b := ((bgr >> 16) & 0xff) - 32 ;variation allowed
    return b > r && b > g
}

find_image(ByRef image_file_name, ByRef found_x := 0, ByRef found_y := 0) {

    return image_search(image_file_name, 0, 0, A_ScreenWidth, A_ScreenHeight, found_x, found_y)
}

find_image_in(ByRef image_file_name, ByRef x_beg, ByRef y_beg, ByRef x_end, ByRef y_end, ByRef found_x := 0, ByRef found_y := 0) {

    return image_search(image_file_name, x_beg, y_beg, x_end, y_end, found_x, found_y)
}

image_search(ByRef image_file_name, ByRef x_beg, ByRef y_beg, ByRef x_end, ByRef y_end, ByRef found_x := 0, ByRef found_y := 0) {

    ImageSearch, found_x, found_y, x_beg, y_beg, x_end, y_end, *0 %image_file_name%

    if (ErrorLevel)
        return false ;ErrorLevel: 1 - image not found 2 - file not found

    return true
}

drag_random(ByRef x1_min, ByRef x1_max, ByRef y1_min, ByRef y1_max, ByRef x2_min, ByRef x2_max, ByRef y2_min, ByRef y2_max) {

    x1 := random(x1_min, x1_max)
    y1 := random(y1_min, y1_max)
    x2 := random(x2_min, x2_max)
    y2 := random(y2_min, y2_max)

    SendEvent {Click %x1%, %y1%, down}{Click %x2%, %y2%, up}
}

click_random(ByRef x_min, ByRef x_max, ByRef y_min, ByRef y_max, ByRef mouse_button) {

    x := random(x_min, x_max)
    y := random(y_min, y_max)
    SendEvent {Click %x%, %y%, %mouse_button%}
}

click(byRef x, byRef y, byref mouse_button) {

    SendEvent {Click %x%, %y%, %mouse_button%}
}

send_array(ByRef array) {

    for index, element in array
        send_sleep(element, random(40, 90))
}

send_string(ByRef str) {

    array :=  StrSplit(str)
    array.push("{Enter}")
    send_array(array)
}

is_suspended() {

    return A_IsSuspended
}

is_paused() {

    return A_IsPaused
}

on_off_tooltip(ByRef script_name, byRef window, ByRef tool_tip_id := 1) {

    win_get_pos(x, y, width, height, window)

    tool_tip_x := width - 165
    tool_tip_y := height - (1 + tool_tip_id) * 40
    state := (is_suspended()) ? "Off" : "On"

    tool_tip(script_name . " " . state, tool_tip_x, tool_tip_y, tool_tip_id)
}

tray_tip(ByRef title := " ", ByRef message := " ", ByRef duration := 2000, ByRef tray_icon := 1) {

    TrayTip, %title%, %message%, %duration%, %tray_icon%
}

tool_tip(ByRef message, ByRef x, ByRef y, ByRef tool_tip_id := 1) {

    Tooltip, %message%, %x%, %y%, %tool_tip_id%
}

pixel_get_color(ByRef x, ByRef y) {

    PixelGetColor, bgr, % x, % y
    return %bgr%
}

win_get_pos(byRef x, byref y, byref width, byref height, byref window) {

    WinGetPos, x, y, width, height, %window%
}

;~^!s::
;Suspend
;return

;~^!e::
;ExitApp
;return