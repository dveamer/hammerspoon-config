local Aurora = {name = "Aurora"}
Aurora.__index = Aurora

function Aurora.new(boxes)
  local t = setmetatable({}, Aurora)
  t.boxes = boxes
  return t
end


local box_height = 23
local box_alpha = 0.35

local function newBox()
    return hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
end

local function reset_boxes(obj)
    obj.boxes = {}
end

local function draw_rectangle(target_draw, x, y, width, height, fill_color)
  -- 그릴 영역 크기를 잡는다
  target_draw:setSize(hs.geometry.rect(x, y, width, height))
  -- 그릴 영역의 위치를 잡는다
  target_draw:setTopLeft(hs.geometry.point(x, y))

  target_draw:setFillColor(fill_color)
  target_draw:setFill(true)
  target_draw:setAlpha(box_alpha)
  target_draw:setLevel(hs.drawing.windowLevels.overlay)
  target_draw:setStroke(false)
  target_draw:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
  target_draw:show()
end

local function enable_show(obj, color)
    reset_boxes(obj)
    hs.fnutils.each(hs.screen.allScreens(), function(scr)
        local frame = scr:fullFrame()

        local box = newBox()
        draw_rectangle(box, frame.x, frame.y, frame.w, box_height, color)
        table.insert(obj.boxes, box)

        local box2 = newBox()
        draw_rectangle(box2, frame.x, frame.y + frame.h - 10, frame.w, box_height, color)
        table.insert(obj.boxes, box2)
    end)
end

local function disable_show(obj)
    hs.fnutils.each(obj.boxes, function(box)
        if box ~= nil then
            box:delete()
        end
    end)
    reset_boxes(obj)
end

function Aurora:show(color) 
    enable_show(self, color)
end


function Aurora:hide(color) 
    disable_show(self, color)
end

return {
    ['of']  = Aurora.new,
}
