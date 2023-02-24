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

def pathfind
  # Top
  cur_pos = START.dup
  destination = { val: VALUES[cur_pos[:y] - 1][cur_pos[:x]], x: cur_pos[:x], y: cur_pos[:y] - 1 }
  if check_next(destination, cur_pos)
    moves << destination
    cur_pos = destination

  end
  # Right
  destination = {val: INPUT[@cur_pos[:y]][@cur_pos[:x] + 1], x: @cur_pos[:x] + 1, y: @cur_pos[:y]}
  if check_next(destination)
    move_to(destination)
    destroy_dup(destination)
  end
  # Bottom
  destination = {val: INPUT[@cur_pos[:y] + 1][@cur_pos[:x]], x: @cur_pos[:x], y: @cur_pos[:y] + 1}
  if check_next(destination)
    move_to(destination)
    destroy_dup(destination)
  end
  # Left
  destination = {val: INPUT[@cur_pos[:y]][@cur_pos[:x] - 1], x: @cur_pos[:x] - 1, y: @cur_pos[:y]}
  if check_next(destination)
    move_to(destination)
    destroy_dup(destination)
  end
  # I self destroy after those 4 steps
  destroy
end

def check_next(destination)
  !destination[:val].nil? && cur_pos[:val] <= destination[:val] - 1 && PATHS.none? { |path| path.include?(destination) }
end

# PATHS.each do |path|
#   PATHS.delete(path) if path.include?(destination) && path.size >= moves.size
# end

p START
p GOAL
p VALUES
