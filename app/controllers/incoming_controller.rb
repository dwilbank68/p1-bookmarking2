class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    # puts "INCOMING PARAMS HERE: #{params}"
    # puts "*"*30
    # puts "SUBJECT: #{params["subject"]}"
    # puts "SENDER: #{params["sender"]}"
    # puts "LINK: #{params["stripped-text"]}"
    # puts "*"*30

    topic_name = params["subject"] || "Misc"
    topic = Topic.find_or_create_by(:name => topic_name)
    email_user = User.find_by_email(params["sender"])
    bookmark = email_user.bookmarks.build(:url => params["stripped-text"], :topic => topic)
    # You put the message-splitting and business
    # magic here.
    if bookmark.save
      Like.create(:bookmark_id => bookmark.id, :user_id => email_user.id)
      # put an entry in the current_user's likes table for this bookmark
      # email current_user back with a confirmation
      head 200 # who is expecting or needing this head?
      #email email_user back with a confirmation
    else
      #email email_user with failure notification
    end
  end
end

# validates :url, :presence => true, :length => { :minimum =>2, :maximum => 255 }
# validates :topic, presence: true
# validates :user, presence: true