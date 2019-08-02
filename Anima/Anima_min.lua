--[[
    Anima: The unofficial Keyframe animation library of LOVE2D
    Licensed Under GPLv3
    Author: Neer 
]]

local Anima={}
--note that animOver(private) is for internal usage and animEnd(public) is for external usage
function Anima:init()
    local obj={initialOpacity=nil,actualText="",typeFunc=function() end,typeTimer=nil,typeSpeed=1,currentText="",currentRepeat={x=0,y=0,r=0,sx=0,sy=0,op=0},rtime={x=-1,y=-1,r=-1,sx=-1,sy=-1,op=-1},isRepeat={x=false,y=false,r=false,sx=false,sy=false,op=false},speed={x=1,y=1,r=math.rad(10),sx=0.01,sy=0.01,op=0.01},key={x=0,y=0,r=0,sx=0,sy=0,op=0},current={x=0,y=0,r=0,sx=0,sy=0,op=0},animStart=false,animOver=false,animEnd=false}
    setmetatable(obj,self)
    self.__index=self
    return obj
end

function Anima:setInitialOpacity(op)
    self.initialOpacity=op or 1
end

function Anima:newTypingAnimation(text,speed,func)
    self.actualText=text
    self.typeSpeed=speed or 1
    self.typeTimer=0
    if type(func)=='function' then self.typeFunc=func end
end

function Anima:startNewTypingAnimation(...)
    self:newTypingAnimation(...)
    self:animationStart()
end

--if -1 (default) then repeat forever
function Anima:repeatTimes(x,y,r,sx,sy,op)
    self.rtime={x=x or -1,y=y or -1,r=r or -1,sx=sx or -1,sy=sy or -1,op=op or -1}
end

function Anima:setRepeat(x,y,r,sx,sy,op)
    self.isRepeat={x=x or false,y=y or false,r=r or false,sx=sx or false,op=op or false}
end

function Anima:setRepeatScale(sx,sy)
    self.isRepeat.sx=sx
    self.isRepeat.sy=sy
end

function Anima:setRepeatMove(x,y)
    self.isRepeat.x=x
    self.isRepeat.y=y
end

function Anima:setRepeatOpacity(op)
    self.isRepeat.op=op
end

function Anima:setRepeatRotation(r)
    self.isRepeat.r=r
end

function Anima:newAnimation(animation,...)
    if animation=='scale' then
        self.key.sx,self.key.sy=...
    elseif animation=='move' then
        self.key.x,self.key.y=...
    elseif animation=='rotate' then
        self.key.r=...
    elseif animation=='opacity' then
        self.key.op=...
    else
        self.key.x,self.key.y,self.key.r,self.key.sx,self.key.sy,self.current.op=animation,...
    end

    self.key.sx=self.key.sx or 0
    self.key.sy=self.key.sy or 0
    self.key.x=self.key.x or 0
    self.key.y=self.key.y or 0
    self.key.r=self.key.r or 0
    self.key.op=self.key.op or 0
end

function Anima:startNewAnimation(...)
    self:resetAnimation()
    self:newAnimation(...)
    self:animationStart()
end

--starts animation
function Anima:animationStart()
    self.animStart,self.animOver=true,false
    self.animEnd=false
end

function Anima:animationStarted()
    return self.animStart
end

function Anima:animationRunning()
    return not self.animEnd
end

function Anima:animationOver()
    return self.animEnd
end

function Anima:rotateAnimationOver()
    return self.current.r==self.key.r
end

function Anima:moveAnimationOver()
    return self.current.x==self.key.x and self.current.y==self.key.y
end

function Anima:scaleAnimationOver()
    return self.current.sx==self.key.sx and self.current.sy==self.key.sy
end


function Anima:animationStop()
    self.animEnd=true
end

function Anima:restartAnimation()
    self:resetAnimation()
    self:animationStart()
end

function Anima:resetAnimation()
    self.current.x,self.current.y,self.current.r,self.current.sx,self.current.sy,self.current.op=0,0,0,0,0,0
    self.currentRepeat={x=0,y=0,r=0,sx=0,sy=0,op=0}
end

function Anima:resetKey()
    self.key={x=0,y=0,r=0,sx=0,sy=0,op=0}
end

function Anima:resetKeyMove()
    self.key.x=0
    self.key.y=0
end

function Anima:resetKeyRotate()
    self.key.r=0
end

function Anima:resetKeyScale()
    self.key.sx=0
    self.key.sy=0
end

function Anima:resetKeyOpacity()
    self.key.op=0
end

function Anima:setMoveSpeed(dx,dy)
    self.speed.x,self.speed.y=dx or 1,dy or 1
end

function Anima:setRotationSpeed(dr)
    self.speed.r=dr or math.rad(10)
end

function Anima:setScaleSpeed(dsx,dsy)
    self.speed.sx,self.speed.sy=dsx or 0.01,dsy or 0.01
end

function Anima:setOpacitySpeed(op)
    self.speed.op=op or 0.01
end

function Anima:setSpeed(dx,dy,dr,dsx,dsy,dop)
    self:setMoveSpeed(dx,dy)
    self:setRotationSpeed(dr)
    self:setScaleSpeed(dsx,dsy)
    self:setOpacitySpeed(dop)
end

