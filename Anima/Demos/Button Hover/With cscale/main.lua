--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [Button-Image Credit- One of the default Assets packed with GD4 and GD5 (GDevelop)]
    Any questions/bugs/suggestions or complaints can be reported at my email--
    netroco@rediffmail.com
    
]]
Anima=require('Anima')


function love.load()
    love.window.setMode(640,480)
    
    love.window.setTitle("Sexy Button Hover Demo [Using Anima]")
    love.graphics.setBackgroundColor(1,1,1)
    button=love.graphics.newImage("button.png")
    --Since we are scaling the button, we don't want that blurry look on the image
    button:setFilter('linear','nearest')
    animbtn=Anima:init()
end

function love.update(dt)
    animbtn:update(1.2,1.2,nil,0.005,0.005)
    x=love.mouse.getX()
    y=love.mouse.getY()
    if x>=(640-button:getWidth())/2 and x<=(640-button:getWidth())/2+button:getWidth()
    and y>=(480-button:getHeight())/2 and y<=(480-button:getHeight())/2+button:getHeight() then
        if love.mouse.isDown(1) then
            animbtn:animationRollBack('opacity')
            animbtn:newAnimation('cscale',0.1,0.1,button:getWidth(),button:getHeight())
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
    
    animbtn:render(button,(640-button:getWidth())/2,(480-button:getHeight())/2,0,1,1)
end