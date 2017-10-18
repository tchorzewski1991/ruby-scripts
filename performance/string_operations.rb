require 'benchmark/ips'

String.class_eval do
  def ease
    self[1..-1]
  end
end

Benchmark.ips do |x|
  str = 'this-is-confusing-string'

  x.report 'String#[]' do
    s = str[1..-1]
  end

  x.report 'String#slice' do
    s = str.slice(1, str.length - 1)
  end

  x.report 'Srting#slice!' do
    str.slice!(1, str.length - 1)
  end

  x.report 'String#gsub' do
    s = str.gsub(/^./, '')
  end

  x.report 'String#gsub!' do
    str.gsub!(/^./, '')
  end

  x.report 'String#sub' do
    s = str.sub(/^./, '')
  end

  x.report 'String#sub!' do
    str.sub!(/^./, '')
  end

  x.report 'String#[]=' do
    str.tap { |x| x[0] = '' }
  end

  x.report 'String#split' do
    s = str.split(/^./)[1]
  end

  x.report 'String#ease' do
    s = str.ease
  end

  x.compare!
end
