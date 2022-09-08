import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics;

class('Player').extends(gfx.sprite)

local playerSprite = nil
local playerSpeed = 4

function Player:init()
    local playerImage = gfx.image.new("images/player")
	playerSprite = gfx.sprite.new(playerImage);
	playerSprite:moveTo(200, 120)
	playerSprite:setCollideRect(0, 0, playerSprite:getSize())
	playerSprite:add(); -- adds to the draw list
end

function Player:update()
    Player.super.update(self);
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        playerSprite:moveBy(0, -playerSpeed)
    end
    if playdate.buttonIsPressed(playdate.kButtonDown) then
        playerSprite:moveBy(0, playerSpeed)
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        playerSprite:moveBy(-playerSpeed, 0)
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        playerSprite:moveBy(playerSpeed, 0)
    end
end
