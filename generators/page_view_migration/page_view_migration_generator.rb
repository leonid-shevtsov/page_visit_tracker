class PageViewMigrationGenerator < Rails::Generator::Base
  def manifest 
    record do |m| 
      m.migration_template 'model:migration.rb', "db/migrate", {:assigns => page_view_migration_local_assigns, :migration_file_name => "create_page_views"} 
    end  
  end  

private 
  def page_view_migration_local_assigns 
    returning(assigns = {}) do  
      assigns[:migration_name] = 'create_page_views'
      assigns[:table_name] = 'page_views' 
      assigns[:attributes] = [
        Rails::Generator::GeneratedAttribute.new('object_type','string'),
        Rails::Generator::GeneratedAttribute.new('object_id','integer'),
        Rails::Generator::GeneratedAttribute.new('user_agent','string'),
        Rails::Generator::GeneratedAttribute.new('ip','string'),
        Rails::Generator::GeneratedAttribute.new('referer','string'),
        Rails::Generator::GeneratedAttribute.new('user_id','integer'),
        Rails::Generator::GeneratedAttribute.new('visitor_hash','string'),
        Rails::Generator::GeneratedAttribute.new('created_at','timestamp'),
      ]
      assigns[:options] = {:skip_timestamps => true}
    end
  end
end
