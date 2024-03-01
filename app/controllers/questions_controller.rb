class QuestionsController < ApplicationController
  before_action :find_test, only: [:index, :create]
  before_action :find_question, only: [:show, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found
  def index
    result = self.test.questions.pluck(:body)
    render html: output(result).html_safe
  end

  def show
    render plain: question.body
  end

  def new; end

  def create
    question = Question.create(question_params)
    question.test_id = test.id
    question.save
    result = ["Q.id: #{question.id}", "Q.body: #{question.body}", "for Test: #{test.id}"]
    render html: output(result).html_safe
  end

  def destroy
    self.question.destroy

    render plain: "Question #{self.question.id} deleted"
  end

  private

  attr_accessor :test, :question

  def find_test
    self.test = Test.find(params[:test_id])
  end

  def find_question
    self.question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: 'Question not found'
  end

  def output text
    "<ul><li>#{text.join('</li><li>')}</li></ul>"
  end
end
