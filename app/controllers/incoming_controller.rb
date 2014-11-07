class IncomingController < ApplicationController
  require 'net/http'
  require 'net/smtp'
  require 'embedly'
  require 'json'
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    # https://github.com/embedly/embedly-ruby
    url = params["stripped-text"]

    embedly_obj = get_embedly_obj(url)      ### For video embeds ###
    embedly_json = get_embedly_json(url)    ### For thumbnail url ###

    topic_name = params["subject"] == "" ? "Misc" : params["subject"]
    topic = Topic.find_or_create_by(:name => topic_name)
    color = topic.color_topic
    topic.update_attributes(color:color)
    email_user = User.find_by_email(params["sender"])

    description, title = embedly_obj[:description], embedly_obj[:title]
    title = nil if title == description # if title and description come out identical, make title nil
    thumbnail_url = embedly_json["thumbnail_url"]
    embed = embedly_obj[:media][:html]
    bookmark = email_user.bookmarks.build(:url => url,                 :topic => topic,
                                          :description => description, :title => title,
                                          :thumbnail => thumbnail_url, :embed => embed)

    if bookmark.save
        Like.create(:bookmark_id => bookmark.id, :user_id => email_user.id )
        UserMailer.confirmation_email(email_user, bookmark).deliver
        render :nothing => true
    else
        UserMailer.rejection_email(email_user, bookmark).deliver
        render :nothing => true
    end

  end


  def get_embedly_obj(url)
    embedly_key = ENV['embedly_key'];
    embedly_user_agent = 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)';
    embedly_api = Embedly::API.new :key => embedly_key, :user_agent => embedly_user_agent;
    embedly_obj = embedly_api.extract( :url => url, :maxwidth => 280 );
    embedly_obj[0]
  end

  def get_embedly_json(url)
    base = "http://api.embed.ly/1/oembed?url=";
    safe_url = CGI.escape(url);
    res = Net::HTTP.get_response(URI.parse(base + safe_url));
    JSON.parse(res.body)
  end


end