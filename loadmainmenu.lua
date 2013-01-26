require "sprite"
local physics = require "physics"
local rato = require "rato"
local container = require "container"

system.activate( "multitouch" )

local loadmainmenu = {}
loadmainmenu.new = function( params )

	local localGroup = display.newGroup()
	local rat
	local background
	local new_rat
	local rodaB
	local containerB
	local barraB
	local heart

	local function moveUp (event)
		new_rat.y = new_rat.y - 5
		if new_rat.y < 0 - new_rat.height/2 then
			Runtime:removeEventListener("enterFrame", moveUp)
		end
	end

	local loadphase = function()

		physics.start()
		physics.setDrawMode("normal")
		physics.setGravity(0, 0)

		background = display.newImage("Cena1.png", true);
		background:setReferencePoint(display.TopLeftReferencePoint)
		background.x = 0
		background.y = 0

		barraB = {
			label = display.newText("0", 30, 460, native.systemFont, 26);
			current_value = 0;
			limit_value = 100;
			multiplier = 0;
			charging = false
		}

		barraB.changeLabel = function ()

			if barraB.current_value <= barraB.limit_value then
				barraB.label.text = "" .. barraB.current_value	
			end

		end

		rodaB = display.newCircle(35, 370, 60)

		local function upBarraB( event )
			barraB.current_value = barraB.current_value + 1
			barraB.changeLabel()
		end

		local function onTouchRodaB(event)

			if event.phase == "began" and not barraB.charging then
				barraB.timer = timer.performWithDelay( 100, upBarraB, 0)
				barraB.charging = true
			elseif event.phase == "began" and barraB.charging then
				containerB.charge(barraB.current_value)
				barraB.current_value = 0
				barraB.changeLabel()
			end

        end
     
     	rodaB:addEventListener("touch", onTouchRodaB)

     	heart = {
     		image = display.newCircle(display.contentWidth - 80, display.contentHeight - 80, 60);
     	}

     	heart.takePulse = function (containerB)
     		
     		local multiplier = 1
     		local chance = containerB.current_value

     		if math.random(multiplier * 100) < chance then
     			return true
     		else
     			return false
     		end

     	end

     	local function onTapHeart( event )

     		if heart.takePulse(containerB) then
     			print("YEAY")
     		else
     			print("HOUK")
     		end

     		containerB.current_value = 0
     		containerB.changeLabel()

     	end

     	heart.image:addEventListener("tap", onTapHeart)

	end

	loadphase()

	

	local initVars = function()

		new_rat = rato.new()
		new_rat.x = 500
		new_rat.y = 700

		new_rat.direcao = 1
		Runtime:addEventListener("enterFrame" , moveUp)

		containerB = container.new()

		localGroup:insert(background)
		localGroup:insert(new_rat)
		localGroup:insert(rodaB)
		localGroup:insert(containerB.label)
		localGroup:insert(barraB.label)
    end

    initVars()

	return localGroup
end

return loadmainmenu