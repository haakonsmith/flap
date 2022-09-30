require "util.vector"
require "style"
require "node"

function TextNode(options)
   local node = Node:new(options)
   node.text = options.text
   
   node.width = string.len(node.text)
   node.height = 1

   node.draw = function(self, monitor)
      if not self.style.visible then return end
      
      local draw_position = self.position
      
      -- if self.style.positioning == "relative" then
      --    if not self.parent then
      --       print 'MUST HAVE PARENT!'
      --    else
      --       draw_position.y = self.parent.position.y + draw_position.y
      --    end
      -- end
      
      monitor.setCursorPos(draw_position.x, draw_position.y)
      monitor.setBackgroundColor(colors[self.style.backgroundColor])
      
      monitor.write(self.text)
   end

   -- node.hitTest = function (self, position)
   --    if not self.style.visible then
   --       return false
   --    end

   --    return position.x > self.position.x
   --      and position.x < self.position.x + string.len(self.text)
   --      and position.y >= self.position.y
   --      and position.y <= self.position.y + 1
   -- end

   return node
end
