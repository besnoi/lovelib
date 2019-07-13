--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [Penguin Credit- From Seth Kenlon Book "Developing Games on Rasperry Pi"]
    [Wall-Image Credit- One of the default Assets packed with GameMaker 8.1, (C) YoYo Games]
    Any questions/bugs or complaints can be reported at my email--
    netroco@rediffmail.com
    
]]
Anima=require('Anima')

function love.load()
    love.window.setMode(640,480)
    background=love.graphics.newImage("maze.png")
    love.window.setTitle("Penguin Animation Demo [Using Anima]")
    love.graphics.setBackgroundColor(1,1,1)
    penguin=love.graphics.newImage("penguin.png")
    animpenguin=Anima:init()
    animpenguin:newAnimation("move",96+5,0)
    animpenguin:animationStart()
    --We are at the first branch of the path
    branch=1
end

function love.update(dt)
    --[[Note that in the first two branch the penguin would walk but in the last branch
        the penguin would run- so we need different speed of animation which means different
        update functions for the same penguin
    ]]
    animpenguin:update(2,2)
    if animpenguin:animationOver() and branch==1 then
        animpenguin:animationMark()
        animpenguin:newAnimation("move",0,288,true)
        animpenguin:animationStart()
        branch=2
    end
    if branch==2 and animpenguin:animationOver() then
        animpenguin:animationMark()
        animpenguin:newAnimation("move",384/2-1,0,true)
        animpenguin:animationStart()
        branch=3
    end
    if branch==3 and animpenguin:animationOver() then
        animpenguin:animationMark()
        animpenguin:newAnimation("move",0,-256,true)
        animpenguin:animationStart()
        branch=4
    end
    if branch==4 and animpenguin:animationOver() then
        animpenguin:animationMark()
        animpenguin:newAnimation("move",256,0,true)
        animpenguin:animationStart()
        branch=5
    end
    if branch==5 and animpenguin:animationOver() then
        animpenguin:animationMark()
        animpenguin:newAnimation("move",0,320,true)
        animpenguin:animationStart()
        branch=6
    end
    if branch==6 and animpenguin:animationOver() then
        animpenguin:animationMark()
        animpenguin:newAnimation("move",96,0,true)
        animpenguin:animationStart()
        branch=7
        --lol there is no 7th branch in our animation
    end
end

function love.draw()
    love.graphics.draw(background)
    animpenguin:render(penguin,0,32)
end
