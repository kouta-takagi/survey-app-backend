class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Survey.find(params[:survey_id]).questions.includes(:answers)
    render json: @questions, include: :answers
  end

  def create
    @question = Survey.find(params[:survey_id]).questions.new(question_params)
    @question.user = current_user
    if @question.save
      render json: @question, status: :created
    else
      render json: @question.errors.full_messages, status: :unprocessable_entity

    end
  end

  private
  def question_params
    params.require(:question).permit(:content)
  end
end
