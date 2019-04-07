# Tell, don't ask refers to one of the OOP principles that
# is focused on enforcing commands, rather than to conduct
# a dialogue with an object. In most cases this kind of dialogue
# is good prerequiste for another code smell called Feature Envy.

# Violation of "Tell, don't ask" - Solution 1:

# User is an abstraction, which main responsibility is to
# encapsulate initialization details for more specific
# types of users.
class User
  attr_reader :name, :admin

  def initialize(name, admin = false)
    @name = name
    @admin = admin
  end

  def welcome_message
    fail NotImplementedError, 'Not implemented error'
  end
end

# AdminUser is a specific User subclass, which main repsonsibility
# is to encapsulate logic related to welcome message for admins.
class Admin < User
  def welcome_message
    "Hello #{name}! You are the best Admin!"
  end
end

# Guest is a specific User subclass, which main repsonsibility
# is to encapsulate logic related to welcome message for guests.
class Guest < User
  def welcome_message
    "Hello #{name}! You are the best Guest!"
  end
end

# WelcomeMessageNotifier is a simple serice object class, which main
# responsibility is to send specific welcome message to provided user.
# As we can notice, we won't suffer from 'Tell, don't ask' principle
# violation anymore. This is especially due to power of polymorphism,
# instead of overusing countless 'if' statements. Our service object is now
# open for new extensions. Its responsibility becomes even simpler.
# It expects 'user' local variable is to implement #welcome_message method
# and this is the only requirement to fulfil contract between those two classes.
# WelcomeMessageNotifier becomes highly cohesive and loosely copuled.
class WelcomeMessgeNotifier 
  def call(user)
    user.welcome_message
  end
end