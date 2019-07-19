fcursor=require 'autocursor'

function love.load()
	fcursor.setDestination(200,200)
	fcursor.clickOnReachingDest()
end

function love.update(dt)
	fcursor.update(5,5)
end

function love.mousepressed(...) print("CLICKED!!!",...) end
