class InsertionSort
  class << self
    def sort(array)
      sorted = [array[0]]
      i = 1

      while item = array[i]
        sorted.length.times do |i|
          next if sorted[i] <= item
          temp = sorted[i..-1]
          sorted[i] = item
          sorted[i+1..-1] = temp
          break
        end

        i += 1
      end

      sorted
    end
  end
end
