require 'benchmark/ips'

class LinearSearch
  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def find(element = nil)
    i = 0

    while item = collection[i]
      result = block_given? ? yield(item) : item == element
      result && (return item)

      i += 1
    end
  end
end

Benchmark.ips do |x|
  x.report('LinearSearch#find') do
    LinearSearch.new([2,2,3,6,7,5,3]).find { |x| x == 7 }
  end

  x.report('Array#find') do
    [2,2,3,6,7,5,3].find { |x| x == 7 }
  end

  x.compare!
end

# Warming up --------------------------------------
#              my find    70.376k i/100ms
#            ruby find    69.078k i/100ms
# Calculating -------------------------------------
#              my find    951.078k (± 7.0%) i/s -      4.786M in   5.060166s
#            ruby find    941.165k (± 6.8%) i/s -      4.697M in   5.015971s
#
# Comparison:
#              my find:   951078.2 i/s
#            ruby find:   941164.9 i/s - same-ish: difference falls within error
