local fcursor={x=0,y=0,stage=0,dragging=false,destReached=false,clickOnDest=false}

function fcursor.reset() fcursor.x,fcursor.y,fcursor.stage,fcursor.dragging,fcursor.destReached,fcursor.clickOnDest=0,0,0,false,false,false end

function fcursor.setPosition(x,y) fcursor.x,fcursor.y=x or 0,y or 0 end

function fcursor.setDestination(x,y) fcursor.destx,fcursor.desty=x,y end

function fcursor.enableDragging(boolean) fcursor.dragging=boolean~=false end

--When destination is reached press a mouse btn (1 by default) [to enable touching the second arg must be true]
function fcursor.clickOnReachingDest(mousebtn,isTouch) fcursor.clickOnDest={fcursor.destx,fcursor.desty,mousebtn or 1,isTouch or false} end

--Unlike clickOnReachingDest, clickOnDest will click on the given point which may be different than the destination point
function fcursor.clickPointOnDest(...) fcursor.clickOnDest={...} end

function fcursor.update(stepx,stepy)
	if not fcursor.destinationReached() then
		stepx,stepy=stepx or 1,stepy or 1

		love.mouse.setPosition(fcursor.x,fcursor.y)

		if fcursor.dragging then love.mousepressed(fcursor.x,fcursor.y) end

		if fcursor.destx~=0 and fcursor.destx~=fcursor.x then
			fcursor.x=fcursor.x+(fcursor.x<fcursor.destx and stepx or -stepx)
		end
		if math.floor(math.abs(fcursor.destx-fcursor.x))==0 then fcursor.x=fcursor.destx end
		if fcursor.desty~=0 and fcursor.desty~=fcursor.y then
			fcursor.y=fcursor.y+(fcursor.y<fcursor.desty and stepy or -stepy)
		end
		if math.floor(math.abs(fcursor.desty-fcursor.y))==0 then fcursor.y=fcursor.desty end
		if fcursor.x==fcursor.destx and fcursor.y==fcursor.desty then
			if fcursor.clickOnDest then love.mousepressed(unpack(fcursor.clickOnDest)) end
		end
	end
end

function fcursor.updateT(tbl,dx,dy)
	for i,point in ipairs(tbl) do 
		if fcursor.stage==0 or (fcursor.destinationReached() and fcursor.stage==i) then
			if fcursor.stage==0 then fcursor.stage=1 end
			fcursor.setPosition(tbl[i]['fromX'] or fcursor.x,tbl[i]['fromY'] or fcursor.y)
			fcursor.setDestination(tbl[i]['toX'] or fcursor.destx,tbl[i]['toY'] or fcursor.desty)
			fcursor.enableDragging(tbl[i]['drag'] or fcursor.dragging)
			if tbl[i]['clickOnDest']~='false' then fcursor.clickOnReachingDest(tbl[i]['clickOnDest'])
			else fcursor.clickOnDest=false
			end
			fcursor.stage=fcursor.stage+1
		end
	end
	
	fcursor.update(dx,dy)
end

function fcursor.destinationReached() return fcursor.x==fcursor.destx and fcursor.y==fcursor.desty end
function fcursor.getX() return fcursor.x end
function fcursor.getY() return fcursor.y end
function fcursor.getPosition() return fcursor.x,fcursor.y end

return fcursor