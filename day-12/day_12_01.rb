# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = IO.readlines('test_input.txt', chomp: true)

start, goal = {}
INPUT.each_with_index do |line, index|
  line.each_char.with_index do |c, i|
    start = {val: 'a', x: i, y: index} if c == 'S'
    goal = {val: 'z', x: i, y: index} if c == 'E'
  end
end

cur_pos = start
moves = [cur_pos.dup]

def check_next(destination)
  alpha = ('a'..'z').to_a
  !destination[:val].nil? &&
  alpha.index(cur_pos[:val]) <= alpha.index(destination[:val]) - 1 &&
  !moves.include?(destination)
end

def move_to(destination)
  moves << destination
  cur_pos = destination
end

# Randomize selection ?
random_dest = %w[top right bottom left]

until cur_pos == goal do
  # Top
  destination = {val: INPUT[cur_pos[:y] - 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] - 1}
  if check_next(destination)
    move_to(destination)
  else
    # Right
    destination = {val: INPUT[cur_pos[:y]][cur_pos[:x] + 1], x: cur_pos[:x] + 1, y: cur_pos[:y]}
    if check_next(destination)
      move_to(destination)
    else
      # Bottom
      destination = {val: INPUT[cur_pos[:y] + 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] + 1}
      if check_next(destination)
        move_to(destination)
      else
        # Left
        destination = {val: INPUT[cur_pos[:y]][cur_pos[:x] - 1], x: cur_pos[:x] - 1, y: cur_pos[:y]}
        if check_next(destination)
          move_to(destination)
        else
          # If I can't move to anything then we start again from beginning
          cur_pos = start
          moves = [cur_pos.dup]
        end
      end
    end
  end
  break
end

p start
p goal
p moves
