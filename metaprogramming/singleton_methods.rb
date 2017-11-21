# This module shows most common and possible ways to define singleton method
# in Ruby programming language. As a small reminder singleton method is just
# a method defined only for particular object. As a tip to understand from
# my little experience with metaprogramming - It's all about understanding
# of ruby 'self' and coresponding scope.
#
# SingletonMethods.singleton_methods
#  => [:from_self, :from_singleton_class, :from_constant,
#      :from_define_singleton_method, :from_instance_eval]

module SingletonMethods
  def self.from_self
  end

  class << self
    def from_singleton_class
    end
  end

  def SingletonMethods.from_constant
  end

  define_singleton_method(:from_define_singleton_method) do
  end

  instance_eval do
    def from_instance_eval
    end
  end
end
