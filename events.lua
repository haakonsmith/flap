drawListener = {'draw', function(_, context)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    print(monitor)
    draw(context)
end}

touchListener = {'monitor_touch', function(event, context)
    local x, y = event[3], event[4]

    local body = {context.rootNode}
    for i = 1, #body do
        if body[i]:hitTest(Vector.new(x, y)) then
            if body[i].onClick then
                body[i]:onClick()
            end
        end
    end
end}


flapListeners = {touchListener, drawListener}

