--[[
    Anima: The unofficial Keyframe animation library of LOVE2D
    Licensed Under GPLv3
    Author: Neer 
]]

local Anima={}
--note that animOver(private) is for internal usage and animEnd(public) is for external usage
function Anima:init()
    local obj={stage=nil,actualText="",typeFunc=function() end,typeTimer=nil,typeSpeed=1,currentText="",rforever={x=false,y=false,r=false,sx=false,sy=false,op=false},speed={x=1,y=1,r=math.rad(10),sx=0.01,sy=0.01,op=0.01},mark={x=0,y=0,r=0,sx=0,sy=0,op=0},key={x=0,y=0,r=0,sx=0,sy=0,op=0},current={x=0,y=0,r=0,sx=0,sy=0,op=0},animStart=false,animOver=false,animEnd=false}
    setmetatable(obj,self)
    self.__index=self
    return obj
end

function Anima:newTypingAnimation(text,speed,func)
    self.actualText=text
    self.typeSpeed=speed or 1
    self.typeTimer=0
    if type(func)=='function' then self.typeFunc=func end
end

function Anima:startNewTypingAnimation(...)
    self:newTypingAnimation(...)
    self:startNewAnimation()
end

function Anima:setRepeat(x,y,r,sx,sy,op)
    self.rforever={x=x,y=y,r=r,sx=sx,op=op}
end

function Anima:setRepeatScale(sx,sy)
    self.rforever.sx=sx
    self.rforever.sy=sy
end

function Anima:setRepeatMove(x,y)
    self.rforever.x=x
    self.rforever.y=y
end

function Anima:setRepeatOpacity(op)
    self.rforever.op=op
end

function Anima:setRepeatRotation(r)
    self.rforever.r=r
end

function Anima:newAnimation(animation,...)

    local width,height,mark;

    if animation=='scale' then
        self.key.sx,self.key.sy,mark=...
    elseif animation=='move' then
        self.key.x,self.key.y,mark=...
    elseif animation=='rotate' then
        self.key.r,mark=...
    elseif animation=='opacity' then
        self.key.op,mark=...
    else
        self.key.x,self.key.y,self.key.r,self.key.sx,self.key.sy,self.current.op,mark=animation,...
    end

    self.key.sx=self.key.sx or 0
    self.key.sy=self.key.sy or 0
    self.key.x=self.key.x or 0
    self.key.y=self.key.y or 0
    self.key.r=self.key.r or 0
    self.key.op=self.key.op or 0
    
    if not mark then
        self.mark={x=0,y=0,r=0,sx=0,sy=0,op=0}
    end

end

function Anima:startNewAnimation(...)
    self:newAnimation(...)
    self:animationStart()
end

--useful if you want to roll back animation
function Anima:animationRollBack(operation,mark)
    if operation=='move' then
        self:newAnimation('move',-self.current.x,-self.current.y,mark)
    elseif operation=='rotate' then
        self:newAnimation('rotate',-self.current.r,mark)
    elseif operation=='scale' then
        self:newAnimation('scale',-self.current.sx,-self.current.sy,mark)
    elseif operation=='opacity' then
        self:newAnimation('opacity',-self.current.op,mark)
    else
        self:newAnimation(-self.current.x,-self.current.y,-self.current.r,-self.current.sx,-self.current.sy,-self.current.op,mark)
    end
end

--starts animation, given arguments will give the animation a headstart
function Anima:animationStart(x,y,r,sx,sy,op)
    self.current.x,self.current.y=x or 0,y or 0
    self.current.r=r or 0
    self.current.sx,self.current.sy=sx or 0,sy or 0
    self.current.op=op or 0
    self.animStart,self.animOver=true,false
    self.animEnd=false
end

--instead of resetting the values like in animationStart(), animationStartOver() uses the default values
--useful when you have more than 1 animations and you don't want to restart the animation but proceed from where you are

function Anima:animationStartOver(x,y,r,sx,sy,op)
    self.current.x,self.current.y=x or self.current.x,y or self.current.y
    self.current.r=r or self.current.r
    self.current.sx,self.current.sy=sx or self.current.sx,sy or self.current.sy
    self.current.op=op or self.current.op
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

function Anima:animationStop(arg)
    if arg==nil then arg=true end
    self.animEnd=arg
end

function Anima:resetAnimation()
    self.current.x,self.current.y,self.current.r,self.current.sx,self.current.sy,self.current.op=0,0,0,0,0,0
end

function Anima:resetKey()
    self.key={x=0,y=0,r=0,sx=0,sy=0,op=0}
end

function Anima:resetKeyM()
    self.key.x=0
    self.key.y=0
end

function Anima:resetKeyS()
    self.key.sx=0
    self.key.sy=0
end

function Anima:resetKeyO()
    self.key.op=0
end

