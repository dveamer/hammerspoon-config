
local right_command_key_hex = 0x37 -- 55
local inputSource = {
    english = "com.apple.keylayout.ABC",
    korean = "com.apple.inputmethod.Korean.2SetKorean",
}

layoutWatcher = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(e)
    local flags = e:getFlags()

    if not flags.cmd then
        return
    end

    if flags.alt or flags.shift or flags.ctrl or flags.fn then
        return 
    end

    local keyCode = e:getKeyCode()
    if keyCode ~= right_command_key_hex then 
        return
    end

    local nextInput = inputSource.english
    local current = hs.keycodes.currentSourceID()
    if current == inputSource.english then
        nextInput = inputSource.korean
    end

    hs.keycodes.currentSourceID(nextInput)

end):start()