-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- the local variables for this scene

local correctAnswerText
local wrongAnswerText1
local wrongAnswerText2
local wrongAnswerText3
local wrongAnswerText4
local wrongAnswerText5
local wrongAnswerText6

local answer
local wrongAnswer1
local wrongAnswer2
local wrongAnswer3
local wrongAnswer4
local wrongAnswer5
local wrongAnswer6

local answerPosition = 1
local cover

local userAnswer
local textTouched = false

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5/5/7

local questionObject
local numericField
local userAnswer
local correctAnswer1
local incorrectAnswer
local randomOperator

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeGame()
end 


--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)
    userAnswer = answerText.text
    
    questionsAnswered = questionsAnswered + 1

    if (touch.phase == "ended") then

        BackToLevel1( )
    
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer1(touch)
    userAnswer = wrongText1.text
    
    if (touch.phase == "ended") then
        
        BackToLevel1( )
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    userAnswer = wrongText2.text
    
    if (touch.phase == "ended") then
        
        BackToLevel1( ) 
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer3(touch)
    userAnswer = wrongText3.text
    
    if (touch.phase == "ended") then
        
        BackToLevel1( )
          
    end 
end

-- add the event listeners
local function AddTextListeners()
	answerText:addEventListener("touch", TouchListenerAnswer)
	wrongText1:addEventListener("tocuh", TouchListenerWrongAnswer1)
	wrongText2:addEventListener("tocuh", TouchListenerWrongAnswer2)
	wrongText3:addEventListener("tocuh", TouchListenerWrongAnswer3)
end

-- remove event listeners
local function RemoveTextListeners()
	answerText:removeEventListener("touch", TouchListenerAnswer)
	wrongText1:removeEventListener("touch", TouchListenerWrongAnswer1)
    wrongText2:removeEventListener("touch", TouchListenerWrongAnswer2)
    wrongText3:removeEventListener("touch", TouchListenerWrongAnswer3)
end

local function AskQuestion()
    -- generate a random number between 1 and 2
    -- *** declare this variable above
    randomOperator = math.random(1,2)

    if (randomOperator == 1) then

        -- correct answer
        correctAnswer = " 8 "

        -- wrong answers
        wrongAnswer1 = correctAnswer1 - math.random(1, 3)
        wrongAnswer2 = correctAnswer1 + math.random(1, 3)
        wrongAnswer3 = correctAnswer1 - math.random(4, 5)

        questionObject.text == " How many planets are there? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongText1.text = wrongAnswer1
        wrongText2.text = wrongAnswer2
        wrongText3.text = wrongAnswer3
    
    elseif (randomOperator == 2) then

        -- correct answer
        correctAnswer = " Earth "

        -- wrong answers
        wrongAnswer4 = " Mars "
        wrongAnswer5 = " Jupiter "
        wrongAnswer6 = " Neptune "

        questionObjectText2.text == " What planet has life on it? "

        -- create answer text
        correctAnswerText.text = correctAnswer

        -- wrong answer text
        wrongText4.text = wrongAnswer4
        wrongText5.text = wrongAnswer5
        wrongText6.text = wrongAnswer6
    end
end

local function PositionAnswers()

    --creating random positions in a certain area
    answerPosition = math.random(1,2)

    if (answerPosition == 1) then

        correctAnswerText1

--------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
--------------------------------------------------------------------------------------

-- the function called when the screen doesn't exist
function scene:create(event)

    -- creat a group tht associates objects with the scene
    local sceneGroup = self.view
    ----------------------------------------------------------------------------------
    -- make a cover rectangle to have rhe background fully blocked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50)
    -- set the cover color
    cover:settFillColor(96/255, 96/255, 96/255)
    ----------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(cover)

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        DisplayQuestion()
        PositionAnswers()
        AddTextListeners()
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTextListeners()
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