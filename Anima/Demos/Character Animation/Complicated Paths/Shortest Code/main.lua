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
--[[
    In all the other versions we couldn't make the code (with comments) less than 50 lines
    So this is just an attempt to do that -- and notice how much of Anima are we using
]]
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
    penguin=love.graphics.newImage("penguin.png")
end
function love.update(dt)
    if not animpenguin then animpenguin=Anima:init() end
    animpenguin:update(PATH,{['dx']=2,['dy']=2})
    --so what just happened right -- until now we were using just the general update function
    --and just know you saw with your own eyes that that's not even half of what anima can do for you
    --You can pass a table as the first argument which is a very powerful method and this is particularly why
    --Anima has its punchline as "Simple-Animations,Cutscenes or Key-frame animations - Anima does it all"
    --And in the second arument we passed the speed table, if we wanted the default speed then we could have skipped it
    --but in the other two versions we have used a speed of 2,2 so i couldn't skip this. 
    --Note that here we have a general speed for all the branches. You can also have different speed for different branches (for that refer to "Bounced Ball animations")
    --And also for more advanced use of this keyframe animation method, please see "Bounced Ball animations"

end
function love.draw()
    love.graphics.draw(background)
    animpenguin:render(penguin,0,32)
end