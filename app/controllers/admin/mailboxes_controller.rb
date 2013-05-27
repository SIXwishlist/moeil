class Admin::MailboxesController < AdminController

  inherit_resources

  before_filter :authenticate_mailbox!

  def create
    create! do |success, error|
      success.html { redirect_to admin_domain_mailboxes_path(resource.domain) }
    end
  end

  def destroy
    destroy! do |success, error|
      success.html { redirect_to admin_domain_mailboxes_path(resource.domain) }
    end
  end

  def new
    build_resource.domain_id = params[:domain_id]
  end

  def update
    update! do |success, error|
      success.html { redirect_to admin_domain_mailboxes_path(resource.domain) }
    end
  end

protected

  def collection
    @mailboxes ||= end_of_association_chain.where(domain_id: params[:domain_id])
  end

end