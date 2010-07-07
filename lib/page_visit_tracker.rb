require 'page_visit_tracker/page_view_tracker'
require 'page_visit_tracker/core_ext'

%w{ models }.each do |dir| 
  path = File.join(File.dirname(__FILE__), 'app', dir)  
  $LOAD_PATH << path 
  ActiveSupport::Dependencies.load_paths << path 
  ActiveSupport::Dependencies.load_once_paths.delete(path) 
end

