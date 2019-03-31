# Method extraction refers to one of the most common refactoring
# techniques. It is simple, but truly powerful way to make your code
# clear and concise.

# There are three basic steps which needs to be done in order to
# extract method:
# 1. We need to choose a name for a new method
# 2. We need to move extracted code to the new method
# 3. We need to change the old code to make it work as before

# The easiest way to spot place for method extraction is to find
# a long method. If the method doesn't have simple and general shape
# we can follow it is probably perfect candidate for refactor.

# We will refer to code snippet from common Rails controller.

# This CompletionsController#update method is great example of
# overusing Ruby's flexibility and abilities to code everything,
# everywhere. It doesn't follow any specific rules. It uses a lot
# of flow control semantics as well as early termination with explicit
# return statement. This method probably works as expected, but it isn't
# readeble and concise. It contains lot of reuseable code, that
# might be extracted for future use without big efforts.

class CompletionsController < ApplicationController
  def update
    @question = Question.find_by_id(params[:question_id])

    unless @question
      render json: { error: 'Question not found' }, status: 404
      return
    end

    @completion = @question.completions.find(params[:id])
    completion_params = params.require(:completion).permit(
      :title,
      :minimum,
      :maximum,
      answers: %i[id submittable_type]
    )

    if @completion.update(completion_params)
      render json: @completion.as_json(only: %i[id maximum minimum answers])
    else
      render json: { error: 'Cannot update completion' }, status: 422
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Completion not found' }, status: 404
  end
end
