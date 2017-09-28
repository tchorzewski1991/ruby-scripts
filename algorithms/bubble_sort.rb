module BubbleSort
  class << self
    def sort(array)
      # Variable j refers to number of comparsions which we need to
      # consider during our sorting process. It is always reduced by one
      # in relation to current array length
      j = array.length - 1

      # Bubbling - how do we know, how many iterations we need to
      # consider to get fully sorted array? Each single iteration moves
      # the biggest element to the end of our target array. According to
      # that simple fact it is enough to execute our 'while' loop at least
      # j - k times. Variable k at start points out to ommiting last
      # element. This is number of iterations without taking into account
      # last element. For each 'while' loop variable k will reduce number of
      # comparsion left, as we do not need to compare elements which
      # are currently in the correct order.
      k = j - 1

      k.times do |k|
        i = 0
        while i < j - k
          m, n = array[i], array[i + 1]

          next(i += 1) if m < n

          array[i], array[i + 1] = n, m

          i += 1
        end
      end

      array
    end
  end
end
