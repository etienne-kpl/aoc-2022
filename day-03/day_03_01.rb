# frozen_string_literal: true

array_letters = ('a'..'z').to_a + ('A'..'Z').to_a

INPUT = open('input.txt').read

array = INPUT.dup.split(/\n/)
splited = array.map { |e| [e[0...e.size/2], e[e.size/2...e.size]]}

def find_double(pair)
  double = ''
  pair.first.each_char do |char|
    double = char if pair.last.include? char
  end
  return double
end

reduced = splited.map do |pair|
  1 + array_letters.index(find_double(pair))
end

p reduced.sum
