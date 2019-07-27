Anima=require 'Anima'

function love.load()
	background=love.graphics.newImage('bg.jpg')
	font=love.graphics.newFont("iron-latch/Iron Latch.TTF",22)
	headingFont=love.graphics.newFont("iron-latch/Iron Latch.TTF",45)
	subHeadingFont=love.graphics.newFont("iron-latch/Iron Latch.TTF",30)
	font:setLineHeight(1.4)
	love.graphics.setFont(font)

	headingAnim=Anima:init()
	subHeadingAnim=Anima:init()
	typingTextAnim=Anima:init()

	headingAnim:startNewAnimation('opacity',1)
	subHeadingAnim:newAnimation('scale',-1,-1)
	subHeadingAnim:newAnimation('opacity',1)

	
	text='\n\nListen Carefully, Anima has been updated and now supports *awesome* typing animation feature. So get your hands dirty with Anima before its too late\n\nYours faithfully,\nNeer'

	typingTextAnim:newTypingAnimation(text,10)
end

function love.update(dt)
	headingAnim:updateO(dt/5)
	subHeadingAnim:update(0,0,0,0.008,0.008,dt)
	if headingAnim:animationOver() and not subHeadingAnim:animationStarted() then
		subHeadingAnim:animationStart()
	end
	if subHeadingAnim:animationOver() and not typingTextAnim:animationStarted() then
		typingTextAnim:animationStart()
	end
	
	typingTextAnim:updateT(dt)
end

function love.draw()
	
	love.graphics.draw(background)
	love.graphics.setFont(subHeadingFont)
	-- love.graphics.setColor(0.1,0.1,0.1,0.5)
	love.graphics.setColor(0,0,0,0)
	
	subHeadingAnim:print("Anima is now even more powerful",240,140,0,2,2,100,-10)

	love.graphics.setColor(0,0,0,0)
	love.graphics.setFont(headingFont)
	headingAnim:printf("Beware!!!",0,100,800,'center')
	love.graphics.setColor(0,0,0,1)
	
	love.graphics.setFont(font)	
	
	typingTextAnim:drawF(120,175,550)
	love.graphics.setColor(1,1,1)
end

