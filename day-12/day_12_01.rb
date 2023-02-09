# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = IO.readlines('test_input.txt', chomp: true)

START, GOAL = {}
INPUT.each_with_index do |line, index|
  line.each_char.with_index do |c, i|
    START = {val: 'a', x: i, y: index} if c == 'S'
    GOAL = {val: 'z', x: i, y: index} if c == 'E'
  end
end

ALPHA = ('a'..'z').to_a
cur_pos = START
moves = [cur_pos.dup]

def check_next(destination)
  !destination[:val].nil? &&
  ALPHA.index(cur_pos[:val]) <= ALPHA.index(destination[:val]) - 1 &&
  !moves.include?(destination)
end

def move_to(destination)
  moves << destination
  cur_pos = destination
end

class Path
  def initialize(moves = [])
    @moves = moves
    @cur_pos = START
  end

  def check_next(destination)
    !destination[:val].nil? &&
    ALPHA.index(@cur_pos[:val]) <= ALPHA.index(destination[:val]) - 1 &&
    !@moves.include?(destination)
  end

  def move_to(destination)
    @moves << destination
    @cur_pos = destination
  end

  def destroy_dup(destination)
    Path.all.each do |path|
      if path.moves.include?(destination)
        if path.moves.size > @moves
          path.destroy
        else
          self.destroy
        end
      end
    end
  end

  def pathfind
    until @cur_pos == GOAL do
      # Top
      destination = {val: INPUT[@cur_pos[:y] - 1][@cur_pos[:x]], x: @cur_pos[:x], y: @cur_pos[:y] - 1}
      if check_next(destination)
        move_to(destination)
        destroy_dup(destination)
      else
        # Right
        destination = {val: INPUT[@cur_pos[:y]][@cur_pos[:x] + 1], x: @cur_pos[:x] + 1, y: @cur_pos[:y]}
        if check_next(destination)
          destroy_dup(destination)
          move_to(destination)
        else
          # Bottom
          destination = {val: INPUT[@cur_pos[:y] + 1][@cur_pos[:x]], x: @cur_pos[:x], y: @cur_pos[:y] + 1}
          if check_next(destination)
            destroy_dup(destination)
            move_to(destination)
          else
            # Left
            destination = {val: INPUT[@cur_pos[:y]][@cur_pos[:x] - 1], x: @cur_pos[:x] - 1, y: @cur_pos[:y]}
            if check_next(destination)
              destroy_dup(destination)
              move_to(destination)
            else
              # If I can't move to anything then we start again from beginning
              self.destroy
            end
          end
        end
      end
    end
  end
end

p START
p GOAL
p moves
