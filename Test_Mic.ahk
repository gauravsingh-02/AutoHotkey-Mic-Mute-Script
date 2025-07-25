SetBatchLines -1
SplashTextOn,,, Gathering Soundcard Info...

; The numbers below correspond to control types
; often used in mixers; many may not exist in actual hardware but are included for completeness.
; Order corresponds to the following control types:
; CUSTOM, BOOLEANMETER, SIGNEDMETER, PEAKMETER,
; UNSIGNEDMETER, BOOLEAN, BUTTON, DECIBELS, SIGNED,
; UNSIGNED, PERCENT, SLIDER, FADER, SINGLESELECT, MUX,
; MULTIPLESELECT, MIXER, MICROTIME, MILLITIME
ControlTypes = VOLUME,ONOFF,MUTE,MONO,LOUDNESS,STEREOENH,BASSBOOST,PAN,QSOUNDPAN,BASS,TREBLE,EQUALIZER,0x00000000, 0x10010000,0x10020000,0x10020001,0x10030000,0x20010000,0x21010000,0x30040000,0x30020000,0x30030000,0x30050000,0x40020000,0x50030000,0x70010000,0x70010001,0x71010000,0x71010001,0x60030000,0x61030000

; List of common audio component types that might be present in a mixer.
; N/A represents a placeholder or undefined component type.
ComponentTypes = MASTER,HEADPHONES,DIGITAL,LINE,MICROPHONE,SYNTH,CD,TELEPHONE,PCSPEAKER,WAVE,AUX,ANALOG,N/A

; Create a GUI ListView with columns to display the gathered mixer info:
; Columns: Component Type | Control Type | Setting | Mixer number
Gui, Add, Listview, w400 h400 vMyListView, Component Type|Control Type|Setting|Mixer
LV_ModifyCol(4, "Integer")  ; Format the Mixer column as an integer for clarity.
SetFormat, Float, 0.2       ; Limit decimal places for numerical percentages to two.

; Main loop to iterate through all mixers available in the system
Loop
{
    CurrMixer := A_Index
    SoundGet, Setting,,, %CurrMixer%
    ; If the mixer cannot be opened, exit the loop (no more mixers).
    if ErrorLevel = Can't Open Specified Mixer
        break

    ; For each component type in the currently selected mixer,
    ; check if it exists and then query instances and control types.
    Loop, parse, ComponentTypes, `,
    {
        CurrComponent := A_LoopField
        ; Check if this component type is supported by the current mixer.
        SoundGet, Setting, %CurrComponent%,, %CurrMixer%
        if ErrorLevel = Mixer Doesn't Support This Component Type
            continue  ; Skip to the next component type if unsupported.

        ; Iterate through instances of this component type.
        Loop
        {
            CurrInstance := A_Index
            ; Check if this instance of the component exists.
            SoundGet, Setting, %CurrComponent%:%CurrInstance%,, %CurrMixer%
            ; If no more instances exist or control type is invalid, stop this inner loop.
            if ErrorLevel in Mixer Doesn't Have That Many of That Component Type,Invalid Control Type or Component Type
                break

            ; For each control type defined, attempt to get its setting.
            Loop, parse, ControlTypes, `,
            {
                CurrControl := A_LoopField
                SoundGet, Setting, %CurrComponent%:%CurrInstance%, %CurrControl%, %CurrMixer%
                ; Skip control types that the component instance does not support or are invalid.
                if ErrorLevel in Component Doesn't Support This Control Type,Invalid Control Type or Component Type
                    continue
                ; If another unexpected error occurs, assign error code as setting.
                if ErrorLevel
                    Setting := ErrorLevel

                ; Format component name (append instance number if > 1)
                ComponentString := CurrComponent
                if CurrInstance > 1
                    ComponentString = %ComponentString%:%CurrInstance%

                ; Add the retrieved information as a new row in the ListView.
                LV_Add("", ComponentString, CurrControl, Setting, CurrMixer)
            }  ; End of control types loop
        }  ; End of component instances loop
    }  ; End of component types loop
}  ; End of mixers loop

; Auto-size each column to fit the content plus headers
Loop % LV_GetCount("Col")
    LV_ModifyCol(A_Index, "AutoHdr")

SplashTextOff
Gui, Show
return

GuiClose:
ExitApp
