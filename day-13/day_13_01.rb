# frozen_string_literal: true
require 'json'

INPUT = IO.read('input.txt').split(/\n\n/).map do |pair|
  l, r = pair.split(/\n/)
  { l: JSON.parse(l), r: JSON.parse(r) }
end

count = 0

def compare(pair)
  p pair
  if pair.all? { |el| el.is_a? Array }
    # Adding nil to process the .zip until the end
    pair.first << nil while pair.first.size < pair.last.size
    pair.first.zip(pair.last).each do |new_pair|
      case compare(new_pair)
      when 0
        break 0
      when 1
        break 1
      end
    end
  elsif pair.all? { |el| el.is_a?(Integer) }
    if pair.first < pair.last
      0
    elsif pair.first > pair.last
      1
    end
  elsif pair.last.nil?
    1
  elsif pair.first.nil?
    0
  elsif pair.first.is_a? Integer
    compare([[pair.first], pair.last])
  else
    compare([pair.first, [pair.last]])
  end
end

INPUT.each_with_index do |packet, index|
  puts '------'
  puts "Pair #{index + 1}"
  count += (index + 1)
  packet[:l].zip(packet[:r]).each do |pair|
    case compare(pair)
    when 0
      puts 'OK'
      break
    when 1
      count -= (index + 1)
      puts 'WRONG'
      break
    end
  end
end

p count
