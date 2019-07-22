# loveCC
A helper library for LOVE2D to help you with colors in general.

## Context (can skip)
Let's say you want to print red text on the screen, how would you do that? Set color to the (1,0,0), right? Well that was easy 'cause every-one knows what is red. But what if you wanted a shade of red such as crimson? Well it's still not that difficult you may wikipedia crimson and set the color to the rgb triplet and remember you will have to divide each component by 255 in the newer version. And honestly saying that's not a lot of work - but what if you had several of such colors which had to difficult to remember color code such as 'light red', 'dark red', 'orange red', etc. So you have two good options - either make your own color-palette-manager to keep track of all the colors you are using or you can use loveCC which comes with default color palette - so you don't need to redefine the common colors such as 'lime', 'orange', etc.

## Documentation

I may not cover all the aspects of loveCC (for that you need to take a dig at the source-code) so only the most important functions are discussed here.

### How to use loveCC?

Start with making a lovecc object which would be used later to set colors, get colors and reset color, set opacity and do all sorts of things.
```lua
	lovecc=require 'lovecc'
	--i like to do love.colors=require 'lovecc'
```
Now I know it's a little too early but try doing:

```lua
	lovecc:setColor('red')
	--same as love.graphics.setColor(1,0,0,1)
	lovecc:setColor('blue',0.5)
	--same as love.graphics.setColor(0,0,1,1)
```

### Add your own colors to the palette!

loveCC already has most of the colors that you'd want to use and even colors you may not have even heard of. But sometimes you want to add your own color to the color palettes, you can do this using newColor() which accepts both hex and rgb triplet

```lua
	--Overload #1
	lovecc:newColor(colorname,r,g,b)
	--note r,g,b is in the range [0,255]
	
	--Overload #2
	lovecc:newColor(colorname,hex)
```

Examples are :-
```lua
	lovecc:newColor('perchblue',0,0,0.5)
	lovecc:newColor('perchred','#900')
	--same as lovecc:newColor('perchred','900')
	lovecc:newColor('gold','#ffd700')
	--same as lovecc:newColor('gold','ffd700')
```

So now you could use all these colors in `setColor` function.
NOTE: **DONOT USE newColor IN love.update() OR love.draw() FOR PERFORMANCE REASONS**

### Convert loveCC colors to Love2D colors

As you know Love2D doesn't understand 'red', 'blue', etc so you'll need some interface to convert the loveCC colors to Love2D color format. This is pretty simple.

```lua
	lovecc:getColor(colorname, opacity)
	--opacity is 1 by default
```

Examples are:-
```lua
	love.graphics.setColor(lovecc:getColor('green'))
	--sets color to green and opacity is 1
	love.graphics.setColor(lovecc:getColor('green',0.5))
	--sets color to green and opacity is 0.5
```

**PLEASE NOTE THAT `love.graphics.setColor(lovecc:getColor('green'),0.5)` WON'T WORK**

If you want to get more than 1 color then you could use:-

```lua
	lovecc:getColors(color1,op1,...color8,op8)
	--get's n number of colors where 1<=n<=8
```

This could be useful when setting particle colors, for example-
```lua
	ParticleSystem:setColors(lovecc:getColors("red",1,"red",0.5,"blue",1,"blue",0.5))
	
	ParticleSystem:setColors(lovecc:getColors("violet",1,"indigo",1,"blue",1,"green",1,"yellow",1,"orange",1,"red",1,"white",1))
```

### Setting colors

Doing love.graphics.setColor(lovecc:getColor .. and all that looks too tacky - so loveCC provides a way to deal with that problem.

Instead of doing-
```lua
	love.graphics.setColor(lovecc:getColor(colorname, opacity))
```
You could do 
```lua
	lovecc:setColor(colorname, opacity)
```

And same for setting the Background Color:-
```lua
	lovecc:setBackgroundColor(colorname, opacity)
```

And if you only want to change the opacity then you could do:-
```lua
	lovecc:setOpacity(a)
	--color is same only opacity is changed
```

And to set particle colors you could do:-
```lua
	lovecc:setParticleColors(psystem,...)
	--Note vararg list shouldn't be nil and must be 8 at the very maximum
```

### Error-handling

What if a color doesn't exist? You could check for it yourself with the provided functions:-
```lua
	lovecc:check(...)
	--Returns true if all the colors passed in vararg list exists
	lovecc:assert(...)
	--Instead of returning anything it will throw an error if any color passed doesn't exist
```

### Default Color-Palette

Like I said earlier you don't need to redefine the common colors they are already defined for you. But sometimes you may not want all the default colors - for performance reasons. So all you have to do is go to lovecc.lua and keep only the colors that you are using i.e. remove all the colors you are not using or don't want to use. And that is the main reason why colorcodes.lua and lovecc.lua are different! colorcodes.lua is the main library and lovecc.lua is just the set of colors that you'd use.

### Performance Issues

If you are that concerned about performance then here's a tip! First figure out which color you want to use -- add them to the palette and all that. If you want to use only the default color-palette then you can skip this step. After that whenever you say lovecc:setColor(some_color) you can replace that later (when polishing the game) with love.graphics.setColor(). And honestly saying I myself never do that - I use some million color codes in my projects and NEVER EVER has the frame-rate dropped even by 1. So all I can say is this trick is for performance-maniacs and it can be a pain to replace every occurence even if you automate the task using some script. So I suggest you 'let-it-be' cause now-a-days everyone has a pretty fast computer and even mobile devices are getting stronger day by day.

### Contribution

Anyone can contribute to loveCC. Just keep in mind - that there are two lua files - one colorcodes.lua which is the kernel and second lovecc.lua which has the default colors. So you could contribute to either or both. Adding to lovecc.lua is easy - just wikipedia for common colors and if some color is not in the list then you can add it (also add a side comment eg. for crimson you can side comment 'a shade of red').
