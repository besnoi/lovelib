--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [Penguin Credit- From Seth Kenlon Book "Developing Games on Rasperry Pi"]
    [Wall-Image Credit- One of the default Assets packed with GameMaker 8.1, (C) YoYo Games]
    Any questions/bugs/suggestions or complaints can be reported at my email--
    netroco@rediffmail.com
    
]]
Anima=require('Anima')

--this time instead of having a like a sort of global branch variable and tons of if statements
--we would have just one if statement. We will solve this 'complicated path' problem using tables and ofcourse Anima

--it would be more effecient if you donot use hashing (this x,y stuff in strings) 
--So instead of saying PATH[i][x] you would say PATH[i][1] and PATH[i][2] for PATH[i][y]
--But here I'm hashing because this is a demo to show you the advantages of Anima, so better keep things simple
PATH={
        {['x']=96+5,['y']=0},{['x']=0,['y']=288},
        {['x']=384/2-1,['y']=0},{['x']=0,['y']=-256},
        {['x']=256,['y']=0},{['x']=0,['y']=320},
        {['x']=96,['y']=0}
    }
function love.load()
    love.window.setMode(640,480)
    background=love.graphics.newImage("maze.png")
    love.window.setTitle("Penguin Animation Demo [Using Anima]")
    love.graphics.setBackgroundColor(1,1,1)
    penguin=love.graphics.newImage("penguin.png")
    --Wait where is animpenguin??
    --[[
        In the previous version of the code we had this branch variable all over the code
        and there was no centre point from where we could easily make changes to the path.
        But in this version we have all the loop at one place - in the update function. Declaring
        a variable is not always a good idea when inside the update function but if careful then
        there is no problem in doing that and that is exactly what we are doing- animpenguin is
        defined in the update function
    ]]
end

function love.update(dt)
    --I'm using ipairs instead of pairs cause of performance reasons but again this is not much of a deal in Lua
    for i in ipairs(PATH) do
        --think of i as the branch
        if not animpenguin then
            animpenguin=Anima:init()
        end
        if not branch or (animpenguin:animationOver() and branch==i) then
            if not branch then branch=1 end
            branch=branch+1
            animpenguin:animationMark()
            animpenguin:newAnimation("move",PATH[i]['x'],PATH[i]['y'],true)
            animpenguin:animationStart()
        end
    end
    animpenguin:update(2,2)
end

function love.draw()
    love.graphics.draw(background)
    animpenguin:render(penguin,0,32)
end

--A foot note here : You may be wondering that the seeming 'long' solution had somewhere like 80 lines
--and this one has like 70 lines so definitely this is not big of a deal. But I'd like to point out that
--if you remove all the comments from both the files and then compare then you'd agree with me that this is
--a more efficient solution and also if we increase branches from 7 to 70, then the difference would be clear