drawListener = {'draw', function(_, context)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    draw(context)
end}

function hitTest(event, context)
    local x, y = event[3], event[4]

    local body = {context.rootNode}

    function sub_test(body)
        for i = 1, #body do
            if body[i].onClick and body[i]:hitTest(Vector.new(x, y)) then
                body[i]:onClick()
            end

            if body[i].children then
                sub_test(body[i].children)
            end
        end
    end

    sub_test(body)
end

touchListener = {'monitor_touch', hitTest}

clickListener = {'mouse_click', hitTest}

flapMonitorListeners = {touchListener, drawListener}
flapTermListeners = {clickListener, drawListener}

