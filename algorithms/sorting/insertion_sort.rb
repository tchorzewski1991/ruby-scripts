class InsertionSort
  class << self
    def sort(array)
      # Let's consider first element of the given array as fully sorted
      # Given array can be reassigned, as we do not need anymore first
      # element
      sorted = [array[0]]
      array = array[1..-1]

      # My implementation refers to iteration through fully sorted array
      # and inserting each consecutive candidate into suitable place
      # Variable s(sorted) refers to each consecutive sorted element and
      # variable c(candidate) refers to each consecutive element from given
      # array.
      i = 0
      while i < sorted.length
        c = array[0] or break
        # Loop will be stopped when there is no more elements in given array

        s = sorted[i]

        # Positive branch of conditional statement below will be responsible
        # for adding elements to the end of sorted array, while negative branch
        # will take responsibility for inserting given element somewhere in the
        # middle of the sorted array. Inserting new elements is quite tricky.
        # 'While' iterator is controlled by conditional statement, as we want
        # to omit elements smaller, than our candidate. Insertion needs to be
        # stopped after success, because we do not need to check anything more
        if s < c
          sorted[i + 1] = c
          array = array[1..-1]
        else
          j = 0
          while j < sorted.length
            s = sorted[j]
            next(j += 1) if s < c
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
