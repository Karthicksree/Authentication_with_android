class MailboxController < ApplicationController
	before_action :authenticate_user!
	layout 'inbox'

  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
  end

  def sent
    @sent = mailbox.sentbox
    @active = :sent
  end

  def trash
    @trash = mailbox.trash
    @active = :trash
  end
end
