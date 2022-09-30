require "util.vector"
require "style"

Node = {'position', 'children', 'style'}
Node.__index = Node

function Node:new(options)
    o = {
        position = options.position or Vector.new(1, 1),
        children = options.children or nil,
        style = options.style or NodeStyle.new {},
        onClick = options.onClick,
        draw = options.draw,
        layout = options.layout,
        width = options.width,
        height = options.height,
        shouldHitTest = false,
        hitTest = options.hitTest or self.hitTest,
        data = options.data
    }

    if o.children then
        for _, value in ipairs(o.children) do
            value.parent = o
        end
    end

    setmetatable(o, self)
    self.__index = self

    return o
end

function Node:draw(monitor)
    if self.onDraw then
        self.onDraw(self, monitor)
    end
end

function Node:onUpdate(callback)
    self.onUpdateCallback = callback

    -- Allow for method chaining
    return self
end

function Node:visble(callback)
    self.onClickCallback = callback

    -- Allow for method chaining
    return self
end

function Node:redraw(time)
    os.queueEvent("draw")
end

-- function Node:layout()
--     -- self:layout()
-- end

function Node:hitTest(position)
    if not self.style.visible then
        return false
    end

    return
        position.x > self.position.x and position.x < self.position.x + self.width and position.y >= self.position.y and
            position.y <= self.position.y + self.height
end
