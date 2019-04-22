# Open/Closed principle is one of the OOP principles which
# stands for keeping your objects (classes in most cases) open
# for extension, but closed for modification. Violation of this
# principle frequently happens due to the tight coupling between
# your codebase and some directly used dependency. Being an open
# for extension in that particular case means we want new behavior
# to be injectable into our class. However, important to reason about
# is fact that we don't want to modify our codebase at all.

# Purchase is an example of class that disobeys OCP requrements:
class Purchase
  attr_reader :user, :amount

  def initialize(user, amount)
    @user = user
    @amount = amount
  end
 
  # This method is a great example of OCP violation. It contains direct
  # reference to the Stripe class and it builds tightly coupled internal
  # dependency over this class. If we would like to change this method
  # in the future, we will need to reopen this Purchase class and change
  # this particular method.
  def charge_user!
    Stripe.charge(user: user, amount: amount)
  end
end
