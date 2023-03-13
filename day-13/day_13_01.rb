# frozen_string_literal: true
require 'json'

INPUT = IO.read('test_input.txt').split(/\n\n/).map do |pair|
  l, r = pair.split(/\n/)
  { l: JSON.parse(l), r: JSON.parse(r) }
end

def compare(pair)
  p pair
  if pair.all? { |el| el.is_a? Array }
    pair.first.zip(pair.last).each do |new_pair|
      # Must find a stop here
      compare(new_pair)
    end
  elsif pair.all? { |el| el.is_a?(Integer) } && pair.first < pair.last
    return 0
  elsif pair.all? { |el| el.is_a?(Integer) } && pair.first > pair.last
    return 2
  elsif pair.all? { |el| el.is_a?(Integer) }
    return 1
  elsif pair.last.nil?
    return 2
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
  packet[:l].zip(packet[:r]).each do |pair|
    case compare(pair)
    when 0
      count += (index + 1)
      break
    when 1
      next
    when 2
      break
    end
  end
end

p count
