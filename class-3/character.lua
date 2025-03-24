-- Slot Machine for PICO-8
-- Creates a 3-channel slot machine where each column consists of head, body, and feet

-- Constants
local HEAD_Y = 20
local BODY_Y = 40
local FEET_Y = 60
local SLOT_X = {30, 60, 90}
local SPRITE_START = 0 -- First sprite ID
local SPRITE_COUNT = 4 -- Number of different head/body/feet variations

-- Slot Machine State
local slots = {
    {id=0, spinning=false, timer=0},
    {id=0, spinning=false, timer=0},
    {id=0, spinning=false, timer=0}
}

local is_spinning = false

function _init()
    -- Initialize slots with random values
    for i=1,3 do
        slots[i].id = flr(rnd(SPRITE_COUNT))
    end
    music(0) -- Start carnival song
end

function _update()
    -- Start spinning when button is pressed
    if btnp(4) and not is_spinning then
        is_spinning = true
        for i=1,3 do
            slots[i].spinning = true
            slots[i].timer = i * 30 -- Stagger stop times
        end
    end

    -- Spin logic
    for i=1,3 do
        if slots[i].spinning then
            slots[i].id = flr(rnd(SPRITE_COUNT))
            slots[i].timer -= 1
            if slots[i].timer <= 0 then
                slots[i].spinning = false
                if i == 3 then is_spinning = false end
            end
        end
    end
end

function _draw()
    cls()
    print("Press Z to Spin!", 40, 10, 7)
    
    for i=1,3 do
        local spr_id = slots[i].id
        spr(SPRITE_START + spr_id, SLOT_X[i], HEAD_Y)
        spr(SPRITE_START + SPRITE_COUNT + spr_id, SLOT_X[i], BODY_Y)
        spr(SPRITE_START + SPRITE_COUNT * 2 + spr_id, SLOT_X[i], FEET_Y)
    end
end

-- Carnival Song
function _music()
    -- Define a simple carnival-style tune
    music(0, 0, 7)
end
