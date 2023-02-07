# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = IO.readlines('test_input.txt', chomp: true)

start = []
goal = []
INPUT.each_with_index do |line, index|
  line.each_char.with_index do |c, i|
    start = [index, i] if c == 'S'
    goal = [index, i] if c == 'E'
  end
end


p start
p goal
