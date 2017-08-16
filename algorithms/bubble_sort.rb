module BubbleSort
  class << self
    def sort(array)
      array.is_a?(Array) || raise(ArgumentError)

      -1.downto(-array.length + 1) do |i|
        j = i-1
        l, k = array[j], array[i]
        l > k ? (array[i] = l; array[j] = k) : next
      end

      array
    end
  end
end
