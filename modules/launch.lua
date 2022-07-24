
hs.hotkey.bind({'shift'}, 'F1', hs.hints.windowHints)


local boxes = {}
local aurora = require('modules.aurora').of(boxes)
local RED = hs.drawing.color.osx_red

local function alert(message, seconds) hs.alert.show(message, hs.alert.defaultStyle, hs.screen.mainScreen(), seconds) end

local binded_keys = {}
local k = hs.hotkey.modal.new('cmd-shift', 'l')
function k:entered() 
    alert('Entered Launch Mode',5) 
    aurora:show(RED) 
end
function k:exited() 
    alert('Exited Launch Mode', 1) 
    aurora:hide() 
end
local function bind_launch(hotkey_modal, key, application) 
    local message = key..' : '..application
    table.insert(binded_keys, message)
    k:bind('', key, application,function() hs.application.launchOrFocus(application) end)
end

bind_launch(k, 'T', 'Terminal')
bind_launch(k, 'C', 'Google Chrome')
bind_launch(k, 'S', 'Safari')
bind_launch(k, 'F', 'FireFox')
bind_launch(k, 'I', 'IntelliJ IDEA')
bind_launch(k, 'L', 'Slack')
bind_launch(k, 'V', 'Visual Studio Code')
bind_launch(k, 'H', 'Hammerspoon')

k:bind('', 'escape', function() k:exit() end)
k:bind('', '/', 'Luanch Key List',function() alert(table.concat(binded_keys,"\n"), 3) end)
k:bind('', '.', 'Current Application',function() hs.alert.show(hs.application.frontmostApplication()) end)

