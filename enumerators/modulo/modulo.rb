module Modulo
  extend self

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

def compute(i, j, opts = {})
  r = opts.fetch(:r, 0)
  enum = (1..Float::INFINITY).each

  0.upto(j).each_with_object([]) do |_, memo|
    while (k = enum.next) % i == r
      memo << k
    end
  end
end
