#require 'tee/issue_status_patch'
require 'tee/project_patch'
require 'tee/role_patch'

Redmine::Plugin.register :tiempo_entre_estados do
  name 'Tiempo Entre Estados plugin'
  author 'Author name'
  description 'Plugin que permite controlar el tiempo entre distintos estados, y donde se muestra el tiempo invertido entre esos estados'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :view_control_statuses, :time_statuses => :index
  menu :project_menu, :time_statuses, { :controller => 'time_statuses', :action => 'index' }, :caption => 'Config. Control Estados', :after => :activity, :param => :project_id
end
