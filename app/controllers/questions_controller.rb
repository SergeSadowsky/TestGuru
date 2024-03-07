class QuestionsController < ApplicationController
  before_action :find_test, only: [:index, :create]
  before_action :find_question, only: [:show, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found
  def index
    result = @test.questions.pluck(:body)
    render html: output(result).html_safe
  end

  def show
    render plain: @question.body
  end

  def new; end

  def create
    question = @test.questions.new(question_params)
    result = if question.save
               ["Question.id: #{question.id}", "Question.body: #{question.body}", "Question for Test: #{question.test_id}"]
             else
               ['Error:', "Can't create question", question.errors.full_message]
             end
    render html: output(result).html_safe
  end

  def destroy
    @question.destroy

    render plain: "Question #{@question.id} deleted"
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
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