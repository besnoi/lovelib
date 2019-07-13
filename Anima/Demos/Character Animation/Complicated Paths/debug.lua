--[[
    LOVE2D Unofficial Debug Library 
    Licensed under GPLv3
    Author: Neer
]]

--setmetatable({},debug)
--draw a border around an image, useful to check collisions


local debug={}
function debug:init(window_mode)
    self.w,self.h=window_mode
end
function debug:drawBorder(img,x,y,width,height,mode)
    assert(img,"Please provide Image in drawborder function")
    if height==nil then mode=width;width=nil end
    width=width or img:getWidth()
    height=height or img:getHeight()
    if mode then mode='fill' else mode='line' end
    love.graphics.rectangle(mode,x,y,width,height)
end
--pause the game, it would resume on any action taken (moving mouse, or pressing any button)
function debug.pause()
    love.event.wait()
end
--print the Co-ordinateS
function debug:printCS(step,div)
    --step implies tilesize, div means by what number should you divide the co-ordinate to be printed
    step = step or 100
    div=div or 1
    for y=0,self.h,step do
        for x=0,self.w,step do 
            love.graphics.print(x/div,x,y)
        end
    end
end
--A very effecient way to drawTiles
function debug:drawTiles(tilesize)
    --Most people use rectangles and thye literally make each tile making the time
    --complexity quadratic. It would only be useful if one has to print tiles seperately
    --otherwise one can just print lines and that would be much more efficient as TC would be linear
    for y=0,self.h,tilesize do
        love.graphics.line(0,y,self.w,y)
    end
    for x=0,self.w,tilesize do
        love.graphics.line(x,0,x,self.h)
    end
end

function debug:drawGrid(tilesize,div)
    debug:drawTiles(tilesize)
    debug:printCS(tilesize,div)
end

return debug