system.activate( "multitouch" )

local intro = {}

intro.new = function ( params )
	local localGroup = display.newGroup()
		
		local musica = audio.loadSound("intro2.ogg")
		local mu = audio.play(musica, {loops = -1})

		local texto = display.newImage("TextoIntro.png", true)
		local back1 = display.newImage("Intro&Menu/terra1.png", true)
		local back2 = display.newImage("Intro&Menu/terra2.png", true)
		local back3 = display.newImage("Intro&Menu/terra3.png", true)
		local star = display.newImage("Intro&Menu/CoracaoDoMundo.png", true)
		texto.x = 500
		texto.y = 1200

		local anim = function() transition.to(back1, {alpha=0.0}) return anim end
		local anim2 = function() transition.to(back2, {alpha=0.0}) return anim2 end		
		local anim3 = function() transition.to(texto, { time = 3400, y = 380}) return anim3 end
		local prox = function() director:changeScene( "loadmainmenu",  "crossfade" ) return prox end
		local musica = function() audio.pause(mu) return musica end

		timer.performWithDelay(2000, anim3)
		timer.performWithDelay(4000, anim)
		timer.performWithDelay(8000, anim2)
		timer.performWithDelay(12000, prox)
		timer.performWithDelay(12000, musica)

	local initVars = function()

	end
	    
	initVars()

	return localGroup

end

return intro
