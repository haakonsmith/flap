-- Listeners is a map of functions with the key as the event name 
-- and that return true or false for event handled.
EventLoop = {}
EventLoop.__index = EventLoop

function EventLoop:new()
    return setmetatable({
        listeners = {}
        -- timed_listeners = {}
    }, EventLoop)
end

function EventLoop:handleEvent(event)
    if self.listeners then
        for eventName, listener in pairs(self.listeners) do

            local timer_name

            if event[2] == nil then
                timer_name = nil
            else
                timer_name = event[1] .. event[2]
            end

            -- The or tests for timer events which look like f'timer{token}'
            if eventName == event[1] or eventName == timer_name then
                listener(event, self)
            end
        end
    end
end

function EventLoop:timedCallback(time, callback)
    token = os.startTimer(time)
    local event_name = 'timer' .. token
    print('registered listener: ' .. event_name)

    self.listeners[event_name] = callback
end

function EventLoop:registerListener(eventName, callback)
    self.listeners[eventName] = callback
    -- table.insert(self.listeners, {eventName, callback})

    return self
end

function EventLoop:queueEvent(event)
    os.queueEvent(event)
end

function EventLoop:run()
    local k = 0
    while k < 20 do
        event = {os.pullEvent()}

        print(event[1])

        self:handleEvent(event)

        k = k + 1
    end
end
