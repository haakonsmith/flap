
require "util.vector"
require "widgets"
require "events"
require "eventLoop"
require "draw"

--- Runs the flap app
---@param rootNode table[]
---@param eventLoop table
---@param monitor table

function runApp(rootNode, eventLoop, display)
    local isMonitor = not display.setTextScale == nil

    display.clear()

    os.queueEvent('draw')

    eventLoop.context = {
        eventLoop = eventLoop,
        monitor = display,
        rootNode = rootNode,
        isMonitor = isMonitor
    }

    if isMonitor then
        eventLoop:registerListeners(flapMonitorListeners)

    else
        eventLoop:registerListeners(flapTermListeners)
    end

    eventLoop:run()

    display.clear()
end
