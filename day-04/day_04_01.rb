# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)

pairs = INPUT.dup.map do |el|
  regexp = /(\d+)-(\d+),(\d+)-(\d+)/
  [regexp.match(el)[1].to_i..regexp.match(el)[2].to_i, regexp.match(el)[3].to_i..regexp.match(el)[4].to_i]
end

overlaps_total = pairs.select do |el|
  el.first === el.last.first && el.first === el.last.last ||
  el.last === el.first.first && el.last === el.first.last
end

overlaps_partial = pairs.select do |el|
  el.first === el.last.first || el.first === el.last.last ||
  el.last === el.first.first || el.last === el.first.last
end

p overlaps_partial.size
