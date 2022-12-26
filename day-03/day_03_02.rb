# frozen_string_literal: true

array_letters = ('a'..'z').to_a.concat(('A'..'Z').to_a)

INPUT = open('input.txt').read

array = INPUT.dup.split(/\n/)

groups = array.each_slice(3).to_a

badges = groups.map do |group|
  badge = ''
  group.first.each_char do |char|
    badge = char if (group[1].include? char) && (group[2].include? char)
  end
  badge
end

score = badges.map do |letter|
  1 + array_letters.index(letter)
end.sum

p score
