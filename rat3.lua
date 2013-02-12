module( ..., package.seeall )
local sprite = require "sprite"
local physics = require "physics"

physics.start()
physics.setDrawMode("normal")
physics.setGravity(0, 0)

local CRat = {}
CRat.new = function(color, direction)
	
	local rat = {pass = nil } -- pass ??
	local options
	local limit

	local init = function ()
		 
		options = { width=200, height=100, numFrames=2, sheetContentWidth=400, sheetContentHeight=100 };

		if color == "RED" then
	        rat.createRatRed()
	    elseif color == "BLUE" then
	    	rat.createRatBlue()
	    elseif color == "GREEN" then
	    	rat.createRatGreen()
	   	elseif color == "YELLOW" then
	    	rat.createRatYellow()
	    end

	    if direction == nil then
	        direction = "UP" -- Direction default
	    end

	    rat.sprite.isFixedRotation = true
	    rat.sprite.direction = direction
	    rat.sprite.color = color

	    rat.sprite.x = 200; rat.sprite.y = 200
	    rat.sprite.pass = 0
	    rat.sprite:scale(0.3, 1)
	    
	    local ratShape = {-40, -50, 
	                 40, -50,
	                 40,  50,
	                -40,  50}

	    physics.addBody(rat.sprite, "dinamic", {density=3.0, friction=0.5,  bounce=0.3, shape=ratShape})

	    if direction == "UP" then -- para CIMA
	        rat.sprite:setSequence("rat_up")
	        Runtime:addEventListener("enterFrame", rat.moveUp)
	    elseif direction == "DOWN" then
	        rat.sprite:setSequence("rat_up")
	        Runtime:addEventListener("enterFrame", rat.moveDown)
	    elseif direction == "RIGHT" then
	        rat.sprite:setSequence("rat_right")
	        Runtime:addEventListener("enterFrame", rat.moveRight)
	    elseif direction == "LEFT" then
	        rat.sprite:setSequence("rat_left")
	        Runtime:addEventListener("enterFrame", rat.moveLeft)
	    end

	    rat.sprite:play()

	end

    rat.getSequence = function (rat_up, rat_right, rat_left)

	    local sequence = {
	            {name="rat_up",   sheet=rat_up, start=1, count=2, time=500, loopCount=0 },
	            {name="rat_right",sheet=rat_right, start=1, count=2, time=500, loopCount=0},
	            {name="rat_left", sheet=rat_left, start=1, count=2, time=500, loopCount=0},
	    }

	    return sequence
	end

	rat.createRatRed = function()
	    
	    local rat_red_up    = graphics.newImageSheet("asserts/rats/RatoVermelhoVertical.png", options);
	    local rat_red_right = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontal.png", options);
	    local rat_red_left  = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontalEsquerda.png", options);

	    local sequence = rat.getSequence(rat_red_up, rat_red_right, rat_red_left)

	    rat.sprite = display.newSprite(rat_red_up, sequence);

	end

	rat.createRatBlue = function()
    
	    local rat_blue_up    = graphics.newImageSheet("asserts/rats/RatoAzulVertical.png", options);
	    local rat_blue_right = graphics.newImageSheet("asserts/rats/RatoAzulHorizontal.png", options);
	    local rat_blue_left  = graphics.newImageSheet("asserts/rats/RatoAzulHorizontalEsquerda.png", options);

	    local sequence = rat.getSequence(rat_blue_up, rat_blue_right, rat_blue_left)

	    rat.sprite = display.newSprite(rat_blue_up, sequence);

	end

	rat.createRatGreen = function()
	    
	    local rat_green_up    = graphics.newImageSheet("asserts/rats/RatoVerdeVertical.png", options);
	    local rat_green_right = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontal.png", options);
	    local rat_green_left  = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontalEsquerda.png", options);

	    local sequence = rat.getSequence(rat_green_up, rat_green_right, rat_green_left)

	    rat.sprite = display.newSprite(rat_green_up, sequence);

	end

	rat.createRatYellow = function()
	    
	    local rat_yellow_up    = graphics.newImageSheet("asserts/rats/RatoAmareloVertical.png", options);
	    local rat_yellow_right = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontal.png", options);
	    local rat_yellow_left  = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontalEsquerda.png", options);

	    local sequence = rat.getSequence(rat_yellow_up, rat_yellow_right, rat_yellow_left)

	    rat.sprite = display.newSprite(rat_yellow_up, sequence)

	end

	rat.stopMove = function ()
        Runtime:removeEventListener("enterFrame", rat.moveUp)
        Runtime:removeEventListener("enterFrame", rat.moveDown)
        Runtime:removeEventListener("enterFrame", rat.moveLeft)
        Runtime:removeEventListener("enterFrame", rat.moveRight)
    end

    rat.moveUp = function (event)

	    if rat then

	        rat.sprite.y = rat.sprite.y - 5

	        if rat.sprite.y <= 0 then
	            rat.removeRat()
	            return
	        end

	        -- ?????
	        if rat.sprite.x <= 400 then
	            
	            Runtime:removeEventListener("enterFrame", rat.moveUp)
	            
	            if rat.sprite.x > 185 and rat.sprite.x < 240 then
	                rat.pass = 3                                 
	            end
	            
	            if rat.pass == 3 then
	                transition.to(rat.sprite, {time =900 ,x = rat.sprite.x - 26, y = 130 })
	                rat.pass = 0     
	            end
	        end
	            
	    end
	end

	rat.moveDown = function (event)

	    if rat then
	        
	        rat.sprite.y = rat.sprite.y + 5

	        if rat.sprite.y > display.contentHeight then                        
	            rat.removeRat()
	            return
	        end

	    end
	end

	rat.moveRight = function (event)
    
	    if rat then

	        rat.sprite.x = rat.sprite.x + 5

	        if rat.sprite.x >= display.contentWidth then
	            rat.removeRat()
	            return
	        end

	        if  rat.sprite.x > 580 then
	            Runtime:removeEventListener("enterFrame", rat.moveRight)
	            limit = true
	            Runtime:addEventListener("enterFrame", rat.moveUp )
	        end

	        if  rat.sprite.y > 440 and rat.sprite.y < 525 then 
	            rat.pass = 1
	        end

	         if  rat.sprite.y > 120 and rat.sprite.y < 190 then 
	            rat.pass = 4
	        end

	         if rat.pass == 1 then
                Runtime:removeEventListener("enterFrame", rat.moveRight)
                transition.to(rat.sprite, {time = 1200, x = 944, y = rat.sprite.y -28})   
                rat.pass = 0
	         end  

	         if rat.pass == 4 then
	                Runtime:removeEventListener("enterFrame", rat.moveRight)                   
	                transition.to(rat.sprite, {time =980, x = 946, y = rat.sprite.y - 30})
	                rat.pass = 0
	         end
	    end

	end

	rat.moveLeft = function (event)

	    if rat then
	        rat.sprite.x = rat.sprite.x - 5

	        if rat.sprite.x <= 0 then
	            rat.removeRat()
	            return
	        end

	        -- ???
	        if rat.sprite.x < 415 and rat.pass ~=2 then

	            Runtime:removeEventListener("enterFrame", rat.moveLeft)
	            rat.sprite.x = 410
	            limit = true
	            Runtime:addEventListener("enterFrame", rat.moveUp )
	            if  rat.sprite.y > 326 and rat.sprite.y < 405 then
                   rat.pass = 2
                   Runtime:addEventListener("enterFrame", rat.moveLeft)
	            end
	        end
	    end
	end

	rat.removeRat = function()
	    Runtime:removeEventListener("enterFrame", rat.moveUp)
	    Runtime:removeEventListener("enterFrame", rat.moveDown)
	    Runtime:removeEventListener("enterFrame", rat.moveRight)
	    rat.sprite:removeSelf()
	    rat = nil
	    print("rat removed")
	end

	init()
    return rat

end

return CRat