require 'benchmark/ips'

module OccurenceCounting
  class << self
    def variant_1
      array.uniq.map { |key| [key, array.count(key)] }.to_h
    end

    def variant_2
      hash = Hash.new(0); array.each { |key| hash[key] += 1 }; hash
    end

    def variant_3
      array.inject(Hash.new(0)) { |hash, key| hash[key] += 1; hash }
    end

    def variant_4
      array.each_with_object(Hash.new(0)) { |key, hash| hash[key] += 1 }
    end

    def variant_5
      array.each_with_object({}) { |key, hash| hash[key] ||= 0; hash[key] += 1 }
    end

    def variant_6
      Hash[array.group_by(&:itself).map { |key, value| [key, value.size] }]
    end

    private

    def array
      %w(a a b c d e e e)
    end
  end
end

Benchmark.ips do |x|
  x.report('1') { OccurenceCounting.variant_1 }
  x.report('2') { OccurenceCounting.variant_2 }
  x.report('3') { OccurenceCounting.variant_3 }
  x.report('4') { OccurenceCounting.variant_4 }
  x.report('5') { OccurenceCounting.variant_5 }
  x.report('6') { OccurenceCounting.variant_6 }

  x.compare!
end

#
# Calculating -------------------------------------
#                    1     86.668k (± 6.3%) i/s -    438.932k in   5.085439s
#                    2    241.159k (± 5.6%) i/s -      1.211M in   5.037488s
#                    3    215.225k (± 8.2%) i/s -      1.072M in   5.020525s
#                    4    216.927k (± 6.7%) i/s -      1.090M in   5.049314s
#                    5    178.323k (± 5.2%) i/s -    891.884k in   5.015653s
#                    6    132.919k (± 4.7%) i/s -    663.572k in   5.003539s
#
# Comparison:
#                    2:   241159.1 i/s
#                    4:   216927.4 i/s - same-ish: difference falls within error
#                    3:   215225.2 i/s - same-ish: difference falls within error
#                    5:   178322.5 i/s - 1.35x  slower
#                    6:   132919.2 i/s - 1.81x  slower
#                    1:    86668.1 i/s - 2.78x  slower
