local fcursor,i={x=0,y=0,dx=1,dy=1,stage=0,stageTimer=0,stageTime=0,codTimer=0,codTime=0,dragging=false,destReached=false,clickOnDest=false}

function fcursor.reset() fcursor.x,fcursor.y,fcursor.dx,fcursor.dy,fcursor.stage,fcursor.stageTimer,fcursor.stageTime,codTimer,codTime,fcursor.dragging,fcursor.destReached,fcursor.clickOnDest=0,0,1,1,0,0,0,0,0,false,false,false end

function fcursor.resetTimers() fcursor.stageTimer,fcursor.codTimer=0,0 end

function fcursor.setPosition(x,y) fcursor.x,fcursor.y=x or fcursor.x,y or fcursor.y end

function fcursor.setDestination(x,y) fcursor.destx,fcursor.desty=x or fcursor.destx,y or fcursor.desty end

function fcursor.enableDragging(boolean) fcursor.dragging=boolean~=false end

--set the speed (pixels per frame)
function fcursor.setSpeed(dx,dy) fcursor.dx,fcursor.dy=dx or fcursor.dx,dy or fcursor.dy end

--When destination is reached press a mouse btn (1 by default) [to enable touching the second arg must be true]
function fcursor.clickOnReachingDest(mousebtn,isTouch) fcursor.clickOnDest={fcursor.destx,fcursor.desty,mousebtn or 1,isTouch or false} end

--Unlike clickOnReachingDest, clickOnDest will click on the given point which may be different than the destination point
function fcursor.clickPointOnDest(...) fcursor.clickOnDest={...} end

--Set the time after which the cursor should click on destination (default 0)
function fcursor.setCODTime(t) fcursor.codTime=t end

--Set the time after which the stage should change (default 0)
function fcursor.setStageTime(t) fcursor.stageTime=t end

--VIRTUAL MOUSE EVENT what to do when cursor is dragged, in complicated cases it's best to over-ride it
function fcursor.drag(x,y) love.mousepressed(x,y) end

--VIRTUAL MOUSE EVENT what to do when cursor is clicked, in complicated cases it's best to over-ride it
function fcursor.click(...) love.mousepressed(...) end

function fcursor.update(dt)
	if not fcursor.destinationReached() then

		love.mouse.setPosition(fcursor.x,fcursor.y)

		if fcursor.dragging then fcursor.drag(fcursor.x,fcursor.y) end

		if fcursor.destx~=0 and fcursor.destx~=fcursor.x then
			fcursor.x=fcursor.x+(fcursor.x<fcursor.destx and fcursor.dx or -fcursor.dx)
		end
		if math.floor(math.abs(fcursor.destx-fcursor.x))==0 then fcursor.x=fcursor.destx end
		if fcursor.desty~=0 and fcursor.desty~=fcursor.y then
			fcursor.y=fcursor.y+(fcursor.y<fcursor.desty and fcursor.dx or -fcursor.dy)
		end
		if math.floor(math.abs(fcursor.desty-fcursor.y))==0 then fcursor.y=fcursor.desty end
	end
	if fcursor.destinationReached() then
		if fcursor.codTimer and fcursor.codTimer~=0 then fcursor.codTimer=fcursor.codTimer+dt end
		if fcursor.wasClicked() and fcursor.codTimer then fcursor.click(unpack(fcursor.clickOnDest)) fcursor.codTimer=nil end
	end
end

function fcursor.updateT(tbl,dt)
	fcursor.stageTimer=fcursor.stageTimer+dt
	if fcursor.stage==0 or (fcursor.destinationReached() and fcursor.stageTimer>fcursor.stageTime and fcursor.stage<=#tbl) then
		fcursor.resetTimers()
		if fcursor.stage==0 then fcursor.stage=1 end
		i=fcursor.stage
		if not tbl[i] then return end
		fcursor.setPosition(tbl[i]['fromX'],tbl[i]['fromY'])
		fcursor.setDestination(tbl[i]['toX'],tbl[i]['toY'])
		fcursor.setSpeed(tbl[i]['speedX'],tbl[i]['speedY'])		
		fcursor.enableDragging(tbl[i]['drag'] or fcursor.dragging)
		fcursor.setCODTime(tbl[i]['codTime'] or fcursor.codTime)
		fcursor.setStageTime(tbl[i]['stageTime'] or fcursor.stageTime)
		if tbl[i]['clickOnDest']~=nil then
			if tbl[i]['clickOnDest']~=false then fcursor.clickOnReachingDest(tbl[i]['clickOnDest'])
			else fcursor.clickOnDest=false end
		end		
		fcursor.stage=fcursor.stage+1
	end
	fcursor.update(dt)
end

function fcursor.destinationReached() return fcursor.x==fcursor.destx and fcursor.y==fcursor.desty end
function fcursor.getX() return fcursor.x end
function fcursor.getY() return fcursor.y end
function fcursor.getPosition() return fcursor.x,fcursor.y end

function fcursor.wasClicked() return fcursor.clickOnDest and (fcursor.codTime==0 or fcursor.codTimer>fcursor.codTime) end

return fcursor
