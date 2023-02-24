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

PATHS = []

def pathfind(path)
  cur_pos = PATHS.empty ? START.dup : path.last
  # Top
  destination = { val: VALUES[cur_pos[:y] - 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] - 1 }
  PATHS << path.dup.append(destination) if check_next(destination) # Create new path with the destination

  # Right
  destination = { val: INPUT[@cur_pos[:y]][@cur_pos[:x] + 1], x: @cur_pos[:x] + 1, y: @cur_pos[:y] }
  PATHS << path.dup.append(destination) if check_next(destination)

  # Bottom
  destination = { val: INPUT[@cur_pos[:y] + 1][@cur_pos[:x]], x: @cur_pos[:x], y: @cur_pos[:y] + 1 }
  PATHS << path.dup.append(destination) if check_next(destination)

  # Left
  destination = { val: INPUT[@cur_pos[:y]][@cur_pos[:x] - 1], x: @cur_pos[:x] - 1, y: @cur_pos[:y] }
  PATHS << path.dup.append(destination) if check_next(destination)

  # This path is destroyed after those 4 steps
  PATHS.delete(path)
end

def check_next(destination)
  # Destination value exists, is up to 1 higher than current position and has not been visited yet
  !destination[:val].nil? &&
    cur_pos[:val] >= destination[:val] - 1 &&
    PATHS.none? { |path| path.include?(destination) }
end

p START
p GOAL
p VALUES
