module( ..., package.seeall )
local sprite = require "sprite"
local physics = require "physics"
local _rat = {}
local rat
local options

_rat.new = function(color, direction)

    options = { width=200, height=100, numFrames=2, sheetContentWidth=400, sheetContentHeight=100 };
    
    if color == "RED" then
        _rat.createRatRed()
    elseif color == "BLUE" then
        _rat.createRatBlue()
    elseif color == "GREEN" then
        _rat.createRatGreen()
    else
        _rat.createRatYellow()
    end

    if direction == nil then
        direction = "UP" -- Direction default
    end

    rat.isFixedRotation = true
    rat.direction = direction
    rat.color = color

    rat.x = 200; rat.y = 200
    rat.pass = 0
    rat:scale(0.3, 1)
    
    ratShape = {-40, -50, 
                 40, -50,
                 40,  50,
                -40,  50}

    physics.addBody(rat, "dinamic", {density=3.0, friction=0.5,  bounce=0.3, shape=ratShape})

    rat.stopMove = function ()
        Runtime:removeEventListener("enterFrame", _rat.moveUp)
        Runtime:removeEventListener("enterFrame", _rat.moveDown)
        Runtime:removeEventListener("enterFrame", _rat.moveLeft)
        Runtime:removeEventListener("enterFrame", _rat.moveRight)
    end

    if direction == "UP" then -- para CIMA
        rat:setSequence("rat_up")
        Runtime:addEventListener("enterFrame", _rat.moveUp)
    elseif direction == "DOWN" then
        rat:setSequence("rat_left")
        Runtime:addEventListener("enterFrame", _rat.moveDown)
    elseif direction == "RIGHT" then
        rat:setSequence("rat_right")
        Runtime:addEventListener("enterFrame", _rat.moveRight)
    elseif direction == "LEFT" then
        rat:setSequence("rat_left")
        Runtime:addEventListener("enterFrame", _rat.moveLeft)
    end

    rat:play()

    return rat
end

_rat.getSequence = function (rat_up, rat_right, rat_left)

    local sequence = {
            {name="rat_up",   sheet=rat_up, start=1, count=2, time=500, loopCount=0 },
            {name="rat_right",sheet=rat_right, start=1, count=2, time=500, loopCount=0},
            {name="rat_left", sheet=rat_left, start=1, count=2, time=500, loopCount=0},
    }

    return sequence
end

_rat.createRatRed = function()
    
    local rat_red_up    = graphics.newImageSheet("asserts/rats/RatoVermelhoVertical.png", options);
    local rat_red_right = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontal.png", options);
    local rat_red_left  = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontalEsquerda.png", options);

    local sequence = _rat.getSequence(rat_red_up, rat_red_right, rat_red_left)

    rat = display.newSprite(rat_red_up, sequence);

end

_rat.createRatBlue = function()
    
    local rat_blue_up    = graphics.newImageSheet("asserts/rats/RatoAzulVertical.png", options);
    local rat_blue_right = graphics.newImageSheet("asserts/rats/RatoAzulHorizontal.png", options);
    local rat_blue_left  = graphics.newImageSheet("asserts/rats/RatoAzulHorizontalEsquerda.png", options);

    local sequence = _rat.getSequence(rat_blue_up, rat_blue_right, rat_blue_left)

    rat = display.newSprite(rat_blue_up, sequence);

end

_rat.createRatGreen = function()
    
    local rat_green_up    = graphics.newImageSheet("asserts/rats/RatoVerdeVertical.png", options);
    local rat_green_right = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontal.png", options);
    local rat_green_left  = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontalEsquerda.png", options);

    local sequence = _rat.getSequence(rat_green_up, rat_green_right, rat_green_left)

    rat = display.newSprite(rat_green_up, sequence);

end

_rat.createRatYellow = function()
    
    local rat_yellow_up    = graphics.newImageSheet("asserts/rats/RatoAmareloVertical.png", options);
    local rat_yellow_right = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontal.png", options);
    local rat_yellow_left  = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontalEsquerda.png", options);

    local sequence = _rat.getSequence(rat_yellow_up, rat_yellow_right, rat_yellow_left)

    rat = display.newSprite(rat_yellow_up, sequence)

end

_rat.moveUp = function (event)

    if rat then

        rat.y = rat.y - 5

        if rat.y <= 0 then
            _rat.removeRat()
            return
        end

        if rat.x <= 4400 then
            print ("4400")
            Runtime:removeEventListener("enterFrame", _rat.moveUp)
            
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

_rat.moveDown = function (event)

    if rat then
        
        rat.y = rat.y + 5

        if rat.y > display.contentHeight then                        
            _rat.removeRat()
            return
        end

    end
end

_rat.moveRight = function (event)
    
    if rat then

        rat.x = rat.x + 5

        if rat.x >= display.contentWidth then
            _rat.removeRat()
            return
        end

        if  rat.x > 580 then
            Runtime:removeEventListener("enterFrame", _rat.moveRight)
            limite = true
            Runtime:addEventListener("enterFrame", _rat.moveUp )
        end

        if  rat.y > 440 and rat.y < 525 then 
               rat.pass = 1
        end

         if  rat.y > 120 and rat.y < 190 then 
               rat.pass = 4
        end

         if rat.pass == 1 then
                Runtime:removeEventListener("enterFrame", _rat.moveRight)
                transition.to(rat, {time = 1200, x = 944, y = rat.y -28})   
                rat.pass = 0
         end  

         if rat.pass == 4 then
                Runtime:removeEventListener("enterFrame", _rat.moveRight)                   
                transition.to(rat, {time =980, x = 946, y = rat.y - 30})
                rat.pass = 0
         end
    end

end

_rat.moveLeft = function (event)

    if rat then
        rat.x = rat.x - 5

        if rat.x <= 0 then
            _rat.removeRat()
            return
        end

        if rat.x < 415 and rat.pass ~=2 then

            Runtime:removeEventListener("enterFrame", _rat.moveLeft)
            rat.x = 410
            limite = true
            Runtime:addEventListener("enterFrame", _rat.moveUp )
            if  rat.y > 326 and rat.y < 405 then 

                   rat.pass = 2
                   Runtime:addEventListener("enterFrame", _rat.moveLeft)
            end
        end
    end
end

_rat.removeRat = function()
    Runtime:removeEventListener("enterFrame", _rat.moveUp)
    Runtime:removeEventListener("enterFrame", _rat.moveDown)
    Runtime:removeEventListener("enterFrame", _rat.moveRight)
    rat:removeSelf()
    rat = nil
    print("rat removed")
end

return _rat