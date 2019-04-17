-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------------
-- BACKGROUND
---------------------------------------------------------------------------------------
-- background
local background = display.newImage("Images/background.png", 0, 0)

-- set the x and y position
background.x = display.contentCenterX
background.y = display.contentCenterY

-- set the width and height
background.width = display.contentWidth
background.height = display.contentHeight

background:toBack()
--------------------------------------------------------------------------------------------------
-- LOCAL VARIABLES & OBJECTS & SOUNDS
-------------------------------------------------------------------------------------------
-- scroll speed
scrollSpeed = 6
------------------------------------------------------------------------------------------------
-- logo
local companyLogo = display.newImage("Images/CompanyLogoIsabelleLC@2x.png", 25, 25)
companyLogo:scale(0.09, 0.09)
companyLogo.isVisible = true
--------------------------------------------------------------------------------------------------------
-- Background Sound
local backgroundSound = audio.loadSound("Sounds/sound.mp3")
local backgroundSoundChannel
------------------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------
local function HideCompanyLogo()
    companyLogo.isVisible = false
end
---------------------------------------------------------------------------------------------------\

companyLogo.alpha = 1

-- set the x and y
companyLogo.x = 1024
companyLogo.y = display.contentHeight/2

-- function: MoveCompanyLogo
  local function MoveCompanyLogo(event)
   -- add the scroll speed to the x-value
     companyLogo.x = companyLogo.x - scrollSpeed
     -- scale the image by 100.2% (x) and 100.2% (y)
    companyLogo:scale(1.025, 1.025)

    timer.performWithDelay(2000, HideCompanyLogo)
  end
-- The function that will go to the main menu 
    local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end
--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        backgroundSoundChannel = audio.play( backgroundSound )

        -- Call the movechibi function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveCompanyLogo)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 2500, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(backgroundSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
