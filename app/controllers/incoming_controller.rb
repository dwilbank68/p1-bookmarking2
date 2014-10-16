class IncomingController < ApplicationController

  require 'embedly'
  require 'json'
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    embedly_key = '8837e2d5c8d14881a505d2fe96f40076'
    embedly_user_agent = 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    embedly_api = Embedly::API.new :key => embedly_key, :user_agent => embedly_user_agent
    embedly_obj = embedly_api.extract :url => params["stripped-text"]

    topic_name = params["subject"] == "" ? "Misc" : params["subject"]
    topic = Topic.find_or_create_by(:name => topic_name)
    email_user = User.find_by_email(params["sender"])

    description = embedly_obj[0][:description]
    title = embedly_obj[0][:title]
    title = nil if title == description # if title and description come out identical, make title nil
    embed = embedly_obj[0][:media][:html]
    bookmark = email_user.bookmarks.build(:url => params["stripped-text"],
                                          :topic => topic,
                                          :description => description,
                                          :title => title,
                                          :embed => embed)


    if bookmark.save
        Like.create(:bookmark_id => bookmark.id,
                    :user_id => email_user.id )
        UserMailer.confirmation_email(email_user, bookmark).deliver
        render :nothing => true
    else
        UserMailer.rejection_email(email_user, bookmark).deliver
        render :nothing => true
   end
  end
end

# validates :url, :presence => true, :length => { :minimum =>2, :maximum => 255 }
# validates :topic, presence: true
# validates :user, presence: true