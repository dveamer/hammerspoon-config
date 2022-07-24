local last_frame = nil

local function move_window_to_another_screen(callback)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local target_screen = callback(screen)
    win:moveToScreen(target_screen, false, true)
    last_frame = win:frame()
end

local function is_same_frame(frame)
    if last_frame == nill then
        return false
    end

    return frame.x == last_frame.x and frame.y == last_frame.y and frame.w == last_frame.w and frame.h == last_frame.h 
end

local function floor_frame(frame)
    frame.x = math.floor(frame.x)
    frame.y = math.floor(frame.y)
    frame.w = math.floor(frame.w)
    frame.h = math.floor(frame.h)
end

local function change_frame(callback_size)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
  
    callback_size(f, max)
    floor_frame(f)

    if is_same_frame(f) then
        return false
    end

    win:setFrame(f)
    last_frame = f
    return true
end


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
    local is_changed = change_frame(function(f, max)     
        f.x = max.x
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
    end)

    if is_changed then
        return
    end

    move_window_to_another_screen(function(screen) return screen:previous() end)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
    local is_changed = change_frame(function(f, max)  
        f.x = max.x + (max.w / 2)
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
    end)
    
    if is_changed then
        return
    end

    move_window_to_another_screen(function(screen) return screen:next() end)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
    change_frame(function(f, max)  
        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h
    end)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
    change_frame(function(f, max)  
        f.x = max.x + (max.w / 10)
        f.y = max.y + (max.h / 10)
        f.w = max.w * 4 / 5
        f.h = max.h * 4 / 5
    end)
   
end)
  