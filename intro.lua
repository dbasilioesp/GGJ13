module(..., package.seeall)
-----------------------------------------------------------------------------------------
--	Notas da versão
--  objeto.x = 400  max esquerdo  do viewport na tela
--  objeto.x = 1424 max direito do viewport na tela
--  osho_andando 131 x 153 cada frame
--  cuidado para não dar prepare dentro das funções de UPDuATE, isso buga atualização da tela
--  personagem está caindo até o final na animação por que a physics é um cilindro curto
--------------------------------------------------------------------------------------------
-- 					REQUIRE'S E INCLUDES

require "sprite"
local camera = require "camera"
local physics = require "physics"
system.activate( "multitouch" )
local ui = require("ui")
 physics.start()
 physics.setDrawMode("hybrid")
--
--  Animação de introdução
--
-----------------------------------------------------------------------------------------
function new()
-- Retirando status bar
	display.setStatusBar( display.HiddenStatusBar );

-----------------------------------------------------------------------------------------
--  ORIENTAÇÃO

	local largura = display.contentWidth;
	local altura = display.contentHeight;
	local centralizado = display.CenterReferencePoint;

--------------------------------------------------------------------------------------------

-- 					GRUPOS 
-- Criando o grupo de introdução
	local introGroup = display.newGroup();

-----------------------------------------------------------------------------------------

-- 					RECURSOS | IMAGENS |
--  Ao dar display na imagem ela vem com 1:2 de razão 2:2 seria o valor real do arquivo.
--  Identação depois de declarar a varivel define os atributos delas

	local plat1 = display.newImage ("img/corredor_direita.png",  true);
		plat1.x = 400; plat1.y = 412;
		plat1Shape = {-400,-35 , 400,-35 , 400,35 , -400,35};
    physics.addBody( plat1, "static", { friction=1.0, density=1.0, bounce=0, shape = plat1Shape  } );

  local plat2 = display.newImage ("img/ground.png",  true);
    plat2.x = 1050
    plat2.y = 300
    plat1Shape = {-400,-35 , 400,-35 , 400,35 , -400,35};
    physics.addBody( plat2, "static", { friction=1.0, density=1.0, bounce=0, shape = plat1Shape  } );

    local folhaDash = { width=145, height=158, numFrames=9, sheetContentWidth=1305, sheetContentHeight=158 };
    local dash = graphics.newImageSheet( "img/dash.png", folhaDash );

    local folhaAndando = { width=133, height=160, numFrames=10, sheetContentWidth=1337, sheetContentHeight=160 };
    local andando = graphics.newImageSheet( "img/andando.png", folhaAndando );

    local folhaAndandoEsquerda = { width=133, height=160, numFrames=10, sheetContentWidth=1337, sheetContentHeight=160 };
    local andandoEsquerda = graphics.newImageSheet( "img/andandoEsquerda.png", folhaAndandoEsquerda );

    local folhaOciosa =  { width=133.4, height=160, numFrames=10, sheetContentWidth=1331, sheetContentHeight=160 };
    local ociosa = graphics.newImageSheet("img/ociosa.png", folhaOciosa);

    local folhaOciosaEsquerda =  { width=133.4, height=160, numFrames=10, sheetContentWidth=1331, sheetContentHeight=160 };
    local ociosaEsquerda = graphics.newImageSheet("img/ociosaEsquerda.png", folhaOciosaEsquerda);

    local folhaAbaixa =  { width=175.4, height=160, numFrames=10, sheetContentWidth=1756, sheetContentHeight=160 };
    local abaixa = graphics.newImageSheet("img/abaixa.png", folhaAbaixa);

    local folhaAbaixaEsquerda=  { width=175.4, height=160, numFrames=10, sheetContentWidth=1756, sheetContentHeight=160 };
    local abaixaEsquerda = graphics.newImageSheet("img/abaixaEsquerda.png", folhaAbaixaEsquerda);

    local dadosSequencia = {
                { name="dash", sheet=dash, start=1, count=9, time=990, loopCount=0 },
                { name="andando", sheet=andando, start=1, count=10, time=1190, loopCount=0 },
                { name="andandoEsquerda", sheet=andandoEsquerda, start=1, count=10, time=1190, loopCount=0 },
                { name="ociosa", sheet=ociosa, start=1, count=10, time=1550, loopCount=0 },
                { name="ociosaEsquerda", sheet=ociosaEsquerda, start=1, count=10, time=1550, loopCount=0 },
                { name="abaixa", sheet=abaixa, start=1, count=10, time=1350, loopCount=0 },
                { name="abaixaEsquerda", sheet=abaixaEsquerda, start=1, count=10, time=1350, loopCount=0 }
            }

