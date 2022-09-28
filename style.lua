
NodeStyle = { 'visible', 'textColor', 'backgroundColor', 'positionChildren', 'positioning' }
NodeStyle.__index = NodeStyle

function NodeStyle.new(options)
    return setmetatable(
        {   
            textColor = options.textColor or "red",
            backgroundColor = options.backgroundColor or "black",
            visible = options.visible or true,
            positionChildren = options.positionChildren or 'absolute',
            positioning = options.positioning or 'absolute'
        },
        NodeStyle)
end

setmetatable(NodeStyle, { __call = function(_, ...) return NodeStyle.new(...) end })