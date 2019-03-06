class Admin::QuestionsController < Admin::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_page

  before_action :set_test, only: %i[index new create]
  before_action :set_question, only: %i[update edit destroy]

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to admin_question_path(@question), notice: t(".success")
    else
      render :new
    end
  end

  def edit
    @test = @question.test
  end

  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question), notice: t(".success")
    else
      render :edit
    end
  end

  def destroy
    @question.answers.destroy_all
    @question.destroy!
    redirect_to admin_test_path(@question.test)
  end

  private

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def render_not_found_page
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