--Many times you want to mark a position for various reasons - maybe you want to continue
--from where you stopped and you can do this on your own but I'd discourage you 'cause you 
--are only wasting your time since it has already been done for you in animationMark
function Anima:animationMark(x,y,r,sx,sy,op)
    if x==nil then
        self.mark={x=self.mark.x+self.current.x,y=self.mark.y+self.current.y,r=self.mark.r+self.current.r,sx=self.mark.sx+self.current.sx,sy=self.mark.sy+self.current.sy,op=self.mark.op+self.current.op}
    else
        self.mark.x=self.mark.x+x
        self.mark.y=self.mark.y+(y or 0)
        self.mark.r=self.mark.r+(r or 0)
        self.mark.sx=self.mark.sx+(sx or 0)
        self.mark.sy=self.mark.sy+(sy or 0)
        self.mark.op=self.mark.op+(op or 0)
    end
end

--marks the destination - you'll do it quite often when staging
function Anima:animationMarkKey()
    self.mark=self.key
end

function Anima:markM()
    self:animationMark(self.current.x,self.current.y,0)
end

function Anima:markR()
    self:animationMark(0,0,self.current.r)
end

function Anima:markS()
    self:animationMark(0,0,0,self.current.sx,self.current.sy)
end

function Anima:markO()
    self:animationMark(0,0,0,0,0,self.current.op)
end

function Anima:updateFromTable(animtbl,cmts,funcs)
    for i in ipairs(animtbl) do
        --think of i as the self.stage
        if not self.stage or (self:animationOver() and self.stage==i) then
            if not self.stage then self.stage=1 end
            self:animationMark()
            if cmts and funcs then
                assert(type(cmts)=='table',"Oops! Table expected in #2nd argument, got '"..type(cmts).."''")
                assert(type(funcs)=='table',"Oops! Table expected in #3rd argument, got '"..type(funcs).."''")
                for cmt in pairs(cmts) do 
                    if cmts[cmt]==animtbl[i]['comment'] then
                        assert(type(funcs[cmt])=='function',"Oops! Function expected for #3rd argument table at key '"..cmt.."'")
                        funcs[cmt]()
                    end
                end    
            end
            self:newAnimation(animtbl[i]['x'],animtbl[i]['y'],animtbl[i]['r'],animtbl[i]['sx'],animtbl[i]['sy'],animtbl[i]['op'],true)
            self:animationStart()
            self.stage=self.stage+1
        end
    end
    if cmts and (not funcs) then
        assert(type(cmts)=='table',"Oops! Table expected in #2nd argument, got '"..type(cmts).."''")
        self:update(cmts['dx'],cmts['dy'],cmts['dr'],cmts['dsx'],cmts['dsy'],cmts['dop'],cmts['f']) 
    else
        self:update(animtbl[self.stage-1]['dx'],animtbl[self.stage-1]['dy'],animtbl[self.stage-1]['dr'],animtbl[self.stage-1]['dsx'],animtbl[self.stage-1]['dsy'],animtbl[self.stage-1]['dop'],animtbl[self.stage-1]['f'])
    end
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

function Anima:setTypingSpeed(speed)
    self.typeSpeed=speed or 1
end

function Anima:update(dt)

    --(self.current.x<self.key.x and 1 or -1)
    --(self.current.y>self.key.y and 1 or -1)

    if self.typeTimer and self.animStart then 
        self.typeTimer=self.typeTimer+dt
        if self.typeTimer*self.typeSpeed>1 then
            self.currentText=self.currentText..self.actualText:sub(1,1)
            self.typeFunc(self.actualText:sub(1,1))            
            self.actualText=self.actualText:sub(2)
            self.typeTimer=0
        end
    end

    if type(stepx)=='table' then
        self:updateFromTable(stepx,stepy,stepr)
        return
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

        if self.current.x==self.key.x and self.current.y==self.key.y and self.current.r==self.key.r and self.current.sx==self.key.sx and self.current.sy==self.key.sy and self.current.op==self.key.op and self.actualText:len()==0 then
        
            if self.rforever.x or self.rforever.y or self.rforever.r or self.rforever.sx or self.rforever.sy or self.rforever.op then
                if self.rforever.x then self.key.x=-self.key.x end
                if self.rforever.y then self.key.y=-self.key.y end
                if self.rforever.r then self.key.r=-self.key.r end
                if self.rforever.sx then self.key.sx=-self.key.sx end
                if self.rforever.sy then self.key.sy=-self.key.sy end
                if self.rforever.op then self.key.op=-self.key.op end
            else
                self.animOver=true
                self.animEnd=true
                self.typeTimer=nil
            end
        end
    end
end

--render the animation
function Anima:render(img,x,y,r,sx,sy,addKey,...)

    --you may want - sometimes - to have the render before the animation part look just like
    --how it would look after animation. For that addKey must be true
    --P.S. FOR MORE CONTROL I RECOMMEND YOU USE animationOver() AND RENDER IN TWO DIFFERENT WAYS
    --assert(img,"The 'render' function requires atleast a drawable object as an argument")

    x=(x or 0) + (addKey==true and self.key.x or 0)
    y=(y or 0) + (addKey==true and self.key.y or 0)
    r=(r or 0) + (addKey==true and self.key.r or 0)
    sx=(sx or 1) + (addKey==true and self.key.sx or 0)
    sy=(sy or 1) + (addKey==true and self.key.sy or 0 )
    if addKey~=true and addKey then args=addKey end
    local cr,cg,cb,ca=love.graphics.getColor()
    love.graphics.setColor(cr,cg,cb,ca+self.current.op+(addKey and self.key.op or 0))
    
    love.graphics.draw(img,x+self.mark.x+self.current.x,y+self.mark.y+self.current.y,r+self.mark.r+self.current.r,sx+self.mark.sx+self.current.sx,sy+self.mark.sy+self.current.sy,args,...)
    love.graphics.setColor(cr,cg,cb,ca)
