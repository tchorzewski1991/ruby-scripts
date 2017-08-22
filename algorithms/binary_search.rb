class BinarySearch
  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def find(element)
    c = collection

    while true
      i = c.length / 2

      return element if element == c[i]
      return if i == 0

      c = c[i] < element ? c[i..-1] : c[0...i]
    end
  end
end
