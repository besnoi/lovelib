fcursor=require 'autocursor'

function love.load()
	--- IMPORTANT NOTE - the first entry MUST HAVE BOTH toX and toY ---
	points={
		{toX=200,toY=200}, --try replacing this entry with {fromX=100,fromY=200,toX=200,toY=200}
		{toY=100,clickOnDest=1}, --press LMB (1) on reaching destination
		{toX=100},
		--since the second entry clickOnDest is 1 so if we don't want to click at point (100,200) we have to explicitly say clickOnDest=false
		{toY=200,clickOnDest=false},
		{toX=200,drag=true}
	}
end

function love.update(dt)
	--set speedx and speedy to 2.5,2.5 respectively
	fcursor.updateT(points,2.5,2.5)
end

function love.mousepressed(...) print("CLICKED!!!",...) end
