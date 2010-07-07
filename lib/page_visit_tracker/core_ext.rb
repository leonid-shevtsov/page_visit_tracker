class ActionController::Request
  def bot?
    unless defined? @is_bot
      @is_bot = false

      if user_agent.blank?
        @is_bot = true
      else
        crawler_agents = [
          'Googlebot',
          'Mediapartners-Google',
          'Yahoo! Slurp',
          'Yandex/1.01.001',
          'YandexBot',
          'MJ12bot', # http://www.majestic12.co.uk/projects/dsearch/
          'Mail.Ru/1.0',
          'StackRambler',
          'Twiceler', # cuil
          'redtram',
          'Yandex.Commerce.Pinger',
          'LWP::Simple', # perl??
          'msnbot',
          'Begun Robot Crawler', 
          'ia_archiver', # alexa
          'METASpider',
          'AportWorm',
          'DotBot', # http://www.dotnetdotcom.org/
          'ichiro' # some wtf
        ]

        crawler_agents.each do |crawler_agent|
          @is_bot = true if user_agent.include? crawler_agent
        end
      end
    end
    @is_bot
  end
end

class ActionController::Base
  include PageViewTracker
end
