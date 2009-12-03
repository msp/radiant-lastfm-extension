# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class LastfmExtension < Radiant::Extension
  version "1.0"
  description "Radiant extension for the last.fm API"
  url "http://github.com/msp/lastfm"
  
  # define_routes do |map|
  #   map.namespace :admin, :member => { :remove => :get } do |admin|
  #     admin.resources :lastfm
  #   end
  # end
  
  def activate
     admin.tabs.add "Lastfm", "/admin/lastfm", :after => "Layouts", :visibility => [:all]
     Page.send :include, LastfmTags
  end
  
  def deactivate
    # admin.tabs.remove "Lastfm"
  end
  
end
