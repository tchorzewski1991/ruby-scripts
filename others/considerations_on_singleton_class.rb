# Small considerations on ruby singleton classes, and how to play
# with them easily. Rule of thumb - It's all about self.

module Presenter
  # self here refers to Presenter

  def self.compute_prepended_with_self
    # self here refers to Presenter
    # We define method by reference to the Presenter object itself.
    # Method defined on the object is the instance method defined on
    # the object singleton-class
  end

  class << self
    # self here refers to <Class:Presenter>
    def compute_direct_from_singleton_class
      # self here refers to Presenter
      # We define instance method directly on the object singleton class.
      # There aren't class methods in ruby. Methods, that look like class
      # methods are just instance methods defined on the object singleton
      # class.
    end
  end

  def Presenter.compute_prepended_with_constant
    # self here refers to Presenter
    # We define method by reference to the Presenter object itself.
    # -- || --   -- || --  -- || --  -- || --  -- || --  -- || --
  end

  # self here refers to Presenter
  # scope becomes flatten.
  define_singleton_method(:compute_from_define_singleton_method) do
    # Self here refers to Presenter
    # We invoke private define_singleton_method on Presenter object itself
    # 'Define singleton method' means define instance method on the object
    # singleton class.
  end

  # self here refers to Presenter
  # scope becomes flatten.
  instance_eval do
    # self here refers to Presenter
    def compute_direct_from_instance_eval
      # self refers to Presenter
      # 'Instance eval' means evaluate piece of code in the context of the
      # current reciver. Reciver here is object of Presenter module.
      # So, what we want to do, is to define method on current object.
      # As mentioned earlier method defined on the object itself is just
      # instance method defined on the object singleton class. Above method
      # will be defined then on the singleton class of the Presenter object,
      # as an instance method.
    end
  end
end
