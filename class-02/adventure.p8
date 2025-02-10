-- Pico-8 Text Adventure Example
-- Define the initial state
player = {
  location = "start"
}

-- Game map with descriptions and choices
rooms = {
  start = {
    description = "You are standing at the entrance of a dark cave. There is a path leading north.",
    choices = {
      { text = "Go north", destination = "cave_entrance" }
    }
  },

  cave_entrance = {
    description = "The cave entrance is damp and eerie. You hear distant echoes. Paths lead north and south.",
    choices = {
      { text = "Go north", destination = "deep_cave" },
      { text = "Go south", destination = "start" }
    }
  },

  deep_cave = {
    description = "The cave is pitch black. You feel a cold draft. The only path is back south.",
    choices = {
      { text = "Go south", destination = "cave_entrance" }
    }
  }
}

-- Draw the room description and choices
function draw_room()
  cls()
  local room = rooms[player.location]
  print(room.description, 1, 1, 7)

  for i, choice in ipairs(room.choices) do
    print(i..". "..choice.text, 1, 8 + i * 8, 6)
  end
end

-- Handle player input
function update_game()
  if (btnp(4)) then -- Button Z
    select_choice(1)
  elseif (btnp(5)) then -- Button X
    select_choice(2)
  end
end

function select_choice(choice_index)
  local room = rooms[player.location]
  local choice = room.choices[choice_index]
  if choice then
    player.location = choice.destination
  end
end

-- Main game loop
function _update()
  update_game()
end

function _draw()
  draw_room()
end
