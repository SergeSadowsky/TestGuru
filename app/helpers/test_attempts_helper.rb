module TestAttemptsHelper
  def test_result(test_attempt)
    result = 'fail'
    result = 'success' if test_attempt.success?

    content_tag :p, class: 'result' do
        content_tag(:span, result.capitalize, class: result) +
          " with #{test_attempt.test_score.round(2)}% correct answers.".html_safe
    end
  end

  def current_of_total(test_attempt)
    content_tag :span, "(#{test_attempt.current_question_index} of #{test_attempt.test.questions.count})"
  end
end
