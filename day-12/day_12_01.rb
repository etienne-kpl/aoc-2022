# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)
# INPUT = IO.readlines('test_input.txt', chomp: true)

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
  # Destination is reachable on current position and has not been visited yet
  cur_pos[:val] >= (destination[:val] - 1) && PATHS.none? { |path| path.include?(destination) }
end

def pathfind(path)
  cur_pos = path.last
  x = cur_pos[:x]
  y = cur_pos[:y]
  destinations = []
  # Top
  destinations << { val: VALUES[y - 1][x], x: x, y: y - 1 } if y.positive?
  # Right
  destinations << { val: VALUES[y][x + 1], x: x + 1, y: y } if VALUES[y].size > x + 1
  # Bottom
  destinations << { val: VALUES[y + 1][x], x: x, y: y + 1 } if VALUES.size > y + 1
  # Left
  destinations << { val: VALUES[y][x - 1], x: x - 1, y: y } if x.positive?

  destinations.each { |d| PATHS << path.dup.append(d) if check_next(d, cur_pos) }
end

until PATHS.any? { |path| path.include?(GOAL) }
  # Sorted by shortest, closest and higher
  PATHS.sort_by! { |path| [path.size, (GOAL[:x] - path.last[:x]).abs + (GOAL[:y] - path.last[:y]).abs, -path.last[:val]] }
  # Taking the optimal path
  pathfind(PATHS.first)
  # Deleting it after the pathfinding to keep it clean
  PATHS.shift
end

p START
p GOAL
# p VALUES
score = PATHS.dup.select do |path|
  path.include?(GOAL)
end
p score.map(&:size).min - 1
