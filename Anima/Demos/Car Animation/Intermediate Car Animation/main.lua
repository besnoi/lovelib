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
    In the basic version, the audio was not fitting the scene cause the vroom sound was making the player believe the car is of the vintage age
    but from the look of it - it didn't seem so. So in this version I've decided to make the car look more vintage and I'm only going to change the
    animation part for that
]]
function love.load()
    background=love.graphics.newImage("back.png")
    vroomsound=love.audio.newSource("vroom.wav",'static')
    collisionsound=love.audio.newSource("car_collision.wav",'static')
    love.audio.play(vroomsound)
    vroomsound:setLooping(true)
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
    anim.car:newAnimation('move',640-car:getWidth()*0.4-21,4)
    anim.car:animationStart()
end

function love.update(dt)
    if not anim.car:animationOver() and (not anim.wheel:animationStarted() or anim.wheel:animationOver()) then
        anim.wheel:newAnimation('rotate',2*math.pi)
        anim.wheel:animationStart()
    end
    if anim.car:animationOver() and vroomsound:isPlaying() then
        collisionsound:play()
        vroomsound:stop()
    end
    --move with default horizontal speed but custom vertical speed
    anim.car:update(nil,0.4)
    if anim.car.y==anim.car.key.y then
        anim.car.key.y=-anim.car.key.y
    end
    anim.wheel:updateR(math.rad(10))
end
function love.draw()  
    love.graphics.draw(background)
    anim.car:render(car,20,360-car:getHeight()*0.4,0,0.3,0.3)
    anim.wheel:render(wheel,anim.car.x+118,370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
    anim.wheel:render(wheel,anim.car.x+34,370-wheel:getHeight()*0.35,0,0.35,0.35,wheel:getWidth()/2, wheel:getHeight()/2)
end
