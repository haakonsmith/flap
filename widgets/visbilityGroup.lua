require "util.vector"

VisibiltyGroup = {}
VisibiltyGroup.__index = VisibiltyGroup

function VisibiltyGroup.new(position, text, color, onClick)
    return setmetatable(
        {
            position = position or Vector.new(0, 0),
            text = text or "",
            onClick = onClick or function(self) end,
            type = "VisibiltyGroup",
            color = color or "red"
        },
        VisibiltyGroup)
end

function VisibiltyGroup:onUpdate(callback)
    self.onUpdateCallback = callback

    -- Allow for method chaining
    return self
end

function VisibiltyGroup:draw(monitor)
    x, y = monitor.setCursorPos(self.position.x, self.position.y)
    colour = monitor.setBackgroundColor(colors[self.color])

    monitor.write(self.text)
end

function VisibiltyGroup:hitTest(position)
    return position.x > self.position.x
        and position.x < self.position.x + string.len(self.text)
        and position.y >= self.position.y
        and position.y <= self.position.y + 1
end

setmetatable(VisibiltyGroup, { __call = function(_, ...) return VisibiltyGroup.new(...) end })
