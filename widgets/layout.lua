function LayoutPosition(options)
    local node = Node:new(options)

    node.getPosition = options.getPosition or function()
        return Vector.new(1, 1)
    end

    node.layout = function(self)
        -- if not self.style.visible then
        --     return
        -- end

        for i = 1, #self.children do
            self.children[i].position = self:getPosition(self.children[i], i)
        end
    end

    return node
end

function Column(options)
    local node = LayoutPosition(options)

    node.getPosition = function(self, node, i)
        return self.position + Vector.new(0, node.height * (i + 1))
    end

    return node
end

function Row(options)

end
