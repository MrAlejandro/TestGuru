class QuestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_page

  before_action :get_test, only: %i[index new create]
  before_action :get_question, only: %i[destroy]

  def index
    @questions = @test.questions
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    render locals: {test_id: @test.id}
  end

  def create
    question = @test.questions.new(question_params)
    if question.save
      redirect_to action: "index", test_id: @test.id
    else
      redirect_to action: "new", test_id: @test.id
    end
  end

  def destroy
    @question.destroy!
    render plain: "Removed"
  end

  private

  def get_test
    @test = Test.find(params[:test_id])
  end

  def get_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def render_not_found_page
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
