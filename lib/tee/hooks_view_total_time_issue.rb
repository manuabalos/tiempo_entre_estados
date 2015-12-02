class HooksViewTotalTimeIssue < Redmine::Hook::ViewListener
  render_on :view_issues_show_details_bottom, :partial => "issues/total_time"
end