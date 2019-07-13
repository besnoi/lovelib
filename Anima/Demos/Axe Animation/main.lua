--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [P.S.: Game assets retrieved from an unidentifiable source, but kudos to whoever made it]
    Any questions/bugs or complaints can be reported at my email--
    netroco@rediffmail.com

    
]]

--require our Anima library, you can give any name to this class, but I'm sticking with Anima
Anima=require '../Anima'

--the timer for the axe strip animation (nothing to do with Anima - just the spritesheet stuff///)
timer=0
--the current frame of the spritesheet (again nothing to do with Anima)
frame=1
function love.load()
    --set the title (just something i like to do in my demos)
    love.window.setTitle("Axe Animation Demo [Using Anima]")
    --set the background image to white (just something i like to do in my demos)
    love.graphics.setBackgroundColor(1,1,1)
    --load the axe graphic images
    WWIDTH,WHEIGHT=love.window.getMode()
    axe=love.graphics.newImage("axe44.png")
    axeQuad={}
    --We have 44 sprites in our spritesheet/atlas/strip or whatever you wanna call it
    for i=1,44 do
        axeQuad[i]=love.graphics.newQuad(64*(i-1),0,64,64,64*44,64)
    end
    --Note animaxe is the object and Anima is the class - the blueprint of the object (not exactly though)
    --From this point we'll work only on animaxe and not Anima
    animaxe=Anima:init()
    --Move along the y axis and keep doing this forever
    --[[
        EXPLANATION:
        When axe have moved -5 units along y axis it will flip direction and move another 5 units 
        along that direction and so on....
        The forever condition is set in the update function of animaxe
    ]]
    animaxe:newAnimation("move",0,-5)
    --You have loaded the animation using newAnimation but still animation won't start cause you have to
    --kick start it using animationStart() -- this has the advantage that you can load animation in one line
    --and run it in another line which may not always be the next line
    animaxe:animationStart()
end

function love.update(dt)
    timer=timer+dt
    --basically what the next 4 lines means is "in every 5ms increment the frame"
    if timer>0.05 then
        frame=frame + 1
        timer=0
    end
    --We don't have more than 44 frames so when we reach 45 we want to reset the frame to 1
    if frame>44 then frame=1 end
    --[The last parameter in update function checks 'forever' condition]
    animaxe:update(0.5,0.5,nil,nil,nil,nil,true)
    --(                   ^r,^sx,^sy,^op, ^forever), r-rotation, sx,sy-scale,op-opacity
    --If the above code doesn't look good then you can use-
    --animaxe:updateF(0.5,0.5)
    --which is kind of a macro to run update with forever==true
end

function love.draw()
    --[[A note: If you are confused what Anima is actually doing then remove the next line where Anima is used
        and make sure you render the quads using love's draw function (its already commented for you)
    ]]
    animaxe:renderQuad(axe,axeQuad[frame],(WWIDTH-64)/2,(WHEIGHT-64)/2)
    --love.graphics.draw(axe,axeQuad[frame],(640-64)/2,(480-64)/2)

end
