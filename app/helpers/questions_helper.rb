module QuestionsHelper
  def question_title(test, question)
    if question.persisted?
      "Edit '#{test.title}' question"
    else
      "Create '#{test.title}' question"
    end
  end
end
