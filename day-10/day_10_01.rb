# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)
# INPUT = IO.readlines('test_input.txt', chomp: true)

commands = INPUT.map(&:split)

strengths = []
x = 1
i = 0
commands.each do |el|
  case el[0]
  when 'noop'
    i += 1
    strengths << (i * x) if i % 20 == 0
  when 'addx'
    2.times do
      i += 1
      strengths << (i * x) if i % 20 == 0
    end
    x += el[1].to_i
  end
end

# The * is to pass an array as argument
p strengths.values_at(* strengths.each_index.select { |i| i.even? }).sum
