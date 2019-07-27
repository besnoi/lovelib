Anima=require 'Anima'

function love.load()
	background=love.graphics.newImage('bg.jpg')
	font=love.graphics.newFont("iron-latch/Iron Latch.TTF",18)
	font:setLineHeight(1.4)
	love.graphics.setFont(font)
	--this is our animation object as usual
	typingTextAnim=Anima:init()
	--the text we want to print
	text='Long Time Ago, there lived a monster kid, his name was Dracula Fernandez - Drake for short. He looked like a monkey and his friends used to tease him that he looked more like a monkey than a monster. Then one day a monkey visited the monster land and found Drake weeping near a tree. "What are you crying for Boy?" the monkey asked. "My friends and nowadays even my family thinks I\'m a monkey. They never get tired of making fun of me." The monkey felt pity for the boy and took out a mysterious flute from his hidden pocket and gave it to the little monster....\n\nTo be Continued'

	typingTextAnim:startNewTypingAnimation(text,10)
end

function love.update(dt)
	--updateT - update Typing Animation just like updateM for moving and others like updateS,etc
	typingTextAnim:updateT(dt)
end

function love.draw()
	--draw is particular for typing text animations ONLY, render is for drawing image animations
	--here we are using drawF which is for drawing formatted text
	love.graphics.draw(background)
	love.graphics.setColor(0,0,0)
	typingTextAnim:drawF(120,150,570)
	love.graphics.setColor(1,1,1)
end

