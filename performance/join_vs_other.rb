require 'benchmark/ips'

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
