# autoCursor

autoCursor is a straight-forward artificial mouse-input-handling module for the beloved LÖVE framework which allows many cool features such as making the cursor _follow_ a particular position rather than jumping from one position to another and of course *that's not all*.

### Context (can Skip)

Sometimes - when developing games with AI - you want the AI-agent to move the mouse on its own (maybe in board-games like chess,tic-tac-toe,etc where such actions adds to the illusion that another player is playing with the user so-to-speak).
You can achieve that by using ```love.mouse:setPosition``` but the problem is that it would appear very fake because the cursor is not _moving_ to a position rather _jumping_ to a position. So would it not be nice if you had a framework whose sole purpose-in-life was to achieve that functionality in LÖVE2D allowing you to make the mouse follow to a particular position with other features such as changing the speed at which mouse follows a position or automatically clicking mouse when the cursor has reached the position, etc.

## Usage

```lua
acursor = require 'autoCursor'
```

### Setting the Destination Point

```setDestination(x,y)``` sets the destination point (x,y) which the cursor follows

Now try running the following example:-

```lua
function love.load()
    acursor.setDestination(200,200)
    --so here the destination point is (200,200)
end

function love.update(dt)
    acursor.update()
end
```

### Changing the speed

```acursor.update``` accepts two parameters ```dx``` and ```dy``` which you can think of as the speed. By default it is 1 pixel/frame but you can set it to something else. This is especially useful when you want to move the cursor diagonally but the distance to cover is unsymmetric (different for x and y).

Try this in the previous example:

```lua
    acursor.update(5,5)
```

### Changing the Source Point

Note that source point is by default (0,0) however you can change it to some other value using ```setPosition(x,y)```

In our example you may want to add the following to ```love.load()```
```lua
    acursor.setPosition(400,400)
```

### Automatically clicking when destination is reached

You can set automatic clicking such that when a destination is reached autoCursor will automatically trigger a mouse click. The question you need to ask yourself before setting automatic clicking is - *Do you want to click at the destination point or at a different point?* depending on that you may want to use either of ```clickOnReachingDest(mousebtn,isTouch)``` or ```clickPointOnDest(x,ymousebtn,isTouch) ```

In our example you may want to add the following to ```love.load()```
```lua
    acursor.clickOnReachingDest()
```
The default arguments are ```mousebtn==1``` and ```isTouch=false```. So what this will do is left-click the destination point on reaching the destination point

### Enable Dragging

You can enable automatic dragging such that LMB is pressed every time the current mouse position is changed and that would give a smooth effect of dragging.

```lua
    acursor.enableDragging()
```

If you want to turn off dragging then you can simple pass `false` in the argument

### Move/click/drag more than one times

All the functions above are good when you only want the cursor to move only one time. But what if you want to move more than one times? What if you want to click on something more than one time? What if you want to drag something in a non-linear path? All these may sound very complicated but are easy to achieve using autoCursor.

Just make a table in the given format which defines all that you want to do with the cursor:-

```
	points={
		{fromX=value,fromY=value,toX=value,toY=value,clickOnDest=1 or 2 or 3),drag=boolean}
		...    ...    ...    ...    ...    ...    ...    ...    ...    ...    ...    ...
		...    ...    ...    ...    ...    ...    ...    ...    ...    ...    ...    ...
		{fromX=value,fromY=value,toX=value,toY=value,clickOnDest=1 or 2 or 3),drag=boolean}
	}
```

Okay that was the generic format - each entry in the table doesn't always need to have these fields 'cause if a field is not found then it will switch to the previous entry's field. So effectively you don't have to set any other field if it's value is no different then the field's value in the previous entry.

Once done setting the table all you have to do is call ```updateT`` function and pass in the table as the first parameter (speedx and speedy are the second and third parameter but they are optional)

```lua
	acursor.updateT(points)
```

And that's all. You can head on to <a href="https://github.com/YoungNeer/lovelib/tree/master/autocursor/Demos/Demo4">Demo4</a> if you are still confused

### Other functions

```lua
    acursor.destinationReached()
	--checks to see whether cursor has reached the destination point 

	acursor.reset()
	--resets everything to default, saves you from re-requiring to get default values

	acursor.getPosition()
	--gets the current artificial cursor position

	acursor.getX()
	--gets the current artificial cursor x co-ordinate

	acursor.getY()
	--gets the current artificial cursor y co-ordinate
```


### Contribution

If you have any further vision for autocursor then please mail me at netroco@rediffmail.com and since this is on GitHub I encourage you to fork it - make your own changes and then pull request. Most likely I WILL accept your contribution and of course your name will get listed in the CREDITS section of this ReadMe file

### CREDITS

YoungNeer (https://github.com/YoungNeer)

### LICENSE

You can do whatever you want with this. It's not mandatory to credit the authors.


