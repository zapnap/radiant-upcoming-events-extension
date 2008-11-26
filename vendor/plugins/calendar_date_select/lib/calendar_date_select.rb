require "calendar_date_select/calendar_date_select.rb"
require "calendar_date_select/includes_helper.rb"

if Object.const_defined?(:Rails) && File.directory?("#{RAILS_ROOT}/public")
  ActionView::Helpers::FormHelper.send(:include, CalendarDateSelect::FormHelper)
  ActionView::Base.send(:include, CalendarDateSelect::FormHelper)
  ActionView::Base.send(:include, CalendarDateSelect::IncludesHelper)

  # install files
  unless File.exists?(RAILS_ROOT + '/public/javascripts/calendar_date_select/calendar_date_select.js')
    ['/public', '/public/javascripts/calendar_date_select', '/public/stylesheets/calendar_date_select', '/public/images/calendar_date_select', '/public/javascripts/calendar_date_select/locale'].each do |dir|
      source = File.dirname(__FILE__) + "/../#{dir}"
      dest = RAILS_ROOT + dir
      FileUtils.mkdir_p(dest)
      FileUtils.cp(Dir.glob(source+'/*.*'), dest)
    end
  end

end
