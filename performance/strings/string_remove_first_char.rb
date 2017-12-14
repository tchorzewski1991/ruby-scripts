require 'benchmark/ips'

# The task is to remove first character from the string, possibly with the
# most elegant way. What we want to return new string instead of mutating
# current original one.

# Task seems to be really simple. Unfortunately there is to be a lot of
# ways to do that.

String.class_eval do
  def ease
    String(self[1..-1])
  end
end

Benchmark.ips do |x|
  str = 'this-is-confusing-string'

  x.report 'String#[(range)]' do
    str[1..-1]
  end

  x.report 'String#[(comma)]' do
    str[1, str.length - 1]
  end

  x.report 'String#slice' do
    str.slice(1, str.length - 1)
  end

  x.report 'String#gsub' do
    str.gsub(/^./, '')
  end

  x.report 'String#sub' do
    str.sub(/^./, '')
  end

  x.report 'String#split' do
    str.split(/^./)[1]
  end

  x.report 'String#ease' do
    str.ease
  end

  x.compare!
end

# Calculating -------------------------------------
#     String#[(range)]      3.388M (±19.6%) i/s -     16.285M in   5.033978s
#     String#[(comma)]      3.961M (±10.3%) i/s -     19.643M in   5.022283s
#         String#slice      3.956M (± 9.2%) i/s -     19.615M in   5.004523s
#          String#gsub    367.607k (± 8.4%) i/s -      1.828M in   5.010303s
#           String#sub      1.135M (± 7.9%) i/s -      5.654M in   5.012589s
#         String#split    453.812k (± 5.1%) i/s -      2.279M in   5.035275s
#          String#ease      3.102M (± 8.7%) i/s -     15.463M in   5.027967s
#
# Comparison:
#     String#[(comma)]:  3960746.0 i/s
#         String#slice:  3955942.8 i/s - same-ish: difference falls within error
#     String#[(range)]:  3387793.9 i/s - same-ish: difference falls within error
#          String#ease:  3101768.3 i/s - 1.28x  slower
#           String#sub:  1135454.6 i/s - 3.49x  slower
#         String#split:   453811.6 i/s - 8.73x  slower
#          String#gsub:   367606.9 i/s - 10.77x  slower
