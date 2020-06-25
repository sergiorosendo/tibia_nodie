#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#Persistent
#SingleInstance force

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 3
DetectHiddenWindows, On
CoordMode, Pixel, Client
CoordMode, ToolTip, Client
CoordMode, Mouse, Client
SetKeyDelay, 0
SetMouseDelay, 0
ListLines Off ; increase script performance
SetBatchLines, 10ms ;higher values increase script performance, but consume more cpu

#include api_misc.ahk
#include api_tibia.ahk

Global main_char_window := "Tibia - "
main_char_window := main_char_window . ini_read("config.ini", "account", "main_char_nickname")