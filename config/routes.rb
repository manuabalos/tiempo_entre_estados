# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do
	match 'tee/:action', :to => 'tee', as: 'tee_home'
	resources :tee_prs
	resources :tee_timetables do
		resources :tee_timetables_journals
	end
	resources :tee_holidays

	get 'issues/:id/stats_total_time', to: 'issues#stats_total_time', as: 'stats_total_time'
	
end