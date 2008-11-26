module UpcomingEventTags
  include Radiant::Taggable
  include ActionView::Helpers::DateHelper

  class TagError < StandardError; end

  desc %{
    Event root node.
  }
  tag 'event' do |tag|
    tag.expand
  end

  desc %{ 
    Causes tags referring to event attributes to refer to the current event. The
    event can be specified by +name+, or the +next+ option can be used to retrieve
    the next scheduled event (relative to the current time).

    *Usage:*
    <pre><code><r:event [name="Happy Fun Time"] [next="true"]>...</r:event></code></pre>
  }
  tag 'event' do |tag|
    if tag.attr['name']
      tag.locals.event = Event.find_by_name(tag.attr['name'])
    elsif tag.attr['next']
      tag.locals.event = Event.next
    end
    raise TagError, "'event' tag must either specify the 'next' event or possess a valid 'name' attribute." unless tag.locals.event
    tag.expand
  end

  desc %{ 
    Events group root node. 
  }
  tag 'events' do |tag|
    tag.locals.events = Event.upcoming
    tag.expand
  end

  desc %{ 
    Cycles through each upcoming event. Inside this tag all attribute tags are mapped
    to the current event.

    *Usage:*
    <pre><code><r:events:each>...</r:events:each>
  }
  tag 'events:each' do |tag|
    results = []
    tag.locals.events.each do |event|
      tag.locals.event = event
      results << tag.expand
    end
    results
  end

  desc %{
    Displays the name of the current event.

    *Usage:*
    <pre><code><r:event:name/></code></pre>
  }
  tag 'event:name' do |tag|
    event = tag.locals.event
    event.name
  end

  desc %{
    Displays the date of the current event.

    *Usage:*
    <pre><code><r:event:date/></code></pre>
  }
  tag 'event:date' do |tag|
    event = tag.locals.event
    event.scheduled_at.to_s
  end

  desc %{
    Displays the distance of time in words between now and the time of the event.

    *Usage:*
    <pre><code><r:event:distance_to_now/></code></pre>
  }
  tag 'event:distance_to_now' do |tag|
    event = tag.locals.event
    distance_of_time_in_words_to_now(event.scheduled_at)
  end
end
