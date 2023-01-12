# frozen_string_literal: true

# INPUT = IO.readlines('input.txt', chomp: true)
INPUT = open('test_input.txt').read
#divide by three

class Monkey
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

  def initialize(i, o, t, tr, fa)
    @items = i || []
    @operation = o
    @test = t
    @monkey_if_true = tr
    @monkey_if_false = fa
  end

  def self.all
    @monkeys
  end

  def self.inspect
    20.times do
      @monkeys.each do |monkey|
        @items.each do |item|
          # Transform the '+' into +
          item = item.public_send(@peration.first, @operation.last == 'old' ? item : @operation.last.to_i)
          item /= 3
          (item % @test).zero? ? @monkeys[@monkey_if_true] << @items.shift : @monkeys[@monkey_if_false] << @items.shift
        end
      end
    end
  end

end

INPUT.dup.split(/\n\n/).each do |monkey_data|
  Monkey.parse(monkey_data)
end

# Monkey.inspect

p Monkey.all

# Monkey 0:
#   Starting items: 79, 98
#   Operation: new = old * 19
#   Test: divisible by 23
#     If true: throw to monkey 2
#     If false: throw to monkey 3
