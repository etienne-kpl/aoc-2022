# frozen_string_literal: true

array_letters = ('a'..'z').to_a + ('A'..'Z').to_a

INPUT = open('input.txt').read

array = INPUT.dup.split(/\n/)
splited = array.map { |e| [e[0...e.size/2], e[e.size/2...e.size]]}

reduced = splited.each do |pair|
  pair.first.each_char { |char| pair.last.include? char }
end

p array
