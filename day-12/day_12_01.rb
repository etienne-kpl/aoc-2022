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
  # Destination value exists, is reachable on current position, is inside the grid and has not been visited yet
  !destination[:val].nil? &&
    destination[:y] >= 0 &&
    destination[:x] >= 0 &&
    cur_pos[:val] >= (destination[:val] - 1) &&
    PATHS.none? { |path| path.include?(destination) }
end

def pathfind(path)
  cur_pos = path.last
  priority = [
    { val: VALUES[cur_pos[:y] - 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] - 1 }, # Top
    { val: VALUES[cur_pos[:y]][cur_pos[:x] + 1], x: cur_pos[:x] + 1, y: cur_pos[:y] }, # Right
    { val: VALUES[cur_pos[:y]][cur_pos[:x] - 1], x: cur_pos[:x] - 1, y: cur_pos[:y] } # Left
  ]
  # Bottom (needs a check because of the [cur_pos[:y] + 1][cur_pos[:x]] -> the first part can be nil)
  unless cur_pos[:y] + 1 >= VALUES.size
    priority << { val: VALUES[cur_pos[:y] + 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] + 1 }
  end
  priority.sort_by! do |destination|
    (GOAL[:x] - destination[:x]).abs + (GOAL[:y] - destination[:y]).abs
  end
  priority.each { |destination| PATHS << path.dup.append(destination) if check_next(destination, cur_pos) }

  # This path is destroyed after those 4 steps
  PATHS.delete(path)
  PATHS.sort_by! { |el| (GOAL[:x] - el.last[:x]).abs + (GOAL[:y] - el.last[:y]).abs }
end

until PATHS.any? { |path| path.include?(GOAL) }
  PATHS.each { |path| pathfind(path) }
end

p START
p GOAL
# p VALUES
score = PATHS.dup.select do |path|
  path.include?(GOAL)
end
p score.map(&:size).min - 1
