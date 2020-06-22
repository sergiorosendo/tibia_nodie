#include header.ahk

SetMouseDelay, 10

ring := 0
bp := 0
ring_per_bp := 21
bp_cnt := 40
stop := False

;ring source coordinates
x1_min := 1582
x1_max := 1606
y1_min := 274
y1_max := 298
;ring destination coordinates
x2_min := 1620
x2_max := 1644
y2_min := 208
y2_max := 232

drag_rings_hk := ini_read("config.ini", "hotkeys", "drag_rings")

Hotkey, IfWinActive, %main_char_window%
Hotkey, %drag_rings_hk%, DRAG_RINGS
Hotkey, ~Escape, STOP
return

STOP:
    SetTimer, DRAG_RINGS, Delete
    stop := true
    ring := 0
    bp := 0
    return

DRAG_RINGS:

    if !window_active(main_char_window)
       Goto, STOP

    if ring = 0
        stop := False

    drag_random(x1_min, x1_max, y1_min, y1_max, x2_min, x2_max, y2_min, y2_max)
    ring := ring + 1

    if (ring >= ring_per_bp)
    {

        random_sleep(25, 75)
        click_random(x2_min, x2_max, y2_min, y2_max, "right")
        ring := 0
        bp := bp + 1
    }

    if ((bp >= bp_cnt) or stop)
        Goto, STOP
    Else
        SetTimer, DRAG_RINGS, % -random(3, 12)
    return