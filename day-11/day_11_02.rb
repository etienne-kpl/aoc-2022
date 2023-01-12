# frozen_string_literal: true

# INPUT = open('input.txt').read
INPUT = open('test_input.txt').read

class Monkey
  attr_reader :ope, :test, :if_true, :if_false
  attr_accessor :items, :count

  @monkeys = {}
  def self.parse(monkey_data)
    n, i, o, t, tr, fa = monkey_data.split(/\n/)
    n = /(\d+)/.match(n)[1].to_i
    i = i.scan(/\d+/).map(&:to_i)
    o = o.split('= old').last.split(' ')
    t = /(\d+)/.match(t)[1].to_i
    tr = /(\d+)/.match(tr)[1].to_i
    fa = /(\d+)/.match(fa)[1].to_i
    @monkeys[n] = Monkey.new(i, o, t, tr, fa)
  end

  def initialize(i, o, t, tr, fa, c = 0)
    @items = i
    @ope = o
    @test = t
    @if_true = tr
    @if_false = fa
    @count = 0
  end

  def self.all
    @monkeys
  end

  def self.inspect
    @monkeys.each do |key, monkey|
      monkey.count += monkey.items.size
      monkey.items.map! do |item|
        item.send(monkey.ope.first, (monkey.ope.last == 'old' ? item : monkey.ope.last.to_i))
      end
      monkey.items.each do |item|
        (item % monkey.test).zero? ? (@monkeys[monkey.if_true].items << item) : (@monkeys[monkey.if_false].items << item)
      end
      monkey.items = []
    end
  end
end

INPUT.dup.split(/\n\n/).each do |monkey_data|
  Monkey.parse(monkey_data)
end

p Monkey.all

20.times do
  Monkey.inspect
end

top_two = Monkey.all.map { |key, monkey| monkey.count }.sort.last(2)
score = top_two.inject(:*)
p top_two
p score
