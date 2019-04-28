class SendNotificationToUsersJob < ApplicationJob
  queue_as :default

  def perform
    users = User.all
    UserMailer.report_most_popular_songs(users)
    UserMailer.report_most_popular_artists(users)
    UserMailer.report_most_popular_albums(users)
  end
end
