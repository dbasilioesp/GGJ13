module( ..., package.seeall )
local sprite = require "sprite"
local physics = require "physics"

physics.start()
physics.setDrawMode("normal")
physics.setGravity(0, 0)

local CRat = {}
CRat.new = function(color, direction)
	
	local rat
	local options
	local limit

    options = { width=200, height=100, numFrames=2, sheetContentWidth=400, sheetContentHeight=100 };

    local getSequence = function(rat_up, rat_right, rat_left)

	    local sequence = {
	            {name="rat_up",   sheet=rat_up, start=1, count=2, time=500, loopCount=0 },
	            {name="rat_right",sheet=rat_right, start=1, count=2, time=500, loopCount=0},
	            {name="rat_left", sheet=rat_left, start=1, count=2, time=500, loopCount=0},
	    }

	    return sequence
	end

	local createRatRed = function()
	    
	    local rat_red_up    = graphics.newImageSheet("asserts/rats/RatoVermelhoVertical.png", options);
	    local rat_red_right = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontal.png", options);
	    local rat_red_left  = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontalEsquerda.png", options);

	    local sequence = getSequence(rat_red_up, rat_red_right, rat_red_left)

	    rat = display.newSprite(rat_red_up, sequence);

	end

	local createRatBlue = function()

	    local rat_blue_up    = graphics.newImageSheet("asserts/rats/RatoAzulVertical.png", options);
	    local rat_blue_right = graphics.newImageSheet("asserts/rats/RatoAzulHorizontal.png", options);
	    local rat_blue_left  = graphics.newImageSheet("asserts/rats/RatoAzulHorizontalEsquerda.png", options);

	    local sequence = getSequence(rat_blue_up, rat_blue_right, rat_blue_left)

	    rat = display.newSprite(rat_blue_up, sequence);

	end

	local createRatGreen = function()
	    
	    local rat_green_up    = graphics.newImageSheet("asserts/rats/RatoVerdeVertical.png", options);
	    local rat_green_right = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontal.png", options);
	    local rat_green_left  = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontalEsquerda.png", options);

	    local sequence = getSequence(rat_green_up, rat_green_right, rat_green_left)

	    rat = display.newSprite(rat_green_up, sequence);

	end

	local createRatYellow = function()
	    
	    local rat_yellow_up    = graphics.newImageSheet("asserts/rats/RatoAmareloVertical.png", options);
	    local rat_yellow_right = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontal.png", options);
	    local rat_yellow_left  = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontalEsquerda.png", options);

	    local sequence = getSequence(rat_yellow_up, rat_yellow_right, rat_yellow_left)

	    rat = display.newSprite(rat_yellow_up, sequence)

	end

	if color == "RED" then
	    createRatRed()
	elseif color == "BLUE" then
		createRatBlue()
	elseif color == "GREEN" then
		createRatGreen()
		elseif color == "YELLOW" then
		createRatYellow()
	end

	if direction == nil then
        direction = "UP" -- Direction default
    end

    rat.isFixedRotation = true
    rat.direction = direction
    rat.color = color
    rat.name = "rat class"

    rat.x = 200; rat.y = 200
    rat.pass = 0
    rat:scale(0.3, 1)
    
    local ratShape = {-40, -50, 
                 40, -50,
                 40,  50,
                -40,  50}

    physics.addBody(rat, "dinamic", {density=3.0, friction=0.5,  bounce=0.3, shape=ratShape})

	rat:play()

	rat.moveUp = function (event)

	    if rat then

	        rat.y = rat.y - 5

	        if rat.y <= 0 then
	            rat.removeRat()
	            return
	        end

	        -- ?????
	        if rat.x <= 400 then
	            
	            Runtime:removeEventListener("enterFrame", rat.moveUp)
	            
	            if rat.x > 185 and rat.x < 240 then
	                rat.pass = 3                                 
	            end
	            
	            if rat.pass == 3 then
	                transition.to(rat, {time =900 ,x = rat.x - 26, y = 130 })
	                rat.pass = 0     
	            end
	        end
	            
	    end
	end

	rat.moveDown = function (event)

	    if rat then
	        
	        rat.y = rat.y + 5

	        if rat.y > display.contentHeight then                        
	            rat.removeRat()
	            return
	        end

	    end
	end

	rat.moveRight = function (event)
    
	    if rat then

	        rat.x = rat.x + 5

	        if rat.x >= display.contentWidth then
	            rat.removeRat()
	            return
	        end

	        if  rat.x > 580 then
	            Runtime:removeEventListener("enterFrame", rat.moveRight)
	            limit = true
	            Runtime:addEventListener("enterFrame", rat.moveUp )
	        end

	        if  rat.y > 440 and rat.y < 525 then 
	            rat.pass = 1
	        end

	         if  rat.y > 120 and rat.y < 190 then 
	            rat.pass = 4
	        end

	         if rat.pass == 1 then
                Runtime:removeEventListener("enterFrame", rat.moveRight)
                transition.to(rat, {time = 1200, x = 944, y = rat.y -28})   
                rat.pass = 0
	         end  

	         if rat.pass == 4 then
	                Runtime:removeEventListener("enterFrame", rat.moveRight)                   
	                transition.to(rat, {time =980, x = 946, y = rat.y - 30})
	                rat.pass = 0
	         end
	    end

	end

	rat.moveLeft = function(event)

	    if rat then
	        rat.x = rat.x - 5

	        if rat.x <= 0 then
	            rat.removeRat()
	            return
	        end

	        -- ???
	        if rat.x < 415 and rat.pass ~=2 then

	            Runtime:removeEventListener("enterFrame", rat.moveLeft)
	            rat.x = 410
	            limit = true
	            Runtime:addEventListener("enterFrame", rat.moveUp )
	            if  rat.y > 326 and rat.y < 405 then
                   rat.pass = 2
                   Runtime:addEventListener("enterFrame", rat.moveLeft)
	            end
	        end
	    end
	end

	rat.removeRat = function()
		if rat ~= nil then
		    Runtime:removeEventListener("enterFrame", rat.moveUp)
		    Runtime:removeEventListener("enterFrame", rat.moveDown)
		    Runtime:removeEventListener("enterFrame", rat.moveRight)
		    rat:removeSelf()
		    rat = nil
		    print("rat removed")
		end
	end

	if direction == "UP" then -- para CIMA
        rat:setSequence("rat_up")
        Runtime:addEventListener("enterFrame", rat.moveUp)
    elseif direction == "DOWN" then
        rat:setSequence("rat_up")
        Runtime:addEventListener("enterFrame", rat.moveDown)
    elseif direction == "RIGHT" then
        rat:setSequence("rat_right")
        Runtime:addEventListener("enterFrame", rat.moveRight)
    elseif direction == "LEFT" then
        rat:setSequence("rat_left")
        Runtime:addEventListener("enterFrame", rat.moveLeft)
    end

    local checkSwipeDirection = function()

        if rat.direction == "UP" then -- para CIMA
            Runtime:removeEventListener("enterFrame", rat.moveUp)
        end 
        if rat.direction == "DOWN" then -- para BAIXO
            Runtime:removeEventListener("enterFrame", rat.moveDown)
        end 
        if rat.direction == "LEFT" then -- para ESQUERDA
            Runtime:removeEventListener("enterFrame", rat.moveLeft)
        end 
        if rat.direction == "RIGHT" then -- para DIREITA
            Runtime:removeEventListener("enterFrame", rat.moveRight)
        end

        xDistance =  math.abs(endX - beginX) -- math.abs will return the absolute, or non-negative value, of a given value.
        yDistance =  math.abs(endY - beginY)

        if xDistance > yDistance then

            if beginX > endX  then
                rat.direction = "LEFT"
                rat:setSequence("rat_left")
                rat:play()
                Runtime:addEventListener("enterFrame" , rat.moveLeft)
            else
                rat.direction = "RIGHT"
                rat:setSequence("rat_right")
                rat:play()
                Runtime:addEventListener("enterFrame" , rat.moveRight)
            end

        else
        	if beginY > endY then
                    rat.direction = "UP"
                    rat:setSequence("rat_up")
                    rat:play()
                    Runtime:addEventListener("enterFrame" , rat.moveUp)
            else
                    rat.direction = "DOWN"
                    rat:setSequence("rat_down")
                    rat:play()
                    Runtime:addEventListener("enterFrame" , rat.moveDown)
            end
        end

	end

	function swipe(event)
        if event.phase == "began" then
            beginX = event.x
            beginY = event.y
            display.getCurrentStage():setFocus(event.target, event.id)
        end
 
        if event.phase == "ended" then
            endX = event.x
            endY = event.y
            checkSwipeDirection()
            display.getCurrentStage():setFocus(event.target, nil)
        end
    end

	rat.removeIt = function()
		if rat ~= nil then
		    Runtime:removeEventListener("enterFrame", rat.moveUp)
		    Runtime:removeEventListener("enterFrame", rat.moveDown)
		    Runtime:removeEventListener("enterFrame", rat.moveRight)
		    Runtime:removeEventListener("enterFrame", rat.moveLeft)
		    rat:removeSelf()
		    rat = nil
		    print("rat removed")
		end
	end

    rat:addEventListener("touch", swipe)

    return rat

end

return CRat