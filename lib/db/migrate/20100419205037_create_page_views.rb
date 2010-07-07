class CreatePageViews < ActiveRecord::Migration
  def self.up
    create_table :page_views do |t|
      t.string :object_type
      t.integer :object_id

      t.string :user_agent
      t.string :ip, :limit => 15
      t.string :referer

      t.integer :user_id
      t.string :visitor_hash, :limit => 32
      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :page_views
  end
end
