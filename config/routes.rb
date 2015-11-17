# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'time_statuses' , :to => 'time_statuses#index'
get '/editstatuses' , :to => 'time_statuses#profilestatuses', as: 'editstatuses'
get '/newcalendar' , :to => 'time_statuses#createcalendar', as: 'newcalendar'