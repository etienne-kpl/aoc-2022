# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = IO.readlines('test_input.txt', chomp: true)

VALUES = INPUT.dup.map.with_index do |line, index|
  line.chars.map.with_index do |c, i|
    case c
    when 'S'
      START = { val: 1, x: i, y: index }.freeze
      1
    when 'E'
      GOAL = { val: 26, x: i, y: index }.freeze
      26
    else
      ('a'..'z').to_a.index(c) + 1
    end
  end
end

PATHS = [[START.dup]]

def check_next(destination, cur_pos)
  # Destination value exists, is up to 1 higher than current position and has not been visited yet
  !destination[:val].nil? &&
    destination[:y] >= 0 &&
    destination[:x] >= 0 &&
    cur_pos[:val] >= (destination[:val] - 1) &&
    PATHS.none? { |path| path.include?(destination) }
end

def pathfind(path)
  cur_pos = path.last
  # Top
  destination = { val: VALUES[cur_pos[:y] - 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] - 1 }
  PATHS << path.dup.append(destination) if check_next(destination, cur_pos) # Create new path with the destination

  # Right
  destination = { val: VALUES[cur_pos[:y]][cur_pos[:x] + 1], x: cur_pos[:x] + 1, y: cur_pos[:y] }
  PATHS << path.dup.append(destination) if check_next(destination, cur_pos)

  # Bottom
  destination = { val: VALUES[cur_pos[:y] + 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] + 1 }
  PATHS << path.dup.append(destination) if check_next(destination, cur_pos)

  # Left
  destination = { val: VALUES[cur_pos[:y]][cur_pos[:x] - 1], x: cur_pos[:x] - 1, y: cur_pos[:y] }
  PATHS << path.dup.append(destination) if check_next(destination, cur_pos)

  # This path is destroyed after those 4 steps
  PATHS.delete(path)
end

PATHS.each { |path| pathfind(path) } until cur_pos == GOAL

p START
p GOAL
# p VALUES
p PATHS
