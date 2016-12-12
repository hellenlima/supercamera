local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------
-- Code outside of the scene functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------




-- -----------------------------------------------------------------------------
-- Scene functions
-- -----------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
	
	_W = display.contentWidth;
	_H = display.contentHeight;

	local smartCamera = require("Brain")
	local smartProcessing = require("PreProcessing")
	local loadsave = require("loadsave")
	local loadsave = require("loadsave")
	json = require('json')

	-- Variables used to configure app navigation
		local x1;
		local x2;
		local y1;
		local y2;
		local xMove;
		local yMove;
		local moveAblle = 1;
		local zoomAblle = 1;
	-- Variables used to store pixel values~
		local line, col = 1, 1

		local operandA = {}
		local operandB = {}
		local operator = {}

		local vectorOperandA = {}
		local vectorOperandB = {}
		local vectorOperator = {}
	-- Variables used to store neural net results
		local numberA, numberB, operation, result
	--
	-- AFTER RETURNING FROM NATIVE CAMERA...
	local function onComplete( event )

		-- 1. Set up the background image

			-- Display image on the main screen
			local backGround = display.newImageRect("images/BackGround.png", _W, _H);
			backGround.x = _W/2; backGround.y = _H/2;
			sceneGroup:insert(backGround);
			
			local photo = event.target
				if(photo == nil)then
					photo = display.newImage("images/BackGround.png");
				end
			--photo.width = _W; photo.height = _H;
			photo.x = _W/2; photo.y = _H/2;
			sceneGroup:insert(photo);
			
			local backGround2 = display.newImageRect("images/fundoSmartCamera.png", 2*_W, 2*_H);
			backGround2.x = _W/2; backGround2.y = _H/2;
			sceneGroup:insert(backGround2);
			
			-- Apply some filters to the image
			photo.fill.effect = "filter.contrast"
			photo.fill.effect.contrast = 4
			photo.fill.effect = "filter.grayscale"
			
			-- Set up touch mechanics for the image
			function photo:touch(photoT)
				if(photoT.phase == "began")then
					x1 = photoT.x;
					y1 = photoT.y;
				end
				if(photoT.phase == "moved")then
					if(moveAblle == 1) then
						x2 = photoT.x;
						y2 = photoT.y;
						xMove = photo.x + 2*(x2 - x1);
						yMove = photo.y + 2*(y2 - y1);
						transition.moveTo(photo, { x=xMove, y=yMove, time=0 } )
						x1 = photoT.x;
						y1 = photoT.y; 
					end
				end
				if(photoT.phase == "ended")then
				end
			end

			-- Set up an event listener for the image
			photo:addEventListener("touch", photo);	

		--------------------------------------------------
		-- 2. Position the grid over the photo

			local gradeImage = display.newImageRect("images/grade.png", 84, 28);
			gradeImage.x = _W/2; gradeImage.y = 0.3*_H;
			sceneGroup:insert(gradeImage);
		
		--------------------------------------------------
		-- 3. Set up the zoom button

			-- Set up button skin and position (zoom +)
				local zoomImagePlus = display.newImageRect("images/SmartCameraPlus.png", 1.333*_H/8, _H/8);
				zoomImagePlus.x = _W - zoomImagePlus.width/2; zoomImagePlus.y = 0.77*_H;
				sceneGroup:insert(zoomImagePlus);

			-- Set up zoom adjustment
				local zoomTouch = 1;
				local step = 0.05;

				function zoomImagePlus:touch(zoomImagePlusT)
						if(zoomImagePlusT.phase == "began")then
							moveAblle = 0;
							transition.scaleTo(zoomImagePlus, { xScale=1.25, yScale=1.25, time=100 } )
						end
						if(zoomImagePlusT.phase == "moved")then
							moveAblle = 1;
							transition.scaleTo(zoomImagePlus, { xScale=1, yScale=1, time=100 })
						end
						if(zoomImagePlusT.phase == "ended")then
							moveAblle = 1;
							zoomTouch = zoomTouch + step;
							transition.scaleTo(photo, { xScale=zoomTouch, yScale=zoomTouch, time=0 } )
							transition.scaleTo(zoomImagePlus, { xScale=1, yScale=1, time=100 })
						end
					end

				zoomImagePlus:addEventListener("touch",zoomImagePlus);

			-- Set up button skin and position (zoom -)
				local zoomImageLess = display.newImageRect("images/SmartCameraMinus.png", 1.333*_H/8, _H/8);
				zoomImageLess.x = _W - zoomImageLess.width/2; zoomImageLess.y = 0.93*_H;
				sceneGroup:insert(zoomImageLess);

			-- Set up zoom adjustment
				function zoomImageLess:touch(zoomImageLessT)
						if(zoomImageLessT.phase == "began")then
							moveAblle = 0;
							transition.scaleTo(zoomImageLess, { xScale=1.25, yScale=1.25, time=100 } )
						end
						if(zoomImageLessT.phase == "moved")then
							moveAblle = 1;
							transition.scaleTo(zoomImageLess, { xScale=1, yScale=1, time=100 })
						end
						if(zoomImageLessT.phase == "ended")then
							moveAblle = 1;
							if (zoomTouch > step) then
								zoomTouch = zoomTouch - step;
								transition.scaleTo(photo, { xScale=zoomTouch, yScale=zoomTouch, time=0 } )
							end
							transition.scaleTo(zoomImageLess, { xScale=1, yScale=1, time=100 })
						end
					end

				zoomImageLess:addEventListener("touch",zoomImageLess);
			
			local pictureImage = display.newImageRect("images/SmartCameraCam.png", 1.333*_H/8, _H/8);
			pictureImage.x = 0.15*_W; pictureImage.y = 0.93*_H;
			sceneGroup:insert(pictureImage);
			
			function pictureImage:touch(pictureImageT)
					if(pictureImageT.phase == "began")then
						transition.scaleTo(pictureImage, { xScale=1.25, yScale=1.25, time=100 } )
					end
					if(pictureImageT.phase == "moved")then
						transition.scaleTo(pictureImage, { xScale=1, yScale=1, time=100 })
					end
					if(pictureImageT.phase == "ended")then
						transition.scaleTo(pictureImage, { xScale=1, yScale=1, time=100 })
						composer.removeScene("Home", true);
						composer.gotoScene("Home");
					end
				end

			pictureImage:addEventListener("touch",pictureImage);

		--------------------------------------------------	
		-- 4. Set up the main button

			-- 4.1 Set up button skin and position
				local mainButton = display.newImageRect("images/SmartCameraLogo.png", 1.333*_H/6, _H/6);
				mainButton.x = _W/2; mainButton.y = _H - mainButton.height/2 - 5;
				sceneGroup:insert(mainButton);

			-- 4.2 Convert pixel color from RGB to Gray and save it
				function onColorSampleA (event)	
					local gray = (event.r + event.g + event.b)/3
					--operandA[pixelNumber] = gray
					operandA[line][col] = gray

					--print( "Sampling pixel ("..line.. "," ..col.. "): " .. operandA[line][col])
				end
				function onColorSampleB (event)
					if(event.x == _W/2 + 14) then
						--operandB[pixelNumber] = 1 -- Wipe border
						operandB[line][col] = 1 -- Wipe border
					else
						local gray = (event.r + event.g + event.b)/3
						--operandB[pixelNumber] = gray
						operandB[line][col] = gray
					end
				end
				function onColorSampleOp (event)
					if(event.x == _W/2 - 14) then
						--operator[pixelNumber] = 1 -- Wipe border
						operator[line][col] = 1 -- Wipe border
					else
						local gray = (event.r + event.g + event.b)/3
						--operator[pixelNumber] = gray
						operator[line][col] = gray
					end
				end

			-- 4.3 Set up touch action for the main button
				function mainButton:touch(mainButtonT)
					if(mainButtonT.phase == "began")then
						transition.scaleTo(mainButton, { xScale=1.6, yScale=1.6, time=100 } )
						moveAblle = 0;
					end
					if(mainButtonT.phase == "moved")then
						transition.scaleTo(mainButton, { xScale=1, yScale=1, time=100 } )
						moveAblle = 1;
					end
					if(mainButtonT.phase == "ended")then
						transition.scaleTo(mainButton, { xScale=1, yScale=1, time=100 } )
						moveAblle = 1;
						-- A. Initialize input matrices
							for y=1, 28 do
								table.insert(operandA, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
							end
							for y=1, 28 do
								table.insert(operator, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
							end
							for y=1, 28 do
								table.insert(operandB, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
							end
						--
						-- That's where the fun begins				
							-- OPERAND_A
								-- a) Get pixels				
									line = 1
									-- Run through the first cell in the grid
									for y = (0.3*_H - 14), (0.3*_H + 13) do
										col = 1
										for x = (_W/2 - 42), (_W/2 - 15) do
											display.colorSample(x, y , onColorSampleA)
											col = col + 1
										end
										line = line + 1
									end
									-- DEBUG
									loadsave.saveTable(operandA, "N1_white.txt")
								-- b) Process image
									-- Invert and filter pixels
									operandA = smartProcessing.invert(operandA)
									operandA = smartProcessing.filter(operandA)
										-- DEBUG
										loadsave.saveTable(operandA, "N1_filtered.txt")
									-- Centralize contents
									local x, y = smartProcessing.centerOfMass(operandA)
									operandA = smartProcessing.centralize(operandA, x, y)
										-- DEBUG
										loadsave.saveTable(operandA, "N1_centralized.txt")
								-- c) Identify character
									vectorOperandA = smartProcessing.matrixToVector(operandA)
									
									-- Use the Brains to identify the number on the first cell
									numberA = smartCamera.processNumber(vectorOperandA)
									--native.showAlert("Image Processing", "Operand A is " .. numberA, { "OK" })

							-- GET OPERATOR				
								-- a) Get pixels	
									line = 1
									-- Run through the second cell in the grid
									for y = (0.3*_H - 14), (0.3*_H + 13) do
										col = 1
										for x = (_W/2 - 14), (_W/2 + 13) do
											display.colorSample(x, y , onColorSampleOp)
											col = col + 1
										end
										line = line + 1
									end

								-- b) Process image
									-- Invert and filter pixels
									operator = smartProcessing.invert(operator)
									operator = smartProcessing.filter(operator)
									-- Centralize contents
									local x, y = smartProcessing.centerOfMass(operator)
									operator = smartProcessing.centralize(operator, x, y)

								-- c) Identify character
									vectorOperator = smartProcessing.matrixToVector(operator)
									
									-- Use the Brains to identify the number on the first cell
									operation = smartCamera.processOperation(vectorOperator)
									--native.showAlert("Image Processing", "Operand A is " .. numberA, { "OK" })

							-- GET OPERAND_B	
								-- a) Get pixels			
									line = 1
									-- Run through the third cell in the grid
									for y = (0.3*_H - 14), (0.3*_H + 13) do
										col = 1
										for x = (_W/2 + 14), (_W/2 + 41) do
											display.colorSample(x, y , onColorSampleB)
											col = col + 1
										end
										line = line + 1
									end
								-- b) Process image
									-- Invert and filter pixels
									operandB = smartProcessing.invert(operandB)
									operandB = smartProcessing.filter(operandB)
									-- Centralize contents
									local x, y = smartProcessing.centerOfMass(operandB)
									operandB = smartProcessing.centralize(operandB, x, y)
										-- DEBUG
										loadsave.saveTable(operandB, "N1_centralized.txt")
								-- c) Identify character
									vectorOperandB = smartProcessing.matrixToVector(operandB)
									
									-- Use the Brains to identify the number on the first cell
									numberB = smartCamera.processNumber(vectorOperandB)
							
							result = smartCamera.calculate(numberA, numberB, operation)
						
						-----------------------------------------------------
						------FUNÇÃO PARA VOLTAR PRA CÂMERA COM WARM-----
					--	local function onComplete( event )
						--	if ( event.action == "clicked" ) then
							--	local i = event.index
								--if ( i == 1 ) then
								--	composer.removeScene("Home", true)
								--	composer.gotoScene("Home");
								--end
						--	end
						--end

						-- Show alert with two buttons
						--native.showAlert("Smart Calculation", numberA .." ".. operation.." "..numberB.." = "..result, { "OK"}, onComplete )	
						------FUNÇÃO PARA VOLTAR PRA CÂMERA COM WARM-----
						native.showAlert("Smart Calculation", numberA .." ".. operation.." "..numberB.." = "..result, { "OK"})	
					end
				end

			-- Set up an event listener for the main button
			mainButton:addEventListener("touch", mainButton);
	end

	-- APP STARTS ON NATIVE CAMERA...
	if media.hasSource( media.PhotoLibrary ) then
	   media.capturePhoto( { mediaSource=media.PhotoLibrary, listener = onComplete } )
	else
	   native.showAlert( "Corona", "This device does not have a camera", { "OK" } )
	end
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------
-- Scene function listeners
-- -----------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------

return scene
