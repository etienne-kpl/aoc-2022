# frozen_string_literal: true

INPUT = open('input.txt').read
array = INPUT.dup.split(/\n/)

LETTERS = ('a'..'z').to_a + ('A'..'Z').to_a

splited = array.map { |e| [e[0...e.size / 2], e[e.size / 2...e.size]] }

doubles = splited.map do |e|
  e.first.each_char.to_a.intersection(e.last.each_char.to_a)
end.flatten

score = doubles.map { |e| 1 + LETTERS.index(e) }.sum

p score

# def find_double(pair)
#   double = ''
#   pair.first.each_char do |char|
#     double = char if pair.last.include? char
#   end
#   return double
# end

# reduced = splited.map do |pair|
#   1 + LETTERS.index(find_double(pair))
# end
