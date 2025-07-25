# 🎤 Mute Mic AutoHotkey Script

This guide walks you through setting up a simple AutoHotkey script to toggle mute for your microphone (or any master audio device) using a customizable hotkey — ideal for desktops or laptops without a dedicated mute button.

---

## 📦 Prerequisites

### 1. Install AutoHotkey

#### Option 1: Download Manually

-   Go to [https://www.autohotkey.com](https://www.autohotkey.com)
-   Download the current stable version of AutoHotkey
-   Run the installer and follow the prompts to install AutoHotkey on your system

#### Option 2: Install via Chocolatey (Windows Package Manager)

-   Make sure you have [Chocolatey installed](https://chocolatey.org/install)
-   Open **PowerShell** as Administrator and run:

```bash
choco install autohotkey
```

---

## 🔁 Clone the Repository

```bash
git clone https://github.com/gauravsingh-02/AutoHotkey-Mic-Mute-Script.git
```

---

## 🎚️ Step 1: Set Mic Level

1. Open **Control Panel**
2. Set _View by_ to `Category`
3. Navigate to **Hardware and Sound** → **Sound**
4. In the pop-up window, switch to the **Recording** tab
5. Double-click your active microphone device
6. Go to the **Levels** tab
7. Set the microphone level to **33%**

---

## 🧪 Step 2: Run `Temp_Mic.ahk` Script

1. Double-click the saved `Temp_Mic.ahk` file
2. The script will run and open a window
3. Look for the `MASTER` component with `VOLUME` at `33.00`
4. Note the corresponding **Mixer** value shown (e.g., 1, 2, 3, or 4). This number will be used in the next step.

---

## 📝 Step 3: Edit `Mute_Mic.ahk` Script

1. Open `Mute_Mic.ahk` in Notepad or any text editor
2. Update the `masterValue` to the Mixer value you noted earlier
3. Set your preferred hotkey by editing the `userShortcut` value
4. Save and double-click the `Mute_Mic.ahk` file
5. Test the mute/unmute toggle using your chosen shortcut

---

## 🔁 Restore Mic Level (Important)

Once you've verified that the script works:

-   Repeat **Step 1** and set your microphone level back to **100%**
    (This ensures normal recording volume outside of setup mode.)

---

## ⚠️ Device Change Warning

> If you change your input device (e.g., switch from a built-in mic to a wired/wireless headset), the **Mixer value will change**.
> You will need to re-run `Temp_Mic.ahk` and update the `masterValue` in `Mute_Mic.ahk` accordingly.

---

## ⚙️ Set Script to Run Automatically on Startup

### Step 1: Finalize and Save

-   Ensure the script is finalized and saved as `Mute_Mic.ahk`

### Step 2: Add to Startup Folder

1. Press `Win + R` to open the Run dialog
2. Type `shell:startup` and press Enter
3. Paste the `Mute_Mic.ahk` file into this folder

> 💡 You can also save the script in a separate folder and place a **shortcut** to it in the Startup folder for easier management.

---

## 🎛️ Additional Tips

-   Customize the `userShortcut` using AutoHotkey hotkey syntax. Examples:

    -   `^!m` → Ctrl + Alt + M
    -   `#m` → Win + M
    -   `^+s` → Ctrl + Shift + S

-   Refer to the official documentation for more hotkey options:
    [https://www.autohotkey.com/docs/v2/misc/Hotkeys.htm](https://www.autohotkey.com/docs/v2/misc/Hotkeys.htm)

---

## 🛠️ Support

If you encounter issues or want to enhance the script, visit the [AutoHotkey Community Forum](https://www.autohotkey.com/boards/).

---

Thanks for using the **Mute Mic AutoHotkey Script**!
Happy scripting 🎉
