require 'benchmark/ips'

# Results of the benchmark are quite surprising. It is obvious that we never
# should use loop 'while' for such simple operation. However, sometimes it
# is really nice to consider to defining methods by hand.

Benchmark.ips do |x|
  array = %w(a b c d e f)

  x.report('String#join') do
    array.join('_')
  end

  x.report('String#*') do
    array * '_'
  end

  x.report('String#* uncommon') do
    array * ?_
  end

  x.report('Enumerable#inject') do
    array.inject('') { |r, e|  r << e }
  end

  x.report('While loop') do
    result = ''
    i = 0
    while true
      s = array[i] or break
      result << s.ord
      i += 1
    end

    result
  end

  x.compare!
end

# Warming up --------------------------------------
#          String#join    62.025k i/100ms
#             String#*    61.770k i/100ms
#    String#* uncommon    62.401k i/100ms
#    Enumerable#inject    56.207k i/100ms
#           While loop    71.281k i/100ms
# Calculating -------------------------------------
#          String#join    832.193k (± 8.8%) i/s -      4.156M in   5.039228s
#             String#*    824.985k (±11.1%) i/s -      4.077M in   5.024438s
#    String#* uncommon    845.603k (± 6.6%) i/s -      4.243M in   5.041031s
#    Enumerable#inject    714.285k (± 6.9%) i/s -      3.597M in   5.062153s
#           While loop    954.509k (± 7.9%) i/s -      4.776M in   5.038024s
#
# Comparison:
#           While loop:   954508.8 i/s
#    String#* uncommon:   845603.4 i/s - same-ish: difference falls within error
#          String#join:   832192.8 i/s - same-ish: difference falls within error
#             String#*:   824984.9 i/s - same-ish: difference falls within error
#    Enumerable#inject:   714284.6 i/s - 1.34x  slower
