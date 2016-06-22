DIALOG = `require('electron').remote.dialog`
BROWSER_WINDOW = `require('electron').remote.BrowserWindow`

class Electron
  def self.show_open_dialog
    DIALOG.JS.showOpenDialog(focused_browser_window, { properties: ['openDirectory'] }.to_n)
  end

  def self.child_process
    @child_process ||= Native(`require('child_process')`)
  end

  def self.focused_browser_window
    BROWSER_WINDOW.JS.getFocusedWindow()
  end
end
