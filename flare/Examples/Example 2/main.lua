flare=require 'flare'

flare("rukti.jpg",{
	initialWidth=480,
	initialHeight=360,
	delay=3,
	finalWidth=640,
	finalHeight=480
})

font=love.graphics.newFont("orbitron-black-webfont.ttf",40)
love.graphics.setLineWidth(5);

--[[If we just wanted to change the loading text or its location then we could have
	simply overriden flare.getText but we also want a title text.
	so it's best to over-ride it here
]]--
function flare.drawText()
	love.graphics.setColor(0,0,0,0.7)
	love.graphics.rectangle('fill',0,320,480,40);
	
	love.graphics.setFont(font)
	love.graphics.setColor(1,1,1,0.7)
	
	love.graphics.setColor(0.960,0.960,0.960,0.9)	
	love.graphics.printf("The Ultimate\n Game",0,20,480,"center");
	
	love.graphics.line(20,30,90,30);
	love.graphics.line(395,30,465,30);

	love.graphics.setNewFont(15)
	love.graphics.setColor(1,1,1)

	love.graphics.print(flare.getText());
	
end

--[[
	Please note that you don't need to set flare to nil if you are using state machine.
	But if performance matters to you that much then you are free to do it
]]

function love.update(dt)
	if flare then flare.update(dt) end
	if flare and not flare.running then
		flare=nil
		collectgarbage()
	end
end

--Since we are over-riding the default flare functions we must explicitly say
--something like `if not flare.running then` draw my stuff.., etc

function love.draw()
	if flare then flare.render()
	else
		love.graphics.printf("Welcome to the Game",0,245,640,'center')
	end
end

function love.keypressed(key)
	if key=='escape' then
		-- we don't want the user to be able to quit the window while in splashscreen
		if not flare then
			love.event.quit()
		end
	end
end