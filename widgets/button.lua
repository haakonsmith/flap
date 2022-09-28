require "lib.flap.util.vector"
require "lib.flap.style"
require "lib.flap.widgets.textNode"

function Button(options)
    local node = TextNode(options)

    node.pressed = false

    node.onClickButtonLogic = function(self)
        self.style.backgroundColor = "white"

        self:redraw()
    end

    node.onClickCallback = options.onClickCallback

    node.onClick = function(self)
        self.pressed = true
        if node.onClickCallback then
            self:onClickCallback()
        end
        self:onClickButtonLogic()
    end

    node.onUpdate = function(self, eventLoop)
        eventLoop:timedCallback(0.2, function()
            if self.pressed then
                self.pressed = false
                self.style.backgroundColor = "black"
                self:redraw()
            end
        end)
    end

    return node
end
