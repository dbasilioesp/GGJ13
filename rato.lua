module( ..., package.seeall )

local direcao_rato

local rato = {}
rato.new = function( direcao)
        
		local rat

		local options =  { width=200, height=100, numFrames=2, sheetContentWidth=400, sheetContentHeight=100 };
		local RatoVermelhoHorizontal = graphics.newImageSheet("RatoVermelhoHorizontal.png", options);

        local dadosSequencia = {
                {name="RatoVermelhoHorizontal", sheet=RatoVermelhoHorizontal, start=1, count=2, time=990, loopCount=0 },
        }

        local rat =  display.newSprite(RatoVermelhoHorizontal, dadosSequencia);
        rat.x = 0
        rat.y = 0
        rat:scale(0.5, 0.5)
        rat:setSequence("RatoVermelhoHorizontal")
        rat:play()

        physics.addBody(rat, "dynamic", {density=3.0, friction=0.5,  bounce=0.3})

        function moveUp (event)
                rat.y = rat.y - 5
                if rat.y < 0 - rat.height/2 then
                        Runtime:removeEventListener("enterFrame", moveUp)
                end
        end

        function moveDown (event)
                rat.y = rat.y + 5

                if rat.y > 768 then
                        
                        Runtime:removeEventListener("enterFrame", moveDown)

                end
        end

        function moveRight (event)
                rat.x = rat.x + 5
                if rat.x > 1024 then
                        Runtime:removeEventListener("enterFrame", moveRight)
                end
        end

        function moveLeft (event)
                rat.x = rat.x - 5
                if rat.x < 0 - rat.width/2 then
                        Runtime:removeEventListener("enterFrame", moveLeft)
                end
        end

        local beginX
        local beginY  
        local endX
        local endY
        
        local xDistance  
        local yDistance  
        
        function checkSwipeDirection()
        
                if direcao_rato == 1 then -- para CIMA
                        Runtime:removeEventListener("enterFrame", moveUp)
                end 
                if direcao_rato == 2 then -- para BAIXO
                        Runtime:removeEventListener("enterFrame", moveDown)
                end 
                if direcao_rato == 3 then -- para ESQUERDA
                        Runtime:removeEventListener("enterFrame", moveLeft)
                end 
                if direcao_rato == 4 then -- para DIREITA
                        Runtime:removeEventListener("enterFrame", moveRight)
                end

                xDistance =  math.abs(endX - beginX) -- math.abs will return the absolute, or non-negative value, of a given value.
                yDistance =  math.abs(endY - beginY)
         
                if xDistance > yDistance then

                        if beginX > endX then
                                direcao_rato = 3
                                Runtime:addEventListener("enterFrame" , moveLeft)
                        else
                                direcao_rato = 4
                                Runtime:addEventListener("enterFrame" , moveRight)
                        end

                else
                        
                        if beginY > endY then
                                direcao_rato = 1
                                Runtime:addEventListener("enterFrame" , moveUp)
                        else
                                direcao_rato = 2
                                Runtime:addEventListener("enterFrame" , moveDown)
                        end
                        
                end
         
        end
         
        function swipe(event)
                if event.phase == "began" then
                        beginX = event.x
                        beginY = event.y
                end
         
                if event.phase == "ended"  then
                        endX = event.x
                        endY = event.y
                        checkSwipeDirection();
                end
        end
         
        if direcao_rato == 1 then -- para CIMA
                Runtime:addEventListener("enterFrame", moveUp)
        end 
        if direcao_rato == 2 then -- para BAIXO
                Runtime:addEventListener("enterFrame", moveDown)
        end 
        if direcao_rato == 3 then -- para ESQUERDA
                Runtime:addEventListener("enterFrame", moveLeft)
        end 
        if direcao_rato == 4 then -- para DIREITA
                Runtime:addEventListener("enterFrame", moveRight)
        end

        Runtime:addEventListener("touch", swipe)       

        return rat
end

return rato