class TestsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test, only: :start

  def index
    @tests = Test.all
  end

  def start
    if @test.questions.count == 0
      redirect_to tests_path, { flash: { alert: t(".test_not_ready") }}
    else
      current_user.tests.push(@test)
      redirect_to current_user.test_passage(@test)
    end
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end
end
