# Mailboxes controller.
class MailboxesController < InheritedResources::Base
  load_and_authorize_resource

  # Work-around for something, I did not understand.
  def resource
    current_mailbox
  end

  # Update Mailbox.
  def update
    unless current_mailbox.admin?
      a = [:active, :admin, :domain_id, :mail_location, :quota, :username]
      params[:mailbox].delete_if { |x| a.include? x.to_sym }
    end

    update! do |success, error|
      success.html { redirect_to [:edit, :mailbox] }
    end
  end
end
