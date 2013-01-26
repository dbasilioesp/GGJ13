require "sprite"
local physics = require "physics"
local rato = require "rato"
local container = require "container"
local bar = require "bar"
local wheel = require "wheel"

system.activate( "multitouch" )
physics.start()
physics.setDrawMode("normal")
physics.setGravity(0, 0)

local loadmainmenu = {}
loadmainmenu.new = function( params )

	local localGroup = display.newGroup()
	local rat
	
	local background
	
	local bar_blue
	local wheel_blue
	local container_blue
	
	local bar_red
	local wheel_red
	local container_red

	local bar_yellow
	local wheel_yellow
	local container_yellow

	local heart

	local initVars = function()

		background = display.newImage("Cena1.png", true)
		background:setReferencePoint(display.TopLeftReferencePoint)
		background.x = 0
		background.y = 0

		rat = display.newCircle(490, 180, 20)
		rat.cor = "VERDE"
		physics.addBody(rat, "dynamic", {density=3.0, friction=0.5,  bounce=0.3})

		rat_blue = display.newCircle(600, 380, 20)
		rat_blue.cor = "AZUL"
		physics.addBody(rat_blue, "dynamic", {density=3.0, friction=0.5,  bounce=0.3})

		local function moveRat(event)
			rat.x = rat.x - 20
			--rat.y = rat.y - 20
			--rat_blue.x = rat_blue.x - 20
		end
		timer.performWithDelay(100, moveRat, 0)

		container_red = container.new("VERMELHO")
		container_red.label:setTextColor(255, 0, 0, 255)
		
		container_blue = container.new("AZUL")
		container_blue.label.x = container_blue.label.x + 60
		container_blue.label:setTextColor(0, 0, 255, 255)

		container_yellow = container.new("AMARELO")
		container_yellow.label.x = container_yellow.label.x + 120
		container_yellow.label:setTextColor(255, 255, 0, 255)

		container_green = container.new("VERDE")
		container_green.label.x = container_green.label.x + 180
		container_green.label:setTextColor(0, 255, 0, 255)

		bar_red = bar.new("VERMELHO")
		bar_blue = bar.new("AZUL")
		bar_yellow = bar.new("AMARELO")
		bar_green = bar.new("VERDE")

		wheel_red = wheel.new(bar_red)
		wheel_blue = wheel.new(bar_blue)
		wheel_blue:setFillColor(0, 0, 255, 255)
		wheel_yellow = wheel.new(bar_yellow)
		wheel_yellow:setFillColor(255, 255, 0, 255)
		wheel_green = wheel.new(bar_green)
		wheel_green:setFillColor(0, 255, 0, 255)

		localGroup:insert(background)
		localGroup:insert(bar_red.label)
		localGroup:insert(bar_blue.label)
		localGroup:insert(bar_green.label)
		localGroup:insert(bar_yellow.label)
		localGroup:insert(wheel_red)
		localGroup:insert(wheel_blue)
		localGroup:insert(wheel_green)
		localGroup:insert(wheel_yellow)
		localGroup:insert(container_red.label)
		localGroup:insert(container_blue.label)
		localGroup:insert(container_yellow.label)
		localGroup:insert(container_green.label)
		localGroup:insert(rat)

		bar_blue.label.x = display.contentWidth - 30
		bar_blue.label.y = display.contentHeight - 400

		bar_green.label.x = display.contentWidth - 30
		bar_green.label.y = 280

		bar_yellow.label.x = 150
		bar_yellow.label.y = 250

		wheel_red.x = 35
		wheel_red.y = 370

		wheel_yellow.x = 175
		wheel_yellow.y = 130

		wheel_blue.x = display.contentWidth - wheel_blue.width/3
		wheel_blue.y = display.contentHeight - 280

		wheel_green.x = display.contentWidth - 50
		wheel_green.y = 160

		local function getContainer(color)
			
			if color == "VERMELHO" then
				return container_red
			elseif color == "AZUL" then
				return container_blue
			elseif color == "AMARELO" then
				return container_yellow
			elseif color == "VERDE" then
				return container_green
			end
		end

		local function onToucnWheel ( event )

			if event.phase == "began" then
				local wheel = event.target
				local container = getContainer(wheel.bar.mytype)
				container.charge(wheel.bar.current_value)
				wheel.bar.current_value = 0
				wheel.bar.changeLabel()
			end

		end


		wheel_red:addEventListener("touch", onToucnWheel)
		wheel_blue:addEventListener("touch", onToucnWheel)
		wheel_green:addEventListener("touch", onToucnWheel)
		wheel_yellow:addEventListener("touch", onToucnWheel)

     	heart = {
     		image = display.newCircle(display.contentWidth - 80, display.contentHeight - 80, 60);
     	}

     	heart.takePulse = function (container_red, container_blue, container_green, container_yellow)

     		local multiplier = 4
     		local chance = container_red.current_value + container_blue.current_value

     		if math.random(multiplier * 100) < chance then
     			return true
     		else
     			return false
     		end
     	end

     	local function onTapHeart( event )

     		if heart.takePulse(container_red, container_blue) then
     			print("YEAY")
     		else
     			print("HOUK")
     		end

     		container_red.current_value = 0
     		container_blue.current_value = 0
     		container_red.changeLabel()
     		container_blue.changeLabel()

     	end

     	heart.image:addEventListener("tap", onTapHeart)
     	heart.image:setFillColor(255, 0, 0, 255)

    end

    initVars()

	return localGroup
end

return loadmainmenu