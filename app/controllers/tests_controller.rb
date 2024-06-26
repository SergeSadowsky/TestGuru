class TestsController < ApplicationController

  before_action :set_test, only: %i[show start]

  def show; end

  def index
    @tests = Test.all
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_attempt(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end
end
