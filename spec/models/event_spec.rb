require File.dirname(__FILE__) + '/../spec_helper'

describe Event do
  before(:each) do
    @event = Event.new(valid_attributes)
  end

  it "should be valid" do
    @event.should be_valid
  end

  context "validations" do
    it "should require a name" do
      @event.name = nil
      @event.should_not be_valid
      @event.errors.on(:name).should == "can't be blank"
    end

    it "should require a unique name" do
      @event.save
      @event = Event.new(valid_attributes)
      @event.should_not be_valid
      @event.errors.on(:name).should == "has already been taken"
    end

    it "should require a date" do
      @event.scheduled_at = nil
      @event.should_not be_valid
      @event.errors.on(:scheduled_at).should == "can't be blank"
    end
  end

  context "class methods" do
    before(:each) do
      @time = Time.now
      Time.stub!(:now).and_return(@time)
    end

    it "should return all upcoming events" do
      Event.should_receive(:find).with(:all, :conditions => ["scheduled_at > ?", @time]).and_return([@event])
      Event.upcoming.first.should == @event
    end

    it "should return the next event" do
      Event.should_receive(:find).with(:first, :conditions => ["scheduled_at > ?", @time], :order => "scheduled_at").and_return(@event)
      Event.next.should == @event
    end
  end

  private

  def valid_attributes
    { :name =>         'Happy Fun Time',
      :scheduled_at =>  Time.now + 2.days }
  end
end