function Anima:update(dt)

    if self.typeTimer and self.animStart and not self.animOver then 
        self.typeTimer=self.typeTimer+dt
        if self.typeTimer*self.typeSpeed>1 then
            self.currentText=self.currentText..self.actualText:sub(1,1)
            self.typeFunc(self.actualText:sub(1,1))            
            self.actualText=self.actualText:sub(2)
            self.typeTimer=0
        end
    end

    if self.animStart and not self.animOver then

        for k in pairs(self.key) do 
            if self.key[k]~=0 and self.key[k]~=self.current[k] then
                self.current[k]=self.current[k]+(self.current[k]<self.key[k] and self.speed[k] or -self.speed[k])
            end
            if (self.key[k]>0 and self.current[k]>self.key[k]) or (self.key[k]<0 and self.current[k]<self.key[k]) then
                self.current[k]=self.key[k]
            end
        end
        local animationComplete=true

        if self.current.x==self.key.x and self.current.y==self.key.y and self.current.r==self.key.r and self.current.sx==self.key.sx and self.current.sy==self.key.sy and self.current.op==self.key.op and self.actualText:len()==0 then
        
            for k in pairs(self.key) do
                if self.isRepeat[k] and (self.rtime[k]==-1 or self.currentRepeat[k]<self.rtime[k]) then
                    self.key[k]=-self.key[k]
                    self.currentRepeat[k]=self.currentRepeat[k]+1
                    if self.currentRepeat[k]==self.rtime[k] then
                        self.isRepeat[k]=false
                    end
                    animationComplete=false
                end
                
            end
            if animationComplete then
                self.animOver=true
                self.animEnd=true
                self.typeTimer=nil
            end
        end
    end
end

--render the animation
function Anima:render(img,x,y,r,sx,sy,...)

    x=(x or 0)
    y=(y or 0) 
    r=(r or 0) 
    sx=(sx or 1) 
    sy=(sy or 1) 
	local cr,cg,cb,ca=love.graphics.getColor()
	
	if not self.initialOpacity then self.initialOpacity=ca end

    love.graphics.setColor(cr,cg,cb,self.initialOpacity+self.current.op)
    
    love.graphics.draw(img,x+self.current.x,y+self.current.y,r+self.current.r,sx+self.current.sx,sy+self.current.sy,...)
    love.graphics.setColor(cr,cg,cb,ca)
end

function Anima:print(text,x,y,r,sx,sy,...)
    x=(x or 0) 
    y=(y or 0) 
    r=(r or 0) 
    sx=(sx or 1) 
    sy=(sy or 1) 
	local cr,cg,cb,ca=love.graphics.getColor()
	
	if not self.initialOpacity then self.initialOpacity=ca end

    love.graphics.setColor(cr,cg,cb,self.initialOpacity+self.current.op)
    
    love.graphics.print(text,x+self.current.x,y+self.current.y,r+self.current.r,sx+self.current.sx,sy+self.current.sy,...)
    love.graphics.setColor(cr,cg,cb,ca)
end


function Anima:printf(text,x,y,limit,alignmode,r,sx,sy,...)
    x=(x or 0) 
    y=(y or 0) 
    r=(r or 0) 
    sx=(sx or 1) 
    sy=(sy or 1) 
	local cr,cg,cb,ca=love.graphics.getColor()

	if not self.initialOpacity then self.initialOpacity=ca end

    love.graphics.setColor(cr,cg,cb,self.initialOpacity+self.current.op)
    
    love.graphics.printf(text,x+self.current.x,y+self.current.y,limit,alignmode,r+self.current.r,sx+self.current.sx,sy+self.current.sy,...)
    love.graphics.setColor(cr,cg,cb,ca)
end


function Anima:getX(x)
    x=x or 0
    --note x is the abscissa during drawing
    return x+self.current.x
end

function Anima:getY(y)
    y=y or 0
    --note y is the ordinate during drawing
    return y+self.current.y
end

function Anima:getSX(sx)
    sx=sx or 0
    --note sx is the scale along x axis during drawing
    return sx+self.current.sx
end

function Anima:getSY(sy)
    sy=sy or 0
    --note sy is the scale along y axis during drawing
    return sy+self.current.sy
end

function Anima:getPosition(x,y)
    --note x and y denotes the position during drawing
    return self:getX(x),self:getY(y)
end

function Anima:getRotation(r)
    --note r is the initial angle of rotation
    r=r or 0
    return r+self.current.r
end

function Anima:getScale(sx,sy)
     --note sx and sy are the initial scale values
    return self:getSX(sx),self:getSY(sy)
end

--i could have done this automatically in render function, but it would have been slower
function Anima:renderQuad(img,quad,x,y,r,sx,sy,...)
    x=(x or 0) 
    y=(y or 0) 
    r=(r or 0) 
    sx=(sx or 1)
    sy=(sy or 1)
    
	local cr,cg,cb,ca=love.graphics.getColor()
	
	if not self.initialOpacity then self.initialOpacity=ca end
	
    love.graphics.setColor(cr,cg,cb,self.initialOpacity+self.current.op)

    love.graphics.draw(img,quad,x+self.current.x,y+self.current.y,r+self.current.r,sx+self.current.sx,sy+self.current.sy,...)
    love.graphics.setColor(cr,cg,cb,ca)
end

function Anima:draw(...)
    self:print(self.currentText,...)
end

function Anima:drawF(...)
    self:printf(self.currentText,...)
end
return Anima

