const { app, BrowserWindow, session, shell } = require('electron');
const path = require('path');

// High-performance / GPU flags (must be set before app ready)
app.commandLine.appendSwitch('enable-gpu-rasterization');
app.commandLine.appendSwitch('enable-zero-copy');
app.commandLine.appendSwitch('ignore-gpu-blocklist');
app.commandLine.appendSwitch('enable-features', 'VaapiVideoDecoder,CanvasOopRasterization');
app.commandLine.appendSwitch('force_high_performance_gpu');
try { app.disableDomainBlockingFor3DAPIs(); } catch (e) {}

function isExternal(url) {
  return /^https?:\/\//i.test(url) && !url.startsWith('file://');
}

function createWindow() {
  const win = new BrowserWindow({
    width: 1400,
    height: 900,
    backgroundColor: '#04080f',
    autoHideMenuBar: true,
    fullscreenable: true,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      sandbox: false,
      // Local app page + user-configured AI API calls only
      webSecurity: true
    }
  });

  win.maximize();
  // Start fullscreen for the cinematic experience; F11 / Esc handled by OS/Electron defaults
  // (kept as maximized window so the user can always reach window controls)

  // Open external links (GitHub, social) in the system browser, never inside the app
  win.webContents.setWindowOpenHandler(({ url }) => {
    if (isExternal(url)) {
      shell.openExternal(url);
      return { action: 'deny' };
    }
    return { action: 'allow' };
  });
  win.webContents.on('will-navigate', (event, url) => {
    if (isExternal(url)) {
      event.preventDefault();
      shell.openExternal(url);
    }
  });

  win.loadFile(path.join(__dirname, 'app', 'index.html'));
  return win;
}

app.whenReady().then(() => {
  // Grant camera / microphone to the app itself (hand gestures + mic features)
  const ses = session.defaultSession;
  ses.setPermissionRequestHandler((webContents, permission, callback) => {
    const allowed = ['media', 'microphone', 'camera', 'display-capture', 'notifications'];
    callback(allowed.includes(permission));
  });
  ses.setPermissionCheckHandler((webContents, permission) => {
    return ['media', 'microphone', 'camera'].includes(permission);
  });

  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});
