-- Hammerspoon API : http://www.hammerspoon.org/docs/index.html
-- MAC 키보드 기본 단축키 : https://support.apple.com/ko-kr/HT201236

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", hs.reload)
hs.alert.show("Config loaded")


require("modules.window")
require("modules.mouse")
require("modules.language")
require('modules.inputsource_aurora')
require('modules.launch')
require('modules.cursor')
