class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question, only: %i[new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_answer_not_found
  def show; end

  def new
    @answer = @question.answers.new
  end

  def edit; end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to answer_url(@answer), notice: "Answer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to answer_url(@answer), notice: "Answer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy

    redirect_to @answer.question, notice: "Answer was successfully destroyed."
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def rescue_with_answer_not_found
    render plain: 'Answer was not found'
  end
end
