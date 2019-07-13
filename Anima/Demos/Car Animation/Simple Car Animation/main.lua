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
    You have a car sprite, you have a wheel sprite LOVE2D. What do you need to rock and roll in less than 5/10 minutes? (depends on your typing speed,brain processing power,etc)
    Answer is Anima!!! In this example you will see how easy it is to animate a car
]]
function love.load()
    background=love.graphics.newImage("back.png")
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
        wheel=Anima:init()
    }
    --see draw function if you want to understand this arithematic
    anim.car:newAnimation('move',640-car:getWidth()*0.4-21)
    anim.car:animationStart()
end

function love.update(dt)
    --if animation of wheel has not yet started (we didn't load the animation in the load function) or if its already over then reset it and do this only while car is moving i.e. don't rotate the wheels if car has stopped 
    if not anim.car:animationOver() and (not anim.wheel:animationStarted() or anim.wheel:animationOver()) then
        anim.wheel:newAnimation('rotate',2*math.pi)
        anim.wheel:animationStart()
    end
    --you normally donot want the rotation per frame to be more than 20d otherwise the gamer would not even know if it is even rotating -you get what i mean
    if anim.car:animationOver() and vroomsound:isPlaying() then
        collisionsound:play()
        vroomsound:stop()
    end
    anim.car:update()
    anim.wheel:updateR(math.rad(10))    
    --If you want to be more strict with your animation then you can add this instead of the above line
    --if not anim.car:animationOver() then anim.wheel:updateR(math.rad(10))    end
    --though it is not going to make THAT much of a difference cause you are only skipping 18 frames at the most
    --in fact i believe the not skipping 18 (or less maybe) frames and rotating the wheels for some time after the car has stopped will look better than being precise - cause you know - the law of inertia and stuff like that
end
function love.draw()  
    love.graphics.draw(background)
    anim.car:render(car,20,360-car:getHeight()*0.4,0,0.3,0.3)
    anim.wheel:render(wheel,anim.car.x+118,370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
    anim.wheel:render(wheel,anim.car.x+34,370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
end
