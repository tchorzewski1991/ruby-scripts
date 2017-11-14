require 'benchmark/ips'
require 'prime'

module PrimeNumbers
  extend self

  # PrimeNumbers#compute creates enumerator that allows you for computation of
  # first n-th prime numbers. Returning enumerator instead of enumeration is
  # just an implementation detail and could be easily expanded with implicit
  # block argument.

  # Example: Basic usage
  #   Returns enum for n first prime numbers
  #
  #   PrimeNumbers.compute(3)
  #   => #<Enumerator: (...):each>
  #
  #   PrimeNumbers.compute(3).first(2)
  #   => [2, 3]
  #
  # Example: With block of code for additional transformation
  #   Returns result of enumeration for first n prime numbers
  #
  #   PrimeNumbers.compute(3) do |enum|
  #     enum.select { |prime| prime > 2 }
  #   end
  #   => [3, 5]

  def compute(n)
    enum = Enumerator.new do |yielder|
      yielder << 2
      primes = [2]
      found = 1

      candidate = 3

      while true
        i = 0

        divisable = false

        boundary = Math.sqrt(candidate)

        while true
          prime = primes[i]

          break(divisable = true) if candidate % prime == 0
          break if prime >= boundary
          i += 1
        end

        divisable || begin
          yielder << candidate
          primes << candidate
          found += 1
        end

        break if found == n

        candidate += 1
      end
    end

    block_given? && yield(enum) || enum
  end
end

# I suppose that those benchmarks are quite satisfying if taken into account
# thats only 50 lines of code. Original Prime library has lots of additional
# improvements just like caching for example, or hardcoded small n-th primes.
# This possibly could be one of the reason of slower computations.
# Please welcome to contribute if you recognize some bugs or significant
# improvements :)

# Benchmark.ips do |x|
#   n = 10
#
#   x.report 'Prime' do
#     Prime::TrialDivisionGenerator.new.first(n)
#   end
#
#   x.report 'PrimeNumbers' do
#     PrimeNumbers.compute(n).first(n)
#   end
#
#   x.compare!
# end
#
# Benchmark.ips do |x|
#   n = 100
#
#   x.report 'Prime' do
#     Prime::TrialDivisionGenerator.new.first(n)
#   end
#
#   x.report 'PrimeNumbers' do
#     PrimeNumbers.compute(n).first(n)
#   end
#
#   x.compare!
# end

#
# Calculating -------------------------------------
#                Prime    261.634k (± 4.0%) i/s -      1.330M in   5.093276s
#         PrimeNumbers     80.773k (± 3.7%) i/s -    407.316k in   5.050198s
#
# Comparison:
#                Prime:   261633.6 i/s
#         PrimeNumbers:    80773.1 i/s - 3.24x  slower
#
# Warming up --------------------------------------
#                Prime     3.656k i/100ms
#         PrimeNumbers   499.000  i/100ms
# Calculating -------------------------------------
#                Prime     35.798k (± 7.8%) i/s -    179.144k in   5.038630s
#         PrimeNumbers      5.018k (± 5.3%) i/s -     25.449k in   5.086792s
#
# Comparison:
#                Prime:    35798.2 i/s
#         PrimeNumbers:     5017.9 i/s - 7.13x  slower
