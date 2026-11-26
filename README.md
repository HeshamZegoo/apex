# Apex — Desktop App

Apex as a real desktop program (Electron): the APEX-UI orb interface first —
tap the circle in the centre to enter the Apex Humanoid experience
(assembly animation, original-style sound, head tracking with mouse/finger,
hand gestures, and the AI SETTINGS side menu).

The app itself works **offline**. AI features need internet and your own
API key (entered in the **AI SETTINGS** side menu inside the app — press
**Done** to save and activate it).

> **Placeholders:** every download link below uses `HeshamZegoo/apex`.
> Replace `HeshamZegoo` with the real GitHub account/org once this repo is pushed.

## Download / تنزيل

From **GitHub Releases**: https://github.com/HeshamZegoo/apex/releases/latest

| System | File |
|---|---|
> Note: in the current v1.0.0 build produced on Linux, the Windows asset is
> `Apex-1.0.0-win-unpacked.zip` (portable/unpacked — extract and run
> `win-unpacked/Apex.exe`); the NSIS installer link below is the target for
> a future build made with Wine/Windows available.

| Windows (installer) | https://github.com/HeshamZegoo/apex/releases/latest/download/Apex%20Setup%201.0.0.exe |
| Windows (portable, no install) | https://github.com/HeshamZegoo/apex/releases/latest/download/Apex-Portable-1.0.0.exe |
| Ubuntu (.deb) | https://github.com/HeshamZegoo/apex/releases/latest/download/Apex-1.0.0-ubuntu.deb |
| Ubuntu / Linux (AppImage) | https://github.com/HeshamZegoo/apex/releases/latest/download/Apex-1.0.0.AppImage |

## Install on Ubuntu — one line / التثبيت على أوبونتو بسطر واحد

```bash
curl -fsSL https://raw.githubusercontent.com/HeshamZegoo/apex/main/install.sh | bash
```

Or manually:

```bash
sudo apt install -y ./Apex-1.0.0-ubuntu.deb
# AppImage alternative:
chmod +x Apex-1.0.0.AppImage && ./Apex-1.0.0.AppImage
```

## Install on Windows / التثبيت على ويندوز

Run `Apex Setup 1.0.0.exe`. The app is unsigned, so Windows SmartScreen may
show a warning: click **More info → Run anyway**.
Or use the portable `Apex-Portable-1.0.0.exe` — no installation needed,
just double-click it.

## Build from source / البناء من المصدر

```bash
npm install
npm start                              # run in development
npm run build:win                      # Windows .exe (NSIS + portable)
npm run build:linux                    # Ubuntu .deb + AppImage
```

## Notes

- Camera/microphone: the app asks for permission because the mic and the
  background hand-gesture tracking need them. No camera preview is shown.
- Uninstall Windows: Settings → Apps → Apex → Uninstall.
  Uninstall Ubuntu (.deb): `sudo apt remove apex-desktop`
