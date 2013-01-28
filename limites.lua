module( ..., package.seeall )
local physics = require "physics"
physics.start()

local limites = {}

limites.start = function ()


		limite = display.newRect(395, 415, 4, 345)
		physics.addBody(limite, {isSensor=true})
		limite.alpha = (1.0)
		limite:rotate(5.4)
		--limiteShape = { -30,-20, -30, -20, 95,-240, 70,78, -50,0 }
		--physics.addBody (limite, "static", {friction = 1.0, density =1.0, bounce=0, shape = limiteShape}) 


		limite2 = display.newRect(618, 580, 4, 180)
		physics.addBody(limite2, {isSensor=true})
		limite2.isSensor = true
		limite2.alpha = (1.0)
		limite2:rotate(-6.9)

				--limite2Shape = { -275,-75, 45,-125, 30,-120, -250,78 }
		--physics.addBody (limite2, "static", {friction = 1.0, density =1.0, bounce=0, shape = limite2Shape}) 

		limite3 = display.newRect(600, 270, 4, 195)
		physics.addBody(limite3, {isSensor=true})
		limite3.isSensor = true
		limite3.alpha = (1.0)
		limite3:rotate(4.4)
		

	--	limite3Shape = { -275,-85, -150, -150, 10,-150, 30,90, -100, 110, -290,95 }
	--	physics.addBody (limite3, "static", {friction = 1.0, density =1.0, bounce=0, shape = limite3Shape}) 

		limite4 = display.newRect(605, 470, 220, 4)
		physics.addBody(limite4, {isSensor=true})
		limite4.isSensor = true
		limite4.alpha = (1.0)
		limite4:rotate(4.1)

		--limite4Shape = { 0, 0, 0, -130, -30, -230 }
		--physics.addBody (limite4, "static", {friction = 1.0, density =1.0, bounce=0, shape = limite4Shape}) 
		limite5 = display.newRect(620, 550, 255, 4)
		physics.addBody(limite5, {isSensor=true})
		limite5.isSensor = true
		limite5.alpha = (1.0)
		limite5:rotate(-7.9)

		--limite5 = display.newRect(630, 50, 20, 120)
		--limite5.alpha = (0.0)
		--limite5Shape = { 0, -108, 80, -108, 16, 3, -16,3 }
		--physics.addBody (limite5, "static", {friction = 1.0, density =1.0, bounce=0, shape = limite5Shape}) 
		
		limite6 = display.newRect(405, 165, 4, 150)
		physics.addBody(limite6, {isSensor=true})
		limite6.isSensor  = true
		limite6.alpha = (1.0)
		limite6:rotate(-1.4)


		limite7 = display.newRect(385, 10, 4, 150)
		physics.addBody(limite7, {isSensor=true})
		limite7.isSensor  = true
		limite7.alpha = (1.0)
		limite7:rotate(-16.4)

		limite8 = display.newRect(645, 5, 4, 100)
		physics.addBody(limite8, {isSensor=true})
		limite8.isSensor  = true
		limite8.alpha = (1.0)
		limite8:rotate(9.4)

		limite9 = display.newRect(650, 103, 245, 4)
		physics.addBody(limite9, {isSensor=true})
		limite9.isSensor  = true
		limite9.alpha = (1.0)
		limite9:rotate(1.4)

		limite10 = display.newRect(700, 210, 190, 4)
		physics.addBody(limite10, {isSensor=true})
		limite10.isSensor  = true
		limite10.alpha = (1.0)
		limite10:rotate(-7.4)


		limite11 = display.newRect(610, 250, 90, 4)
		physics.addBody(limite11, {isSensor=true})
		limite11.isSensor  = true
		limite11.alpha = (1.0)
		limite11:rotate(-27.4)


		limite12 = display.newRect(280, 325, 125, 4)
		physics.addBody(limite12, {isSensor=true})
		limite12.isSensor  = true
		limite12.alpha = (1.0)
		limite12:rotate(-1.4)

		limite13 = display.newRect(100, 415, 305, 4)
		physics.addBody(limite13, {isSensor=true})
		limite13.isSensor  = true
		limite13.alpha = (1.0)
		limite13:rotate(-1.4)

		limite14 = display.newRect(93, 325, 100, 4)
		physics.addBody(limite14, {isSensor=true})
		limite14.isSensor  = true
		limite14.alpha = (1.0)
		limite14:rotate(-1.4)

		limite15 = display.newRect(185, 225, 4, 100)
		physics.addBody(limite15, {isSensor=true})
		limite15.isSensor  = true
		limite15.alpha = (1.0)
		limite15:rotate(-11.4)

		limite16 = display.newRect(239, 170, 4, 105)
		physics.addBody(limite16, {isSensor=true})
		limite16.isSensor  = true
		limite16.alpha = (1.0)
		limite16:rotate(-4.4)

		limite17 = display.newRect(265, 280, 4, 50)
		physics.addBody(limite17, {isSensor=true})
		limite17.isSensor  = true
		limite17.alpha = (1.0)
		limite17:rotate(-28.4)



	--[[function preColisao(self, event )
		  print(
        "preCollision: " .. self.myName .. self.x .. self.y
        .. " esta colidindo com o  " .. event.other.myName )
		 event.contact.isEnabled  = false

		end


	
	limite.preCollision = preColisao
	limite:addEventListener( "preCollision", limite )

	function limite:postCollision(event)
		print("Retirando Listner")
		  print(event.other.x)
		self:removeEventListener ( "preCollision")
		self:removeEventListener( "postCollision" )
	end
	
	limite:addEventListener ( "postCollision")
	]]--
		

--[[

	limite:addEventListener("collision", limite)
	function limite:collision( event )
			print(event.other.caiu)
			if event.other.myName == "ratinho" and event.phase == "began" then
				print ("exito")
				event.other.caiu = "true"
				print(event.other.caiu)
			end
			
		end]]--



		return limite
end

return limites
