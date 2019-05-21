-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Isabelle LC
-- Date: May 2, 2019
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

--------------------------------------------------------------------------------------------------
--GLOBAL VARIABLES
-------------------------------------------------------------------------------------------
-- scroll speed
scrollSpeed = 6

---------------------------------------------------------------------------------------
-- SOUNDS
--------------------------------------------------------------------------------------
-- Background Sound
local backgroundSound = audio.loadSound("Sounds/sound.mp3")
local backgroundSoundChannel

--------------------------------------------------------------------------------------------------
-- LOCAL VARIABLES 
-------------------------------------------------------------------------------------------
local background
local turboG
local companyLogo

------------------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------
local function HideCompanyLogo()
    companyLogo.isVisible = false
end

local function ShowTurboG()
    turboG.isVisible = true
end

local function HideTurboG()
    turboG.isVisible = false
end
---------------------------------------------------------------------------------------------------

-- function: MoveCompanyLogo
local function MoveCompanyLogo(event)
    -- add the scroll speed to the x-value
    companyLogo.x = companyLogo.x - scrollSpeed
    -- scale the image by 100.2% (x) and 100.2% (y)
    companyLogo:scale(1.025, 1.025)

    timer.performWithDelay(2000, HideCompanyLogo)
    timer.performWithDelay(2050, ShowTurboG)
    timer.performWithDelay(2100, HideTurboG)
end

local function HideTurboG2()
    turboG.isVisible = false
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end
--------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    ------------------------------------------------------------------------------------------------------------
    -- OBJECT CREATION & TEXT
    ------------------------------------------------------------------------------------------------------------
    -- background
    background = display.newImage("Images/1.jpg", 0, 0)

    -- set the x and y position
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- set the width and height
    background.width = display.contentWidth
    background.height = display.contentHeight


    -- create the text object that will say Correct, set the colour and then hide it
    turboG = display.newText("Turbo Games", display.contentWidth/2, display.contentHeight*1/2, nil, 100 )
    turboG:setTextColor(1, 1, 1)
    turboG.isVisible = false


    ------------------------------------------------------------------------------------------------
    -- logo
    companyLogo = display.newImage("Images/CompanyLogoIsabelleLC@2x.png", 25, 25)
    companyLogo:scale(0.09, 0.09)
    companyLogo.isVisible = true

    companyLogo.alpha = 1

    -- set the x and y
    companyLogo.x = 1024
    companyLogo.y = display.contentHeight/2

  
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert(background)
    sceneGroup:insert(turboG)
    sceneGroup:insert(companyLogo)

end -- function scene:create( event )   

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
        backgroundSoundChannel = audio.play(backgroundSound)

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
