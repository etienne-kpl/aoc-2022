# frozen_string_literal: true
require 'json'

INPUT = IO.read('test_input.txt').split(/\n\n/).map do |pair|
  l, r = pair.split(/\n/)
  { l: JSON.parse(l), r: JSON.parse(r) }
end

def compare(pair)
  p pair
  if pair.all? { |el| el.is_a? Array }
    pair.first.zip(pair.last).any? do |new_pair|
      compare(new_pair)
    end
  elsif pair.all? { |el| el.is_a?(Integer) || el.nil? }
    !pair.last.nil? && pair.first < pair.last
  elsif pair.first.is_a? Integer
    compare([[pair.first], pair.last])
  else
    compare([pair.first, [pair.last]])
  end
end

count = 0

INPUT.each_with_index do |packet, index|
  p count
  p ""
  packet[:l].zip(packet[:r]).any? do |pair|
    if compare(pair)
      count += (index + 1)
      break
    end
  end
end

p count
