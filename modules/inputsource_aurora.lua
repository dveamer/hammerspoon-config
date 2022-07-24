
local inputEnglish = "com.apple.keylayout.ABC"

local boxes = {}
local aurora = require('modules.aurora').of(boxes)
local GREEN = hs.drawing.color.osx_green

local last_input_source = nil

-- 입력소스 변경 이벤트에 이벤트 리스너를 달아준다
hs.keycodes.inputSourceChanged(function()

    local current = hs.keycodes.currentSourceID()
    if current == last_input_source then
        return
    end

    current = last_input_source
    aurora:hide()
    if hs.keycodes.currentSourceID() ~= inputEnglish then
        aurora:show(GREEN)
    end
end)
