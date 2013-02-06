system.activate( "multitouch" )

local intro = {}

intro.new = function ( params )
	local localGroup = display.newGroup()
		
		local musica = audio.loadSound("asserts/sounds/intro2.ogg")
		local mu = audio.play(musica, {loops = -1})

		local texto = display.newImage("asserts/TextoIntro.png", true)
		local back1 = display.newImage("asserts/intro_menu/terra1.png", true)
		local back2 = display.newImage("asserts/intro_menu/terra2.png", true)
		local back3 = display.newImage("asserts/intro_menu/terra3.png", true)
		local star = display.newImage("asserts/intro_menu/CoracaoDoMundo.png", true)
		texto.x = 500
		texto.y = 1200

		local anim = function() transition.to(back1, {alpha=0.0}) return anim end
		local anim2 = function() transition.to(back2, {alpha=0.0}) return anim2 end		
		local anim3 = function() transition.to(texto, { time = 3400, y = 380}) return anim3 end
		local prox = function() director:changeScene( "scene1",  "crossfade" ) return prox end
		local musica = function() audio.pause(mu) return musica end

		timer.performWithDelay(2000, anim3)
		timer.performWithDelay(4000, anim)
		timer.performWithDelay(8000, anim2)
		timer.performWithDelay(12000, musica)
		timer.performWithDelay(12000, prox)

	local initVars = function()

	end
	    
	initVars()

	return localGroup

end

return intro
