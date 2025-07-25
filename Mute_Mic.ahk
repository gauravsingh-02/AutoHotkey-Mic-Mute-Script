; Set your master mixer value here (replace "4" with your obtained number)
masterValue := 4

; Set your preferred hotkey here (replace "F9" with your choice)
userShortcut := "F9"

; Dynamically create the hotkey
Hotkey, %userShortcut%, ToggleMute

return

ToggleMute:
    SoundSet, +1, MASTER, mute, %masterValue%
    SoundGet, master_mute, , mute, %masterValue%

    ToolTip, Mute %master_mute%
    SetTimer, RemoveToolTip, 1000
return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return
