-- Listeners is a map of functions with the key as the event name
-- and that return true or false for event handled.
EventLoop = {}
EventLoop.__index = EventLoop

function EventLoop:new()
    return setmetatable({
        listeners = {},
        context = {self}
    }, EventLoop)
end

function EventLoop:handleEvent(event)
    if self.listeners then

        for i = 1, #self.listeners do
            local event_listener = self.listeners[i]

            -- This event listener may let be null this may be an error!!! Not sure.
            if event_listener and event[1] == event_listener[1] then
                if 'timer' == event_listener[1] then
                    if event_listener[3] == event[2] then
                        event_listener[2](event, self.context)

                        -- Gotta clean up those timers
                        table.remove(self.listeners, i)
                    end
                else
                    event_listener[2](event, self.context)
                end

            end

        end
    end
end

---@param time string
---@param callback function
function EventLoop:timedCallback(time, callback)
    token = os.startTimer(time)

    self:registerListener({ 'timer', callback, token })
end

---@param options table<string, function, string>
function EventLoop:registerListener(options)
    print('insert!')
    print(options[1])
    print(options[2])

    table.insert(self.listeners, options)

    return self
end

---@param listeners table<string, function, string>[]
function EventLoop:registerListeners(listeners)
    print(listeners[1])
    print(listeners[2])
    for i = 1, #listeners do
        table.insert(self.listeners, listeners[i])
    end

    return self
end

function EventLoop:queueEvent(event)
    os.queueEvent(event)
end

function EventLoop:run()
    -- local k = 0
    while true do
        local event = { os.pullEvent() }

        print(event[1])

        self:handleEvent(event)

        -- k = k + 1
    end
end
