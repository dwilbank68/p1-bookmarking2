class IncomingController < ApplicationController

  require 'embedly'
  require 'json'
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create

    embedly_api = Embedly::API.new :key => '8837e2d5c8d14881a505d2fe96f40076', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    url_for_embedly = params["stripped-text"]
    #url_for_embedly = 'www.lifehacker.com'
    embedly_obj = embedly_api.extract :url => url_for_embedly

    #return embedly_obj[0][:title]
    topic_name = params["subject"] == "" ? "Misc" : params["subject"]
    topic = Topic.find_or_create_by(:name => topic_name)
    email_user = User.find_by_email(params["sender"])
    bookmark = email_user.bookmarks.build(:url => params["stripped-text"],
                                          :topic => topic,
                                          # :favicon => embedly_obj[0][:favicon_id],
                                          :favicon => JSON.pretty_generate(embedly_obj[0].marshal_dump),
                                          :description => embedly_obj[0][:description],
                                          :title => embedly_obj[0][:title],
                                          :html => embedly_obj[0][:html])

    if bookmark.save
        Like.create(:bookmark_id => bookmark.id,
                    :user_id => email_user.id,
        )
        UserMailer.confirmation_email(email_user, bookmark).deliver
       render :nothing => true
    else
      puts "*"*30
      puts "failure"
      puts "*"*30
      UserMailer.rejection_email(email_user, bookmark).deliver
   end
  end
end

# validates :url, :presence => true, :length => { :minimum =>2, :maximum => 255 }
# validates :topic, presence: true
# validates :user, presence: true