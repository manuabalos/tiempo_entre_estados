class HooksViewLastIntervalTimeIssue < Redmine::Hook::ViewListener
  render_on :view_issues_show_details_bottom, :partial => "issues/last_interval_time"
end