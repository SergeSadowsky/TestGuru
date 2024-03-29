module TestAttemptsHelper
  def test_result(test_attempt)
    result = 'fail'
    result = 'success' if test_attempt.success?

    content_tag :p, class: 'result' do
        content_tag(:span, result.capitalize, class: result) +
          " with #{test_attempt.test_score}% correct answers.".html_safe
    end
  end
end
