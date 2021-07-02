class ReportController < ApplicationController
  def index
    @tasks = Task.all
    @comments = Comment.all
  end

  def user_complete
    if current_user
      @tasks = Task.where(status: "complete", user_id: current_user.id)
      @comments = Comment.all.order(:body)
    else
      flash[:alert] = "You must be logged in to see this page"
      redirect_to report_path
    end
  end
end
