# frozen_string_literal: true

INPUT = open('input.txt').read

array = INPUT.dup.split(/\n/)
array.map!(&:split)

opponent_score = 0
my_score = 0

array_op = %w[A B C]
array_me = %w[X Y Z]

array.each do |e|
  case e.last
  when 'X' then my_score += 1 + (array_op.index(e.first) - 1) % 3
  when 'Y' then my_score += 4 + array_op.index(e.first)
  when 'Z' then my_score += 7 + (array_op.index(e.first) + 1) % 3
  end
end

p my_score
