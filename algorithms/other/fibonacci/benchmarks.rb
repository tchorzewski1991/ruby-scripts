require 'benchmark/ips'

require_relative './recursive.rb'
require_relative './memoized.rb'
require_relative './iterative.rb'
require_relative './folding/mutation.rb'
require_relative './folding/reassignment.rb'
require_relative './hash.rb'

module Fibonacci
  module Benchmarks
    extend self

    def execute
      ::Benchmark.ips do |x|
        x.report 'Recursive' do
          Fibonacci::Recursive.compute(40)
        end

        x.report 'Memoized' do
          Fibonacci::Memoized.compute(40)
        end

        x.report 'Iterative' do
          Fibonacci::Iterative.compute(40)
        end

        x.report 'Folding - Mutation' do
          Fibonacci::Folding::Mutation.compute(40)
        end

        x.report 'Folding - Reassignment' do
          Fibonacci::Folding::Reassignment.compute(40)
        end

        x.report 'Hash' do
          Fibonacci::Hash.compute(40)
        end

        x.compare!
      end
    end
  end
end

#
# Calculating --------------------------------------------------------------
# Recursive               0.052  (± 0.0%)   i/s -       1.000  in  19.323509s
# Memoized                3.825M (± 7.5%)   i/s -     19.056M in   5.012021s
# Iterative               224.563k (± 4.8%) i/s -      1.136M in   5.071475s
# Folding - Mutation      138.958k (± 4.4%) i/s -    706.365k in   5.093485s
# Folding - Reassignment  148.923k (± 5.1%) i/s -    743.380k in   5.005356s
# Hash                    64.986k (± 5.6%)  i/s -    327.288k in   5.052694s
#
# Comparison:
# Memoized:                 3825329.6 i/s
# Iterative:                 224563.2 i/s - 17.03x  slower
# Folding - Reassignment:    148922.7 i/s - 25.69x  slower
# Folding - Mutation:        138958.4 i/s - 27.53x  slower
# Hash:                       64986.2 i/s - 58.86x  slower
# Recursive:                      0.1 i/s - 73918790.03x  slower
