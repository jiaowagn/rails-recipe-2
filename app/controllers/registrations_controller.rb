class RegistrationsController < ApplicationController
  before_action :find_event
  before_action :find_registration, only: [:show, :step2, :step2_update, :step3, :step3_update]
  def new
  end

  def create
    @registration = @event.registrations.new(registration_params)
    @registration.ticket = @event.tickets.find(params[:registration][:ticket_id])
    @registration.status = "pending"
    @registration.user = current_user
    if @registration.save
      redirect_to step2_event_registration_path(@event, @registration)
    else
      render "new"
    end
  end

  def show
  end

  def step2
  end

  def step2_update
    if @registration.update(registration_params)
      redirect_to step3_event_registration_path(@event, @registration)
    else
      render "step2"
    end
  end

  def step3
  end

  def step3_update
    @registration.status = "confirmed"
    if @registration.update(registration_params)
      redirect_to event_registration_path(@event, @registration)
    else
      render "step3"
    end
  end

  protected
  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end

  def find_registration
    @registration = @event.registrations.find_by_uuid(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:ticket_id, :name, :email, :cellphone, :website, :bio)
  end
end
