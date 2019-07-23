fcursor=require 'autocursor'

function love.load()
	fcursor.setDestination(200,200)
	fcursor.setSpeed(5,5)
	fcursor.clickOnReachingDest()
end

function love.update(dt)
	fcursor.update()
end

function love.mousepressed(...) print("CLICKED!!!",...) end
