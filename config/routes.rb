# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do
	match 'tee/:action', :to => 'tee', as: 'tee_home'
	resources :tee_prs
	resources :tee_timetables
	resources :tee_calendars
end