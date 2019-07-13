--[[
    Anima Library For LOVE2D  Example : Infinite up and down animation
    Author: Neer
    https://github.com/YoungNeer/
    [Bounce Sound Credit- Generated in sfxr -- and I don't think i need to credit myself for that]
    [Hamster Ball Image Credit - Downloaded from Love2d wiki page for love.graphics.draw]
    Any questions/bugs/suggestions or complaints can be reported at my email--
    netroco@rediffmail.com
]]
Anima=require('Anima')

--[[
    Squash and Stretch animation principle. Almost every animator's first animation is this ball animation
    sort of how almost every programmer's first program is Hello World. Reason for this ofcourse cause most animators
    learn their trade at animation academies where almost all of them begin with a sphere animation and also because squash
    and stretch is the first animation principle to learn and master.
    [note if you are interested: my first animation was a rather boring text animation - since i was 'community-educated' (i learnt and am still learning from youtube,vimeo,etc)
    so i just picked any random animation tutorial video on the internet]
    here we use squash and stretch to animate a ball. If you notice then we have used only three of anima's functions
]]

animtbl={
    {['x']=50,['y']=-100,['dx']=3/2,['dy']=3},
    {['x']=40,['y']=-10,['dx']=2,['dy']=1},
    {['x']=15,['y']=15,['dx']=1,['dy']=1},
    {['x']=15,['y']=45,['dx']=1,['dy']=3},
    {['x']=15,['y']=90,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=12,['dsx']=0.01,['dsy']=0.01},
    {['x']=15,['y']=150,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=20,['dsx']=0.01,['dsy']=0.01},
    {['x']=15,['y']=75,['sx']=0.4,['sy']=-0.4,['dx']=2,['dy']=10,['dsx']=0.05,['dsy']=0.05},
    {['sy']=-0.2,['dsy']=0.05,['comment']='bounce'},
    {['x']=30,['y']=-115,['sx']=-0.4,['sy']=0.5,['dx']=3,['dy']=11.5,['dsx']=0.05,['dsy']=0.05},
    {['x']=30,['y']=-120,['sx']=0.2,['sy']=-0.1,['dx']=2,['dy']=8,['dsx']=0.05,['dsy']=0.05},
    {['x']=30,['y']=-60,['dx']=2,['dy']=4,['dsy']=0.05},
    
    {['x']=15,['y']=15,['dx']=1,['dy']=1},        
    {['x']=15,['y']=45,['dx']=1,['dy']=3},
    
    {['x']=15,['y']=90,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=12,['dsx']=0.01,['dsy']=0.01},
    {['x']=15,['y']=120,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=16,['dsx']=0.01,['dsy']=0.01},
    {['x']=15,['y']=15,['sx']=0.4,['sy']=-0.4,['dx']=2,['dy']=2,['dsx']=0.05,['dsy']=0.05},
    {['sy']=-0.2,['dsy']=0.05,['comment']='bounce'},
    {['x']=30,['y']=-90,['sx']=-0.4,['sy']=0.5,['dx']=3,['dy']=9,['dsx']=0.05,['dsy']=0.05},
    {['x']=30,['y']=-60,['sx']=0.2,['sy']=-0.1,['dx']=2,['dy']=4,['dsx']=0.05,['dsy']=0.05},
    {['x']=30,['y']=-30,['dx']=2,['dy']=2,['dsy']=0.05},
    
    {['x']=15,['y']=15,['dx']=1,['dy']=1},        
    {['x']=15,['y']=45,['dx']=1,['dy']=3},
    {['x']=15,['y']=75,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=5,['dsx']=0.01,['dsy']=0.01},
    {['x']=15,['y']=30,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=4,['dsx']=0.01,['dsy']=0.01},
    {['x']=15,['y']=15,['sx']=0.4,['sy']=-0.4,['dx']=2,['dy']=2,['dsx']=0.05,['dsy']=0.05},
    {['sy']=-0.2,['dsy']=0.05,['comment']='bounce'},
    {['x']=30,['y']=-60,['sx']=-0.4,['sy']=0.5,['dx']=3,['dy']=6,['dsx']=0.05,['dsy']=0.05},
    {['x']=30,['y']=-30,['sx']=0.2,['sy']=-0.1,['dx']=2,['dy']=2,['dsx']=0.05,['dsy']=0.05},
    {['x']=15,['y']=15,['dx']=1,['dy']=1},
    {['x']=15,['y']=45,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=6,['dsx']=0.01,['dsy']=0.01},        
    {['x']=15,['y']=15,['sx']=-0.1,['sy']=0.1,['dx']=2,['dy']=2,['dsx']=0.01,['dsy']=0.01},
    {['x']=15,['y']=15,['sx']=0.4,['sy']=-0.4,['dx']=2,['dy']=2,['dsx']=0.05,['dsy']=0.05},
    {['sy']=-0.2,['dsy']=0.05,['comment']='bounce'},
    {['x']=15,['y']=-15,['sx']=-0.4,['sy']=0.5,['dx']=3,['dy']=9,['dsx']=0.05,['dsy']=0.05},
    {['x']=15,['y']=-15,['sx']=0.2,['sy']=-0.1,['dx']=2,['dy']=4,['dsx']=0.05,['dsy']=0.05},
    {['x']=15,['y']=-15,['dx']=2,['dy']=2,['dsy']=0.05},
    {['x']=15,['y']=15,['dx']=1,['dy']=1},        
    {['x']=15,['y']=15,['dx']=1,['dy']=3},
    {['x']=15,['y']=15,['sy']=-0.1,['dx']=1,['dy']=1,['dsy']=0.05},        
    
    
}
function love.load()
    love.window.setTitle("Bouncing Ball Animation [Using Anima]")
    love.window.setMode(640,480)
    love.graphics.setBackgroundColor(1,1,1)
    ball=love.graphics.newImage("hamster.png")
    bouncesound=love.audio.newSource("bounce.wav",'static')
    
local stage=nil
animball=Anima:init()
end
function playsound()
    bouncesound:play()
end
function love.update(dt)
    animball:update(animtbl,{'bounce'},{playsound})
    --same as 
    --animball:updateT(animtbl,{'bounce'},{playsound})
end
function love.draw()  
    --we want to scale upwards not downwards, so we set the origin to ball:getWidth()/2,ball:getHeight()
    animball:render(ball,0,230,0,1,1,ball:getWidth()/2,ball:getHeight())
end
