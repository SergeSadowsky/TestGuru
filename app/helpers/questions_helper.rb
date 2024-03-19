# frozen_string_literal: true
module QuestionsHelper

  def question_header(question)
    test_title = question.test.title
    header = if question.new_record?
               "Create new question for #{test_title} test"
             else
               "Edit question for #{test_title} test"
             end
    content_tag 'h2', header
  end
end
