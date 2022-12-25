# frozen_string_literal: true

INPUT = open('input.txt').read

array = INPUT.dup.split(/\n\n/)
array.map!(&:split)

sum = array.map do |e|
  e.map!(&:to_i)
  e.sum
end.sort

p sum.last
p sum.last(3).sum
