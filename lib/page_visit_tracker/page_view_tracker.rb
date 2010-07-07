module PageViewTracker
  def track_page_view(object)
    return if request.bot? # don't track bots

    user_id = defined?(current_user) ? current_user.try(:id) : nil
    visitor_hash = Digest::MD5.hexdigest([Date.today.to_s, request.user_agent, request.remote_ip, user_id].compact.join("\n"))

    PageView.create!(
      :object_type => object.class.to_s, 
      :object_id => object.id, 
      :user_id => user_id, 
      :referer => request.referer, 
      :user_agent => request.user_agent, 
      :ip => request.remote_ip, 
      :visitor_hash => visitor_hash) unless 
        PageView.exists?(:object_type => object.class.to_s, :object_id => object.id, :visitor_hash => visitor_hash)
  end
end
