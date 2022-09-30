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
                    local should_remove = event_listener[2](event, self.context)
                    
                    if should_remove then
                        table.remove(self.listeners, i)
                    end
                end

            end

        end
    end
end

---@param time string
---@param callback function
function EventLoop:timedCallback(time, callback)
    token = os.startTimer(time)

    self:registerListener({'timer', callback, token})
end

---@param listener table<string, function, string>
function EventLoop:registerListener(listener)
    table.insert(self.listeners, listener)

    return self
end

---@param listeners table<string, function, string>[]
function EventLoop:registerListeners(listeners)
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
        local event = {os.pullEvent()}

        self:handleEvent(event)
    end
end
