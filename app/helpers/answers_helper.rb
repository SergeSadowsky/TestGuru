module AnswersHelper
  def answer_header(answer)
    question = answer.question.body
    header = if answer.new_record?
               "Add answer for"
             else
               "Edititing answer for"
             end
    content_tag('h2', header) + content_tag('h3', question)
  end
end
