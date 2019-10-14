--[[
    Author : Neer
    https://github.com/YoungNeer
    
    This file is part of the love2dlib repository on github:
    https://github.com/YoungNeer/love2dlib/
    loveCC (ColorCodes library for Love2D) is useful if you maintain a somewhat limited color palette
    or if you have the habit of reusing lovecc. So instead of memorising or noting down the lovecc you
    are using or (you will use) let loveCC do the hard work for you. Just in the beginning add lovecc  to your
    lovecc database like "brownyred" for some rgb (0-255 range or 0-1 range) or even hex (#rgb or rgb or #rrggbb or rrggbb)
    Note that in the ending of you project some standard lovecc have been set to the lovecc database so you don't
    even have to define most lovecc. If you want to use some shade of red just search red and you will find the result
    either in the color name like "darkred" or in the comments for let's say "crimson". And note that
    here the standard definition is mingling with the library and making it look huge (*d.trump in the middle- HUGE)
    So i strongly recommend you have a seperate file for palettes and have all the color-definitions in that file
    so whenever you want to change color to something instead of scrolling up to main.lua (or whatever)
    you just open the seperate file on the next tab and see what lovecc you are using which keeps the game aesthetics healthy
    and makes the game look more coherent and plus point is also that such practice will reduce your code and you don't have
    to sort of try all the color combinations and waste minutes or maybe even hours.

    love2dlib in general is licensed under GPLv3 which allows you to 
    REDISTRIBUTE IT AND/OR MODIFY IT. You can use it for BOTH PERSONAL
    AND/OR COMMERCIAL PROJECTS. And YOU DO NOT NEED TO CREDIT ME
    (although I would appreciate that ^_^)
]]

local lovecc={
    colors={}
}

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
function lovecc.getHex(hex)
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
function lovecc.newColorRGB(colorname,r,g,b,type)
    if type~='default' then
        lovecc.colors[colorname]={r/255,g/255,b/255};
    else
        lovecc.colors[colorname]={r,g,b};
    end
end
function lovecc.getColorRGB(r,g,b)
    return r/255,g/255,b/255
end
function lovecc.getColorRGBA(r,g,b,a)
    return r/255,g/255,b/255,a/255
end
function lovecc.newColorHex(colorname,colorcode)
   lovecc.colors[colorname]=lovecc.getHex(colorcode)
end
function lovecc.newColor(colorname,...)
    if select('#',...)==3 then
        lovecc.newColorRGB(colorname,...)
    elseif select('#',...)==1 then
        lovecc.newColorHex(colorname,...)
    else
        lovecc.newColorRGB(colorname,255,255,255)
    end
end
function lovecc.reset()
    love.graphics.setColor(1,1,1,1)    
end
function lovecc.setColor(colorname,opacity)
    lovecc.assert(colorname)
    if love then
        love.graphics.setColor(lovecc.getColor(colorname,opacity or 1))
    end
end
function lovecc.setBackgroundColor(colorname,opacity)
    lovecc.assert(colorname)
    if love then
        love.graphics.setBackgroundColor(lovecc.getColor(colorname,opacity or 1))
    end
end

function lovecc.setParticleColors(particle,...)
    particle:setColors(lovecc.getColors(...))
end

--inverts the given color - like black becomes white and all that
function lovecc.invertColor(color,opacity)
    local r,g,b=lovecc.getColor(color)
    love.graphics.setColor(math.abs(1-r),math.abs(1-g),math.abs(1-b),opacity or 1)   
end

--inverts the current color
function lovecc.invert(opacity)
    local r,g,b=love.graphics.getColor()
    love.graphics.setColor(math.abs(1-r),math.abs(1-g),math.abs(1-b),opacity or 1)
end



function lovecc.setOpacity(opacity)
    assert(opacity,"Function 'setOpacity' requires argument 'alpha' (0-1)")
    assert(type(opacity)=="number","Argument Provided in function 'setOpacity' must be a number")
    local r,g,b=love.graphics.getColor()
    love.graphics.setColor(r,g,b,opacity)
end

function lovecc.getColor(colorname,opacity)
    if lovecc.colors[colorname] then
        return lovecc.colors[colorname][1],lovecc.colors[colorname][2],lovecc.colors[colorname][3],(opacity or 1)
    else
        return 1,1,1,opacity
    end
end

function lovecc.getColors2(color1,op1,color2,op2)
    local r1,g1,b1=lovecc.getColor(color1)
    return r1,g1,b1,op1,lovecc.colors[color2][1],lovecc.colors[color2][2],lovecc.colors[color2][3],op2 or 1
end

function lovecc.getColors3(color1,op1,color2,op2,color3,op3)
    local r1,g1,b1,a1,r2,g2,b2,a2=lovecc.getColors2(color1,op1,color2,op2)
    return r1,g1,b1,a1,r2,g2,b2,a2,lovecc.colors[color3][1],lovecc.colors[color3][2],lovecc.colors[color3][3],op3 or 1
end

function lovecc.getColors4(color1,op1,color2,op2,color3,op3,color4,op4)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3=lovecc.getColors3(color1,op1,color2,op2,color3,op3)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,lovecc.colors[color4][1],lovecc.colors[color4][2],lovecc.colors[color4][3],op4 or 1
end

function lovecc.getColors5(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4=lovecc.getColors4(color1,op1,color2,op2,color3,op3,color4,op4)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,lovecc.colors[color5][1],lovecc.colors[color5][2],lovecc.colors[color5][3],op5 or 1
end

function lovecc.getColors6(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5=lovecc.getColors5(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,lovecc.colors[color6][1],lovecc.colors[color6][2],lovecc.colors[color6][3],op6 or 1
end

function lovecc.getColors7(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6=lovecc.getColors6(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6,lovecc.colors[color7][1],lovecc.colors[color7][2],lovecc.colors[color7][3],op7 or 1
end

function lovecc.getColors8(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7,color8,op8)
    local r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6,r7,g7,b7,a7=lovecc.getColors7(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7)
    return r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3,r4,g4,b4,a4,r5,g5,b5,a5,r6,g6,b6,a6,r7,g7,b7,a7,lovecc.colors[color8][1],lovecc.colors[color8][2],lovecc.colors[color8][3],op8 or 1
end

function lovecc.getColors(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7,color8,op8)
    lovecc.assert(color1,color2,color3,color4,color5,color6,color7,color8)
    if not color2 then return lovecc.getColor(color1,op1)
    elseif not color3 then return lovecc.getColors2(color1,op1,color2,op2)
    elseif not color4 then return lovecc.getColors3(color1,op1,color2,op2,color3,op3)
    elseif not color5 then return lovecc.getColors4(color1,op1,color2,op2,color3,op3,color4,op4)
    elseif not color6 then return lovecc.getColors5(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5)
    elseif not color7 then return lovecc.getColors6(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6)
    elseif not color8 then return lovecc.getColors7(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7)
    else return lovecc.getColors8(color1,op1,color2,op2,color3,op3,color4,op4,color5,op5,color6,op6,color7,op7,color8,op8)
    end
end


--[[Debugging functions - just to sort of doublecheck whether color exists useful when in loop and/or when you have something else to do if color doesn't exist]]

--returns true if all the lovecc provided in the argument exists
function lovecc.assert(...)
    for _,i in ipairs{...} do
        assert(lovecc.colors[i],"Oops! Color '"..tostring(i).."' doesn't exist!!!")
    end
end

--unlike assert, it doesn't print any errors or stops the program it just returns whether or not a color exists
function lovecc.check(...)
    for _,i in ipairs{...} do
        if not i or not lovecc.colors[i] then
            return false
        end
    end
    return true
end

local LIB_PATH=...

function lovecc.addPalette(palette_file,is_hashtable,love_format)
    local palette=require (LIB_PATH..'.Palette.'..palette_file)
    
    for i,color in pairs(palette) do
        if not is_hashtable then
            if love_format then
                local _,r,g,b=unpack(color)            
                lovecc.colors[name]={r,g,b}
            else
                lovecc.newColor(unpack(color))
            end
        else
            if love_format then
                lovecc.colors[i]=color
            else
                lovecc.newColor(i,unpack(color))
            end
        end
    end
end

lovecc.addPalette('default',true,true)
return lovecc
