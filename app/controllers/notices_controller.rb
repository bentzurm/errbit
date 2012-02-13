class NoticesController < ApplicationController
  respond_to :xml

  skip_before_filter :authenticate_user!, :only => :create

  def create
    # params[:data] if the notice came from a GET request, raw_post if it came via POST
    @notice = App.report_error!(params[:data] || request.raw_post)
    err = Err.find(@notice.err_id)
    if err.problem.app.issue_tracker and err.problem.issue_link.nil?
      err.problem.app.issue_tracker.create_issue err.problem
    end
    respond_with @notice
  end

end

