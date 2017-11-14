module PrimeNumbers
  extend self

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
