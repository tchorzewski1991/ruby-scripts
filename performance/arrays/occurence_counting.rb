require 'benchmark/ips'

# The task is to count occurence of each unique element of an array and to
# return hash with corresponding results. I took into account these attempts
# are definitely not all possible attempts. Please feel free to contribute
# and benchmark your own solution.

def variant_1(array)
  array.uniq.map { |key| [key, array.count(key)] }.to_h
end

def variant_2(array)
  hash = Hash.new(0); array.each { |key| hash[key] += 1 }; hash
end

def variant_3(array)
  array.inject(Hash.new(0)) { |hash, key| hash[key] += 1; hash }
end

def variant_4(array)
  array.each_with_object(Hash.new(0)) { |key, hash| hash[key] += 1 }
end

def variant_5(array)
  array.each_with_object({}) { |key, hash| hash[key] ||= 0; hash[key] += 1 }
end

def variant_6(array)
  Hash[array.group_by(&:itself).map { |key, value| [key, value.size] }]
end

def variant_7(array)
  result = Hash.new(0)
  i = 0

  while e = array[i]
    result[e] += 1
    i += 1
  end

  result
end

Benchmark.ips do |x|
  array = %w(a a b c d e r e s a s e)

  x.report('variant 1') { variant_1(array) }
  x.report('variant 2') { variant_2(array) }
  x.report('variant 3') { variant_3(array) }
  x.report('variant 4') { variant_4(array) }
  x.report('variant 5') { variant_5(array) }
  x.report('variant 6') { variant_6(array) }
  x.report('variant 7') { variant_7(array) }

  x.compare!
end

#
# Calculating -------------------------------------
#            variant 1     79.005k (± 8.0%) i/s -    394.205k in   5.023874s
#            variant 2    184.203k (± 6.2%) i/s -    920.610k in   5.017866s
#            variant 3    161.382k (±10.4%) i/s -    808.911k in   5.076996s
#            variant 4    170.109k (± 5.9%) i/s -    856.548k in   5.053924s
#            variant 5    133.756k (± 5.5%) i/s -    668.635k in   5.015324s
#            variant 6     98.708k (± 7.8%) i/s -    496.269k in   5.063483s
#            variant 7    203.420k (± 7.1%) i/s -      1.018M in   5.032203s
#
# Comparison:
#            variant 7:   203420.2 i/s
#            variant 2:   184202.7 i/s - same-ish: difference falls within error
#            variant 4:   170109.4 i/s - 1.20x  slower
#            variant 3:   161382.4 i/s - 1.26x  slower
#            variant 5:   133755.6 i/s - 1.52x  slower
#            variant 6:    98707.9 i/s - 2.06x  slower
#            variant 1:    79005.2 i/s - 2.57x  slower
