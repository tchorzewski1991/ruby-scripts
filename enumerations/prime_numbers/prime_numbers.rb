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
