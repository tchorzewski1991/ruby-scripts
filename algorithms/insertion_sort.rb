class InsertionSort
  class << self
    def sort(array)
      sorted = [array[0]]
      array = array[1..-1]

      i = 0
      while s = sorted[i]
        c = array[0]

        break unless c

        if s < c
          sorted[i + 1] = c
          array = array[1..-1]
        else
          j = 0
          while sorted[j]
            next(j += 1) if sorted[j] < c
            temp = sorted[j..-1]
            sorted[j] = c
            sorted[j+1..-1] = temp
            break
          end

          array = array[1..-1]
        end

        i += 1
      end

      sorted
    end
  end
end
