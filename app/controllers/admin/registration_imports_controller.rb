class Admin::RegistrationImportsController < AdminController
  before_action :require_editor!
  before_action :find_event
  def index
    @imports = @event.registration_imports.order("id DESC")
  end

  def create
    @import = @event.registration_imports.new(registration_import_params)
    @import.status = "pending"
    @import.user = current_user
    if @import.save
      @import.process!
      flash[:notice] = "汇入完成"
    end
    redirect_to admin_event_registration_imports_path(@event)
  end

  protected
  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end

  def registration_import_params
    params.require(:registration_import).permit(:csv_file)
  end
end
