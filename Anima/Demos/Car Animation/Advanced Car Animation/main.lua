--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [Vroom Sound,Car-Image Credit- One of the default Assets packed with GDevelop 5]
    [Car collision sound credit -  by Jacob Habgood + one of the default Assets packed with GameMaker]
    [Background Image: Racing Game Assets by Unlucky Studio (http://unluckystudio.com)]
    Any questions/bugs/suggestions or complaints can be reported at my email--
    netroco@rediffmail.com
]]
Anima=require('Anima')

--[[
    In the previous example, our animation was way too simple and naive (naive cause no animation principles were used)
    such as exaggeration,anticipation,etc. But in this example we will use the anticipation principle (for starters anticipation means getting
    ready for animation, for example the unnecessary moves an athlete makes before running) 
    [Note: For more on animation principle you can read the book "The Illusion Of Life" - but again it's not that important unless
    you want to become a professional animator or maybe your game is full of cutscenes and your animations are looking somewhat dull]
]]
function love.load()
    background=love.graphics.newImage("back.png")
    dustbin=love.graphics.newImage("bin_close.png")
    vroomsound=love.audio.newSource("vroom.wav",'static')
    collisionsound=love.audio.newSource("car_collision.wav",'static')
    love.audio.play(vroomsound)
    vroomsound:setLooping(true)
    --set volume of collisionsound to 30% so that your ears are alright
    collisionsound:setVolume(0.3)
    love.window.setMode(640,480)
    love.window.setTitle("Car Animation Demo [Using Anima]")
    love.graphics.setBackgroundColor(1,1,1)
    car=love.graphics.newImage("car-body.png")
    wheel=love.graphics.newImage("tire.png")
    anim={
        car=Anima:init(),
        --dustbin falling animation 
        dustbin=Anima:init(),
        wheel=Anima:init()
    }
    --see draw function if you want to understand this arithematic
    --anim.car:newAnimation('rotate',math.rad(-30))
    anim.car:newAnimation('scale',-0.05,0,true)
    anim.car:animationStart()
    --so first we will move the car backwards, kind of silly but this is the core principle of anticipation (remember how athlete moves a little backward before moving a large amount in the forward direction)
    phase='squash'
end

function love.update(dt)
    --the loop of rotating the wheels
        if phase~='squash' and phase~='move back' and phase~='what' and (not anim.wheel:animationStarted() or anim.wheel:animationOver()) then
            anim.wheel:animationMark()
            anim.wheel:resetKey()
            anim.wheel:newAnimation('rotate',2*math.pi,true)
            anim.wheel:animationStart()
        end
    --you normally donot want the rotation per frame to be more than 20d otherwise the gamer would not even know if it is even rotating -you get what i mean
    anim.wheel:update(2,2,math.rad(10))
    
    
    if phase=='squash' then
        if not anim.car:animationOver() then 
            anim.car:updateS(0.001,0.001)
        else
            anim.car:animationMark()
            anim.car:newAnimation('move',-20,0,true)
            anim.car:animationStart()
            phase='move back'
        end
    elseif phase=='move back' then
        if not anim.car:animationOver() then
            anim.car:updateM(0.2,0.2)
        else
            anim.car:animationMark()
            anim.car:animationRollBack('scale',true)
            anim.car:newAnimation('rotate',math.rad(-10),true)
            anim.car:newAnimation('move',230,0,true)
            anim.car:animationStart()
            phase='move front'
        end
    elseif phase=='move front' then
        if not anim.car:animationOver() then
            anim.car:updateR(math.rad(0.1))
            anim.car:updateS(0.001,0.001)
            anim.car:updateM(5)
        else
            anim.car:animationMark()
            anim.car:newAnimation('rotate',math.rad(-10),true)
            anim.wheel:newAnimation('move',0,-20)
            anim.car:newAnimation('move',50,-20,true)
            anim.car:animationStart()
            phase='jump'
        end
        --anim.car:updateS()
    elseif phase=='jump' then
        -- love.event.wait()
        if not (anim.car.r==anim.car.key.r and anim.car.x==anim.car.key.x and anim.car.y==anim.car.key.y) then
            anim.car:updateR(math.rad(0.1))
            anim.car:updateM(1,1)
        else
            anim.car:animationMark()
            anim.car:resetKey()
            anim.car:newAnimation('move',140,0,true)
            anim.car:animationStart()
            anim.dustbin:newAnimation('rotate',math.pi/2)
            anim.dustbin:animationStart()
            phase='over'
        end
        
        
    elseif phase=='over' then
        if not (anim.car.x==anim.car.key.x and anim.car.y==anim.car.key.y) then
            anim.car:updateM(5)
        else
            anim.car:animationMark()
            anim.car:resetKey()
            -- print(anim.car.r,anim.car.key.r)
            -- anim.car:newAnimation('rotate',math.rad(-30),true)
            -- anim.wheel:resetKey()
            anim.wheel:animationMark()
            anim.wheel:newAnimation('move',0,100,true)
            
            --print(anim.car.r,anim.car.key.r)
            
            anim.car:animationStart()    
            phase='end'        
        end
    elseif phase=='end' then
        -- love.event.wait()
    
        if not (anim.car.r==anim.car.key.r and anim.wheel.x==anim.wheel.key.x and anim.wheel.y==anim.wheel.key.y) then
            anim.car:updateR(math.rad(2))
        else
            -- anim.wheel:animationMarkKey()
            
             anim.car:newAnimation('rotate',math.rad(40),true)
            anim.car:newAnimation('move',0,50,true)
            anim.car:animationStartOver(0,0)
            phase='what'
        end 
    elseif phase=='what' then
        if not (anim.car.y==anim.car.key.y) then
            --print('working')
            anim.car:update(0,2,math.rad(2))
        end
    end
    anim.dustbin:updateR(math.rad(5))
