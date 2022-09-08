import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import("models/player")
import("models/coin")

local gfx <const> = playdate.graphics;

local player = Player()
local coin = Coin()

local playTimer = nil
local playTime = 10 * 1000
local score = 0

local function resetTimer()
	playTimer = playdate.timer.new(playTime, playTime, 0, playdate.easingFunctions.linear)
end

local function resetScore()
	score = 0
end

local function resetGame()
	resetTimer()
	resetScore()
end

local function initalize()
	math.randomseed(playdate.getSecondsSinceEpoch())

	local backgroundImage = gfx.image.new("images/background")
	gfx.sprite.setBackgroundDrawingCallback(
		function(x, y, width, height)
			gfx.setClipRect(x, y, width, height)
			backgroundImage:draw(0, 0)
			gfx.clearClipRect()
		end
	)
	resetTimer()
	resetScore()
end

initalize()

function playdate.update()
	if playTimer.value == 0 then
		if playdate.buttonJustPressed(playdate.kButtonA) then
			resetGame()
			coin:moveCoin()
		end
	else

		player:update()

		local didPlayerGetCoin = coin:isOverlappingPlayer()
		if didPlayerGetCoin then
			coin:moveCoin()
			score = score + 1
		end
	end

	playdate.timer.updateTimers();
	gfx.sprite.update();

	gfx.drawText("Time: " .. math.ceil(playTimer.value / 1000), 5, 5)
	gfx.drawText("Score: " .. score, 320, 5)
end
