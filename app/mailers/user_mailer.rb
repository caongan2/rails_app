class UserMailer < ApplicationMailer
  default from: 'no_reply@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Hello a ngan_ct')
  end
end
