--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [Penguin Credit- From Seth Kenlon Book "Developing Games on Rasperry Pi"]
    Any questions/bugs or complaints can be reported at my email--
    netroco@rediffmail.com
    
]]

--require our Anima library, you can give any name to this class, but I'm sticking with Anima
Anima=require 'Anima'

function love.load()
    --set the title (just something i like to do in my demos)
    love.window.setTitle("Penguin Animation Demo [Using Anima]")
    --set the background image to white (just something i like to do in my demos)
    love.graphics.setBackgroundColor(1,1,1)
    --load the penguin graphic image
    penguin=love.graphics.newImage("d0.png")
    --Note animpenguin is the object and Anima is the class - the blueprint of the object (not exactly though)
    --From this point we'll work only on animpenguin and not Anima
    animpenguin=Anima:init()
    --[[We will move the character in a path. Note that path animations can be little tricky sometimes
      Here we only move in L path so it won't be that hard even if you were to do this without Anima
      But when paths get more and more branched Anima will literally save you HOURS OF HARD WORK.
      When you have that many branches I suggest you use a branch variable to denote which branch you are
      or you can think in terms of nodes/joints/points or whatever- but the idea is the same. Once you have completed
      one branch-path animation you increment the branch variable denoting that you are in another branch now
      and for a particular value of branch the character/object will undergo a different animation
    --[[
        EXPLANATION:
        In the first branch we have to move down (200px) and after that 200px along the x axis (so L path)
        Unfortunately we cannot do this in one step- cause if we do - animpenguin:newAnimation("move",200,200)-
        Anima will give you a diagonal movement animation, which ofcourse you don't want.
        So we will have to split the animation. First part is here, second you can find in love's update function
    ]]
    animpenguin:newAnimation("move",0,200)
    --You have loaded the animation using newAnimation but still animation won't start cause you have to
    --kick start it using animationStart() -- this has the advantage that you can load animation in one line
    --and run it in another line which may not always be the next line
    animpenguin:animationStart()
    --We are at the first branch of the path
    branch=1
end

function love.update(dt)
    --Right now we want the same speed throughout the path so we will have only one update function
    --If however we wanted different speeds then we'd have to have two update() function
    --Note default movement speed is 1,1
    animpenguin:update()
    --Same as animaxe:updateM()

    if animpenguin:animationOver() and branch==1 then
        --Mark the current relative position, other-wise you would begin the animation from where you started
        animpenguin:animationMark()
        animpenguin:newAnimation("move",200,0,true)
        --What this true means in the above line is that "Do not set marked position to Zero"
        --If you set it to some falsy value then it would be the same as not having any marked position
        animpenguin:animationStart()
        branch=2
    end
end

function love.draw()
    animpenguin:render(penguin,20,20)
end
