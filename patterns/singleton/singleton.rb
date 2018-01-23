# Singleton pattern refers to programming technique, which
# main point is to create standalone, unique instance of
# the Ruby class. It becomes globally accessible due to
# public accessor and contains predefined, expected behavior.

# Singleton pattern could be really helpful for our system
# if we exactly know, how to use it and what are the common
# pitfalls due to overusage of singletons.

# There are a lot of ways to define singleton.
# In most cases it will be defined as an object of the Class
# instance, but there is no any restriction to define it as
# an instance of the Module. (Modules in Ruby are objects too).
# It's worth to point out that both cases have some pros and cons,
# so there is no perfect way, to define singleton.

require_relative './implementations/eager_instantiation'
require_relative './implementations/lazy_instantiation'
require_relative './implementations/testable_class'
require_relative './implementations/modular'

module Singleton
end
