# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = IO.readlines('test_input.txt', chomp: true)

alpha = ('a'..'z').to_a

start, goal = {}
INPUT.each_with_index do |line, index|
  line.each_char.with_index do |c, i|
    start = {val: 'a', x: i, y: index} if c == 'S'
    goal = {val: 'z', x: i, y: index} if c == 'E'
  end
end

cur_pos = start
moves = [cur_pos.dup]
until cur_pos == goal do
  if alpha.index(cur_pos[:val]) <= alpha.index(DESTINATION) - 1
    moves << DESTINATION
    cur_pos = DESTINATION
  end
  break
end


p start
p goal
