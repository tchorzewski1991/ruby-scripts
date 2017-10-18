require 'benchmark/ips'

# The task is to remove first character from the string, possibly with most
# elegant solution. Rather than return deleted character, what we want
# to do is to returns new string.

# Task seems to be really simple, but definitely there is a lot of ways
# to do that. Are there any special differences between those?  Apart from
# little 'overdesign' to that pretty straight forward task, what we need to
# be considered is the amount of possibilities which ruby programming
# language offers.

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
