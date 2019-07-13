--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [Button-Image Credit- One of the default Assets packed with GD4 and GD5 (GDevelop)]
    Any questions/bugs/suggestions or complaints can be reported at my email--
    netroco@rediffmail.com
    
]]
Anima=require('Anima')

--[[
    If you read the 'with cscale' main file then you must have noticed that we had to change the speed
    of the movement per frame as well as the speed by which we scale per frame. And if you donot provide
    right speed such that both the animations stop at almost the same time then it won't give you the effect
    of scaling along the center. And you also need to pass the width and the height of the image as we saw.
    So even if cscale does a number of things automatically let it can be a little tricky to get the hang of
    it - the main pain in the neck is figuring out the speed. So you may ask is there any other way? Ofcourse
    there are tons of ways - but most of them donot use Anima, in this example we will explore the lower level
    details of Anima and by the end of the example you will - hopefully - admit that when Anima is combined with
    your skills it can be a very powerful tool - powerful in the sense that it will SAVE U A LOT OF TIME.
    So let's get started
]]
function love.load()
    love.window.setMode(640,480)
    love.window.setTitle("Sexy Button Hover Demo [Using Anima]")
    love.graphics.setBackgroundColor(1,1,1)
    button=love.graphics.newImage("button.png")
    --Since we are scaling the button, we don't want that blurry look on the image
    button:setFilter('nearest','nearest')
    animbtn=Anima:init()
end

function love.update(dt)
    animbtn:update()
    x=love.mouse.getX()
    y=love.mouse.getY()
    if x>=(640-button:getWidth())/2 and x<=(640-button:getWidth())/2+button:getWidth()
    and y>=(480-button:getHeight())/2 and y<=(480-button:getHeight())/2+button:getHeight() then
        if love.mouse.isDown(1) then
            animbtn:animationRollBack('opacity')
            animbtn:newAnimation('scale',0.1,0.1)
        else
            animbtn:newAnimation('opacity',-0.5)        
        end
        animbtn:animationStartOver() 
    else
        --roll back every changes made
        animbtn:animationRollBack()
        animbtn:animationStartOver()
    end
end
function love.draw() 
    animbtn:render(button,(640-button:getWidth()*(1+animbtn.sx))/2,(480-button:getHeight()*(1+animbtn.sy))/2,0,1,1)
end