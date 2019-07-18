fcursor=require 'autocursor'

function love.load()
	fcursor:setDestination(300,300)
print("here",fcursor.clickOnDest)
end

function love.update(dt)
	fcursor:update(5,5)
end

