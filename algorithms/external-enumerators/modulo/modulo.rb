require 'benchmark/ips'

module Modulo
  extend self

  # Modulo#compute creates enumeration that allows you for computation of
  # first j-th numbers where each of number satisfies modulo equation
  # operation for given i number.

  # Example: Basic usage
  #   Returns first j numbers where number % i equals to 0.
  #
  #   Modulo.compute 2, 3
  #   => [2, 4, 6]
  #
  # Example: With custom rest of modulo computation
  #   Returns first j numbers where number % i equals to r
  #
  #   Modulo.compute 2, 3, r: 1
  #   => [1, 3, 5]

  def compute(i, j, opts = {})
    r = opts.fetch(:r, 0)

    enum = Enumerator.new do |yielder|
      k = 1
      found = 0

      while true
        next(k += 1) unless k % i == r

        found += 1
        yielder << k

        break if found == j
        k += 1
      end
    end

    enum.to_a
  end
end

# I am not pretty sure if is it possible to compute this easily and efficient
# with common usage of ruby language features. I took into account there might
# be a better solution than my. Please, welcome to contribute and compare your
# own solution.

def compute(i, j, opts = {})
  r = opts.fetch(:r, 0)
  enum = (1..Float::INFINITY).each

  0.upto(j).each_with_object([]) do |_, memo|
    while (k = enum.next) % i == r
      memo << k
    end
  end
end

Benchmark.ips do |x|
  p 'Small number of computations'

  x.report 'Modulo.compute' do
    Modulo.compute(2, 8)
  end

  x.report 'Standard approach' do
    compute(2, 8)
  end

  x.compare!
end

Benchmark.ips do |x|
  p 'Large number of computations'

  x.report 'Modulo.compute' do
    Modulo.compute(7, 100)
  end

  x.report 'Standard approach' do
    compute(7, 100)
  end

  x.compare!
end

# "Small number of computations"
# Calculating -------------------------------------
#    Modulo.compute       164.979k (± 6.6%) i/s -    821.394k in   5.001877s
#    Standard approach     15.333k (± 5.8%) i/s -     77.539k in   5.075148s
#
# Comparison:
#    Modulo.compute:     164979.3 i/s
#    Standard approach:   15332.9 i/s - 10.76x  slower
#
# "Large number of computations"
# Calculating -------------------------------------
#    Modulo.compute        17.550k (± 6.2%) i/s -     88.485k in   5.062319s
#    Standard approach      2.380k (± 5.8%) i/s -     12.005k in   5.062469s
#
# Comparison:
#    Modulo.compute:       17549.6 i/s
#    Standard approach:     2379.6 i/s - 7.37x  slower
