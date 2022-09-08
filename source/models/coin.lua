import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics;

local coinSprite = nil

class('Coin').extends(gfx.sprite)

function Coin:init()
    local coinImage = gfx.image.new("images/coin")
	coinSprite = gfx.sprite.new(coinImage)
	Coin:moveCoin()
	coinSprite:setCollideRect(0, 0, coinSprite:getSize())
	coinSprite:add(); -- adds to the draw list
end

function Coin:moveCoin()
	local randX = math.random(40, 360)
	local randY = math.random(40, 200)
	coinSprite:moveTo(randX, randY)
end

function Coin:isOverlappingPlayer()
    local collisions = coinSprite:overlappingSprites()
    return #collisions >= 1
end
