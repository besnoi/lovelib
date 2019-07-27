Anima=require 'Anima'
typingSound=love.audio.newSource('type.wav','static')

function love.load()
	--this is our animation object as usual
	typingTextAnim=Anima:init()

	typingTextAnim:startNewTypingAnimation("Hello World!!!",1,playTypingSound)
end

function love.update(dt)
	--updateT - update Typing Animation just like updateM for moving and others like updateS,etc
	typingTextAnim:updateT(dt)
end

function love.draw()
	--draw is particular for typing text animations ONLY, render is for drawing image animations
	typingTextAnim:draw(360,280)
end

function playTypingSound(char)
	if char~=' ' then typingSound:play() end
end

