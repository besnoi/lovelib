local flare={
	width,height,    --the dimensions of the splash window
	fw,fh,           --internal variables to keep count of the final dimension
	iflags,          --the flags for the initial window mode
	fflags,          --the flags for the final window mode
	img,             --the background image for the splash window
	delay,           --the time after which actual window would appear
	timer=0,         --an internal variable
	canDraw=true,    --an internal variable
	running=true,    --whether the splash window is still running
	showProgressBar, --whether to show the progress bar
	getProgress,     --a handler to get the progress for progress bar (0-1)
	showProgressText,--whether to show the percentage of progress
	showText,        --whether to show the text
	getText,         --a handler which returns all information needed for drawing text
	onSplashOver,    --what should happen exactly after splashing is over
}

local function get_text()
	local text="(C) Copyright Lorem Ipsum, 2019\nLoading"..('.'):rep(1+2*flare.timer%3)
	return text,0,flare.height-35
end

local default_settings={
	iw=640,
	ih=360,
	fw=1280,
	fh=720,
	iflags={borderless=true},
	fflags={borderless=false},
	delay=5,
	onSplashOver=function() end,
	showProgressBar=false,
	showProgressText=true,
	getProgress=function() return flare.timer/flare.delay end,
	showText=true,
	getText=get_text
}

function flare.init(img,settings,...)

	if type(img)=='table' then img,settings=settings,... end
	
	 
	--just setting the default values
	settings = settings or default_settings
	
	flare.width=settings.iw or settings.initialWidth or default_settings.iw
	flare.height=settings.ih or settings.initialHeight or default_settings.ih
	flare.fw=settings.fw or settings.finalWidth or default_settings.fw
	flare.fh=settings.fh or settings.finalHeight or default_settings.fh
	flare.iflags=settings.iflags or settings.initFlags or default_settings.iflags
	flare.fflags=settings.fflags or settings.finalFlags or default_settings.fflags
	flare.delay=settings.delay or default_settings.delay
	flare.onSplashOver=settings.onSplashOver or default_settings.onSplashOver
	flare.showText=settings.showText
	if flare.showText==nil then
		flare.showText=default_settings.showText
	end
	flare.getText=settings.getText or default_settings.getText
	flare.showProgressBar=settings.showProgressBar
	if flare.showProgressBar==nil then
		flare.showProgressBar=default_settings.showProgressBar
	end
	flare.showProgressText=settings.showProgressText
	if flare.showProgressText==nil then
		flare.showProgressText=default_settings.showProgressText
	end
	flare.getProgress=settings.getProgress  or default_settings.getProgress
	
	if type(img)=='string' then img=love.graphics.newImage(img) end
	flare.img=img
	love.window.setMode(flare.width,flare.height,flare.iflags)
end

local canDraw
function flare.render()
	if not flare.running then return end
	--just to give the end-user more power to over-ride these as he wishes
	flare.drawImage()
	flare.drawText()
	flare.drawProgressBar()
end

function flare.drawImage()
	love.graphics.draw(flare.img,0,0,0,
		flare.width/flare.img:getWidth(),
		flare.height/flare.img:getHeight()
	)
end

function flare.drawText()
	if flare.showText then love.graphics.print(flare.getText()) end
end

function flare.drawProgressBar()
	if not flare.showProgressBar then return end
	local py,text=flare.showText and (flare.height-70) or flare.height-50 
	love.graphics.setColor(0.1,0.1,0.1,0.5);
	love.graphics.rectangle('fill',50,py,flare.width-100,30,8,8)
	love.graphics.setColor(0.890,0.243,0.133);
	love.graphics.rectangle('fill',50,py,(flare.width-100)*flare.getProgress(),30,8,8)
	love.graphics.setColor(1,1,1)

	if flare.showProgressText then
		if flare.getProgress()>0.19 then text="Loading "..math.floor(flare.getProgress()*100).."%"
		else text=math.floor(flare.getProgress()*100).."%" end
		love.graphics.printf(text,45,py+7,math.max(35,(flare.width-100)*flare.getProgress()-20),'right')
	end
end

function flare.update(dt)
	if not flare.running then return end
	flare.timer=flare.timer+dt
	if flare.timer>flare.delay then
		love.window.setMode(flare.fw,flare.fh,flare.fflags)
		flare.onSplashOver()
		flare.timer,flare.running,flare.canDraw=nil
	end
end

flare.draw=flare.render
--just overriding some stuff so that they don't appear in quick walkthrough
function love.update(dt) flare.update(dt) end
function love.draw() flare.draw() end

setmetatable(flare,{__call=flare.init})

return flare