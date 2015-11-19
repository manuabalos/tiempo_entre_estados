# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

# get 'time_statuses' , :to => 'time_statuses#index'
# get '/editstatuses' , :to => 'time_statuses#profilestatuses', as: 'editstatuses'
# get '/newcalendar' , :to => 'time_statuses#createcalendar', as: 'newcalendar'

RedmineApp::Application.routes.draw do
	match 'tee/:action', :to => 'tee', as: 'tee_home'
	resources :tee_prs
	resources :tee_timetables
	resources :tee_calendars
end