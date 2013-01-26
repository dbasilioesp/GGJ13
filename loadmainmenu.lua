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
	local rat_blue
	local rat_red
	local background
	local wheel_red
	local wheel_blue
	local container_red
	local barra_red
	local barra_blue
	local heart

	local initVars = function()

		background = display.newImage("Cena1.png", true);
		background:setReferencePoint(display.TopLeftReferencePoint)
		background.x = 0
		background.y = 0

		rat = display.newCircle(400, 380, 20)
		rat.cor = "VERMELHO"
		physics.addBody(rat, "dynamic", {density=3.0, friction=0.5,  bounce=0.3})

		rat_blue = display.newCircle(600, 380, 20)
		rat_blue.cor = "AZUL"
		physics.addBody(rat_blue, "dynamic", {density=3.0, friction=0.5,  bounce=0.3})

		rat_red = display.newCircle(1200, 380, 20)
		rat_red.cor = "VERMELHO"
		physics.addBody(rat_red, "dynamic", {density=3.0, friction=0.5,  bounce=0.3})

		local function moveRat(event)
			rat.x = rat.x - 20
			rat_blue.x = rat_blue.x - 20
			rat_red.x = rat_red.x - 20
		end
		timer.performWithDelay(100, moveRat, 0)

		container_red = container.new()
		container_blue = container.new()
		container_blue.label.x = container_blue.label.x + 60
		barra_red = bar.new("VERMELHO")
		barra_blue = bar.new("AZUL")
		wheel_red = wheel.new(barra_red, container_red)
		wheel_blue = wheel.new(barra_blue, container_blue)

		localGroup:insert(background)
		localGroup:insert(wheel_red)
		localGroup:insert(wheel_blue)
		localGroup:insert(container_red.label)
		localGroup:insert(container_blue.label)
		localGroup:insert(barra_red.label)
		localGroup:insert(barra_blue.label)
		localGroup:insert(rat)
    end

    initVars()

    local loadphase = function()

		barra_blue.label.x = display.contentWidth - 30
		barra_blue.label.y = display.contentHeight - 190

		wheel_red.x = 35
		wheel_red.y = 370

		wheel_blue.x = display.contentWidth - wheel_blue.width/3
		wheel_blue.y = display.contentHeight - 280

     	heart = {
     		image = display.newCircle(display.contentWidth - 80, display.contentHeight - 80, 60);
     	}

     	heart.takePulse = function (container_red, container_blue)

     		local multiplier = 2
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

	end

	loadphase()

	return localGroup
end

return loadmainmenu