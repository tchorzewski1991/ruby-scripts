# See before.rb for introductionary note on method extraction.

# After

# The same CompletionsController#update method seems to be much
# more readeable and easy to reason about.
# I would try to describe changes that have been made in a few steps:

# 1. I like to move any kind of 'finder' methods to before_* action hooks.
#    This might be true that our controller do not need this kind of
#    improvement as we only have one action, but I found this pattern
#    to be clean and intention revealing. Another fact is the naming
#    convention, which is not accidential. When it comes to rails controllers
#    I really like to extend any method names with '!' as an indicator that
#    operation returns exception while it's not succeed. I think, we always
#    should be as explicit as possible in terms of 'finder' methods. This is
#    also an introduction to my second change which refers to extending parent
#    ApplicationController.
#
# 2. Rails API always was quite big and expressive. There are thousands of
#    methods available for end user, which may be sometimes swiss knife for
#    your problem. As I mentioned earlier, I really prefer to be more explicit
#    about action that my code takes. Technically it means I would rather throw
#    and catch an exception rather then play with some 'nil'/'false' checks.
#    Rails offers great mechanism for catching any kind of exceptions within our
#    controllers. This is way I decided to extend our ApplicationController with
#    rescue_from statement, which is a nice and clean way for handling API
#    errors.
#
# 3. Last improvement is special form of method extraction which refers to
#    changing local variable on 'query' method. There is no need to keep
#    complation_params local variable inside body of our #update action.
#    It will be more reuseable when we abstract it to separate method call.
#
# Additional notes: It's worth to point our that almost every change that we
#                   made refers to introducing some additional level of
#                   abstraction. We have created new abstractions by extracting
#                   code into several private methods. The point is we don't
#                   change actual public API so there is no need for separate
#                   specs for those new methods.
#                   Code refactoring is all about changing the way your code do
#                   something, but not how it actually doing it. d

class CompletionsController < ApplicationController
  before_action :find_question!,   only: [:update]
  before_action :find_completion!, only: [:update]

  def update
    @completion.update!(completion_params)
    render json: @completion.as_json(only: %i[id title maximum minimum answers])
  end

  private

  def completion_params
    params.require(:completion).permit(
      :title,
      :minimum,
      :maximum,
      answers: %i[id submittable_type]
    )
  end

  def find_question!
    @question = Question.find(params[:question_id])
  end

  def find_completion!
    @completion = @question.completions.find(params[:id])
  end
end

class ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_form ActiveRecord::RecordInvalid,  with: :handle_record_invalid

  private

  def handle_not_found
    render json: { error: 'Record not found' }, status: 404
  end

  def handle_record_invalid
    render json: { error: 'Record invalid' }, status: 422
  end
end
