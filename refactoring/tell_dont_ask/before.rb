# Tell, don't ask refers to one of the OOP principles that
# is focused on enforcing commands, rather than to conduct
# a dialogue with an object. In most cases this kind of dialogue
# is good prerequiste for another code smell called Feature Envy.

# Violation of "Tell, don't ask" - Example:

class User
  attr_reader :name, :admin

  def initialize(name, admin = false)
    @name = name
    @admin = admin
  end

  def admin?
    !!admin
  end

  def user_welcome_message
    "Hello %s, User!" % name
  end

  def admin_welcome_message
    "Hello %s, Admin!" % name
  end
end

# WelcomeMessageNotifier is a simple serice object class, which main
# responsibility is to send specific welcome message to provided user.
# Unfortunately, its implementation is suffering from "Tell, don't ask"
# principle violation. The reason is due to the fact of how many questions
# we need to ASK to get appropriate value. This class is tightly coupled
# with internals of an object that is referenced by 'user' local variable.
# To be more accurate:
#   1. WelcomeMessageNotifier knows there is at least more than one kind
#      of 'User'
#   2. WelcomeMessageNotifier knows about existence of 3 user's methods, which
#      needs to be changed, if any of these methods will change in the source
#   3. WelcomeMessageNotifier violates Open/Closed principle. It is impossible
#      to add new welcome message type without changing already existing
#      codebase.
class WelcomeMessageNotifier
  def call(user)
    if user.admin?
      user.admin_welcome_message
    else
      user.user_welcome_message
    end
  end
end