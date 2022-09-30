function draw(context)
    -- local root = {context.rootNode}
    local monitor = context.monitor
    local eventLoop = context.eventLoop

    function sub_draw(root)

        for i = 1, #root do
            if root[i].layout then
                root[i].layout(root[i])
            end

            if root[i].children and root[i].style.visible then
                sub_draw(root[i].children)
            end

            if root[i].draw then
                root[i]:draw(monitor)
            end
            if root[i].onUpdate then
                root[i]:onUpdate(context)
            end
        end
    end

    sub_draw({context.rootNode})
end
