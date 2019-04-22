# Open/Closed principle is one of the OOP principles which
# stands for keeping your objects (classes in most cases) open
# for extension, but closed for modification. Violation of this
# principle frequently happens due to the tight coupling between
# your codebase and some directly used dependency. Being an open
# for extension in that particular case means we want new behavior
# to be injectable into our class. However, important to reason about
# is fact that we don't want to modify our codebase at all.

# Purchase is an example of class that obeys OCP requrements:
class Purchase
  attr_reader :user, :amount

  def initialize(user, amount)
    @user = user
    @amount = amount
  end

  # This method is a great example of 'win' over OCP violation.
  # We achieved satisfying level of flexibility by introducing
  # dependency injection and new 'payment_processor' abstraction.
  # It is impossible to obey OCP without using dependency injection.
  # This is also the place where we can spot how powerful duck typing
  # and polymorphism are. Now we are able to extend class behavior
  # (providing another payment processor) without modyifing our current
  # code.
  def charge_user!(payment_processor)
    payment_processor.charge(user: user, amount: amount)
  end
end
