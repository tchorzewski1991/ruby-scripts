module Hamming
  extend self

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
