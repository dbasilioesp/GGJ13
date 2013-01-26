---------------------------------------------------------------------------------
--
-- mainmenu.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require("ui")

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local btnAnim

local btnSound = audio.loadSound( "tapsound.wav" )

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-- completely remove levelselect
	storyboard.removeScene( "levelselect" )
	
	print( "\nmainmenu: createScene event" )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local screenGroup = self.view
	
	print( "mainmenu: enterScene event" )
	
	local backgroundImage = display.newImageRect( "mmScreen.png", 480, 320 )
	backgroundImage.x = 240; backgroundImage.y = 160
	screenGroup:insert( backgroundImage )
	
	local playBtn
	
	local onPlayTouch = function( event )
		if event.phase == "release" then
			
			audio.play( btnSound )
			storyboard.gotoScene( "levelselect", "fade", 300  )
			
		end
	end
	
	playBtn = ui.newButton{
		defaultSrc = "playbtn.png",
		defaultX = 200,
		defaultY = 60,
		overSrc = "playbtn.png",
		overX = 205,
		overY = 65,
		onEvent = onPlayTouch,
		id = "PlayButton",
		text = "",
		font = "Helvetica",
		textColor = { 255, 255, 255, 255 },
		size = 16,
		emboss = false
	}
	
	playBtn.x = 240; playBtn.y = 440
  	screenGroup:insert( playBtn )
	
	btnAnim = transition.to( playBtn, { time=500, y=240, transition=easing.inOutExpo } )
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene()

	if btnAnim then transition.cancel( btnAnim ); end
	
	print( "mainmenu: exitScene event" )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying mainmenu's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene