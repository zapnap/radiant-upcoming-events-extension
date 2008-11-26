class Event < ActiveRecord::Base
  validates_presence_of :scheduled_at, :name
  validates_uniqueness_of :name

  def self.upcoming
    self.find(:all, :conditions => ["scheduled_at > ?", Time.now])
  end

  def self.next
    self.find(:first, :conditions => ["scheduled_at > ?", Time.now], :order => "scheduled_at")
  end
end
