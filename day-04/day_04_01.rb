# frozen_string_literal: true

INPUT = open('input.txt').read

pairs = INPUT.dup.split(/\n/).map { |e| e.split(',')}.map { |e| e.map { |e| e.split('-').map(&:to_i) } }
pairs.map! do |e|
  {
    elf1: e.first.first..e.first.last,
    elf2: e.last.first..e.last.last
  }
end
  p pairs.first(3)
