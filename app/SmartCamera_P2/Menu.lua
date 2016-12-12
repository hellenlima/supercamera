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

	local backGround = display.newImageRect("images/MenuImage.png", _W, _H);
	backGround.x = _W/2; backGround.y = _H/2;
	sceneGroup:insert(backGround);

	local logoImage = display.newImageRect("images/SmartCameraLogo.png", 1.333*_H/6, _H/6);
	logoImage.x = _W/2; logoImage.y = _H - logoImage.height/2 - 5;
	sceneGroup:insert(logoImage);
	
	logoImage.fill.effect = "filter.wobble"

	logoImage.fill.effect.amplitude = 10;

	function logoImage:touch(logoImageT)
			if(logoImageT.phase == "began")then
			end
			if(logoImageT.phase == "moved")then
			end
			if(logoImageT.phase == "ended")then
				composer.gotoScene( "Home" );
			end
		end

	logoImage:addEventListener("touch",logoImage);
    -- Code here runs when the scene is first created but has not yet appeared on screen

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
