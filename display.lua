
require "flap"

local dropdown = Button {
    position = Vector.new(1, 1),
    text = "Menu",
    onClickCallback = function(self)
        for i = 1, #self.children do
            self.children[i].style.visible = not self.children[i].style.visible
        end
    end,
    children = {Column {
        children = {TextNode {
            text = "invisible"
        }, TextNode {
            text = "invisible"
        }, TextNode {
            text = "invisible"
        }, TextNode {
            text = "invisible"
        }}
    }}
}

local counter = Column {
    position = Vector.new(10, 5),
    children = {TextNode {
        text = "Counter: 1",
        data = {
            number = 1
        }
    }, Button {
        text = "add",
        onClickCallback = function(self)
            textNode = self.parent.children[1]
            textNode.data.number = textNode.data.number + 1

            textNode.text = 'Counter: ' .. textNode.data.number
        end
    }}
}

local main = Node:new({
    children = {dropdown, counter}
})

local eventLoop = EventLoop.new()

monitor = term
-- term.redirect(peripheral.wrap("top"))

-- monitor = peripheral.wrap("top")
-- monitor.setTextScale(0.5)

runApp(main, eventLoop, monitor)
