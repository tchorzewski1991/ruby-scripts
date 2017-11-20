require 'benchmark/ips'

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
