--[[
    Author : Neer
    https://github.com/YoungNeer
    
    This file is part of the love2dlib repository on github:
    https://github.com/YoungNeer/love2dlib/
    lovecc: Love ColorCodes library

    love2dlib in general is licensed under GPLv3 which allows you to 
    REDISTRIBUTE IT AND/OR MODIFY IT. You can use it for BOTH PERSONAL
    AND/OR COMMERCIAL PROJECTS
]]

 colors={}
 
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
    end
    local color={}
    for i=1,3,1 do
        color[i]=_conv_htf(hex:sub(start+(i-1)*length,start+i*length-1))/255
    end
    return color
end
function colors:newColorRGB(colorname,r,g,b)
    colors[colorname]={r/255,g/255,b/255};
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
function colors:setColor(colorname)
    if love then
        love.graphics.setColor(colors[colorname])
    end
end
function colors:clear(colorname)
    if love then
        love.graphics.clear(colors[colorname])
    end
end
function colors:getColor(colorname)
    if colors[colorname]~=nil then
        return colors[colorname]
    else
        return 1,1,1
    end
end

--[[Standard Colors definition]]
colors:newColor("black","#000")
colors:newColor("red",256,0,0)
colors:newColor("green",0,256,0)
colors:newColor("blue",0,0,256)
colors:newColor("violet","#ee82ee");
colors:newColor("white","fff")
colors:newColor("aliceblue","f0f8ff")
colors:newColor("antiquewhite",'#faebd7')
colors:newColor("aqua",'#00ffff')
colors:newColor("aquamarine",'#7fffd4')
colors:newColor("azure",'#f0ffff')
colors:newColor("beige","#f5f5dc")
colors:newColor("bisque","#ffe4c4")
colors:newColor("blanchedalmond","#ffebcd")
colors:newColor("crimson",'#ed143d')
return colors
