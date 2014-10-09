class UserMailer < ActionMailer::Base
  default from: 'bookmarker@app30409245.mailgun.org'

  def confirmation_email(email_user, bookmark)
    @user = email_user
    @bookmark  = bookmark
    puts "*"*30
    puts "@user.email"
    puts "@bookmark.name"
    puts "*"*30
    mail(to: @user.email, subject: 'Bookmark saved')
  end

end
