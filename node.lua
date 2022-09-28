require "lib.flap.util.vector"
require "lib.flap.style"

Node = {'position', 'children', 'style'}
Node.__index = Node

function Node:new(options)
    o = {
        position = options.position or Vector.new(0, 0),
        children = options.children or nil,
        style = options.style or NodeStyle.new {},
        onClick = options.onClick,
        draw = options.draw,
        hitTest = options.hitTest
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
    if self.onDraw then self.onDraw(self, monitor) end
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

function Node:hitTest(position)
    return false
end
