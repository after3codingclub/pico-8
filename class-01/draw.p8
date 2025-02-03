pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- simple pico-8 drawing project
-- controls: arrow keys to move, 🅾️ to draw, x to clear the screen, 🅾️ + ⬇️ to stamp

-- initial setup
x = 64 -- start x position
y = 64 -- start y position
draw_color = 7 -- default color (white)
selected_sprite = 1 -- default sprite index (1)

function _init()
    cls() -- clear the screen
end

function _update()
    -- move the cursor with arrow keys
    if btn(0) then x = max(0, x - 1) end -- left
    if btn(1) then x = min(127, x + 1) end -- right
    if btn(2) then y = max(0, y - 1) end -- up
    if btn(3) then y = min(127, y + 1) end -- down

    -- change color with the 🅾️ button (button 4)
    if btnp(4) and not btn(3) then
        draw_color = (draw_color + 1) % 16
    end

    -- stamp sprite with 🅾️ + down
    if btn(4) and btnp(3) then
        spr(selected_sprite, x - 4, y - 4)
    end

    -- cycle through sprites using buttons 1 through 9
    for i = 0, 8 do
        if btnp(i) then
            selected_sprite = i + 1
        end
    end

    -- clear the screen with the x button (button 5)
    if btnp(5) then
        cls()
    end
end

function _draw()
    -- draw pixel if 🅾️ button is held
    if btn(4) and not btn(3) then
        pset(x, y, draw_color)
    end

    -- draw cursor at current position
    circ(x, y, 1, draw_color)
end

__gfx__
00000000000000000001000000000000000000000000000000000000000007000bb00b0000000000000000000000000000000000000000000000000000000000
00000000004000000111110099900990111110000030300000000000000077700b0b0b0000000000000000000000000000000000000000000000000000000000
0070070000000400100000000090099910010100003303000eeee000000700700bbbbb0000000000000000000000000000000000000000000000000000000000
000770000000000010011100090000990011110000333030e00eee0000770700bbbbbbbb00000000000000000000000000000000000000000000000000000000
000770000000000010100100999999900011110000300030e00e0e0000777700bb0bbbb000000000000000000000000000000000000000000000000000000000
007007000040400010001000999999001011110000333330e0000ee0007770000bbbbb0000000000000000000000000000000000000000000000000000000000
000000000000000011110000090099001111110000000000e000ee00000000000000b00000000000000000000000000000000000000000000000000000000000
000000000000000000000000009990001110000000000000eeee0000000000000000000000000000000000000000000000000000000000000000000000000000
