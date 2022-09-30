require "util.vector"
require "style"
require "widgets.textNode"

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

    node.onUpdate = function(self, context)

        if self.pressed then
            self.pressed = false

            if context.isMonitor then
                context.eventLoop:timedCallback(0.2, function()
                    self.style.backgroundColor = "black"
                    self:redraw()

                end)
            else
                context.eventLoop:registerListener({'mouse_up', function()
                    self.style.backgroundColor = "black"
                    self:redraw()

                    return true
                end})
            end
        end
    end

    return node
end
