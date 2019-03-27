# 'Move method' is a refactoring technique which could improve
# quality of our code without big efforts with ease. It fits perfectly
# in scenarios where we spot method, that conceptually does not belongs
# to host class.

# Before

class Completion
  attr_reader :answers

  def initialize(answers)
    @answers = answers
  end

  def score
    answers.inject(0) do |result, answer|
      # This is the hot spot of our issue. As it turns out we care more about
      # Answer's data, rather than Completion class itself. It may seems like
      # simple method extraction should resolve the problem, but this is not the
      # case here. Method extraction is not enough here, as it will only move the
      # problem into another place. It may additionaly introduce another common 'smell'
      # called Feature Envy.
      question = answer.question
      result + question.score(answer.text)
    end
  end
end

class Answer
  attr_reader :question, :text

  def initialize(question, text)
    @question = question
    @text = text
  end
end

class Question
  attr_reader :correct_answer

  def initialize(correct_answer)
    @correct_answer = correct_answer
  end

  def score(answer_text)
    correct_answer == answer_text ? 1 : 0
  end
end

# After

class Completion
  attr_reader :answers

  def initialize(answers)
    @answers = answers
  end

  def score
    answers.inject(0) do |result, answer|
      # Thanks to this simple refactor, our code becomes more
      # obvious and concise. Responsibility of computing score
      # has been moved to the Awswer class, where it should
      # belongs to from the beginning.
      result + answer.score
    end

    # Inject is not necessarily needed anymore. We can be more
    # idiomatic and use handy &:method syntax in conjuction with
    # #map and #sum methods, to get expected score value.
    # answers.map(&:score).sum
  end
end

class Answer
  attr_reader :question, :text

  def initialize(question, text)
    @question = question
    @text = text
  end

  def score
    question.score(text)
  end
end

class Question
  attr_reader :correct_answer

  def initialize(correct_answer)
    @correct_answer = correct_answer
  end

  def score(answer_text)
    correct_answer == answer_text ? 1 : 0
  end
end
