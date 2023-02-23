# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = IO.readlines('test_input.txt', chomp: true).map.with_index do |line, index|
  line.chars.map.with_index do |c, i|
    case c
    when 'S'
      START = { x: i, y: index }.freeze
      1
    when 'E'
      GOAL = { x: i, y: index }.freeze
      26
    else
      ('a'..'z').to_a.index(c) + 1
    end
  end
end

move_set = []
cur_pos = START.dup

def pathfind
  # Top
  destination = { x: cur_pos[:x], y: cur_pos[:y] - 1 }
  if check_next(destination)
    move_to(destination)
    destroy_dup(destination)
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

# class Path
#   @@all = []
#   def initialize(moves = [], cur_pos = START)
#     @moves = moves
#     @cur_pos = cur_pos
#     @@all << self
#   end

#   def self.all
#     @@all
#   end

#   def check_next(destination)
#     !destination[:val].nil? &&
#     ALPHA.index(@cur_pos[:val]) <= (ALPHA.index(destination[:val]) - 1) &&
#     !@moves.include?(destination)
#   end

#   def move_to(destination)
#     Path.new(moves: @moves.append(destination), cur_pos: destination)
#   end

#   def destroy_dup(destination)
#     Path.all.each do |path|
#       if path.moves.include?(destination) && path.moves.size >= @moves.size
#         path.destroy
#       end
#     end
#   end

#   def pathfind
#     # Top
#     destination = {val: INPUT[@cur_pos[:y] - 1][@cur_pos[:x]], x: @cur_pos[:x], y: @cur_pos[:y] - 1}
#     if check_next(destination)
#       move_to(destination)
#       destroy_dup(destination)
#     end
#     # Right
#     destination = {val: INPUT[@cur_pos[:y]][@cur_pos[:x] + 1], x: @cur_pos[:x] + 1, y: @cur_pos[:y]}
#     if check_next(destination)
#       move_to(destination)
#       destroy_dup(destination)
#     end
#     # Bottom
#     destination = {val: INPUT[@cur_pos[:y] + 1][@cur_pos[:x]], x: @cur_pos[:x], y: @cur_pos[:y] + 1}
#     if check_next(destination)
#       move_to(destination)
#       destroy_dup(destination)
#     end
#     # Left
#     destination = {val: INPUT[@cur_pos[:y]][@cur_pos[:x] - 1], x: @cur_pos[:x] - 1, y: @cur_pos[:y]}
#     if check_next(destination)
#       move_to(destination)
#       destroy_dup(destination)
#     end
#     # I self destroy after those 4 steps
#     destroy
#   end
# end

p START
p GOAL
p INPUT