end

function Anima:printKey(text,x,y,r,sx,sy,addKey,...)
    x=(x or 0) + (addKey==true and self.key.x or 0)
    y=(y or 0) + (addKey==true and self.key.y or 0)
    r=(r or 0) + (addKey==true and self.key.r or 0)
    sx=(sx or 1) + (addKey==true and self.key.sx or 0)
    sy=(sy or 1) + (addKey==true and self.key.sy or 0 )
    local cr,cg,cb,ca=love.graphics.getColor()
    love.graphics.setColor(cr,cg,cb,ca+self.current.op+(addKey and self.key.op or 0))
    
    love.graphics.print(text,x+self.mark.x+self.current.x,y+self.mark.y+self.current.y,r+self.mark.r+self.current.r,sx+self.mark.sx+self.current.sx,sy+self.mark.sy+self.current.sy,...)
    love.graphics.setColor(cr,cg,cb,ca)
end

function Anima:print(text,x,y,r,sx,sy,...)
    self:printKey(text,x,y,r,sx,sy,false,...)
end

function Anima:printfKey(text,x,y,limit,alignmode,r,sx,sy,addKey,...)
    x=(x or 0) + (addKey==true and self.key.x or 0)
    y=(y or 0) + (addKey==true and self.key.y or 0)
    r=(r or 0) + (addKey==true and self.key.r or 0)
    sx=(sx or 1) + (addKey==true and self.key.sx or 0)
    sy=(sy or 1) + (addKey==true and self.key.sy or 0 )
    local cr,cg,cb,ca=love.graphics.getColor()
    love.graphics.setColor(cr,cg,cb,ca+self.current.op+(addKey and self.key.op or 0))
    
    love.graphics.printf(text,x+self.mark.x+self.current.x,y+self.mark.y+self.current.y,limit,alignmode,r+self.mark.r+self.current.r,sx+self.mark.sx+self.current.sx,sy+self.mark.sy+self.current.sy,...)
    love.graphics.setColor(cr,cg,cb,ca)
end

function Anima:printf(text,x,y,limit,alignmode,r,sx,sy,addKey,...)
    self:printfKey(text,x,y,limit,alignmode,r,sx,sy,false,...)
end

function Anima:getX(x)
    x=x or 0
    --note x is the initial abscissa
    return x+self.mark.x+self.current.x
end

function Anima:getY(y)
    y=y or 0
    --note y is the initial ordinate
    return y+self.mark.y+self.current.y
end

function Anima:getSX(sx)
    sx=sx or 0
    --note sx is the initial scale along x axis
    return sx+self.mark.sx+self.current.sx
end

function Anima:getSY(sy)
    sy=sy or 0
    --note sy is the initial scale along y axis
    return sy+self.mark.sy+self.current.sy
end

function Anima:getPosition(x,y)
    --note x and y are the initial positions
    return self:getX(x),self:getY(y)
end

function Anima:getRotation(r)
    --note r is the initial angle of rotation
    r=r or 0
    return r+self.mark.r+self.current.r
end

function Anima:getScale(sx,sy)
     --note sx and sy are the initial scale values
    return self:getSX(sx),self:getSY(sy)
end

--i could have done this automatically in render function, but it would have been slower
function Anima:renderQuadKey(img,quad,x,y,r,sx,sy,addKey,...)
    x=(x or 0) + (addKey and self.key.x or 0)
    y=(y or 0) + (addKey and self.key.y or 0)
    r=(r or 0) + (addKey and self.key.r or 0)
    sx=(sx or 1) + (addKey and self.key.sx or 0)
    sy=(sy or 1) + (addKey and self.key.sy or 0 )
    
    local cr,cg,cb,ca=love.graphics.getColor()
    love.graphics.setColor(cr,cg,cb,ca+self.current.op+(addKey and self.key.op or 0))

    love.graphics.draw(img,quad,x+self.mark.x+self.current.x,y+self.mark.y+self.current.y,r+self.mark.r+self.current.r,sx+self.mark.sx+self.current.sx,sy+self.mark.sy+self.current.sy,...)
    love.graphics.setColor(cr,cg,cb,ca)
end

function Anima:renderQuad(img,quad,x,y,r,sx,sy,...)
    self:renderQuadKey(img,quad,x,y,r,sx,sy,false,...)
end

function Anima:draw(...)
    self:print(self.currentText,...)
end

function Anima:drawF(...)
    self:printf(self.currentText,...)
end
return Anima
