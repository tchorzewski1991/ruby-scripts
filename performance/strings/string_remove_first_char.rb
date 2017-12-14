require 'benchmark/ips'

# The task is to remove first character from the string, possibly with most
# elegant solution. Rather than return deleted character, what we want
# to do is to returns new string.

# Task seems to be really simple, but definitely there is a lot of ways
# to do that. Are there any special differences between those?  Apart from
# little 'overdesign' to that pretty straight forward task, what need to
# be considered is the amount of possibilities which ruby programming
# language offers.

String.class_eval do
  def ease
    String(self[1..-1])
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

  x.report 'String#gsub' do
    s = str.gsub(/^./, '')
  end

  x.report 'String#sub' do
    s = str.sub(/^./, '')
  end

  x.report 'String#split' do
    s = str.split(/^./)[1]
  end

  x.report 'String#ease' do
    s = str.ease
  end

  x.compare!
end
#
# Calculating -------------------------------------
#            String#[]      6.602M (± 9.1%) i/s -     32.855M in   5.027235s
#         String#slice      6.405M (± 8.3%) i/s -     31.871M in   5.017099s
#        Srting#slice!      5.996M (± 8.6%) i/s -     29.800M in   5.014456s
#          String#gsub      1.527M (± 8.3%) i/s -      7.603M in   5.019654s
#         String#gsub!      1.607M (± 6.2%) i/s -      8.087M in   5.051857s
#           String#sub      1.472M (± 8.4%) i/s -      7.371M in   5.047246s
#          String#sub!      1.544M (± 8.4%) i/s -      7.681M in   5.014661s
#           String#[]=      2.513M (± 8.2%) i/s -     12.551M in   5.031050s
#         String#split      1.709M (± 9.8%) i/s -      8.525M in   5.039068s
#          String#ease      5.464M (± 8.5%) i/s -     27.138M in   5.006263s
#
# Comparison:
#            String#[]:  6601985.6 i/s
#         String#slice:  6404593.1 i/s - same-ish: difference falls within error
#        Srting#slice!:  5996043.4 i/s - same-ish: difference falls within error
#          String#ease:  5464458.1 i/s - 1.21x  slower
#           String#[]=:  2512528.2 i/s - 2.63x  slower
#         String#split:  1708825.6 i/s - 3.86x  slower
#         String#gsub!:  1607419.0 i/s - 4.11x  slower
#          String#sub!:  1543953.8 i/s - 4.28x  slower
#          String#gsub:  1526774.2 i/s - 4.32x  slower
#           String#sub:  1472456.8 i/s - 4.48x  slower
