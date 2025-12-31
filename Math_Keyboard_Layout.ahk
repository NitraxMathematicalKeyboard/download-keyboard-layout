#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook True
#MaxThreadsPerHotkey 1

; ==========================================================
; Nitrax Mathematical Keyboard - Release Script (Product mode)
; ==========================================================

; ---------------- App constants ----------------
global AppName := "Nitrax Mathematical Keyboard"
global IconOn  := A_ScriptDir "\nitrax_on.ico"
global IconOff := A_ScriptDir "\nitrax_off.ico"
global HelpUrl := "https://mathematicalkeyboard.com/how-to-use-the-nitrax-math-keyboard/"

; ---------------- Registry ----------------
global RunRegPath   := "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
global RunValueName := "Nitrax Mathematical Keyboard"

; Onboarding storage (shown only once)
global AppRegPath      := "HKCU\Software\Nitrax\MathKeyboard"
global OnboardingValue := "OnboardingShown"

; ---------------- State ----------------
global MathModeEnabled := true
global UsedMathChord   := false
global RegisteredHotkeys := []

; ---------------- Mutex (single instance across any copy) ----------------
if !AcquireNitraxMutex() {
    NotifyAlreadyRunning()
    Sleep 1200
    ExitApp()
}

; Set tray icon immediately
SetTrayIconSafe(IconOn)

; ==========================================================
; Notepad fix: cancel menu focus when our math chord was used
; ==========================================================

~LAlt up:: {
    global UsedMathChord
    if UsedMathChord && WinActive("ahk_exe notepad.exe")
        SendInput "{vk07}{Esc}"
    UsedMathChord := false
}

~RAlt up:: {
    global UsedMathChord
    if UsedMathChord && WinActive("ahk_exe notepad.exe")
        SendInput "{vk07}{Esc}"
    UsedMathChord := false
}

~LControl up:: {
    global UsedMathChord
    if UsedMathChord && WinActive("ahk_exe notepad.exe")
        SendInput "{vk07}{Esc}"
    return
}

~RControl up:: {
    global UsedMathChord
    if UsedMathChord && WinActive("ahk_exe notepad.exe")
        SendInput "{vk07}{Esc}"
    return
}

; ==========================================================
; Mapping (scancode -> codepoint)
; ==========================================================

blue := Map(
    "sc00A", 0x27E8, ; ⟨
    "sc00B", 0x27E9, ; ⟩
    "sc00D", 0x00B1, ; ±
    "sc010", 0x03D1, ; ϑ
    "sc011", 0x03A3, ; Σ
    "sc012", 0x2203, ; ∃
    "sc013", 0x03F1, ; ϱ
    "sc014", 0x221A, ; √
    "sc015", 0x03C2, ; ς
    "sc016", 0x039B, ; Λ
    "sc017", 0x2229, ; ∩
    "sc018", 0x221D, ; ∝
    "sc019", 0x2202, ; ∂
    "sc01E", 0x2200, ; ∀
    "sc020", 0x0394, ; Δ
    "sc021", 0x03A6, ; Φ
    "sc022", 0x221E, ; ∞
    "sc023", 0x2190, ; ←
    "sc024", 0x2192, ; →
    "sc025", 0x2222, ; ∢
    "sc026", 0x2220, ; ∠
    "sc027", 0x03D6, ; ϖ
    "sc02C", 0x2286, ; ⊆
    "sc02D", 0x2287, ; ⊇
    "sc02E", 0x2282, ; ⊂
    "sc02F", 0x2283, ; ⊃
    "sc030", 0x039E, ; Ξ
    "sc031", 0x2205, ; ∅
    "sc032", 0x0393  ; Γ
)

gray := Map(
    "sc00D", 0x2260, ; ≠
    "sc010", 0x03B8, ; θ
    "sc011", 0x03A9, ; Ω
    "sc012", 0x03B5, ; ε
    "sc013", 0x03C1, ; ρ
    "sc014", 0x03C4, ; τ
    "sc015", 0x03C8, ; ψ
    "sc016", 0x220F, ; ∏
    "sc017", 0x03B9, ; ι
    "sc018", 0x03C9, ; ω
    "sc019", 0x03C0, ; π
    "sc01E", 0x03B1, ; α
    "sc020", 0x03B4, ; δ
    "sc021", 0x03C6, ; φ
    "sc022", 0x03B3, ; γ
    "sc023", 0x03B7, ; η
    "sc024", 0x222B, ; ∫
    "sc025", 0x03C3, ; σ
    "sc026", 0x03BB, ; λ
    "sc02C", 0x03B6, ; ζ
    "sc02D", 0x03BE, ; ξ
    "sc02E", 0x2208, ; ∈
    "sc02F", 0x220B, ; ∋
    "sc030", 0x03B2, ; β
    "sc031", 0x2207, ; ∇
    "sc033", 0x2264, ; ≤
    "sc034", 0x2265, ; ≥
    "sc032", 0x03BC  ; μ
)

; Register hotkeys
RegisterLayer("<^<!",  blue)
RegisterLayer("<^<!+", gray)

; Tray UX
BuildTray()
UpdateUI()

; Launch toast
ShowLaunchToast()

; Onboarding (once)
MaybeShowOnboarding()

; Secret hotkeys
<^<!+F12::ToggleMathMode()
<^<!+F11::ExitApp()

; ==========================================================
; Functions
; ==========================================================

AcquireNitraxMutex() {
    static hMutex := 0
    name := "Global\NitraxMathKeyboard_Mutex"
    hMutex := DllCall("CreateMutexW", "ptr", 0, "int", true, "wstr", name, "ptr")
    if !hMutex
        return false
    if (A_LastError = 183)
        return false
    return true
}

