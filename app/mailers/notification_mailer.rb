# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def send_notification(notification, user, current_user)
    @visitor = current_user
    @notification = notification
    @user = user
    mail to: user.email, subject: '弊社サービスからのお知らせ'
  end
end
