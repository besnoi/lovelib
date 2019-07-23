fcursor=require 'autocursor'

function love.load()
	fcursor.setStageTime(1)
	points={
		{toX=200,toY=200,speedX=2.5,speedY=2.5}, --set speed to (2.5,2.5)
		{toY=100,clickOnDest=1,stageTime=1}, --move to next entry after 1s
		{toX=100}	
	}
end

function love.update(dt) fcursor.updateT(points,dt) end

function love.mousepressed(...) print("CLICKED!!!",...) end

