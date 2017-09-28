module BubbleSort
  class << self
    def sort(array)
      j = array.length - 1
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
