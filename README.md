# Nitrax Mathematical Keyboard — Windows Companion App

This repository contains the official open-source Windows companion app for the Nitrax Mathematical Keyboard.

Built with AutoHotkey v2, it enables fast input of mathematical, Greek, and scientific Unicode symbols across Windows applications.

- Blue symbols: `Ctrl + Alt + key`
- Gray symbols: `Ctrl + Alt + Shift + key`
- Runs locally from the Windows system tray
- Inserts Unicode characters directly without using the clipboard
- No telemetry or network access

## Official links

- [Product website](https://mathematicalkeyboard.com/)
- [Interactive demo](https://mathematicalkeyboard.com/try-it-right-now-for-free/)
- [Quick Start](https://mathematicalkeyboard.com/how-to-use-the-nitrax-math-keyboard/)
- [Full documentation](https://mathematicalkeyboard.com/full-documentation/)
- [Purchase on Amazon](https://www.amazon.com/dp/B0FRNHKH71)

---

## The Nitrax Mathematical Keyboard (hardware)

The Nitrax Mathematical Keyboard is a compact physical keyboard designed for fast mathematical input.

### Connection modes

The keyboard supports **two connection modes**:

#### 🔹 2.4 GHz wireless (USB dongle)
- Plug the USB dongle into your computer
- The keyboard connects automatically
- Lowest latency
- Recommended for desktop use

#### 🔹 Bluetooth
- Allows wireless use without a USB dongle
- Useful for laptops and mobile setups
- Slightly higher latency than 2.4 GHz (normal for Bluetooth)

Both modes behave like a **standard keyboard at the operating system level**.  
No driver installation is required for the keyboard itself.

---

## What this software does

The Nitrax Mathematical Keyboard software runs quietly in the background on Windows and translates key combinations from the physical keyboard into mathematical symbols.

It works globally across applications and inserts Unicode symbols directly, without using the clipboard.

---

## Features

- Designed **exclusively for the Nitrax Mathematical Keyboard (QWERTY-based layout)**
- Global Math Mode using dedicated key combinations
- Direct Unicode insertion (no clipboard usage)
- Works across applications:
  - Microsoft Word
  - Google Docs
  - Notepad / Notepad++
  - Most Windows applications
- Tray-based interface with Math Mode ON / OFF
- Optional automatic start with Windows
- Lightweight and silent background operation

---

## Download

➡️ **Download the latest version here:**

https://github.com/NitraxMathematicalKeyboard/download-keyboard-layout/releases/latest

Download the file: `NitraxMathKeyboard.exe`

Direct executable link:

https://github.com/NitraxMathematicalKeyboard/download-keyboard-layout/releases/latest/download/NitraxMathKeyboard.exe


---

## Installation

1. Download `NitraxMathKeyboard.exe` from the Releases page.
2. Double-click the file to run it.
3. The application will appear in the system tray (near the clock).

No installation wizard.  
No administrator privileges required.

---

## How to use

Once launched, the application lives in the **system tray** (near the clock).

### Tray controls
- **Double-click the tray icon** to toggle Math Mode ON / OFF
- Or use the tray menu to:
  - Enable or disable Math Mode
  - Enable or disable start with Windows
  - Open the help / quick guide
  - Quit the application

### Keyboard shortcuts
- **Ctrl + Alt + Shift + F12** → Toggle Math Mode
- **Ctrl + Alt + Shift + F11** → Quit the application

📘 Full usage guide:  
https://mathematicalkeyboard.com/how-to-use-the-nitrax-math-keyboard/

---

## Keyboard layers and symbol input

The Nitrax Mathematical Keyboard uses a **layered design** to access mathematical symbols efficiently.

### 🔵 Blue symbols
- Press **Ctrl + Alt + key**
- Inserts the **blue symbol** printed on the key

### ⚪ Gray symbols
- Press **Ctrl + Alt + Shift + key**
- Inserts the **gray symbol** printed on the key

You can keep **Ctrl + Alt** pressed and type multiple symbols in sequence for fast input.

This design allows quick access to a large number of mathematical symbols without switching layouts or opening symbol menus.

---

## Start with Windows — what does it mean?

When **Start with Windows** is enabled, the software automatically launches in the background when you log into Windows.

- Math Mode is immediately available
- No user interaction required
- The application remains silent and accessible from the tray

This option can be enabled or disabled at any time from the tray menu.

---

## Windows security notice (SmartScreen)

On first launch, Windows may display a blue security warning screen.

This happens because:
- The application is a small independent utility
- It is not digitally code-signed yet
- It is built using **AutoHotkey**, an open-source Windows automation framework

### About AutoHotkey
AutoHotkey (AHK) is a widely used open-source scripting language for Windows, trusted by millions of users worldwide for keyboard automation and productivity tools.

The Nitrax Mathematical Keyboard software:
- Uses AutoHotkey for reliable low-level keyboard handling
- Contains no telemetry and no network access
- Runs entirely locally on your machine

### How to proceed
1. Click **More info**
2. Click **Run anyway**

This is expected behavior and completely safe.

---

## Compatibility

- Windows 10
- Windows 11

---

## Status

Current version: **v1.1.2**

Stable release.

---

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).

Distributed versions derived from this project must remain open source under the same license.

---

© Nitrax Mathematical Keyboard
