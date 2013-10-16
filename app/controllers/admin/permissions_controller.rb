class Admin::PermissionsController < AdminController

  inherit_resources
  actions :all, except: :show

  belongs_to :domain

  load_and_authorize_resource :domain
  load_and_authorize_resource :permission, through: :domain


  def create
    build_resource.creator = current_mailbox
    build_resource.subject = Mailbox.find(params[:permission][:subject_id])
    build_resource.save!

    respond_to do |format|
      format.html { redirect_to [:admin, parent, :permissions], flash: { notice: 'Permission successfully created.' } }
    end
  rescue
    redirect_to [:new, :admin, parent, :permission], flash: { error: 'Permission already existing.' }
  end


  private

  def permitted_params
    params.permit \
      permission: [
        :role,
        :subject,
        :subject_id,
        :subject_type
      ]
  end

end
