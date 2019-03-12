class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    client = GitHubOctokitClient.new
    @question = @test_passage.current_question
    result = GistQuestionService.new(@question, client: client).call

    flash_options = { alert: t('.failure') }
    if result[:success]
      current_user.gists.create(gist_params(result))
      flash_options = { notice: t('.success', gist_url: result[:url]), flash: { html_safe: true } }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def gist_params(result)
    { url: result[:url], question_id: @question.id }
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
