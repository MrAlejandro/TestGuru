class QuestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_page

  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[update edit destroy]

  def index
    @questions = @test.questions
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit
    @test = @question.test
  end

  def update
    @question.update(question_params)
    if @question.save
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    test_id = @question.test_id
    @question.destroy!
    redirect_to action: "index", test_id: test_id
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

  def render_not_found_page
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end