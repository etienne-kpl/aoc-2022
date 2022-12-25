# frozen_string_literal: true

INPUT = open('input.txt').read

array = INPUT.dup.split(/\n/)
array.map!(&:split)

my_score = 0

array_op = %w[A B C]
array_me = %w[X Y Z]

array.each do |e|
  my_score += array_me.index(e.last) + 1
  outcome = array_op.index(e.first) - array_me.index(e.last)
  case outcome
  when 0 then my_score += 3
  when -1 then my_score += 6
  when 2 then my_score += 6
  end
end

p my_score
