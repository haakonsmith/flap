-- The budget version of flutter => flap
require "lib.flap.util.vector"
require "lib.flap.widgets"
require "lib.flap.events"
require "lib.flap.eventLoop"
require "lib.flap.draw"

function runApp(rootNode, eventLoop, monitor)
    
    monitor.clear()
    os.queueEvent('draw')

    eventLoop.context = {eventLoop = eventLoop, monitor = monitor, rootNode = rootNode}
    eventLoop:registerListeners(flapListeners)
    eventLoop:run()
end
