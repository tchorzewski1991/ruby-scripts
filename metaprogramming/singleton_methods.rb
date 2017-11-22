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
  # Self here refers to SingletonMethods.


  def self.from_self
    # Self here refers to SingletonMethods.

    # We define method by direct reference to self.
    # Method defined on the object itself is just the instance method
    # defined on the object singleton-class.
  end

  class << self
    # Self here refers to <Class:SingletonMethods>.

    def from_singleton_class
      # Self here refers to SingletonMethods.

      # We define instance method directly on the object singleton class.
      # There aren't class methods in ruby. Methods, that look like class
      # methods are just instance methods defined on the object singleton
      # class.
    end
  end

  def SingletonMethods.from_constant
    # Self here refers to SingletonMethods.

    # We define method by direct reference to the SingletonMethods
    # constant.
  end

  # Self here refers to SingletonMethods
  # Scope becomes flatten.
  define_singleton_method(:from_define_singleton_method) do
    # Self here refers to SingletonMethods.

    # We invoke define_singleton_method on SingletonMethods object itself.
    # 'Define singleton method' means define instance method on the object
    # singleton class.
  end

  # Self here refers to SingletonMethods.
  # Scope becomes flatten.
  instance_eval do
    # Self refers to SingletonMethods.

    def from_instance_eval
      # Self refers to SingletonMethods.

      # 'Instance eval' means evaluate piece of code in the context of the
      # current reciver. Reciver here is object of SingletonMethods module.
      # So, what we want to do, is to define method on current object.
      # As mentioned earlier method defined on the object itself is just
      # instance method defined on the object singleton class. Above method
      # will be defined then on the singleton class of the Presenter object,
      # as an instance method.
    end
  end
end
