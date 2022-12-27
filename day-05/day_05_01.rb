# frozen_string_literal: true

INPUT = IO.readlines('input.txt', chomp: true)
crates_txt = INPUT.dup.first(8)
commands_txt = INPUT.dup[10..]

crates = {}
counter = 1
index = 1
while index <= crates_txt.first.size do
  crates[counter] = []
  crates_txt.reverse.each do |el|
    crates[counter] << el[index]
    crates[counter].delete(' ')
  end
  index += 4
  counter += 1
end

commands = commands_txt.map do |el|
  el.scan(/\d+/).map(&:to_i)
end

commands.each do |command|
  command[0].times do
    crates[command[2]] << crates[command[1]].pop
  end
end

final_crates = []
crates.each_key do |key|
  final_crates << crates[key].last
end

p final_crates.join
