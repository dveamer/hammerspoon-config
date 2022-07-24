
hs.hotkey.bind({""}, "home", function()
    hs.eventtap.keyStroke({"cmd"}, "left", current_app)
end)

hs.hotkey.bind({""}, "end", function()
    hs.eventtap.keyStroke({"cmd"}, "right", current_app)
end)
