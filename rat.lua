module( ..., package.seeall )

local _rat = {}
_rat.new = function( direcao, cor)

        local options =  { width=200, height=100, numFrames=2, sheetContentWidth=400, sheetContentHeight=100 };
        local RatoVermelhoVertical = graphics.newImageSheet("asserts/rats/RatoVermelhoVertical.png", options);
        local RatoVermelhoHorizontal = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontal.png", options);
        local RatoVermelhoHorizontalEsquerda = graphics.newImageSheet("asserts/rats/RatoVermelhoHorizontalEsquerda.png", options);       
        local RatoVerdeVertical = graphics.newImageSheet("asserts/rats/RatoVerdeVertical.png", options);
        local RatoVerdeHorizontal = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontal.png", options);
        local RatoVerdeHorizontalEsquerda = graphics.newImageSheet("asserts/rats/RatoVerdeHorizontalEsquerda.png", options);
        local RatoAmareloVertical = graphics.newImageSheet("asserts/rats/RatoAmareloVertical.png", options);
        local RatoAmareloHorizontal = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontal.png", options);
        local RatoAmareloHorizontalEsquerda = graphics.newImageSheet("asserts/rats/RatoAmareloHorizontalEsquerda.png", options);
        local RatoAzulVertical = graphics.newImageSheet("asserts/rats/RatoAzulVertical.png", options);
        local RatoAzulHorizontal = graphics.newImageSheet("asserts/rats/RatoAzulHorizontal.png", options);
        local RatoAzulHorizontalEsquerda = graphics.newImageSheet("asserts/rats/RatoAzulHorizontalEsquerda.png", options);

        local dadosSequencia = {
                {name="RatoVermelhoVertical", sheet=RatoVermelhoVertical, start=1, count=2, time=500, loopCount=0 },
                {name="RatoVermelhoHorizontal",sheet=RatoVermelhoHorizontal, start=1, count=2, time=500, loopCount=0},
                {name="RatoVerdeVertical",sheet=RatoVerdeVertical, start=1, count=2, time=500, loopCount=0},
                {name="RatoVerdeHorizontal",sheet=RatoVerdeHorizontal, start=1, count=2, time=500, loopCount=0},
                {name="RatoAmareloVertical",sheet=RatoAmareloVertical, start=1, count=2, time=500, loopCount=0},
                {name="RatoAmareloHorizontal",sheet=RatoAmareloHorizontal, start=1, count=2, time=500, loopCount=0},
                {name="RatoAzulVertical",sheet=RatoAzulVertical, start=1, count=2, time=500, loopCount=0},
                {name="RatoAzulHorizontal",sheet=RatoAzulHorizontal, start=1, count=2, time=500, loopCount=0},
                {name="RatoAzulHorizontalEsquerda",sheet=RatoAzulHorizontalEsquerda, start=1, count=2, time=500, loopCount=0},
                {name="RatoVerdeHorizontalEsquerda",sheet=RatoVerdeHorizontalEsquerda, start=1, count=2, time=500, loopCount=0},
                {name="RatoVermelhoHorizontalEsquerda",sheet=RatoVermelhoHorizontalEsquerda, start=1, count=2, time=500, loopCount=0},
                {name="RatoAmareloHorizontalEsquerda",sheet=RatoAmarelolHorizontalEsquerda, start=1, count=2, time=500, loopCount=0}

        }

        local rat

        if cor == "BLUE" then
                rat = display.newSprite(RatoAzulVertical, dadosSequencia);
        end
        if cor == "RED" then
                rat = display.newSprite(RatoVermelhoVertical, dadosSequencia);
        end
        if cor == "GREEN" then
                rat = display.newSprite(RatoVerdeVertical, dadosSequencia);
        end
        if cor == "YELLOW" then
                rat = display.newSprite(RatoAmareloVertical, dadosSequencia);
        end

        limite  = false
        rat.x = 0
        rat.pass = 0
        rat.y = 0
        rat:scale(0.3, 1)
        rat:setSequence("RatoVermelhoVertical")
        rat:play()

        ratShape = {-40, -50, 
                     40, -50,
                     40,  50,
                    -40,  50}

        physics.addBody(rat, "dinamic", {density=3.0, friction=0.5,  bounce=0.3, shape=ratShape})

        rat.isFixedRotation = true
        rat.direcao_rato = direcao
        rat.cor = cor


        rat.moveUp = function (event)
                
            rat.y = rat.y - 5

            if rat.x <= 400 then
                Runtime:removeEventListener("enterFrame", rat.moveUp)
                if rat.x > 185 and rat.x < 240 then
                        rat.pass = 3                                 
                end
                if rat.pass == 3 then
                        Runtime:removeEventListener("enterFrame", rat.moveUp)
                        transition.to(rat, {time =900 ,x = rat.x - 26, y = 130 })
                        rat.pass = 0
                        
                end
                
            end
        end

        rat.moveDown = function (event)
                rat.y = rat.y + 5
                if rat.y > 768 then                        
                    Runtime:removeEventListener("enterFrame", rat.moveDown)
                end
        end

        rat.moveRight = function (event)

            rat.x = rat.x + 5
    
            if  rat.x > 580 then
                Runtime:removeEventListener("enterFrame", rat.moveRight)
                limite = true
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

        rat.moveLeft = function (event)

           rat.x = rat.x - 5
           if rat.x < 415 and rat.pass ~=2 then

                Runtime:removeEventListener("enterFrame", rat.moveLeft)
                rat.x = 410
                limite = true
                Runtime:addEventListener("enterFrame", rat.moveUp )
                if  rat.y > 326 and rat.y < 405 then 

                       rat.pass = 2
                       Runtime:addEventListener("enterFrame", rat.moveLeft)
                end
            end
        end

        local beginX
        local beginY  
        local endX
        local endY
        
        local xDistance  
        local yDistance  
        
        local function checkSwipeDirection()

                local ratoVertical
                local ratoHorizontal

                if rat.cor == "BLUE" then
                        ratoVertical = "RatoAzulVertical"
                        ratoHorizontalEsquerda = "RatoAzulHorizontalEsquerda"
                        ratoHorizontal = "RatoAzulHorizontal"
                end
                if rat.cor == "RED" then
                        ratoVertical = "RatoVermelhoVertical"
                        ratoHorizontalEsquerda = "RatoVermelhoHorizontalEsquerda"
                        ratoHorizontal = "RatoVermelhoHorizontal"
                end
                if rat.cor == "GREEN" then
                        ratoVertical = "RatoVerdeVertical"
                        ratoHorizontal = "RatoVerdeHorizontal"
                        ratoHorizontalEsquerda = "RatoVerdeHorizontalEsquerda"
                end
                if rat.cor == "YELLOW" then
                        ratoVertical = "RatoAmareloVertical"
                        ratoHorizontalEsquerda = "RatoAmareloHorizontalEsquerda"
                        ratoHorizontal = "RatoAmareloHorizontal"
                end

                if rat.direcao_rato == 1 then -- para CIMA
                        Runtime:removeEventListener("enterFrame", rat.moveUp)
                end 
                if rat.direcao_rato == 2 then -- para BAIXO
                        Runtime:removeEventListener("enterFrame", rat.moveDown)
                end 
                if rat.direcao_rato == 3 then -- para ESQUERDA
                        Runtime:removeEventListener("enterFrame", rat.moveLeft)
                end 
                if rat.direcao_rato == 4 then -- para DIREITA
                        Runtime:removeEventListener("enterFrame", rat.moveRight)
                end

                xDistance =  math.abs(endX - beginX) -- math.abs will return the absolute, or non-negative value, of a given value.
                yDistance =  math.abs(endY - beginY)

         
                if xDistance > yDistance then

                        if beginX > endX  then
                                rat.direcao_rato = 3
                                rat:setSequence(ratoHorizontalEsquerda)
                                rat:play()
                                Runtime:addEventListener("enterFrame" , rat.moveLeft)


                        else
                                rat.direcao_rato = 4
                                rat:setSequence(ratoHorizontal)
                                rat:play()
                                Runtime:addEventListener("enterFrame" , rat.moveRight)

                        end

                else
                        
                        if beginY > endY then
                                rat.direcao_rato = 1
                                rat:setSequence(ratoVertical)
                                rat:play()
                                Runtime:addEventListener("enterFrame" , rat.moveUp)
                        else
                                rat.direcao_rato = 2
                                rat:setSequence(ratoVertical)
                                rat:play()
                                Runtime:addEventListener("enterFrame" , rat.moveDown)
                        end
                end
        end



         
        local function swipe(event)
                if event.phase == "began" then
                        beginX = event.x
                        beginY = event.y
                        display.getCurrentStage():setFocus(event.target, event.id);
                end
         
                if event.phase == "ended" then
                        endX = event.x
                        endY = event.y
                        checkSwipeDirection();
                        display.getCurrentStage():setFocus(event.target, nil);
                end
        end
         
        if rat.direcao_rato == 1 then -- para CIMA
                Runtime:addEventListener("enterFrame", rat.moveUp)
        end 
        if rat.direcao_rato == 2 then -- para BAIXO
                Runtime:addEventListener("enterFrame", rat.moveDown)
        end 
        if rat.direcao_rato == 3 then -- para ESQUERDA
                Runtime:addEventListener("enterFrame", rat.moveLeft)
        end 
        if rat.direcao_rato == 4 then -- para DIREITA
                Runtime:addEventListener("enterFrame", rat.moveRight)
        end

        rat.stopMove = function ()
            Runtime:removeEventListener("enterFrame", rat.moveUp)
            Runtime:removeEventListener("enterFrame", rat.moveDown)
            Runtime:removeEventListener("enterFrame", rat.moveLeft)
            Runtime:removeEventListener("enterFrame", rat.moveRight)
        end

        rat:addEventListener("touch", swipe)


        return rat
end

return _rat