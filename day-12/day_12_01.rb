# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = IO.readlines('test_input.txt', chomp: true)

INPUT.each_with_index do |line, index|
  line.each_char.with_index do |c, i|
    START = {val: 'a', x: i, y: index} if c == 'S'
    GOAL = {val: 'z', x: i, y: index} if c == 'E'
  end
end

ALPHA = ('a'..'z').to_a
class Path
  @@all = []
  def initialize(moves = [], cur_pos = START)
    @moves = moves
    @cur_pos = cur_pos
    @@all << self
  end

  def self.all
    @@all
  end

  def check_next(destination)
    !destination[:val].nil? &&
    ALPHA.index(@cur_pos[:val]) <= (ALPHA.index(destination[:val]) - 1) &&
    !@moves.include?(destination)
  end

  def move_to(destination)
    Path.new(moves: @moves.append(destination), cur_pos: destination)
  end

  def destroy_dup(destination)
    Path.all.each do |path|
      if path.moves.include?(destination) && path.moves.size >= @moves.size
        path.destroy
      end
    end
  end

  def pathfind
    # Top
    destination = {val: INPUT[@cur_pos[:y] - 1][@cur_pos[:x]], x: @cur_pos[:x], y: @cur_pos[:y] - 1}
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
    self.destroy
  end
end

p START
p GOAL
until Path.all.any? { |path| path.cur_pos == GOAL } do
  Path.all.each do |path|
    path.pathfind
  end
end
Path.all.each do |path|
  p path.moves.size
end
