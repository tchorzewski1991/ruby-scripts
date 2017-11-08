module Modulo
  extend self

  # Modulo#compute creates enumerator that allows you for computation of
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
