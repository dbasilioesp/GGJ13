require("ui")
local director = require("director")

local telaDerrota = {}
telaDerrota.new = function()

	local flash = display.newRect(0,0, 1024,768)
	--local alpha = 1

	local function doFlash()
		flash.alpha = flash.alpha - 1/3
	end

	timer.performWithDelay(100, doFlash, 3)

	local tela = display.newGroup()
	--display.newImage("TelaDerrota.png", true)

	local function restart(event)
		director:changeScene("loadmainmenu")
	end

	Runtime:addEventListener("tap", restart)

	return tela
end

return telaDerrota