NotifyAlreadyRunning() {
    global AppName
    TrayTip(AppName, "Already running. Check the system tray (near the clock).")
    SetTimer(() => TrayTip(), -2500)
}

ShowLaunchToast() {
    global AppName, MathModeEnabled
    txt := MathModeEnabled ? "Math Mode: ON" : "Math Mode: OFF"
    TrayTip(AppName, txt)
    SetTimer(() => TrayTip(), -2500)
}

RegisterLayer(prefix, mapping) {
    global RegisteredHotkeys
    for sc, codepoint in mapping {
        hk := prefix sc
        Hotkey hk, InsertCodepoint.Bind(codepoint, sc), "On"
        RegisteredHotkeys.Push(hk)
    }
}

InsertCodepoint(codepoint, scKey, *) {
    global MathModeEnabled, UsedMathChord
    if !MathModeEnabled
        return

    if GetKeyState("LAlt", "P") || GetKeyState("RAlt", "P")
        UsedMathChord := true

    hex := Format("{:04X}", codepoint)
    SendInput "{Blind}{U+" hex "}"
    SendInput "{vk07}"

    if WinActive("ahk_exe notepad.exe")
        SendInput "{Esc}"

    KeyWait StrUpper(scKey)
}

ToggleMathMode(*) {
    global MathModeEnabled, RegisteredHotkeys
    MathModeEnabled := !MathModeEnabled

    state := MathModeEnabled ? "On" : "Off"
    for _, hk in RegisteredHotkeys
        Hotkey hk, state

    UpdateUI()
}

BuildTray() {
    global HelpUrl
    A_TrayMenu.Delete()

    A_TrayMenu.Add("Math Mode ON/OFF", ToggleMathMode)
    A_TrayMenu.Default := "Math Mode ON/OFF"

    A_TrayMenu.Add()
    A_TrayMenu.Add("Start with Windows", ToggleAutostart)

    A_TrayMenu.Add()
    A_TrayMenu.Add("Help / Quick guide", (*) => Run(HelpUrl))

    A_TrayMenu.Add()
    A_TrayMenu.Add("Quit", (*) => ExitApp())
}

UpdateUI() {
    global MathModeEnabled, IconOn, IconOff, AppName

    if MathModeEnabled {
        SetTrayIconSafe(IconOn)
        A_TrayMenu.Check("Math Mode ON/OFF")
        A_IconTip := AppName " — Math Mode: ON"
    } else {
        SetTrayIconSafe(IconOff)
        A_TrayMenu.Uncheck("Math Mode ON/OFF")
        A_IconTip := AppName " — Math Mode: OFF"
    }

    if IsAutostartEnabled()
        A_TrayMenu.Check("Start with Windows")
    else
        A_TrayMenu.Uncheck("Start with Windows")
}

SetTrayIconSafe(path) {
    try {
        if FileExist(path)
            TraySetIcon(path)
    }
}

ToggleAutostart(*) {
    if IsAutostartEnabled()
        DisableAutostart()
    else
        EnableAutostart()
    UpdateUI()
}

IsAutostartEnabled() {
    global RunRegPath, RunValueName
    try {
        v := RegRead(RunRegPath, RunValueName)
        return (v != "")
    } catch {
        return false
    }
}

EnableAutostart() {
    global RunRegPath, RunValueName
    RegWrite(GetRunCommand(), "REG_SZ", RunRegPath, RunValueName)
}

DisableAutostart() {
    global RunRegPath, RunValueName
    try RegDelete(RunRegPath, RunValueName)
}

GetRunCommand() {
    if A_IsCompiled
        return '"' A_ScriptFullPath '"'
    else
        return '"' A_AhkPath '" "' A_ScriptFullPath '"'
}

MaybeShowOnboarding() {
    if HasSeenOnboarding()
        return
    ShowOnboardingGui()
    MarkOnboardingSeen()
}

HasSeenOnboarding() {
    global AppRegPath, OnboardingValue
    try {
        v := RegRead(AppRegPath, OnboardingValue)
        return (v = 1)
    } catch {
        return false
    }
}

MarkOnboardingSeen() {
    global AppRegPath, OnboardingValue
    RegWrite 1, "REG_DWORD", AppRegPath, OnboardingValue
}

ShowOnboardingGui() {
    global AppName

    g := Gui("+AlwaysOnTop -MinimizeBox", AppName)
    g.BackColor := "FFFFFF"
    g.MarginX := 18
    g.MarginY := 16

    ; Title
    g.SetFont("s12 Bold", "Segoe UI")
    g.AddText("w460", "Math Mode is ready")

    g.SetFont("s9", "Segoe UI")
    g.AddText("y+6 w460 c666666", AppName " is running in the system tray (near the clock).")

    ; Separator
    g.AddProgress("y+14 w460 h1 -Smooth", 100)

    ; Body
    g.SetFont("s10", "Segoe UI")
    g.AddText("y+14 w460", "Use the tray menu to toggle Math Mode (ON/OFF) and to quit the app.")

    g.AddText("y+10 w460",
        "Shortcuts:" "`n"
      . "Ctrl + Alt + Shift + F12  → Toggle Math Mode" "`n"
      . "Ctrl + Alt + Shift + F11  → Quit"
    )

    cb := g.AddCheckbox("y+14", "Start with Windows")
    cb.Value := IsAutostartEnabled() ? 1 : 0

    btnOk := g.AddButton("y+16 w120 Default", "OK")

    ApplyAndClose := (*) => (
        cb.Value ? EnableAutostart() : DisableAutostart(),
        UpdateUI(),
        g.Destroy()
    )

    btnOk.OnEvent("Click", ApplyAndClose)
    g.OnEvent("Close", ApplyAndClose)

    g.Show()
}
