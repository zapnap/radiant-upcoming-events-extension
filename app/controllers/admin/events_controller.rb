class Admin::EventsController < ApplicationController
  def index
    @events = Event.find(:all, :order => "scheduled_at DESC, name")
    render(:action => 'index')
  end

  def new
    @event = Event.new
    render(:action => 'edit')
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "Successfully added a new event."
      redirect_to(admin_events_path)
    else
      flash[:error] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
      render(:action => 'edit')
    end
  end

  def edit
    @event = Event.find(params[:id])
    render(:action => 'edit')
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated the event details."
      redirect_to(admin_events_path)
    else
      flash[:error] = "Validation errors occurred while processing this form. Please take a moment to review the form and correct any input errors before continuing."
      render(:action => 'edit')
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:error] = "The event was deleted."
    redirect_to(admin_events_path)
  end
end
