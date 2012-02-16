class NoticesController < ApplicationController
  respond_to :xml

  skip_before_filter :authenticate_user!, :only => :create

  def create
    # params[:data] if the notice came from a GET request, raw_post if it came via POST
    @notice = App.report_error!(params[:data] || request.raw_post)
    err = Err.find(@notice.err_id)
    if err.environment == 'production'
      if err.problem.app.issue_tracker and err.problem.issue_link.nil?
        issue = err.problem.app.issue_tracker.create_issue(err.problem, 1)
        account_id = issue.attributes['description'].match('\"account_id\"=>\"([0-9]+)\"')[1]
        member_id = issue.attributes['description'].match('\"member_id\"=>\"([0-9]+)\"')[1]
        post_params = {
          "action" => "create",
          "case[name]" => issue.subject,
          "case[redmine_id]" => issue.id,
          "case[description]" => issue.description,
          "case[issue][account_id]" => account_id,
          "case[issue][user_id]" => member_id
        }
      else
        redmine_id = err.problem.issue_link.split('/').last.split('?')[0]
        account_id = err.notices.last.request['session']['account_id']
        member_id = err.notices.last.request['session']['member_id']
        post_params = {
          "action" => "create",
          "case[redmine_id]" => redmine_id,
          "case[issue][account_id]" => account_id,
          "case[issue][user_id]" => member_id
        }
      end
      x = Net::HTTP.post_form(URI.parse(Errbit::Config.admin_url + '/subscription_admin/cases/create'), post_params)
    end
    respond_with @notice
  end

end