end
function love.draw()  
    love.graphics.draw(background)
    anim.dustbin:render(dustbin,350,360-car:getHeight()*0.4+dustbin:getHeight(),0,0.5,0.5,dustbin:getWidth()/2,dustbin:getHeight())
    anim.car:render(car,50,360-car:getHeight()*0.4,0,0.3,0.3)
    --I seriously donot have any reasonable explanation for this arithematic down here, i am just somewhat good at guessing (fyi i've hacked many password JUST BY GUESSING) but if anyone of you have any better approach to this problem rather than just guessing then please mail it to me (of course you will get credit for your algorithm)
    if anim.car:getRotation()==0 then
        if phase~='end' then
            anim.wheel:render(wheel,anim.car:getX()+(car:getWidth()*0.1*(anim.car:getSX()))+64,370-wheel:getHeight()*0.35,0,0.35+anim.car:getSX(),0.35,wheel:getWidth()/2, wheel:getHeight()/2)        
            anim.wheel:render(wheel,car:getWidth()*0.7*(anim.car:getSX())+anim.car:getX()+148,370-wheel:getHeight()*0.35,0,0.35+anim.car:getSX(),0.35,wheel:getWidth()/2, wheel:getHeight()/2)
        end
    elseif anim.car:getRotation()==math.rad(-10) then
        --if it was all about moving then we could have sort of used anima for this but we also need to reset the scale value
        --so no scaling with respect to the car, and x and y coordinates will be moved
        if phase~='end' then
            anim.wheel:render(wheel,13+anim.car:getX()+(car:getWidth()*0.1*(anim.car:getSX()))+64,-5+370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)        
            anim.wheel:render(wheel,11+car:getWidth()*0.7*(anim.car:getSX())+anim.car:getX()+148,-15+370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
        end
    else
        -- print("Car Information")
        -- print(anim.car.x,anim.car.y,anim.car.r)
        -- print("Left Wheel Information")
        -- print(25+anim.car:getX()+(car:getWidth()*0.1*(anim.car:getSX()))+64,-29+370-wheel:getHeight()*0.35)        
        -- print("Right Wheel Information")
        -- print(21+car:getWidth()*0.7*(anim.car:getSX())+anim.car:getX()+148,-55+370-wheel:getHeight()*0.35)
        -- print("-----------------------------")
        if phase~='end' and phase~='what' then
            anim.wheel:render(wheel,25+anim.car:getX()+(car:getWidth()*0.1*(anim.car:getSX()))+64,-09+370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
            anim.wheel:render(wheel,21+car:getWidth()*0.7*(anim.car:getSX())+anim.car:getX()+148,-35+370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
        end
    end
    if phase=='end' or phase=='what' then
        anim.wheel:render(wheel,25+anim.car:getX()+(car:getWidth()*0.1*(anim.car:getSX()))+64,-9+370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2,wheel:getHeight()/2)
        --print(anim.car:getRotation())
        anim.wheel:render(wheel,21+car:getWidth()*0.7*(anim.car:getSX())+anim.car:getX()+148,
        -35+370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
    end
end
