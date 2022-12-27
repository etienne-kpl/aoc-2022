# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

p INPUT
array_right = []
INPUT.dup.each do |el|
  a = []
  el.each_char.with_index do |char|
    a << el[0]
    index = 1
    while el[index].to_i > el[index - 1].to_i && index <= el.size do
      a << char
      index += 1
    end
  end
  array_right << a
end

p array_right
