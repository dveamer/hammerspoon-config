
local function is_browser(current_app)  
    local names = {'Safari'}
    for key,value in pairs(names) do 
      local a_browser_app = hs.application.find(value)
      if (current_app == a_browser_app) then
        return true
      end
    end
    return false
end
  
local function mouseBackwardForwardButton(event)
    local current_app = hs.application.frontmostApplication()
    if (is_browser(current_app) == false) then
      return 
    end
  
    local button = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
    if (button == 3) then
        hs.eventtap.keyStroke({"cmd"}, "[", current_app)      
    end
  
    if (button == 4) then
        hs.eventtap.keyStroke({"cmd"}, "]", current_app)
    end
    return 
end
  

mouseBackwardForwardButtonEventTapWatcher = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, mouseBackwardForwardButton):start()
  