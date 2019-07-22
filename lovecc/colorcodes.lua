--[[
    Author : Neer
    https://github.com/YoungNeer
    
    This file is part of the love2dlib repository on github:
    https://github.com/YoungNeer/love2dlib/
    loveCC (ColorCodes library for Love2D) is useful if you maintain a somewhat limited color palette
    or if you have the habit of reusing colors. So instead of memorising or noting down the colors you
    are using or (you will use) let loveCC do the hard work for you. Just in the beginning add colors  to your
    colors database like "brownyred" for some rgb (0-255 range or 0-1 range) or even hex (#rgb or rgb or #rrggbb or rrggbb)
    Note that in the ending of you project some standard colors have been set to the colors database so you don't
    even have to define most colors. If you want to use some shade of red just search red and you will find the result
    either in the color name like "darkred" or in the comments for let's say "crimson". And note that
    here the standard definition is mingling with the library and making it look huge (*d.trump in the middle- HUGE)
    So i strongly recommend you have a seperate file for palettes and have all the color-definitions in that file
    so whenever you want to change color to something instead of scrolling up to main.lua (or whatever)
    you just open the seperate file on the next tab and see what colors you are using which keeps the game aesthetics healthy
    and makes the game look more coherent and plus point is also that such practice will reduce your code and you don't have
    to sort of try all the color combinations and waste minutes or maybe even hours.

    love2dlib in general is licensed under GPLv3 which allows you to 
    REDISTRIBUTE IT AND/OR MODIFY IT. You can use it for BOTH PERSONAL
    AND/OR COMMERCIAL PROJECTS. And YOU DO NOT NEED TO CREDIT ME
    (although I would appreciate that ^_^)
]]


local colors={}


local function _conv_charhtd(c)
    if c=='a' or c=='b' or c=='c' or c=='d' or c=='e' or c=='f' then 
        return c:byte()-87
    else
        if tonumber(c)~=null then
            return tonumber(c)
        else
            return nil
        end
    end
end
local function _conv_htf(c)
    if tonumber(c)~=nil then
        if tonumber(c)<10 then
            return tonumber(c)*16
        else
            return (tonumber(c)-tonumber(c)%10)*1.6+tonumber(c)%10
        end
    else
        c=c:lower()
        if c:len()==1 then 
            return _conv_charhtd(c)*16
        elseif c:len()==2 then
            return _conv_charhtd(c:sub(1,1))*16+_conv_charhtd(c:sub(2,2))
        end
    end
    return nil
end
function colors:getHex(hex)
    if hex:len()==3 then
        start=1
        length=1
    elseif hex:len()==4 then     
        start=2
        length=1   
    elseif hex:len()==6 then
        start=1
        length=2
    elseif hex:len()==7 then
        start=2
        length=2
    else
        error("Invalid Hex Color Code provided in 'getHex' function")
    end
    local color={}
    for i=1,3,1 do
        color[i]=_conv_htf(hex:sub(start+(i-1)*length,start+i*length-1))/255
    end
    return color
end
function colors:newColorRGB(colorname,r,g,b,type)
    if type~='default' then
        colors[colorname]={r/255,g/255,b/255};
    else
        colors[colorname]={r,g,b};
    end
end
function colors:getColorRGB(r,g,b)
    return r/255,g/255,b/255
end
function colors:getColorRGBA(r,g,b,a)
    return r/255,g/255,b/255,a/255
end
function colors:newColorHex(colorname,colorcode)
   colors[colorname]=colors:getHex(colorcode)
end
function colors:newColor(colorname,...)
    if select('#',...)==3 then
        colors:newColorRGB(colorname,...)
    elseif select('#',...)==1 then
        colors:newColorHex(colorname,...)
    else
        colors:newColorRGB(colorname,255,255,255)
    end
end
function colors:reset()
    love.graphics.setColor(1,1,1,1)    
end
function colors:setColor(colorname,opacity)
    colors:assert(colorname)
    if love then
        love.graphics.setColor(colors:getColor(colorname,opacity or 1))
    end
end
function colors:setBackgroundColor(colorname,opacity)
    colors:assert(colorname)
    if love then
        love.graphics.setColor(colors:getColor(colorname,opacity or 1))
    end
end

function colors:setParticleColors(particle,...)
    particle:setColors(colors:getColors(...))
end

function colors:setOpacity(opacity)
    assert(opacity,"Function 'setOpacity' requires argument 'alpha' (0-1)")
    assert(type(opacity)=="number","Argument Provided in function 'setOpacity' must be a number")
    local r,g,b=love.graphics.getColor()
    love.graphics.setColor(r,g,b,opacity)
end

function colors:getColor(colorname,opacity)
    if colors[colorname] then
        return colors[colorname][1],colors[colorname][2],colors[colorname][3],(opacity or 1)
    else
        return 1,1,1,opacity
    end
end

function colors:getColors2(color1,op1,color2,op2)
    local r1,g1,b1=colors:getColor(color1)
    return r1,g1,b1,op1,colors[color2][1],colors[color2][2],colors[color2][3],op2 or 1
end

function colors:getColors3(color1,op1,color2,op2,color3,op3)
    local r1,g1,b1,a1,r2,g2,b2,a2=colors:getColors2(color1,op1,color2,op2)
    return r1,g1,b1,a1,r2,g2,b2,a2,colors[color3][1],colors[color3][2],colors[color3][3],op3 or 1
end

function colors:getColors4(color1,op1,color2,op2,color3,op3,color4,op4)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3=colors:getColors3(color1,op1,color2,op2,color3,op3)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,colors[color4][1],colors[color4][2],colors[color4][3],op4 or 1
end

function colors:getColors5(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4=colors:getColors4(color1,op1,color2,op2,color3,op3,color4,op4)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,colors[color5][1],colors[color5][2],colors[color5][3],op5 or 1
end

function colors:getColors6(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5=colors:getColors5(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,colors[color6][1],colors[color6][2],colors[color6][3],op6 or 1
end

function colors:getColors7(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6=colors:getColors6(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6,colors[color7][1],colors[color7][2],colors[color7][3],op7 or 1
end

function colors:getColors8(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7,color8,op8)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6,r7,g7,b7,a7=colors:getColors7(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6,r7,g7,b7,a7,colors[color8][1],colors[color8][2],colors[color8][3],op8 or 1
end

function colors:getColors(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7,color8,op8)
    colors:assert(color1,color2,color3,color4,color5,color6,color7,color8)
    if not color2 then return colors:getColor(color1,op1)
    elseif not color3 then return colors:getColors2(color1,op1,color2,op2)
    elseif not color4 then return colors:getColors3(color1,op1,color2,op2,color3,op3)
    elseif not color5 then return colors:getColors4(color1,op1,color2,op2,color3,op3,color4,op4)
    elseif not color6 then return colors:getColors5(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5)
    elseif not color7 then return colors:getColors6(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6)
    elseif not color8 then return colors:getColors7(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7)
    else return colors:getColors8(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7,color8,op8)
    end
end


--[[Debugging functions - just to sort of doublecheck whether color exists useful when in loop and/or when you have something else to do if color doesn't exist]]

--returns true if all the colors provided in the argument exists
function colors:assert(...)
    for _,i in ipairs{...} do
        assert(colors[i],"Oops! Color '"..tostring(i).."' doesn't exist!!!")
    end
end

--unlike assert, it doesn't print any errors or stops the program it just returns whether or not a color exists
function colors:check(...)
    for _,i in ipairs{...} do
        if not i or not colors[i] then
            return false
        end
    end
    return true
end

return colors
