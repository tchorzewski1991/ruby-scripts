require 'benchmark/ips'

class BinarySearch
  class << self
    def find(collection, element = nil)
      c = collection
      i = collection.length

      while i > 0
        i /= 2

        return element if element == c[i]

        c = c[i] < element ? c[i..-1] : c[0...i]
      end
    end
  end
end

Benchmark.ips do |x|
  x.report('BinarySearch#find') do
    BinarySearch.find([1,2,3,4,5,6,7,8], 7)
  end

  x.report('Array#bsearch') do
    [1,2,3,4,5,6,7,8].bsearch { |x| x == 7 }
  end

  x.compare!
end

#
# Calculating -------------------------------------
#    BinarySearch#find      1.165M (± 8.2%) i/s -      5.836M in   5.046825s
#        Array#bsearch      1.622M (± 5.7%) i/s -      8.154M in   5.042785s
#
# Comparison:
#        Array#bsearch:  1622294.6 i/s
#    BinarySearch#find:  1164808.4 i/s - 1.39x  slower
