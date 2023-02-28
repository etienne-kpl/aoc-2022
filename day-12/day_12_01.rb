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
  # Destination is reachable on current position and has not been visited yet
  cur_pos[:val] >= (destination[:val] - 1) && PATHS.none? { |path| path.include?(destination) }
end

def pathfind(path)
  cur_pos = path.last
  x = cur_pos[:x]
  y = cur_pos[:y]
  priority = []
  # Top
  priority << { val: VALUES[y - 1][x], x: x, y: y - 1 } if y.positive?
  # Right
  priority << { val: VALUES[y][x + 1], x: x + 1, y: y } if VALUES[y].size > x + 1
  # Bottom
  priority << { val: VALUES[y + 1][x], x: x, y: y + 1 } if VALUES.size > y + 1
  # Left
  priority << { val: VALUES[y][x - 1], x: x - 1, y: y } if x.positive?

  priority.sort_by! do |destination|
    # Sorted by closest and higher
    [(GOAL[:x] - destination[:x]).abs + (GOAL[:y] - destination[:y]).abs, cur_pos[:val] - destination[:val]]
  end
  priority.each { |destination| PATHS << path.dup.append(destination) if check_next(destination, cur_pos) }

  # This path is destroyed after those 4 steps
  PATHS.delete(path)
end

until PATHS.any? { |path| path.include?(GOAL) }
  PATHS.each { |path| pathfind(path) }
  # PATHS.sort_by! { |path| (GOAL[:x] - path.last[:x]).abs + (GOAL[:y] - path.last[:y]).abs }
end

p START
p GOAL
# p VALUES
score = PATHS.dup.select do |path|
  path.include?(GOAL)
end
p score.map(&:size).min - 1
