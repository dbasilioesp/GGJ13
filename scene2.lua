module( ..., package.seeall )
local director = require "director"
local sprite = require "sprite"
local physics = require "physics"
local container = require "container"
local bar = require "bar"
local wheel = require "wheel2"
local rat = require "rat4"
system.activate("multitouch")

physics.start()
physics.setDrawMode("normal")
physics.setGravity(0, 0)

local localGroup
local background
local container_red
local container_blue
local container_yellow
local container_green
local bar_red
local bar_blue
local bar_green
local bar_yellow
local wheel_red
local wheel_blue
local wheel_yellow
local wheel_green
local heart
local rats_table = {}
local rats_timer

local scene2 = {}
scene2.new = function ( params )
	
	localGroup = display.newGroup()

	-- BACKGROUND
	scene2.createBackground()

	-- CONTAINERS
	scene2.createContainers()

	-- BARS
	scene2.createBars()

	-- WHEELS
	scene2.createWheels()

	-- HEART
	scene2.createHeart()
	
	localGroup:insert(background)
	localGroup:insert(container_red.label)
	localGroup:insert(container_blue.label)
	localGroup:insert(container_green.label)
	localGroup:insert(container_yellow.label)
	localGroup:insert(bar_red.label)
	localGroup:insert(bar_blue.label)
	localGroup:insert(bar_yellow.label)
	localGroup:insert(bar_green.label)

	localGroup:insert(wheel_red)
	localGroup:insert(wheel_blue)
	localGroup:insert(wheel_green)
	localGroup:insert(wheel_yellow)

	localGroup:insert(heart)

	-- RATS
	scene2.createRats()

	return localGroup

end

scene2.createBackground = function()
	
	background = display.newImage("asserts/maps/cena1.png", true)
	background:setReferencePoint(display.TopLeftReferencePoint)
	background.x = 0; background.y = 0
end

scene2.createContainers = function()
	container_red = container.new("RED")
	container_red.label:setTextColor(255, 0, 0, 255)

	container_blue = container.new("BLUE")
	container_blue.label.x = container_blue.label.x + 60
	container_blue.label:setTextColor(0, 0, 255, 255)

	container_yellow = container.new("YELLOW")
	container_yellow.label.x = container_yellow.label.x + 120
	container_yellow.label:setTextColor(255, 255, 0, 255)

	container_green = container.new("GREEN")
	container_green.label.x = container_green.label.x + 180
	container_green.label:setTextColor(0, 255, 0, 255)
end

scene2.createBars = function()

	bar_red = bar.new("RED")
	bar_blue = bar.new("BLUE")
	bar_yellow = bar.new("YELLOW")
	bar_green = bar.new("GREEN")

	bar_blue.label.x = display.contentWidth - 30
	bar_blue.label.y = display.contentHeight - 400

	bar_green.label.x = display.contentWidth - 30
	bar_green.label.y = 280

	bar_yellow.label.x = 150
	bar_yellow.label.y = 250

end

scene2.createWheels = function()

	wheel_red = wheel.new(bar_red)
	wheel_blue = wheel.new(bar_blue)
	wheel_yellow = wheel.new(bar_yellow)
	wheel_green = wheel.new(bar_green)

	wheel_red.x = 35
	wheel_red:setSequence("wheelEmptyRed")
	wheel_red:scale(0.6,0.6)
	wheel_red:play()
	wheel_red.y = 370

	wheel_yellow.x = 175
	wheel_yellow:setSequence("wheelEmptyYellow")
	wheel_yellow:scale(0.6,0.6)
	wheel_yellow:play()
	wheel_yellow.y = 130

	wheel_blue:setSequence("wheelEmptyBlue")
	wheel_blue:scale(0.6,0.6)
	wheel_blue:play()
	wheel_blue.x = display.contentWidth - 40
	wheel_blue.y = display.contentHeight - 280

	wheel_green:setSequence("wheelEmptyGreen")
	wheel_green:scale(0.6,0.6)
	wheel_green:play()
	wheel_green.x = display.contentWidth - 50
	wheel_green.y = 160

	local function onToucnWheel (event)

		if event.phase == "began" then
			local wheel = event.target
			local container = scene2.getContainer(wheel.bar.color)
			container.charge(wheel.bar.current_value)
			wheel.bar.current_value = 0
			wheel.bar.changeLabel()
		end
	end

	wheel_red:addEventListener("touch", onToucnWheel)
	wheel_blue:addEventListener("touch", onToucnWheel)
	wheel_green:addEventListener("touch", onToucnWheel)
	wheel_yellow:addEventListener("touch", onToucnWheel)

end

scene2.createHeart = function()
	
	heart = display.newImage("asserts/ratov3.png", display.contentWidth - 160, display.contentHeight - 175)

	local function onTapHeart( event )
		if scene2.isWinner() then
			scene2.nextGameScreen()
		else
			scene2.gameOverScreen()
		end
	end

	heart:addEventListener("tap", onTapHeart)

end

scene2.createRats = function()
	
	local ratcolor = math.random(4)
     		
	if ratcolor == 1 then
		ratcolor = "GREEN"
	elseif ratcolor == 2 then
		ratcolor = "YELLOW"
	elseif ratcolor == 3 then
		ratcolor = "RED"
	else
		ratcolor = "BLUE"
	end

	local new_rat = rat.new(ratcolor)
	new_rat.x = math.random(420,600)
	new_rat.y = math.random(700,950)

	table.insert(rats_table, new_rat)
	rats_timer = timer.performWithDelay(1500, scene2.createRats)

end

scene2.stopCreateRats = function()
	print ("Timer Stop")
	timer.pause(rats_timer)
end

scene2.getContainer =  function (color)
			
	if color == "RED" then
		return container_red
	elseif color == "BLUE" then
		return container_blue
	elseif color == "YELLOW" then
		return container_yellow
	elseif color == "GREEN" then
		return container_green
	end
end

scene2.isWinner = function ()
	
	local chance = container_red.current_value + container_blue.current_value + container_green.current_value + container_yellow.current_value

	if math.random(4 * 100) < chance then
		return true
	else
		return false
	end

end

scene2.nextGameScreen = function()
	print ("Win")
end

scene2.gameOverScreen = function()
	scene2.stopCreateRats()
	director:changeScene("scene3")

end

scene2.clean = function (event)
	
	wheel_blue:removeEventListener('collision', wheel_blue.onPostCollision)
	wheel_red:removeEventListener('collision', wheel_red.onPostCollision)
	wheel_yellow:removeEventListener('collision', wheel_yellow.onPostCollision)
	wheel_green:removeEventListener('collision', wheel_green.onPostCollision)

	for index,rat in ipairs(rats_table) do
		rat.removeIt()
	end

	container_red = nil
	container_blue = nil
	container_yellow = nil
	container_green = nil
	bar_red = nil
	bar_blue = nil
	bar_yellow = nil
	bar_green = nil
	wheel_blue = nil
	wheel_red = nil
	wheel_yellow = nil
	wheel_green = nil
end

return scene2