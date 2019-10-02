# Flare

Flare is a funky love2d library which allows you to have predefined (or even custom) splash-screen for your Love2D game. And what I mean by splash-screen? Well you should have a look at [a quick walkthrough](#a-quick-walkthrough)

# Table of Contents
- [A quick walkthrough](#a-quick-walkthrough)
- [Documentation](#documentation)
	- [Essential Ones]()
		- [flare.init](#flareinitimgparams)
		- [flare.update](#flareupdatedt)
		- [flare.draw](#flaredraw)
	- [Other functions]()
		- [flare.drawImage](#flaredrawimage)
		- [flare.drawText](#flaredrawtext)
		- [flare.drawProgressBar](#flaredrawprogressbar)
- [Aliases used by Flare](#aliases-used-by-flare)

## A quick Walkthrough

Let's say you have an image like [this](Examples/Example%201/splash.jpg) which you want as a splashscreen. How many lines do you think you need for that? Twenty, Thirty, Fifty,... what if I say **two**. Let's see how could you implement a splash-screen in two lines.

```lua
flare=require 'flare'    --require the library
flare("splash.jpg")      --init flare with the background image for splash-screen
```

And that'd create a default splash-screen with copyright and loading text at bottom-left and no progress bar. But we decide to remove the text and show the built-in progress bar that comes with flare. So we change the second line with:-

```lua
flare("splash.jpg",{
	showText=false,
	showProgressBar=true
})
```

And that'd have the following effect:-

<p align="center">
<img src="Images/demo1.gif" title="The splash-screen we just created"/>
</p>

Didn't like it? Don't worry- *Flare is fully customizable* - and that too on a higher level. And by that I mean you don't tweak with the library (if you like you could tweak, source is well-commented for you to start) but make changes in your *own code* - that's the kind of customization I'm talking about.

## Documentation

Flare is a pretty small library - there are only six functions and only one of them is mandatory - which is flare.init (the constructor function that we saw in the [quick walkthrough](#a-quick-walkthrough)). And the number of essential functions (the functions that you'd use in most of the cases) is half of that. And the other half of functions are more about customizing which of-course is 'non-essential' but you could do it if you like it.


### flare.init(img,[params])

This is the sort of driver function and must be called before using any other function of flare!!

- **Arguments**
	1.	<u>img </u>     The background image for the splash-screen (url or                         reference)
	2.	<u>params </u>  A table of extra parameters (optional)
		* `delay`            - For how long should splash window appear
		* `initialWidth`     - The width of the splash window
		* `initialHeight`    - The height of the splash window
		* `initFlags`        - The flags for the splash window
		* `finalWidth`       - The width of the actual window
		* `finalHeight`      - The height of the actual window
		* `finalFlags`       - The flags for the actual window		
		* `showProgressBar`  - Should the progress bar be displayed?
		* `showProgressText` - Should text be displayed over the progress bar?
		* `getProgress`      - A callback function which returns the progress                         value for the progress bar (between 0-1)
		* `showText`         - Should text be displayed in the splash?
		* `getText`          - A callback function which returns all the                              parameters needed by `love.graphics.print`
		* `onSplashOver`     - A callback function which is invoked when the                          splash is over

> For default values check line 24 of [flare.lua](flare.lua) and for default aliases check [aliases used by flare](#aliases-used-by-flare)

- **Returns**
	* nil - flare.init doesn't return anything

- **Synopsis**
	- ```lua
		flare.init(imageUrl,params) 
		-- same as
		flare(imageUrl,params)
	```
- **Example**
	- ```lua
		flare("img",{
			delay=3,                                        --delay after three seconds
			iw=640,ih=480,                                  --set the splash window dimension to (640,360)
			iw=1280,ih=720,                                 --set the actual window dimension to (1280,720)
			onSplashOver=function() print("welcome") end    --when the splash is complete (after 3s)
		})
	```
	- ```lua
		flare.init("img",{
			showText=false,                   --don't show the loading text in the splash
			showProgressBar=true,             --show the progress bar in the splash
			showProgressText=false,           --but don't show the progress text over the bar (1%,2%,...)
		})
	```
	- ```lua
		local a=0
		flare("img",{
			--the text and where to position it
			getText=function() return "Copyright (C) Lorem Ipsum",300,400 end,
			showProgressBar=true,
			--the handler which returns the progress of the progress bar
			getProgress=function() a=a+1 return a end,
		})
	```

### flare.update(dt)

*Self-explanatory*

> If you don't have anything else in your `love.update` function (which btw is very rare) then you don't need to have this function anywhere in your code. Only if you are `overriding` love.update then should you call this function inside of `love.update`

### flare.draw()

Takes no arguments, doesn't return anything. Other stuff should be "*Self-explanatory*"

### flare.drawImage()

How many images should flare draw? Where should it draw? Or should it draw any image at all? All of this can be customised by over-riding this function with your own that *does something* and that's all!

### flare.drawText()

Customization related to text. If you understand `flare.drawImage` then you understand `flare.drawText` as well

### flare.drawProgressBar()

Customization related to the progress bar. If you understand either of the above two then you - by principle - understand this one as well.

## Aliases used in flare

Due to the constraint of time that's imposed on this project (by myself) I couldn't complete this section. So I'll simply give directions here. Look at line 48 of [flare.lua](flare.lua) and you'll (perhaps) understand the aliases used in `flare.init`. An alias for `flare.render` for `flare.draw`