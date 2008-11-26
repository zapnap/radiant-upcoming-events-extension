# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class UpcomingEventsExtension < Radiant::Extension
  version "0.1"
  description "Create and manage important dates and events" 
  url "http://github.com/zapnap/radiant-upcoming-events-extension"
  
  define_routes do |map|
    map.namespace 'admin' do |admin|
      admin.resources :events
    end
  end
  
  def activate
    admin.tabs.add "Events", "/admin/events", :after => "Layouts", :visibility => [:all]
    Page.send :include, UpcomingEventTags
  end
  
  def deactivate
    admin.tabs.remove "Events"
  end
end
