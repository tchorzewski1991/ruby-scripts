class SelectionSort
  class << self
    def sort(array)
      sorted = []

      until array.empty?
        min = array.shift

        array.length.times do |index|
          next if array[index] > min
          temp = min
          min = array[index]
          array[index] = temp
        end

        sorted << min
      end

      sorted
    end
  end
end
