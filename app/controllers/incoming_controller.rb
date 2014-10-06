class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    #puts "INCOMING PARAMS HERE: #{params}"
    puts "*"*30
    puts "SUBJECT: #{params["subject"]}"
    puts "SENDER: #{params["sender"]}"
    puts "LINK: #{params["stripped-text"]}"
    puts "*"*30

    # You put the message-splitting and business
    # magic here.

    # Assuming all went well.
    head 200
  end
end