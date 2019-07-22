--[[Standard Colors definition]]
--[[
    Over-all colors are red,blue,green,white,black,brown,grey,yellow,orange,violet,purple and indigo
    Colors other than above mentioned are just necessarily shades of the above colors or
    a mixture of two or more.
]]

local colors=require 'colorcodes'

colors:newColor("aliceblue","f0f8ff") --*very light blue
colors:newColor("antiquewhite",'#faebd7')
colors:newColor("aqua",'#00ffff') -- a blue shade
colors:newColor("aquamarine",'#7fffd4') -- a blue shade
colors:newColor("azure",'#f0ffff') -- *very light blue, (*very light means so light that even non-colorblinds can mistake for white)
colors:newColor("beige","#f5f5dc") -- *very light brown
colors:newColor("bisque","#ffe4c4") -- soup brown (light)
colors:newColor("black","#000")
colors:newColor("blanchedalmond","#ffebcd") -- very light brown
colors:newColor("blue",0,0,256)
colors:newColor("bronze","#cd7f32") -- a shade of brown
colors:newColor("brown","#a52a2a") --standard brown though i see it as dark red
colors:newColor("blueviolet","#8a2be2")
colors:newColor("burlywood","#deb887") -- a standard shade of brown
colors:newColor("cadetblue","#5f9ea0")
colors:newColor("coral","ff7f50") -- a standard orange (ish) color
colors:newColor("cornflowerblue","#6495ed")
colors:newColor("cornsilk","#fff8dc") -- very light orange and brown (ish) shade
colors:newColor("crimson",'#ed143d') -- most good-looking shade of red i believe 
colors:newColor("cyan",0,256,256) -- a very standard shade of blue
colors:newColor("dark cyan","#008b8b") -- kinda like navy blue 
colors:newColor("darkblue","#00008b")
colors:newColor("darkslateblue","#483d8b")
colors:newColor("darkolivegreen","#556b2f")
colors:newColor("darkorchid","#9932cc") -- light purple
colors:newColor("darkgrey","#a9a9a9")
colors:newColor("darkslategrey","#2f4f4f")
colors:newColor("deeppink","#ff1493") -- bright purple
colors:newColor("deepskyblue","#00bfff")
colors:newColor("dimgrey","#696969")
colors:newColor("dodgerblue","#1e90ff")
colors:newColor("grey","#808080") 
colors:newColor("gold","#ffd700") --a shade of yellow
colors:newColor("green","008000")
colors:newColor("indianred","#cd5c5c")
colors:newColor("indigo","#4b0082")
colors:newColor("ivory","#fffff0") -- one of those white shades
colors:newColor("lightgrey","#d3d3d3")
colors:newColor("lightblue","#add8e6")
colors:newColor("lightsteelblue","#b0c4de")
colors:newColor("lightskyblue","#87cefa")
colors:newColor("lime",0,256,0) -- perhaps the most well-known green shade
colors:newColor("mediumpurple","#9370db")
colors:newColor("mediumblue",'#0000cd')
colors:newColor("mediumslateblue",'#7b68ee')
colors:newColor("navy","#000080") -- navy blue
colors:newColor("neon","26d3ff") -- neon blue
colors:newColor("olive","#808000") -- a shade of green and brown
colors:newColor("olivedrab","#6b8e23")  -- little dark olive green
colors:newColor("orange","#ffa500");
colors:newColor("orangered","#ff4500");
colors:newColor("orchid","#da70d6"); -- so similar that you will say 'i dont know looks exactly like violet'
colors:newColor("palegreen","#98fb98") -- kinda like grass green, i'd say
colors:newColor("paleturquoise","#afeeee") -- nice light (not very light) blue color
colors:newColor("pink","#ffc0cb") -- a very light shade of red
colors:newColor("purple","#800080")
colors:newColor("rebeccapurple","#663399")
colors:newColor("red",256,0,0)
colors:newColor("royalblue","#4169e1")
colors:newColor("rosybrown","#bc8f8f")
colors:newColor("skyblue","87ceeb")
colors:newColor("silver","#c0c0c0")  -- a grey shade
colors:newColor("slategrey","#708090") 
colors:newColor("slateblue","#6a5acd") 
colors:newColor("steelblue","#4682b4") 
colors:newColor("violet","#ee82ee");
colors:newColor("yellow",256,256,0)
colors:newColor("white","fff")
colors:newColor("whitesmoke","#f5f5f5") -- a shade of grey


return colors