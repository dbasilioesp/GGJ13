require "sprite"
local physics = require "physics"
local rato = require "rato"
local container = require "container"
local bar = require "bar"
local wheel = require "wheel"
local pause = require("pause")

system.activate( "multitouch" )
physics.start()

physics.setDrawMode("normal")
physics.setGravity(0, 0)

local loadmainmenu = {}
loadmainmenu.new = function()

	local localGroup
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
	local clock_label
	local tempo
	local shade
	local musica

	local initVars = function()

		localGroup = display.newGroup()
		
		local restartGame = function ()
			director:changeScene("menu2")
		end

		local nextGameScreen = function()
			shade.isVisible = true
			local nextgame_image = display.newImage("NextBandeiras.png")
			nextgame_image:scale(0.5, 0.5)
			nextgame_image.x = display.contentWidth/2
			nextgame_image.y = display.contentHeight/2
			nextgame_image:toFront()
			timer.pause(clock_time)
		end

		local gameOverScreen = function()

			physics.pause()

			shade.isVisible = true
			local gameover_image = display.newImage("GameOverBandeiras.png")
			gameover_image:scale(0.5, 0.5)
			gameover_image.x = display.contentWidth/2
			gameover_image.y = display.contentHeight/2
			gameover_image:toFront()

			timer.pause(clock_time)
			gameover_image:addEventListener("touch", restartGame)
		end

		clock_label = display.newText("1:00", 450, 0, native.systemFont, 60)
		tempo = 60

		local function decreaseTime()
			if clock_label.text ~= "0:00" then
				tempo = tempo - 1
				clock_label.text = string.format("0:%02d", tempo)
			else
				gameOverScreen()
			end
		end

		clock_time = timer.performWithDelay(1000, decreaseTime , 61)

		pauseBtn = pause.new(clock_time)

		musica = audio.loadSound("musica1.ogg")
		local m = audio.play(musica, {loops = -1})

		shade = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
		shade:setFillColor( 0, 0, 0, 255 )
		shade.x = display.contentWidth/2; shade.y = display.contentHeight/2
		shade.alpha = 0.5
		shade.isVisible = false

		background = display.newImage("Cena1.png", true)
		background:setReferencePoint(display.TopLeftReferencePoint)
		background.x = 0
		background.y = 0

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
		wheel_yellow = wheel.new(bar_yellow)
		wheel_green = wheel.new(bar_green)

		bar_blue.label.x = display.contentWidth - 30
		bar_blue.label.y = display.contentHeight - 400

		bar_green.label.x = display.contentWidth - 30
		bar_green.label.y = 280

		bar_yellow.label.x = 150
		bar_yellow.label.y = 250

		wheel_red.x = 35
		wheel_red:setSequence("rodavaziaVermelha")
		wheel_red:scale(0.6,0.6)
		wheel_red:play()
		wheel_red.y = 370

		wheel_yellow.x = 175
		wheel_yellow:setSequence("rodavaziaAmarela")
		wheel_yellow:scale(0.6,0.6)
		wheel_yellow:play()
		wheel_yellow.y = 130

		wheel_blue:setSequence("rodavaziaAzul")
		wheel_blue:scale(0.6,0.6)
		wheel_blue:play()
		wheel_blue.x = display.contentWidth - 40
		wheel_blue.y = display.contentHeight - 280

		wheel_green:setSequence("rodavaziaVerde")
		wheel_green:scale(0.6,0.6)
		wheel_green:play()
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
				print("Type: ", wheel.bar.mytype)
				
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
     		image = display.newImage("IconCoracaoGame.png", display.contentWidth - 160, display.contentHeight - 175)
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
     			nextGameScreen()
     		else
     			gameOverScreen()
     		end
     	end

     	heart.image:addEventListener("tap", onTapHeart)
     	
     	local function goRat()

     		local ratcolor = math.random(4)
     		
     		if ratcolor == 1 then
     			ratcolor = "VERDE"
     		elseif ratcolor == 2 then
     			ratcolor = "AMARELO"
     		elseif ratcolor == 3 then
     			ratcolor = "VERMELHO"
     		else
     			ratcolor = "AZUL"
     		end

     		local rat = rato.new(1, ratcolor)
			rat.x = math.random(420,600)
			rat.y = math.random(700,950)

			local function moveUp (event)
				rat.y = rat.y - 5
				if rat.y < 0 - rat.height/2 then
					Runtime:removeEventListener("enterFrame", moveUp)
				end
			end

			rat:play()

			localGroup:insert(rat)
			timer.performWithDelay(1000, goRat)
     	end

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

		localGroup:insert(heart.image)
		localGroup:insert(shade)
		localGroup:insert(clock_label)

		
		goRat()

    end

    initVars()

	return localGroup
end

return loadmainmenu