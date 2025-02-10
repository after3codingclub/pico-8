-- Pico-8 Text Adventure with Sprites and Backgrounds
-- Define the initial state
player = {
  location = "start",
  x = 64,
  y = 64,
  sprite = 1
}

-- Game map with descriptions, choices, and background sprites
rooms = {
  start = {
    description = "You are standing at the entrance of a dark cave. There is a path leading north.",
    background_sprite = 16,
    choices = {
      { text = "Go north", destination = "cave_entrance" }
    }
  },

  cave_entrance = {
    description = "The cave entrance is damp and eerie. You hear distant echoes. Paths lead north and south.",
    background_sprite = 17,
    choices = {
      { text = "Go north", destination = "deep_cave" },
      { text = "Go south", destination = "start" }
    }
  },

  deep_cave = {
    description = "The cave is pitch black. You feel a cold draft. The only path is back south.",
    background_sprite = 18,
    choices = {
      { text = "Go south", destination = "cave_entrance" }
    }
  }
}

-- Draw the room background, description, and choices
function draw_room()
  cls()
  local room = rooms[player.location]

  -- Draw background sprite
  map(room.background_sprite % 16, flr(room.background_sprite / 16), 0, 0, 16, 16)

  -- Display room text
  print(room.description, 1, 1, 7)
  for i, choice in ipairs(room.choices) do
    print(i..". "..choice.text, 1, 8 + i * 8, 6)
  end

  -- Draw player sprite
  spr(player.sprite, player.x, player.y)
end

-- Handle player input for navigation and selection
function update_game()
  -- Arrow key movement
  if btn(0) then player.x = max(0, player.x - 2) end -- Left
  if btn(1) then player.x = min(120, player.x + 2) end -- Right
  if btn(2) then player.y = max(0, player.y - 2) end -- Up
  if btn(3) then player.y = min(120, player.y + 2) end -- Down

  -- Button inputs for choices
  if btnp(4) then select_choice(1) end -- Z
  if btnp(5) then select_choice(2) end -- X
end

function select_choice(choice_index)
  local room = rooms[player.location]
  local choice = room.choices[choice_index]
  if choice then
    player.location = choice.destination
    player.x = 64
    player.y = 64
  end
end

-- Main game loop
function _update()
  update_game()
end

function _draw()
  draw_room()
end
