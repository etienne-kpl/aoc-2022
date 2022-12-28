# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

counter = 0
INPUT.dup.each_with_index do |row, row_i|
  row.each_char.with_index do |char, char_i|
    if row_i.zero? ||
       INPUT[0...row_i].all? { |r| char.to_i > r[char_i].to_i } ||
       char_i == row.size - 1 ||
       row[(char_i + 1)...row.size].each_char.all? { |c| char.to_i > c.to_i } ||
       row_i == INPUT.size - 1 ||
       INPUT[(row_i + 1)...INPUT.size].all? { |r| char.to_i > r[char_i].to_i } ||
       char_i.zero? ||
       row[0...char_i].each_char.all? { |c| char.to_i > c.to_i }
      counter += 1
    end
  end
end
p counter
