# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)
# INPUT = %w[30373 25512 65332 33549 35390]

scores = []
INPUT.dup.each_with_index do |row, row_i|
  row.each_char.with_index do |char, char_i|
    t = 0
    r = 0
    b = 0
    l = 0

    unless row_i.zero?
      INPUT[0...row_i].reverse.each do |r|
        t += 1
        break if r[char_i].to_i >= char.to_i
      end
    end

    unless char_i == (row.size - 1)
      row[(char_i + 1)...row.size].each_char do |c|
        r += 1
        break if c.to_i >= char.to_i
      end
    end

    unless row_i == (INPUT.size - 1)
      INPUT[(row_i + 1)...INPUT.size].each do |r|
        b += 1
        break if r[char_i].to_i >= char.to_i
      end
    end

    unless char_i.zero?
      row[0...char_i].reverse.each_char do |c|
        l += 1
        break if c.to_i >= char.to_i
      end
    end
    scores << (t * r * b * l)
  end
end

p scores
p scores.max
