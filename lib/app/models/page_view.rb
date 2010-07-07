class PageView < ActiveRecord::Base
  belongs_to :object, :polymorphic => true

  named_scope :today, lambda { {:conditions => ['created_at > ?',Time.zone.now.beginning_of_day]}} 

  def self.get_statistics_for(type)
    Rails.cache.fetch("page_viewis_statistics_#{type}", :expires_in => 1.hour) do
      class_name = type.to_s.classify
      connection.select_rows("SELECT count(*) as cnt, DATE(created_at) as date FROM page_views WHERE object_type=\"#{class_name}\" GROUP BY date")
    end
  end

  def self.get_top_for(type)
    class_name = type.to_s.classify
    klass = class_name.constantize
    ids = Rails.cache.fetch("page_views_top_#{type}", :expires_in => 1.hour) do
      connection.select_rows("SELECT object_id, count(*) as cnt FROM page_views WHERE object_type=\"#{class_name}\" AND created_at>\"#{(Date.today-7).to_s :db}\" GROUP BY object_id ORDER BY cnt DESC LIMIT 50")
    end
    objects_map = {}
    klass.find(ids.map{|a| a[0]}).each do |o|
      objects_map[o.id] = o
    end
    ids.map {|a| [objects_map[a[0].to_i], a[1]]}.reject {|a| a[0].nil?}
  end
end
