require 'benchmark/ips'

class Fibonacci
  class << self
    def recursive_fib(n)
      return 0 if n == 0
      return 1 if n == 1
      recursive_fib(n - 2) + recursive_fib(n - 1)
    end

    def memoized_fib(n)
      @_memo ||= { 0 => 0, 1 => 1 }
      @_memo[n] || @_memo[n] = memoized_fib(n - 2) + memoized_fib(n - 1)
    end

    def iterative_fib(n)
      i = 2
      memo = [0, 1]
      while i <= n
        memo[i] = memo[i - 2] + memo[i - 1]
        i += 1
      end
      memo.last
    end

    def folding_fib(n)
      2.upto(n).inject([0, 1]) do |memo, i|
        memo[i] = memo[-2] + memo[-1]
        memo
      end.last
    end
  end
end


Benchmark.ips do |x|
  x.report('pure - recursive    ') { Fibonacci.recursive_fib(40) }
  x.report('memoized - recursive') { Fibonacci.memoized_fib(40) }
  x.report('pure - iterative    ') { Fibonacci.iterative_fib(40) }
  x.report('fold - iterative    ') { Fibonacci.folding_fib(40) }
  x.compare!
end

# Calculating -------------------------------------
# pure - recursive          0.045  (± 0.0%) i/s -      1.000  in  22.386674s
# memoized - recursive      4.199M (± 8.8%) i/s -     20.828M in   5.002035s
# pure - iterative        203.194k (±10.4%) i/s -      1.006M in   5.009933s
# fold - iterative        134.339k (±10.6%) i/s -    671.577k in   5.062760s
#
# Comparison:
# memoized - recursive:  4198818.0 i/s
# pure - iterative    :   203193.9 i/s - 20.66x  slower
# fold - iterative    :   134339.1 i/s - 31.26x  slower
# pure - recursive    :        0.0 i/s - 93997569.32x  slower
