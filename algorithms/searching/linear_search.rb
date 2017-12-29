require 'benchmark/ips'

class LinearSearch
  class << self

    def find(collection, element = nil)
      i = 0
      l = collection.length

      while i < l
        item = collection[i]
        result = block_given? ? yield(item) : item == element
        result && (return item)

        i += 1
      end
    end
  end
end

Benchmark.ips do |x|
  x.report('LinearSearch#find with block') do
    LinearSearch.find([2,2,3,6,7,5,3]) { |x| x == 7 }
  end

  x.report('LinearSearch#find without block') do
    LinearSearch.find([2,2,3,6,7,5,3], 7)
  end

  # Unexpectedly ruby Enumerable#find can't return result of the search
  # when invoked without a block

  x.report('Enumerable#find') do
    [2,2,3,6,7,5,3].find { |x| x == 7 }
  end

  x.compare!
end

# Calculating -------------------------------------
# LinearSearch#find with block      970.754k (± 6.5%) i/s -      4.877M in   5.046184s
# LinearSearch#find without block     1.158M (± 5.9%) i/s -      5.835M in   5.057635s
# Enumerable#find                   921.794k (± 7.0%) i/s -      4.627M in   5.044513s
#
# Comparison:
# LinearSearch#find without block:  1157772.7 i/s
# LinearSearch#find with block:     970753.9 i/s - 1.19x  slower
# Enumerable#find:                  921793.9 i/s - 1.26x  slower
