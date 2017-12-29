module Hamming
  extend self

  # Hamming#distance measures the minimum number of substitutions required to
  # change one string into another, or the minimum number of errors that could
  # have transformed one string into the other.

  # Example: Basic usage
  #   Returns number of different characters from both strings of equal length
  #
  #   Hamming.distance 'karolin', 'kathrin'
  #   => 3
  #

  def distance(origin, target)
    j, k = origin.length, target.length

    return if j != k

    i, diff = 0, 0

    while i < j
      diff += 1 if target[i] != origin[i]
      i += 1
    end

    diff
  end
end