-----------------------------------------------------------------------------------------
-- 					  RECURSOS | BOTOES |
-----------------------------------------------------------------------------------------

	local botao = ui.newButton{default = "img/botao.png"}
    	botao.x, botao.y = largura  /4 ,  altura - 90
    	botao.id = "right"

	local botao2 = ui.newButton{default = "img/botao.png"}
    	botao2.x, botao2.y = largura /4 - 80, altura - 90
    	botao2.id = "left"

	local botao3 = ui.newButton{default = "img/botao.png"}
    	botao3.x, botao3.y = largura - 80, altura - 90

  local botao4 = ui.newButton{default = "img/botao.png"}
      botao4.x, botao4.y = largura /4 -40, altura - 130
      botao4.id = "up"

  local botao5 = ui.newButton{default = "img/botao.png"}
      botao5.x, botao5.y = largura /4 -40, altura - 50
      botao5.id = "down"

  local botao6 = ui.newButton{default = "img/botao.png"}
      botao6.x, botao6.y = largura - 150, altura - 90
      botao6.id = "atk"

-----------------------------------------------------------------------------------------
--          CARREGANDO PERSONAGEM | CONTROLES DO PERSONAGEM
--
-----------------------------------------------------------------------------------------

local personagem =  display.newSprite(ociosa, dadosSequencia);
      personagem:play()
      personagem.x = 400; personagem.y = 300
      personagemShape = { -70,-78, 70,-78, 70,78, -70,78 };
      physics.addBody(personagem, {friction = 1.0, density = 1.5, bounce = 0, shape = personagemShape})
      velo = 3;
      pulo = true;

-----------------------------------------------------------------------------------------
-- 					FUNCOES 
-----------------------------------------------------------------------------------------

	local charMoveLeft = function(event)
 	  personagem.x = personagem.x - velo
	end

	local charMoveRight = function(event)
 	  personagem.x = personagem.x + velo
	end

-- O local estado retorna pro perform por que senão ele ativa instantaneo, assim ele funciona o delay;

local estado = function() personagem:setSequence("ociosa") return personagem:play() end

function botao:tap(event)
  print(event.numTaps)
  if event.numTaps == 2 then
    timer.performWithDelay( 250, estado )
    transition.to(personagem, { time = 250, x = personagem.x + 150, y = personagem.y, onStart = personagem:setSequence("dash") })
    personagem:play()
  end
end

	local function onTouch(event)
    
    	local mode = event.phase
    	local clickedButton = event.target
   		--print(clickedButton.id)

    	if mode == "began" then

      		  if clickedButton.id == "left" then
         	 	  Runtime:addEventListener("enterFrame",charMoveLeft)
              personagem:setSequence("andandoEsquerda")
          		personagem:play()
            end 
        
       		 	if clickedButton.id == "right" then
         		  Runtime:addEventListener("enterFrame",charMoveRight)
              personagem:setSequence("andando")
              personagem:play()
            end 

            if clickedButton.id == "down" then
              personagem:setSequence("abaixa")
              personagem:play();
            end

   		 elseif mode == "ended" then

      		  if clickedButton.id == "left" then
           	  Runtime:removeEventListener("enterFrame",charMoveLeft)
           		personagem:pause()
              personagem:setSequence("ociosaEsquerda")
              personagem:play()
            end

        		if clickedButton.id == "right" then
              Runtime:removeEventListener("enterFrame",charMoveRight)
           		personagem:pause()
              personagem:setSequence("ociosa")
              personagem:play()
            end

            if clickedButton.id =="down" then
              personagem:setSequence("ociosa")
              personagem:play()
        		end
    end
  return true
end

function botao3:touch(event)

    if event.phase == "began" then
      if pulo == true then
        transition.to(botao3, {time = 100, alpha = 0})
        personagem:applyForce(0, -3500, personagem.x, personagem.y)
      end
        transition.to(botao3, {delay = 700, alpha = 1.0})
    end
  return true
end

local function onGlobalCollision(event)
    
    if event.phase == "began" then
      pulo = true
    end

    if event.phase == "ended" then
      pulo = false
    end
  return
end

local socket = require("socket")
-----------------------------------------------------------------------------------------
--          CONEXÂO COM A INTERNET 
-----------------------------------------------------------------------------------------

--Connect to the client
local client = socket.connect("www.google.com",  80)
--Get IP and Port from client
local ip, port = client:getsockname()
 
--Print the ip address and port to the terminal
print("IP Address: " .. ip)
print("Port: " .. port)


--[[
-- teste para ver se funcinou
    local testeAnimacao = display.newSprite(dash, dadosSequencia);
    testeAnimacao.x = largura / 2; testeAnimacao.y = altura / 2;
    testeAnimacao:play();

-- Depois de um tempo altera a sequencia para testar
local function trocaFolha()
	testeAnimacao:setSequence("andando");
	testeAnimacao:play();
end

timer.performWithDelay(3000, trocaFolha);
]]--

-----------------------------------------------------------------------------------------
--          LISTNERS
--
-----------------------------------------------------------------------------------------

botao:addEventListener( "tap", botao )
botao:addEventListener("touch", onTouch)
botao2:addEventListener("touch", onTouch)
botao3:addEventListener("touch", botao3)
botao4:addEventListener("touch", onTouch)
botao5:addEventListener("touch", onTouch)
Runtime:addEventListener("collision", onGlobalCollision)

return introGroup;

end