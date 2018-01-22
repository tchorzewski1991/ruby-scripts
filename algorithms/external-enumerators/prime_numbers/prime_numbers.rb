require 'benchmark/ips'
require 'prime'

module PrimeNumbers
  # PrimeNumbers#first returns array with first n prime numbers.
  # It uses external enumerator. Enumeration is based on trial-division
  # approach.
  #
  # Example: Returns array with first n prime numbers
  #
  #   PrimeNumbers.first(2)
  #   => [2, 3]
  #
  # Example: Returns array with first n prime numbers with additional
  #          transformation specified by code block.
  #
  #   PrimeNumbers.first(3) do |enum|
  #     enum.select { |prime| prime > 2 }
  #   end
  #   => [3, 5]

  def self.first(n)
    enum = Enumerator.new do |yielder|
      primes = []
      found = 0
      candidate = 2

      while found <= n
        boundary = Math.sqrt(candidate)

        divisable = false

        i = 0

        while prime = primes[i] and prime <= boundary
          break(divisable = true) if candidate % prime == 0
          i += 1
        end

        divisable || begin
          yielder << candidate
          primes << candidate
          found += 1
        end

        candidate += 1
      end
    end

    block_given? ? yield(enum) : enum.first(n)
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
#     PrimeNumbers.first(n)
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
#     PrimeNumbers.first(n)
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
